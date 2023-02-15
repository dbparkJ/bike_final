package map.storeDTO;

public class KakaoStore {
	private Integer store_id;
	private String store_name;
	private String addr;
	private Float lat;
	private Float lon;
	private Integer kakao_star_avg;
	private String kakao_review_num;
	private String kakao_url;
	private String cate_b;
	private String cate_c;
	public Integer getStore_id() {
		return store_id;
	}
	public void setStore_id(Integer store_id) {
		this.store_id = store_id;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Float getLat() {
		return lat;
	}
	public void setLat(Float lat) {
		this.lat = lat;
	}
	public Float getLon() {
		return lon;
	}
	public void setLon(Float lon) {
		this.lon = lon;
	}
	public Integer getKakao_star_avg() {
		return kakao_star_avg;
	}
	public void setKakao_star_avg(Integer kakao_star_avg) {
		this.kakao_star_avg = kakao_star_avg;
	}
	public String getKakao_review_num() {
		return kakao_review_num;
	}
	public void setKakao_review_num(String kakao_review_num) {
		this.kakao_review_num = kakao_review_num;
	}
	public String getKakao_url() {
		return kakao_url;
	}
	public void setKakao_url(String kakao_url) {
		this.kakao_url = kakao_url;
	}
	public String getCate_b() {
		return cate_b;
	}
	public void setCate_b(String cate_b) {
		this.cate_b = cate_b;
	}
	public String getCate_c() {
		return cate_c;
	}
	public void setCate_c(String cate_c) {
		this.cate_c = cate_c;
	}
}
