package cn.edu.guet.realm;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import cn.edu.guet.entity.User;
import cn.edu.guet.service.MajorService;
import cn.edu.guet.service.UserService;

public class MyRealm extends AuthorizingRealm{
	@Resource
	private UserService userService;
	@Resource
	private MajorService majorService;
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken passwordToken = (UsernamePasswordToken)token;
		String userName = passwordToken.getUsername();
		User existUser=userService.getUserByName(userName);
		if(existUser==null) {
			return null;
		}
		AuthenticationInfo info = new SimpleAuthenticationInfo(existUser, existUser.getPassword(), existUser.getUserName());
		//框架负责比对数据库中的密码和页面输入的密码是否一致
		return info;
	}

}
