package cn.edu.guet.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.guet.dao.RoleFunctionDao;
import cn.edu.guet.entity.RoleFunction;

@Service("roleFunctionSevice")
public class RoleFunctionSeviceImpl implements RoleFunctionSevice{
	@Autowired
	private RoleFunctionDao roleFunctionDao;
	@Override
	public RoleFunction getByMap(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return roleFunctionDao.getByMap(map);
	}
	@Override
	public int add(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return roleFunctionDao.add(map);
	}
	
}
