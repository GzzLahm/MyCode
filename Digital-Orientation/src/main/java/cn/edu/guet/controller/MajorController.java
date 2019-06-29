package cn.edu.guet.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.guet.entity.Major;
import cn.edu.guet.entity.Thing;
import cn.edu.guet.service.MajorService;
import cn.edu.guet.service.ThingService;
import cn.edu.guet.service.Thing_MajorService;
import cn.edu.guet.utils.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/major")
public class MajorController {
	@Autowired
	private MajorService majorService;
	@Autowired
	private ThingService thingService;
	@Autowired
	private Thing_MajorService thing_MajorService;

	@RequestMapping("/list")
	public String majorList(HttpServletResponse response,
			@RequestParam(value = "collegeId", required = false) String collegeId,
			@RequestParam(value = "majorName", required = false) String majorName) throws Exception {
		List<Major> majorList = new ArrayList<Major>();
		Map<String, Object> map = new HashMap<String, Object>();
		if ((collegeId != null) && (!collegeId.equals(""))) {
			int cId = Integer.parseInt(collegeId);
			map.put("collegeId", cId);
		}
		if ((majorName != null) && (!majorName.equals(""))) {
			map.put("majorName", majorName);
		}
		majorList = majorService.getMajorByMap(map);
		int total = majorService.getTotal(map);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "college" });
		JSONArray jsonArray = JSONArray.fromObject(majorList, jsonConfig);
		JSONObject result = new JSONObject();
		result.put("total", total);
		result.put("rows", jsonArray);
		ResponseUtil.write(response, jsonArray);
		return null;
	}

	@RequestMapping("/listPage")
	public String majorListPage(@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows, HttpServletResponse response,
			@RequestParam(value = "collegeId", required = false) String collegeId,
			@RequestParam(value = "majorName", required = false) String majorName) throws Exception {
		List<Major> majorList = new ArrayList<Major>();
		Map<String, Object> map = new HashMap<String, Object>();
		if ((collegeId != null) && (!collegeId.equals(""))) {
			int cId = Integer.parseInt(collegeId);
			map.put("collegeId", cId);
		}
		if ((majorName != null) && (!majorName.equals(""))) {
			map.put("majorName", majorName);
		}
		int start = (Integer.parseInt(page) - 1) * Integer.parseInt(rows);
		map.put("start", start);
		map.put("size", Integer.parseInt(rows));
		majorList = majorService.getMajorByMap(map);
		int total = majorService.getTotal(map);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "college" });
		JSONArray jsonArray = JSONArray.fromObject(majorList, jsonConfig);
		JSONObject result = new JSONObject();
		result.put("total", total);
		result.put("rows", jsonArray);
		ResponseUtil.write(response, jsonArray);
		return null;
	}

	@RequestMapping("/setTuition")
	public String setTuition(Major major, HttpServletResponse response) throws Exception {
		int total = majorService.updateMajor(major);
		JSONObject result = new JSONObject();
		if (total > 0) {
			result.put("success", true);
		} else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/addThing")
	public String addThing(Major major, HttpServletResponse response, String thingName) throws Exception {
		Major existMajor = majorService.getMajorByName(major.getMajorName());
		JSONObject result = new JSONObject();
		for (Thing thing : existMajor.getThings()) {
			if (thing.getThingName().equals(thingName)) {
				result.put("success", false);
				ResponseUtil.write(response, result);
				return null;
			}
		}
		Thing thing = thingService.getThingByName(thingName);
		if (thing == null) {
			thingService.addThing(thingName);
			thing = thingService.getThingByName(thingName);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("majorId", existMajor.getId());
		map.put("thingId", thing.getId());
		int total = thing_MajorService.addThing_Major(map);
		if (total > 0) {
			result.put("success", true);
			ResponseUtil.write(response, result);
		}
		return null;
	}

	@RequestMapping("/deleteThing")
	public String deleteThing(String thingName, String majorId, HttpServletResponse response) throws Exception {
		Thing thing = thingService.getThingByName(thingName);
		Major major = majorService.getMajorById(Integer.parseInt(majorId));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("thingId", thing.getId());
		map.put("majorId", major.getId());
		int total = thing_MajorService.deleteThing_Major(map);
		JSONObject result = new JSONObject();
		if (total > 0) {
			result.put("success", true);
		} else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
}
