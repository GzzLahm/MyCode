package cn.edu.guet.dao;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.Role;

public interface UserRoleDao {
	public List<Role> getRolesByUserId(Integer id);

	public int deleteByUserId(Integer userId);

	public int add(Map<String, Object> map);

	public int deleteRole(Map<String, Object> map);
}
