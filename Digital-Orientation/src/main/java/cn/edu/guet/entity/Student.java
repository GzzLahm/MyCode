package cn.edu.guet.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cn.edu.guet.utils.Date2StringUtil;

public class Student {
	private Integer id;
	private String studentId; //学号
	private String studentName; //学生姓名
	private Major major; //专业
	private String phone; // 电话号码
	private String thing; //领取的物品
	private BigDecimal paiedTuition; // 已经支付的学费
	private String highsc; // 毕业高中
	private Integer archives=0; //是否提交档案
	private Integer gender; //性别
	private Integer score; //高考成绩
	private Date birth; //出生年月
	private String IDCard; //身份证密码
	private String address; //地址
	private String ticket; //准考账号
	private String noticeNO; //通知书编号
	private List<Thing> things;
	private List<Thing> notGet;
	private String nation; //民族
	private String political;//政治面貌
	private int register;
	private int one_card_pass;
	private int green_channel;
	private int registerComplete;
	public Student() {
		super();
		this.paiedTuition=new BigDecimal("0");
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public Major getMajor() {
		return major;
	}
	public String getMajorName() {
		return major.getMajorName();
	}
	public void setMajor(Major major) {
		this.major = major;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getThing() {
		return thing;
	}
	public void setThing(String thing) {
		this.thing = thing;
	}
	public BigDecimal getTuition() {
		return major.getTuition();
	}
	public BigDecimal getPaiedTuition() {
		return paiedTuition;
	}
	public void setPaiedTuition(BigDecimal paiedTuition) {
		this.paiedTuition = paiedTuition;
	}
	public Integer getArchives() {
		return archives;
	}
	public void setArchives(Integer archives) {
		this.archives = archives;
	}
	public String getIsarchives() {
		if(this.archives==0) {
			return "否";
		}else {
			return "是";
		}
	}
	public String getHighsc() {
		return highsc;
	}
	public void setHighsc(String highsc) {
		this.highsc = highsc;
	}
	
	public Integer getGender() {
		return gender;
	}
	public String getGenderv() {
		if(this.gender==0) {
			return "女";
		}else {
			return "男";
		}
	}
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getFormatBirth() {
		if(this.birth!=null) {
			return Date2StringUtil.DateFormat(this.birth);
		}else {
			return null;
		}
		
	}
	
	public String getIDCard() {
		return IDCard;
	}
	public void setIDCard(String iDCard) {
		IDCard = iDCard;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTicket() {
		return ticket;
	}
	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	public BigDecimal getUnpaidTuition() {
		if(major.getTuition()!=null) {
			return major.getTuition().subtract(this.paiedTuition);
		}else {
			return null;
		}
	}
	public String getNoticeNO() {
		return noticeNO;
	}
	public void setNoticeNO(String noticeNO) {
		this.noticeNO = noticeNO;
	}
	
	public List<Thing> getThings() {
		return things;
	}
	public void setThings(List<Thing> things) {
		this.things = things;
	}
	public String getThingGet() {
		String str="";
		if(this.things!=null) {
			for(int i=0;i<this.things.size();i++) {
				if(i!=(this.things.size()-1)) {
					str=str+this.things.get(i).getThingName()+"、";
				}else {
					str=str+this.things.get(i).getThingName();
				}
			}
		}
		return str;
	}
	
	public List<Thing> getNotGet() {
		return notGet;
	}
	public void setNotGet(List<Thing> notGet) {
		this.notGet = notGet;
	}
	public String getThingNotGet() {
		String str="";
		if(this.notGet!=null) {
			for(int i=0;i<this.notGet.size();i++) {
				if(i!=(this.notGet.size()-1)) {
					str=str+this.notGet.get(i).getThingName()+"、";
				}else {
					str=str+this.notGet.get(i).getThingName();
				}
			}
		}
		return str;
	}
	
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getPolitical() {
		return political;
	}
	public void setPolitical(String political) {
		this.political = political;
	}
	
	public int getRegister() {
		return register;
	}
	public void setRegister(int register) {
		this.register = register;
	}
	public int getOne_card_pass() {
		return one_card_pass;
	}
	public void setOne_card_pass(int one_card_pass) {
		this.one_card_pass = one_card_pass;
	}
	public int getGreen_channel() {
		return green_channel;
	}
	public void setGreen_channel(int green_channel) {
		this.green_channel = green_channel;
	}
	public String getIsGreen_channel() {
		if(this.green_channel==1) {
			return "是";
		}else {
			return "否";
		}
	}
	public String getIsRegister() {
		if(this.register==1) {
			return "是";
		}else {
			return "否";
		}
	}
	public String getIsOne_card_pass() {
		if(this.one_card_pass==1) {
			return "是";
		}else {
			return "否";
		}
	}
	
	public int getRegisterComplete() {
		return registerComplete;
	}
	public void setRegisterComplete(int registerComplete) {
		this.registerComplete = registerComplete;
	}
	@Override
	public String toString() {
		return "Student [id=" + id + ", studentId=" + studentId + ", studentName=" + studentName + ", major=" + major
				+ ", phone=" + phone + ", thing=" + thing + ", paiedTuition=" + paiedTuition + ", highsc=" + highsc
				+ ", archives=" + archives + ", gender=" + gender + ", score=" + score + ", birth=" + birth
				+ ", IDCard=" + IDCard + ", address=" + address + ", ticket=" + ticket + ", noticeNO=" + noticeNO + "]";
	}
	
}
