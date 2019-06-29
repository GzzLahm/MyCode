package cn.edu.guet.dao;

import cn.edu.guet.entity.Thing;

public interface ThingDao {
	public Thing getThingById(Integer id);

	public Integer addThing(String thingName);

	public Thing getThingByName(String thingName);
}
