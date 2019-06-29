package cn.edu.guet.entity;

public class College {
	private Integer id;
	private String collegeName;
	public College() {
		super();
		// TODO Auto-generated constructor stub
	}
	public College(String collegeName) {
		super();
		this.collegeName = collegeName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCollegeName() {
		return collegeName;
	}
	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
}
