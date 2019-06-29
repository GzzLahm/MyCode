package cn.edu.guet.service.impl;

import java.util.Map;

import cn.edu.guet.entity.RoleFunction;

public interface RoleFunctionSevice {

	RoleFunction getByMap(Map<String, Object> map);

	int add(Map<String, Object> map);
	
}
