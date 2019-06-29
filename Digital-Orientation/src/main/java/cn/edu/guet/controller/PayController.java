package cn.edu.guet.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.guet.entity.PayRecord;
import cn.edu.guet.entity.Student;
import cn.edu.guet.entity.User;
import cn.edu.guet.service.PayRecordService;
import cn.edu.guet.service.StudentService;
import cn.edu.guet.service.UserService;
import cn.edu.guet.utils.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/pay")
public class PayController {
	@Autowired
	private UserService userService;
	@Autowired
	private StudentService studentService;
	@Autowired
	private PayRecordService payRecordService;

	@RequestMapping("/payTuition")
	public String payTuition(int stuId, int way, String voucher, BigDecimal amount, HttpServletResponse response,HttpSession httpSession)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		User currentUser = (User) httpSession.getAttribute("loginUser");
		currentUser = userService.getUserByName(currentUser.getUserName());
		map.put("stuId", stuId);
		map.put("way", way);
		map.put("voucher", voucher);
		map.put("amount", amount);
		map.put("userId", currentUser.getId());
		Student student = studentService.getStudentById(stuId);
		JSONObject result = new JSONObject();
		if (student.getMajor().getTuition().compareTo(amount.add(student.getPaiedTuition())) >= 0) {
			int payAdd = payRecordService.add(map);
			if (payAdd > 0) {
				result.put("success", 1);
			}
		} else {
			result.put("success", 0);
		}
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/list")
	public String listStudent(@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "studentId", required = false) String studentId,
			@RequestParam(value = "stuName", required = false) String stuName,
			@RequestParam(value = "majorId", required = false) String majorId, HttpServletResponse response)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (Integer.parseInt(page) - 1) * Integer.parseInt(rows);
		map.put("start", start);
		map.put("size", Integer.parseInt(rows));
		if ((studentId != null) && (studentId != "")) {
			map.put("studentId", studentId);
		}
		if ((stuName != null) && (stuName != "")) {
			map.put("stuName", stuName);
		}
		if ((majorId != null) && (majorId != "")) {
			map.put("majorId", majorId);
		}
		List<PayRecord> list = payRecordService.getPayRecordByPage(map);
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "student", "user", "createtime" });
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list, jsonConfig);
		int total = payRecordService.getTotal(map);
		result.put("total", total);
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/deleteRecord")
	public String deleteRecord(String id,HttpServletResponse response) throws Exception{
		int total=payRecordService.delete(Integer.parseInt(id));
		JSONObject result = new JSONObject();
		if(total>0) {
			result.put("success", 1);
		}else {
			result.put("success", 0);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/editRecord")
	public String editRecord(String id,String amount,String voucher,HttpServletResponse response) throws Exception{
		Map<String,Object> map=new HashMap<>();
		map.put("amount", new BigDecimal(amount));
		map.put("id", Integer.parseInt(id));
		map.put("voucher", voucher);
		int total=payRecordService.update(map);
		JSONObject result = new JSONObject();
		if(total>0) {
			result.put("success", 1);
		}else {
			result.put("success", 0);
		}
		ResponseUtil.write(response, result);
		return null;
	}
}
