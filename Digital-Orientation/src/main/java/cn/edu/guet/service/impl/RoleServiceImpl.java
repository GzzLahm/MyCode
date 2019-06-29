package cn.edu.guet.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.edu.guet.dao.RoleDao;
import cn.edu.guet.entity.Role;
import cn.edu.guet.service.RoleService;
@Service("roleService")
public class RoleServiceImpl implements RoleService {
	@Autowired 
	private RoleDao roleDao;
	@Override
	public List<Role> getAllRole() {
		// TODO Auto-generated method stub
		return roleDao. getAllRole();
	}
	@Override
	public List<Role> getRoleByPage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return roleDao.getRoleByPage(map);
	}
	@Override
	public int getTotal() {
		// TODO Auto-generated method stub
		return roleDao.getTotal();
	}
	@Override
	public int update(Role role) {
		// TODO Auto-generated method stub
		return roleDao.update(role);
	}
	@Override
	public int add(Role role) {
		// TODO Auto-generated method stub
		return roleDao.add(role);
	}
	@Override
	public Role getRoleByName(String roleName) {
		// TODO Auto-generated method stub
		return roleDao.getRoleByName(roleName);
	}

}
