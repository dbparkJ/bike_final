package item;

public class Item_reviewDTO {
	
	private Integer item_id;
	private String review_content;
	private Integer review_star;
	private String review_nickname;
	private String review_date;
	
	public Integer getItem_id() {
		return item_id;
	}
	public void setItem_id(Integer item_id) {
		this.item_id = item_id;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public Integer getReview_star() {
		return review_star;
	}
	public void setReview_star(Integer review_star) {
		this.review_star = review_star;
	}
	public String getReview_nickname() {
		return review_nickname;
	}
	public void setReview_nickname(String review_nickname) {
		this.review_nickname = review_nickname;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}	
	
}
