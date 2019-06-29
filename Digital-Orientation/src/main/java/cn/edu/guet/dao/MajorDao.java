package cn.edu.guet.dao;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.Major;

public interface MajorDao {
	public Major getMajorById(Integer id);

	public Major getMajorByName(String name);

	public Integer addMajor(Major major);

	public Integer updateMajor(Major major);

	public Major getMajorByUserName(String userName);

	public List<Major> getMajorByMap(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

}
