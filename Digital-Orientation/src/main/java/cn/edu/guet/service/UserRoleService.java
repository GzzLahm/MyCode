package cn.edu.guet.service;

import java.util.Map;

public interface UserRoleService {
	public int deleteByUserId(Integer userId);

	public int add(Map<String, Object> map);

	public int deleteRole(Map<String, Object> map);
}
