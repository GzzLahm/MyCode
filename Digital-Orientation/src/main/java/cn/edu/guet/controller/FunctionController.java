package cn.edu.guet.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.edu.guet.entity.Function;
import cn.edu.guet.service.FunctionService;
import cn.edu.guet.utils.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/function")
public class FunctionController {
	@Autowired
	private FunctionService functionService;
	@RequestMapping("/getMenu")
	public String getMenu(HttpServletResponse response,HttpSession session) throws Exception{
		List<Function> list=functionService.getMenu(session);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] {"parentFunction","roles","children","url","generatemenu","privilegeName","zindex"});
		JSONArray data = JSONArray.fromObject(list, jsonConfig);
		ResponseUtil.write(response, data);
		return null;
	}
	@RequestMapping("/functionList")
	public String getFunction(HttpServletResponse response) throws Exception{
		List<Function> list=functionService.getAllFunction();
		JSONArray data = JSONArray.fromObject(list);
		System.out.println(data);
		ResponseUtil.write(response, data);
		return null;
	}
}
