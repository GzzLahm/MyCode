package cn.edu.guet.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cn.edu.guet.entity.Role;
import cn.edu.guet.entity.User;
import cn.edu.guet.service.UserRoleService;
import cn.edu.guet.service.UserService;
import cn.edu.guet.utils.Md5Util;
import cn.edu.guet.utils.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private UserService userService;
	@Autowired
	private UserRoleService userRoleService;

	@RequestMapping("/login")
	public ModelAndView login(User user, HttpServletRequest request, HttpSession httpSession) {
		ModelAndView mav = new ModelAndView();
		if (user.getPassword() != null && user.getUserName() != null) {
			Subject subject = SecurityUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(),
					Md5Util.md5(user.getPassword(), user.getUserName()));
			try {
				subject.login(token); // 登录验证
				if(httpSession.getAttribute("loginUser")!=null) {
					httpSession.removeAttribute("loginUser");
					httpSession.removeAttribute("admin");
				}
				mav.setViewName("index");
				User loginUser = userService.getUserByName(user.getUserName());
				httpSession.setAttribute("loginUser", loginUser);
				httpSession.setAttribute("major", loginUser.getMajor());
				for (Role role : loginUser.getRoles()) {
					if (role.getRoleName().equals("超级管理员")) {
						httpSession.setAttribute("admin", 1);
					}
				}
				return mav;
			} catch (Exception e) {
				e.printStackTrace();
				mav.setViewName("login");
				mav.addObject("error", "用户名或者密码错误！");
				return mav;
			}
		} else {
			mav.setViewName("login");
			return mav;
		}
	}

	@RequestMapping("/editPassword")
	public String editPassword(String originPass, String password, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("loginUser");
		JSONObject result = new JSONObject();
		if (currentUser.getPassword().equals(Md5Util.md5(originPass, currentUser.getUserName()))) {
			currentUser = userService.getUserByName(currentUser.getUserName());
			currentUser.setPassword(Md5Util.md5(password, currentUser.getUserName()));
			int total = userService.updatePassword(currentUser);
			if (total > 0) {
				result.put("success", "1");
				HttpSession session = request.getSession();
				session.invalidate();
			} else {
				result.put("success", "2");
			}
		} else {
			result.put("success", "3");
		}
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session != null) {
			// 清除session
			session.invalidate();
		}
		// 重定向到登录页面的跳转方法
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}

	@RequestMapping("/list")
	public String list(@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows, HttpServletResponse response)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (Integer.parseInt(page) - 1) * Integer.parseInt(rows);
		map.put("start", start);
		map.put("size", Integer.parseInt(rows));
		List<User> list = userService.getUserByPage(map);
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(list);
		int total = userService.getTotal();
		result.put("total", total);
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/add")
	public String add(User user, HttpServletResponse response) throws Exception {
		JSONObject result = new JSONObject();
		user.setPassword(Md5Util.md5(user.getPassword(), user.getUserName()));
		if ((userService.getUserByName(user.getUserName()) != null) && (user.getId() == null)) {
			result.put("success", 0);
		} else {

			if (user.getId() == null) {
				int total = userService.add(user);
				if (total > 0) {
					result.put("success", 1);
				} else {
					result.put("success", 2);
				}
			} else {
				int total = userService.update(user);
				if (total > 0) {
					result.put("success", 3);
				} else {
					result.put("success", 4);
				}
			}
		}
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/delete")
	public String delete(String id, HttpServletResponse response) throws Exception {
		User user = userService.getUserById(Integer.parseInt(id));
		if (user.getRoles().size() > 0) {
			userRoleService.deleteByUserId(user.getId());
		}
		int total = userService.delete(Integer.parseInt(id));
		JSONObject result = new JSONObject();
		if (total > 0) {
			result.put("success", 1);
		} else {
			result.put("success", 0);
		}
		ResponseUtil.write(response, result);
		return null;
	}

	@RequestMapping("/assignRole")
	public String assignRole(HttpServletResponse response, String roleId, String userId) throws Exception {
		User user=userService.getUserById(Integer.parseInt(userId));
		JSONObject result = new JSONObject();
		Map<String,Object> map=new HashMap<>();
		if((roleId!=null)&&(!roleId.equals(""))) {
			if(user.getRoles().size()>0) {
				for(Role role:user.getRoles()) {
					if(role.getId()==Integer.parseInt(roleId)) {
						result.put("success", 0);
						ResponseUtil.write(response, result);
						return null;
					}
				}
			}
			map.put("roleId", Integer.parseInt(roleId));
			map.put("userId", Integer.parseInt(userId));
			int total=userRoleService.add(map);
			if(total>0) {
				result.put("success", 1);
				ResponseUtil.write(response, result);
				return null;
			}else {
				result.put("success", 2);
				ResponseUtil.write(response, result);
				return null;
			}
		}else {
			result.put("success", 3);
			ResponseUtil.write(response, result);
			return null;
		}
	}
	@RequestMapping("/delRole")
	public String delRole(HttpServletResponse response, String roleId, String userId) throws Exception {
		User user=userService.getUserById(Integer.parseInt(userId));
		JSONObject result = new JSONObject();
		Map<String,Object> map=new HashMap<>();
		if((roleId!=null)&&(!roleId.equals(""))) {
			if(user.getRoles().size()>0) {
				for(Role role:user.getRoles()) {
					if(role.getId()==Integer.parseInt(roleId)) {
						map.put("roleId", roleId);
						map.put("userId", userId);
						int total=userRoleService.deleteRole(map);
						if(total>0) {
							result.put("success", 1);
							ResponseUtil.write(response, result);
							return null;
						}else {
							result.put("success", 0);
							ResponseUtil.write(response, result);
							return null;
						}
					}
				}
				result.put("success", 2);
				ResponseUtil.write(response, result);
				return null;
			}else {
				result.put("success", 2);
				ResponseUtil.write(response, result);
				return null;
			}
		}
		else {
			result.put("success", 3);
			ResponseUtil.write(response, result);
			return null;
		}
	}
}
