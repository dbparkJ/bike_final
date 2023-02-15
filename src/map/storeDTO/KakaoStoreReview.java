package map.storeDTO;

public class KakaoStoreReview {
	private Integer store_id;
	private String kakao_nickname;
	private String kakao_date;
	private String kakao_content;
	private Float kakao_star;
	public Integer getStore_id() {
		return store_id;
	}
	public void setStore_id(Integer store_id) {
		this.store_id = store_id;
	}
	public String getKakao_nickname() {
		return kakao_nickname;
	}
	public void setKakao_nickname(String kakao_nickname) {
		this.kakao_nickname = kakao_nickname;
	}
	public String getKakao_date() {
		return kakao_date;
	}
	public void setKakao_date(String kakao_date) {
		this.kakao_date = kakao_date;
	}
	public String getKakao_content() {
		return kakao_content;
	}
	public void setKakao_content(String kakao_content) {
		this.kakao_content = kakao_content;
	}
	public Float getKakao_star() {
		return kakao_star;
	}
	public void setKakao_star(Float kakao_star) {
		this.kakao_star = kakao_star;
	}
}
