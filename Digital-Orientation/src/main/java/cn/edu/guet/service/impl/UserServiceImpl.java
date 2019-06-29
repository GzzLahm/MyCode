package cn.edu.guet.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.guet.dao.UserDao;
import cn.edu.guet.entity.User;
import cn.edu.guet.service.UserService;
@Service("userService")
public class UserServiceImpl implements UserService{
	@Resource
	private UserDao userDao;
	@Override
	public User getUser(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return userDao.getUser(map);
	}
	@Override
	public User getUserByName(String userName) {
		// TODO Auto-generated method stub
		return userDao.getUserByName(userName);
	}
	@Override
	public int updatePassword(User currentUser) {
		// TODO Auto-generated method stub
		return userDao.updatePassword(currentUser);
	}
	@Override
	public List<User> getUserByPage(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.getUserByPage(map);
	}
	@Override
	public int getTotal() {
		// TODO Auto-generated method stub
		return userDao.getTotal();
	}
	@Override
	public int add(User user) {
		// TODO Auto-generated method stub
		return userDao.add(user);
	}
	@Override
	public int update(User user) {
		// TODO Auto-generated method stub
		return userDao.update(user);
	}
	@Override
	public User getUserById(Integer id) {
		// TODO Auto-generated method stub
		return userDao.getUserById(id);
	}
	@Override
	public int delete(int parseInt) {
		// TODO Auto-generated method stub
		return userDao.delete(parseInt);
	}

}
