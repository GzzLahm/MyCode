<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数字迎新系统</title>
<link href="${pageContext.request.contextPath }/css/login.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.code.js"></script>
<script type="text/javascript">
	$(function () {
	    $('.creatCode').createCode({
	      len:4
	    });
	  });
	function checkForm() {
		var error="<%=session.getAttribute("error")%>"; 
		//验证码的值
		var codeV=$("#creatCode").text();
		var userName=$("#userName").val();
		var password=$("#password").val();
		//验证码框里的值
		var code=$("#code").val();
		if(userName==""||userName==null){
			alert("用户名不能为空！");
			return false;
		}else if(password==""||password==null){
			alert("密码不能为空！");
			return false;
		}
		else if(code==""||code==null){
			alert("验证码不能为空！");
			return false;
		}else if(codeV!=code){
			alert("验证码不正确！");
			return false;
		}
	}
</script>
</head>
<body>
<div class="main-login">
    <div class="login-logo">
	    	<center><font color="yellow" size="20">数字迎新系统登录</font></center>
    </div>
    <div class="login-content">
        <form action="${pageContext.request.contextPath }/user/login.html" method="post" id="login-form" name="login-form" onsubmit="return checkForm()">
            <div class="login-info">
                <span class="user">&nbsp;</span>
                <input name="userName" id="userName" type="text" placeholder="用户名..." class="login-input"/>
            </div>
            <div class="login-info">
                <span class="pwd">&nbsp;</span>
                <input name="password" id="password" type="password" placeholder="密码..."
                       class="login-input"/>
            </div>
            <div>
	            <table>
	            	<tr>
		            	<td>
		            		<div class="login-code">
			            		<span class="code">&nbsp;</span>
			                	<input name="code" id="code" type="text" class="input-code" placeholder="验证码..."/>
		                	</div>
		                </td>	
	                	<td><span class="creatCode"  id="creatCode" title='点击切换' style="font-size: 20px;vertical-align: middle;margin-top: 20px;margin-left: 10px;"></span></td>
	            	</tr>
	            </table>
            </div>
            <div class="login-oper">
	            <input name="submit" type="submit" value="登 录" class="login-btn" />
            </div>
        </form>
        <center>
        	<font color="red">${error}</font>
        </center>
    </div>
</div>
</body>

</body>
</html>