package cn.edu.guet.dao;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.User;

public interface UserDao {
	public User getUser(Map<String, Object> map);

	public User getUserByName(String userName);

	public User getUserById(Integer id);

	public int updatePassword(User currentUser);

	public List<User> getUserByPage(Map<String, Object> map);

	public int getTotal();

	public int add(User user);

	public int update(User user);

	public int delete(int id);

}
