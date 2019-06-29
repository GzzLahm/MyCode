package com.lahm.service;

import com.lahm.dao.UserDao;
import com.lahm.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	public void addUser(User user) {
		// TODO Auto-generated method stub
		userDao.insertUser(user);
	}

}
