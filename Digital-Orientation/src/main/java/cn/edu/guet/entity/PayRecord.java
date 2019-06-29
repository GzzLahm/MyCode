package cn.edu.guet.entity;

import java.math.BigDecimal;
import java.util.Date;

import cn.edu.guet.utils.Date2StringUtil;

public class PayRecord {
	private Integer id;
	private User user;
	private Student student;
	private BigDecimal amount;
	private Date createtime;
	private int way;
	private String voucher;
	
	public PayRecord() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PayRecord(Integer id, User user, Student student, BigDecimal amount, Date createtime, int way,
			String voucher) {
		super();
		this.id = id;
		this.user = user;
		this.student = student;
		this.amount = amount;
		this.createtime = createtime;
		this.way = way;
		this.voucher = voucher;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public int getWay() {
		return way;
	}
	public void setWay(int way) {
		this.way = way;
	}
	public String getVoucher() {
		return voucher;
	}
	public void setVoucher(String voucher) {
		this.voucher = voucher;
	}
	public String getStudentId() {
		return this.student.getStudentId();
	}
	public String getStudentName() {
		return this.student.getStudentName();
	}
	public String getUserName() {
		return this.user.getUserName();
	}
	public String getPayTime()
	{
		return Date2StringUtil.DateFormatDetail(this.createtime);
	}
	public String getWayDetail() {
		switch (this.way) {
			case 1:
				return "现金缴费";
			case 2:
				return "刷卡缴费";
			case 3:
				return "支付宝缴费";
			default:
				return "微信缴费";
		}
	}
	public String getMajorName() {
		return student.getMajorName();
	}
	@Override
	public String toString() {
		return "PayRecord [id=" + id + ", user=" + user + ", student=" + student + ", amount=" + amount
				+ ", createtime=" + createtime + ", way=" + way + ", voucher=" + voucher + "]";
	}
	
}
