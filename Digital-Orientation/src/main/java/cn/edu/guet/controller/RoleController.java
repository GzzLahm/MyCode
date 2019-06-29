package cn.edu.guet.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.guet.entity.Role;
import cn.edu.guet.entity.RoleFunction;
import cn.edu.guet.service.RoleService;
import cn.edu.guet.service.impl.RoleFunctionSevice;
import cn.edu.guet.utils.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private RoleService roleService;
	@Autowired
	private RoleFunctionSevice roleFunctionSevice;
	@RequestMapping("/alllist")
	public String roleAllList(HttpServletResponse response) throws Exception {
		List<Role> roles=roleService.getAllRole();
		JSONArray jsonArray = JSONArray.fromObject(roles);
		ResponseUtil.write(response, jsonArray);
		return null;
	}
	@RequestMapping("/list")
	public String roleList(HttpServletResponse response,@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (Integer.parseInt(page) - 1) * Integer.parseInt(rows);
		map.put("start", start);
		map.put("size", Integer.parseInt(rows));
		List<Role> list=roleService.getRoleByPage(map);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		int total = roleService.getTotal();
		result.put("total", total);
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/update")
	public String update(Role role,HttpServletResponse response)throws Exception{
		JSONObject result = new JSONObject();
		if(role.getId()!=null) {
			Role existRole=roleService.getRoleByName(role.getRoleName());
			if(existRole!=null) {
				int total=roleService.update(role);
				if(total>0) {
					result.put("success", 1);
				}else {
					result.put("success", 2);
				}
			}else {
				result.put("success", 0);
			}
		}else {
			int total=roleService.add(role);
			if(total>0) {
				result.put("success", 3);
			}else {
				result.put("success", 4);
			}
		}
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/fuctionSave")
	public String fuctionSave(String functionId,String roleId,HttpServletResponse response) throws Exception{
		JSONObject result = new JSONObject();
		System.out.println("==============");
		if(functionId==null) {
			result.put("success", 0);
		}else {
			Map<String,Object> map=new HashMap<>();
			map.put("functionId", Integer.parseInt(functionId));
			map.put("roleId", Integer.parseInt(roleId));
			RoleFunction roleFunctions=roleFunctionSevice.getByMap(map);
			if(roleFunctions!=null) {
				result.put("success", 1);
			}else {
				int total=roleFunctionSevice.add(map);
				if(total>0) {
					result.put("success", 2);
				}else {
					result.put("success", 3);
				}
			}
		}
		ResponseUtil.write(response, result);
		return null;
	}
}
