package map.storeDTO;

public class NaverStore {
	private Integer store_id;
	private String store_name;
	private String addr;
	private Float lat;
	private Float lon;
	private Integer naver_star_avg;
	private String naver_review_num;
	private String naver_url;
	private String naver_img_url;
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
	public Integer getNaver_star_avg() {
		return naver_star_avg;
	}
	public void setNaver_star_avg(Integer naver_star_avg) {
		this.naver_star_avg = naver_star_avg;
	}
	public String getNaver_review_num() {
		return naver_review_num;
	}
	public void setNaver_review_num(String naver_review_num) {
		this.naver_review_num = naver_review_num;
	}
	public String getNaver_url() {
		return naver_url;
	}
	public void setNaver_url(String naver_url) {
		this.naver_url = naver_url;
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
	public String getNaver_img_url() {
		return naver_img_url;
	}
	public void setNaver_img_url(String naver_img_url) {
		this.naver_img_url = naver_img_url;
	}
}
