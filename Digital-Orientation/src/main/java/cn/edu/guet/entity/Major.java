package cn.edu.guet.entity;

import java.math.BigDecimal;
import java.util.List;

public class Major {
	private Integer id;
	private String majorName;
	private College college;
	private BigDecimal tuition;
	private List<Thing> things;
	public Major() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Major(String majorName, College college,BigDecimal tuition) {
		super();
		this.majorName = majorName;
		this.college = college;
		this.tuition=tuition;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMajorName() {
		return majorName;
	}
	public void setMajorName(String majorName) {
		this.majorName = majorName;
	}
	public College getCollege() {
		return college;
	}
	public void setCollege(College college) {
		this.college = college;
	}
	public BigDecimal getTuition() {
		return tuition;
	}
	public void setTuition(BigDecimal tuition) {
		this.tuition = tuition;
	}
	public String getCollegeName() {
		return this.college.getCollegeName();
	}
	
	public List<Thing> getThings() {
		return things;
	}
	public void setThings(List<Thing> things) {
		this.things = things;
	}
	public String getThingString() {
		String str="";
		int size=this.things.size();
		for(int i=0;i<size;i++) {
			if(i<(size-1)) {
				str=str+things.get(i).getThingName()+"、";
			}else {
				str=str+things.get(i).getThingName();
			}
		}
		return str;
	}
	@Override
	public String toString() {
		return "Major [id=" + id + ", majorName=" + majorName + ", college=" + college + ", tuition=" + tuition
				+ ", things=" + things + "]";
	}
	
}
