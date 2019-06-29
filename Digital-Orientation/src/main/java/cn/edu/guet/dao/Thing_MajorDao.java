package cn.edu.guet.dao;

import java.util.List;
import java.util.Map;

import cn.edu.guet.entity.Thing;

public interface Thing_MajorDao {
	public List<Thing> getThingsByMajorId(Integer id);

	public Integer addThing_Major(Map<String, Object> map);

	public int deleteThing_Major(Map<String, Object> map);
}
