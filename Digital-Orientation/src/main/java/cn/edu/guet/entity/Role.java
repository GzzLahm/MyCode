package cn.edu.guet.entity;

import java.util.HashSet;
import java.util.Set;

public class Role {
	private Integer id;
	private String roleName;
	private String description;
	private Set functions = new HashSet(0);//当前角色对应的多个权限
	private Set users = new HashSet(0);//当前角色对应的多个用户
	public Role(String roleName) {
		super();
		this.roleName = roleName;
	}
	public Role() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Set getFunctions() {
		return functions;
	}
	public void setFunctions(Set functions) {
		this.functions = functions;
	}
	public Set getUsers() {
		return users;
	}
	public void setUsers(Set users) {
		this.users = users;
	}
	@Override
	public String toString() {
		return "Role [id=" + id + ", roleName=" + roleName + ", description=" + description + ", functions=" + functions
				+ ", users=" + users + "]";
	}
	
}
