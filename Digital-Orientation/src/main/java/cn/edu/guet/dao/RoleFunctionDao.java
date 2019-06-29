package cn.edu.guet.dao;

import java.util.Map;

import cn.edu.guet.entity.RoleFunction;

public interface RoleFunctionDao {

	public RoleFunction getByMap(Map<String, Object> map);

	public int add(Map<String, Object> map);

}
