package cn.edu.guet.dao;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.Role;

public interface RoleDao {
	public Role getRoleById(Integer id);

	public List<Role> getAllRole();

	public List<Role> getRoleByPage(Map<String, Object> map);

	public int getTotal();

	public int update(Role role);

	public int add(Role role);

	public Role getRoleByName(String roleName);

}
