package cn.edu.guet.entity;

import java.util.List;

public class User {
	private Integer id;
	private String userName;
	private String password;
	private String phone;
	private String email;
	private Major major;
	private List<Role> roles;
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(String userName, String password) {
		super();
		this.userName = userName;
		this.password = password;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Major getMajor() {
		return major;
	}
	public void setMajor(Major major) {
		this.major = major;
	}
	
	public List<Role> getRoles() {
		return roles;
	}
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMajorName()
	{
		if(this.getMajor()!=null)
		{
			return this.major.getMajorName();
		}else {
			return null;
		}
	}
	public String getAllRole() {
		String str="";
		if(this.roles.size()>0) {
			for(int i=0;i<this.roles.size();i++) {
				if(i!=(this.roles.size()-1)) {
					str=str+this.roles.get(i).getRoleName()+",";
				}else {
					str=str+this.roles.get(i).getRoleName();
				}
			}
			return str;
		}else {
			return null;
		}
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", password=" + password + ", major=" + major + "]";
	}
	
	
}
