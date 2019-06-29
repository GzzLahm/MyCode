package cn.edu.guet.service;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.Role;

public interface RoleService {
	public List<Role> getAllRole();

	public List<Role> getRoleByPage(Map<String, Object> map);

	public int getTotal();

	public int update(Role role);

	public int add(Role role);

	public Role getRoleByName(String roleName);
}
