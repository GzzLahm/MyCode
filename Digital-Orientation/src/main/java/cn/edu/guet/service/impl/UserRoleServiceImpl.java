package cn.edu.guet.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.guet.dao.UserRoleDao;
import cn.edu.guet.service.UserRoleService;
@Service("/userRoleService")
public class UserRoleServiceImpl implements UserRoleService {
	@Autowired
	private UserRoleDao userRoleDao;
	@Override
	public int deleteByUserId(Integer userId) {
		// TODO Auto-generated method stub
		return userRoleDao.deleteByUserId(userId);
	}
	@Override
	public int add(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userRoleDao.add(map);
	}
	@Override
	public int deleteRole(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userRoleDao.deleteRole(map);
	}

}
