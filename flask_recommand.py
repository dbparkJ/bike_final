from flask import Flask
# pip install flask-restful
from flask_restful import Resource, Api
from flask import Flask, render_template, request
import pandas as pd
import numpy as np
import cx_Oracle
from datetime import datetime
import codecs
from konlpy.tag import Okt
import pickle
from flask_cors import CORS
import math
import re
import json
from flask import Response
from functools import wraps

cx_Oracle.init_oracle_client(lib_dir=r"D:\util\instantclient_21_8")

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False


CORS(app)
app.debug = True
api = Api(app)
stop_words = ['쪽', '번', '못', '타다', '부분', '좋다', '타고', '타', '보다', '해주다', '그냥', '받다', '않다', '너무', '아니다', '나',
              '안되다', '오다', '처음', '제', '후', '아니다', '우선', '자다', '하다', '것', '같다', '우리', '이다', '등', '있다', '저', '오늘',
              '들', '되다', '적', '함께', '우리', '없다', '력', '이번', '여러분', '구매', '자전거', '때', '생각', '것', '그것', '수', '더',
              '등', '그', '위', '명', '이', '저', '개', '창', '때', '바로', '내용', '가장', '위해', '안', '배', '다시', '도', '단',
              '리', '말', '이후', '국', '충', '번', '바', '속', '총', '관', '그게', '분', '협', '몇', '생', '전', '임', '데', '치',
              '를', '창', '개']


class RecommandNaverStore(Resource):
    def get(self):
        result=find_simi_place('naver',int(request.args.get('store_id')))
        return {'result1':result[0],
                'result2':result[1],
                'result3':result[2],
                'result4':result[3],
                'result5':result[4]}

class RecommandKakaoStore(Resource):
    def get(self):
        result=find_simi_place('kakao',int(request.args.get('store_id')))
        return {'result1':result[0],
                'result2':result[1],
                'result3':result[2],
                'result4':result[3],
                'result5':result[4]}


class StoreNaverKeyword(Resource):
    def get(self):
        keyword = return_keyword("naver",int(request.args.get('store_id')))
        result = {
            'keyword1': keyword[0],
            'keyword2': keyword[1],
            'keyword3': keyword[2]
        }
        json_string = json.dumps(result, ensure_ascii=False)
        return Response(json_string, content_type='application/json; charset=utf-8')

class StoreKakaoKeyword(Resource):
    def get(self):
        keyword=return_keyword("kakao",int(request.args.get('store_id')))
        result = {
            'keyword1': keyword[0],
            'keyword2': keyword[1],
            'keyword3': keyword[2]
        }
        json_string = json.dumps(result, ensure_ascii=False)
        return Response(json_string, content_type='application/json; charset=utf-8')

class RecommandItem(Resource):
    def get(self):
        # request.args.get('item_id'), request.args.get('cosine_weight')
        result=find_simi_item(int(request.args.get('item_id')))
        return {'result1':result[0],
                'result2':result[1],
                'result3':result[2],
                'result4':result[3],
                'result5':result[4]
                }



# store algorithm fx
def process_store_df(site, store_id):
    if site == 'naver':
        with open("naver_store.pickle", "rb") as fr:
            df = pickle.load(fr)
    elif site == 'kakao':
        with open("kakao_store.pickle", "rb") as fr:
            df = pickle.load(fr)

    my_lon = df[df['STORE_ID'] == store_id].LON.tolist()[0]
    my_lat = df[df['STORE_ID'] == store_id].LAT.tolist()[0]

    df['CATEGORY'] = (df['CATE_B'] + df['CATE_C']).str.replace('/', ' ').str.replace('-', ' ')
    df = df[((df['STAR_AVG'] > 3.5) & (df['STORE_ID'] != store_id)) | (df['STORE_ID'] == store_id)]

    df['distance'] = ((df['LON'] - my_lon) ** 2 + (df['LAT'] - my_lat) ** 2) ** (1 / 2)
    df = df.sort_values('distance').reset_index(drop=True)[:50]

    return df[['STORE_ID', 'STORE_NAME', 'ADDR', 'REVIEW_SUM', 'CATEGORY', 'distance']]


def cosine_similarity_store(df):
    # 유사도를 계산해 반환
    # 인자에 가중치를 넣어줌

    from sklearn.feature_extraction.text import CountVectorizer  # 피체 벡터화
    from sklearn.metrics.pairwise import cosine_similarity  # 코사인 유사도

    # 서로 카테고리 텍스트가 얼마나 유사한지를 따져줌
    count_vect_category = CountVectorizer(min_df=0, ngram_range=(1, 2))
    place_category = count_vect_category.fit_transform(df['CATEGORY'])
    place_simi_cate = cosine_similarity(place_category, place_category)

    # 리뷰 텍스트 데이터 간의 텍스트 피쳐 벡터라이징
    count_vect_review = CountVectorizer(min_df=2, ngram_range=(1, 2))
    df['CONTENT'] = [str(item) for item in df['REVIEW_SUM']]
    place_review = count_vect_review.fit_transform(df['REVIEW_SUM'].fillna(''))
    place_simi_review = cosine_similarity(place_review, place_review)

    # 전체가중치
    place_simi_co = (
            + place_simi_cate * 0.01  # 공식 1. 카테고리 유사도
            + place_simi_review * 0.3  # 공식 2. 리뷰 텍스트 유사도
    )
    place_simi_co_sorted_ind = place_simi_co.argsort()[:, ::-1]
    return place_simi_co_sorted_ind

def find_simi_place(site,store_id):
    df=process_store_df(site,store_id)
    place_simi_co_sorted_ind=cosine_similarity_store(df)
    top_n=6
    place_id = df[df['STORE_ID'] == store_id]
    place_index = place_id.index.values
    similar_indexes = place_simi_co_sorted_ind[place_index, :(top_n)]
    similar_indexes = similar_indexes.reshape(-1)
#     my_star=df[df['STORE_ID']==store_id].STAR_AVG.tolist()[0]
    return df['STORE_ID'].iloc[similar_indexes[1:]].tolist()

#item algorythm
def process_df(df, item_id):
    my_price = df[df['ITEM_ID'] == item_id].ITEM_PRICE.tolist()[0]
    my_category = df[df['ITEM_ID'] == item_id].ITEM_CATEGORY.tolist()[0]

    # 카테고리
    if my_category == '스포츠/레저>자전거>자전거/MTB>전기자전거':
        df = df[df['ITEM_CATEGORY'] == '스포츠/레저>자전거>자전거/MTB>전기자전거']
    else:
        df = df[df['ITEM_CATEGORY'] != '스포츠/레저>자전거>자전거/MTB>전기자전거']

    # 가격
    df_processed = df[(df['ITEM_PRICE'] >= 0.5 * my_price) & (df['ITEM_PRICE'] <= 1.5 * my_price)]

    if len(df_processed) < 5:
        df['process'] = df['ITEM_PRICE'] - my_price
        df['process'] = df.process.abs()
        df_processed = df.sort_values('process')
        df_processed = df_processed[:6]

    return df_processed

def cosine_similarity_item(df):
    # 유사도를 계산해 반환
    # 인자에 가중치를 넣어줌

    from sklearn.feature_extraction.text import CountVectorizer  # 피체 벡터화
    from sklearn.metrics.pairwise import cosine_similarity  # 코사인 유사도

    # 서로 item_category 텍스트가 얼마나 유사한지를 따져줌
    count_vect_category = CountVectorizer(min_df=0, ngram_range=(1, 2))
    category = count_vect_category.fit_transform(df['ITEM_CATEGORY'].str.split('>').str[-1])
    simi_cate = cosine_similarity(category, category)

    # 서로 dissatisfied_coment 텍스트가 얼마나 유사한지를 따져줌
    count_vect_dissatisfied = CountVectorizer(min_df=0, ngram_range=(1, 2))
    dissatisfied = count_vect_dissatisfied.fit_transform(df['DISSATISFIED_KEYWORD'])
    simi_dissatisfied = cosine_similarity(dissatisfied, dissatisfied)

    # 서로 satisfied_coment 텍스트가 얼마나 유사한지를 따져줌
    count_vect_satisfied = CountVectorizer(min_df=0, ngram_range=(1, 2))
    satisfied = count_vect_dissatisfied.fit_transform(df['SATISFIED_KEYWORD'])
    simi_satisfied = cosine_similarity(satisfied, satisfied)

    # 기어박스 유사도
    if len(df['GEARBOX'].drop_duplicates())==1:
        simi_gearbox=np.array([[1.0 for j in range(6)] for i in range(6)])
    else:
        count_vect_gearbox = CountVectorizer(min_df=0, ngram_range=(1, 2))
        gearbox = count_vect_gearbox.fit_transform(df['GEARBOX'].fillna(''))
        simi_gearbox = cosine_similarity(gearbox, gearbox)

    # 브레이크 유사도
    if len(df['BRAKE'].drop_duplicates())==1:
        simi_brake=np.array([[1.0 for j in range(6)] for i in range(6)])
    else:
        count_vect_brake = CountVectorizer(min_df=0, ngram_range=(1, 2))
        brake = count_vect_brake.fit_transform(df['BRAKE'].fillna(''))
        simi_brake = cosine_similarity(brake, brake)

    # 핸들 유사도
    if len(df['HANDLE_TYPE'].drop_duplicates())==1:
        simi_handle=np.array([[1.0 for j in range(6)] for i in range(6)])
    else:
        count_vect_handle = CountVectorizer(min_df=0, ngram_range=(1, 2))
        handle = count_vect_handle.fit_transform(df['HANDLE_TYPE'].fillna(''))
        simi_handle = cosine_similarity(handle, handle)

    # 특징 유사도
    if len(df['FEATURE'].drop_duplicates())==1:
        simi_feature=np.array([[1.0 for j in range(6)] for i in range(6)])
    else:
        count_vect_feature = CountVectorizer(min_df=0, ngram_range=(1, 2))
        feature = count_vect_feature.fit_transform(df['FEATURE'].fillna(''))
        simi_feature = cosine_similarity(feature, feature)

    # SUSPENSION 유사도
    if len(df['SUSPENSION'].drop_duplicates())==1:
        simi_suspension=np.array([[1.0 for j in range(6)] for i in range(6)])
    else:
        count_vect_suspension = CountVectorizer(min_df=0, ngram_range=(1, 2))
        suspension = count_vect_suspension.fit_transform(df['SUSPENSION'].fillna(''))
        simi_suspension = cosine_similarity(suspension, suspension)

    # FRAME 유사도
    if len(df['FRAME'].drop_duplicates())==1:
        simi_frame=np.array([[1.0 for j in range(6)] for i in range(6)])
    else:
        count_vect_frame = CountVectorizer(min_df=0, ngram_range=(1, 2))
        frame = count_vect_frame.fit_transform(df['FRAME'].fillna(''))
        simi_frame = cosine_similarity(frame, frame)

    # 안장 유사도
    if len(df['SADDLE'].drop_duplicates())==1:
        simi_saddle=np.array([[1.0 for j in range(6)] for i in range(6)])
    else:
        count_vect_saddle = CountVectorizer(min_df=0, ngram_range=(1, 2))
        saddle = count_vect_saddle.fit_transform(df['SADDLE'].fillna(''))
        simi_saddle = cosine_similarity(saddle, saddle)

    category_list = [0.01, 0.01, 0.01,
                     0.01, 0.01, 0.01,
                     0.01, 0.01, 0.01, 0.01]


    simi_co = (
            simi_cate * category_list[0]  # 카테고리
            + simi_dissatisfied * category_list[1]  # 불만족키워드
            + simi_satisfied * category_list[2]  # 만족 키워드
            + simi_gearbox * category_list[3]  # 기어박스
            + simi_brake * category_list[4]  # 브레이크
            + simi_handle * category_list[5]  # 핸들
            + simi_feature * category_list[6]  # 특징
            + simi_suspension * category_list[7]  # 서스펜션
            + simi_frame * category_list[8]  # 프레임
            + simi_saddle * category_list[9]  # 안장

    )

    simi_co_sorted_ind = simi_co.argsort()[:, ::-1]
    return simi_co_sorted_ind

def find_simi_item(item_id):
    with open("iteminfo.pickle","rb") as fr:
        df = pickle.load(fr)
    df=process_df(df,item_id).reset_index()[['ITEM_ID', 'ITEM_NAME', 'ITEM_IMG', 'ITEM_PRICE', 'ITEM_AVG_STAR',
           'ITEM_DELIVERY_FEE', 'ITEM_CATEGORY', 'ITEM_REVIEW_NUM', 'WHISH', 'URL',
           'RELEASE_Y', 'MAX_SPEED_KM', 'MILEAGE_KM', 'BACK_ANGLE_DO', 'GEAR_DAN',
           'WHEEL_INCH', 'WEIGHT_KG', 'GEARBOX', 'BRAKE', 'HANDLE_TYPE', 'FEATURE',
           'MOTOR_OUTPUT_W', 'BATTERY_CAP_AH', 'BATTERY_VOL_V', 'CHARGE_TIME_H',
           'SUSPENSION', 'FRAME', 'SADDLE', 'TYPE', 'SATISFIED_REVIEW_SUM',
           'SATISFIED_NUM', 'DISSATISFIED_REVIEW_SUM', 'DISSATISFIED_NUM',
           'DISSATISFIED_KEYWORD', 'SATISFIED_KEYWORD']]
    simi_co_sorted_ind = cosine_similarity_item(df)
    top_n = 6
    item_id = df[df['ITEM_ID'] == item_id]
    item_index = item_id.index.values
    similar_indexes = simi_co_sorted_ind[item_index - 1, :(top_n)]
    similar_indexes = similar_indexes.reshape(-1)

    return df['ITEM_ID'].iloc[similar_indexes[1:]].tolist()
#     return df.iloc[similar_indexes[1:]]

#keyword

def text_processing(text): #  전처리
    special = re.compile(r'[^ 가-힣 ]+')
    result = special.sub('',text)
    return result

def return_keyword(site, store_id):
    if site == "naver":
        with open("naver_keyword.pickle", "rb") as fr:
            df = pickle.load(fr)
    elif site == "kakao":
        with open("kakao_keyword.pickle", "rb") as fr:
            df = pickle.load(fr)

    idx = df[df['STORE_ID'] == store_id].index[0]
    text = text_processing(df.loc[idx, 'REVIEW_SUM'])

    okt = Okt()
    lines = str(text).split(" ")
    results = []
    # 단어 기본형으로 반환 (ex. 불만족스러웠는데 => 불만족)
    for line in lines:
        malist = okt.pos(line, norm=True, stem=True)
        r = []
        for word in malist:
            if ((not word[1] in ["Josa", "Eomi", "Punctuation"]) and (not word[0] in stop_words)):
                r.append(word[0])
        rl = (" ".join(r)).strip()
        results.append(rl)

    # 단어 빈도 체크

    word_dic = {}
    for line in results:
        malist = okt.pos(line, norm=True, stem=True)
        for word in malist:
            if ((not word[1] in ["Josa", "Eomi", "Punctuation"]) and (not word[0] in stop_words)):
                if not (word[0] in word_dic):
                    word_dic[word[0]] = 0
                word_dic[word[0]] += 1
    keys = sorted(word_dic.items(), key=lambda x: x[1], reverse=True)[:3]

    keyword = ['키워드없음', '키워드없음', '키워드없음']
    for index, key in enumerate(keys):
        keyword[index] = key[0]

    return keyword


api.add_resource(RecommandNaverStore,'/recommandNaverStore')
api.add_resource(RecommandKakaoStore,'/recommandKakaoStore')

api.add_resource(RecommandItem,'/recommandItem')

api.add_resource(StoreNaverKeyword,'/storeNaverKeyword')
api.add_resource(StoreKakaoKeyword,'/storeKakaoKeyword')

if __name__ == '__main__':
    app.run(host='192.168.0.78')
    # app.run(host='192.168.0.146')