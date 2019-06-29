package cn.edu.guet.service;

import cn.edu.guet.entity.Thing;

public interface ThingService {
	public Integer addThing(String thingName);
	public Thing getThingByName(String thingName);
	public Thing getThingById(int parseInt);
}
