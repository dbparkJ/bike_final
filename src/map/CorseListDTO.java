package map;

/*
 * 코스 리스트 DTO
 */

public class CorseListDTO {
	private Integer id;
	private String name;
	private Double lat; // 위도
	private Double lon; // 경도
	private Double elev; // 고도
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Double getLon() {
		return lon;
	}
	public void setLon(Double lon) {
		this.lon = lon;
	}
	public Double getElev() {
		return elev;
	}
	public void setElev(Double elev) {
		this.elev = elev;
	}
	
}
