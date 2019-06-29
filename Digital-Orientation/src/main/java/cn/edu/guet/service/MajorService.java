package cn.edu.guet.service;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.Major;

public interface MajorService {
	public Integer addMajor(Major major);

	public Integer updateMajor(Major major);

	public Major getMajorByName(String name);

	public List<Major> getMajorByMap(Map<String, Object> map);

	public Major getMajorById(Integer parseInt);

	public int getTotal(Map<String, Object> map);
}
