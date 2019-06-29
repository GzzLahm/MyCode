package cn.edu.guet.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.edu.guet.entity.College;
import cn.edu.guet.service.CollegeService;
import cn.edu.guet.utils.ResponseUtil;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/college")
public class CollegeController {
	@Autowired
	private CollegeService collegeService;
	
	@RequestMapping("/list")
	public String CollegeListAll(HttpServletResponse response) throws Exception {
		List<College> collegeList=collegeService.getAll();
		JSONArray jsonArray=JSONArray.fromObject(collegeList);
		ResponseUtil.write(response, jsonArray);
		return null;
	}
}
