package map.corseDTO;

import java.time.LocalDateTime;

public class BikeRealTime {
	private String station_id;
	private String station_name;
	private Integer racktocnt;
	private Integer biketocnt;
	private Float lat;
	private Float lon;
	private LocalDateTime updatetime;
	public String getStation_id() {
		return station_id;
	}
	public void setStation_id(String station_id) {
		this.station_id = station_id;
	}
	public String getStation_name() {
		return station_name;
	}
	public void setStation_name(String station_name) {
		this.station_name = station_name;
	}
	public Integer getRacktocnt() {
		return racktocnt;
	}
	public void setRacktocnt(Integer racktocnt) {
		this.racktocnt = racktocnt;
	}
	public Integer getBiketocnt() {
		return biketocnt;
	}
	public void setBiketocnt(Integer biketocnt) {
		this.biketocnt = biketocnt;
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
	public LocalDateTime getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(LocalDateTime updatetime) {
		this.updatetime = updatetime;
	}
}
