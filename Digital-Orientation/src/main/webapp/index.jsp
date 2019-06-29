<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数字迎新系统</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<!-- 导入ztree类库 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"
	type="text/css" />
<script
	src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/usericons/myicon.css">
<script type="text/javascript">
	// 初始化ztree菜单
	$(function() {
		var setting = {
			data : {
				simpleData : { // 简单数据 
					enable : true
				}
			},
			callback : {
				onClick : onClick
			}
		};
		
		// 基本功能菜单加载
		$.ajax({
			url : '${pageContext.request.contextPath}/function/getMenu.html',
			type : 'POST',
			dataType : 'text',
			success : function(data) {
				var zNodes = eval("(" + data + ")");
				$.fn.zTree.init($("#treeMenu"), setting, zNodes);
			},
			error : function(msg) {
				alert('菜单加载异常!');
			}
		});
		
		// 系统管理菜单加载
		$.ajax({
			url : '${pageContext.request.contextPath}/json/admin.json',
			type : 'POST',
			dataType : 'text',
			success : function(data) {
				var zNodes = eval("(" + data + ")");
				$.fn.zTree.init($("#adminMenu"), setting, zNodes);
			},
			error : function(msg) {
				alert('菜单加载异常!');
			}
		});
		
		// 页面加载后 右下角 弹出窗口
		/**************/
		window.setTimeout(function(){
			var userName=$("#loginUser").text();
			var msg="欢迎登录,<strong style='color: red;'>"+userName+"</strong>";
			$.messager.show({
				title:"消息提示",
				msg:msg,
				timeout:5000
			});
		},3000);
		/*************/
	});

	function onClick(event, treeId, treeNode, clickFlag) {
		// 判断树菜单节点是否含有 page属性
		if (treeNode.page!=undefined && treeNode.page!= "") {
			var content = '<div style="width:100%;height:100%;overflow:hidden;">'
					+ '<iframe src="'
					+"${pageContext.request.contextPath }/"+ treeNode.page
					+ '" scrolling="auto" style="width:100%;height:100%;border:0;" ></iframe></div>';
			if ($("#tabs").tabs('exists', treeNode.name)) {// 判断tab是否存在
				$('#tabs').tabs('select', treeNode.name); // 切换tab
				var tab = $('#tabs').tabs('getSelected'); 
				$('#tabs').tabs('update', {
				    tab: tab,
				    options: {
				        title: treeNode.name,
				        content: content
				    }
				});
			} else {
				// 开启一个新的tab页面
				$('#tabs').tabs('add', {
					title : treeNode.name,
					content : content,
					closable : true
				});
			}
		}
	}

	function editPassword() {
		$('#editPwdWindow').window('open');
	}
	function closeDialog() {
		$('#editPwdWindow').window('close');
	}
	function resetPass() {
		var originPass=$("#originPass").val();
		var txtRePass=$("#txtRePass").val();
		var txtNewPass=$("#txtNewPass").val();
		if(txtRePass==txtNewPass){
			$.post("${pageContext.request.contextPath}/user/editPassword.html",{
				"originPass":originPass,
				"password":txtRePass
			},function(result){
				alert(result.success);
				if(result.success=="1"){
					$.messager.alert("系统提示","修改密码成功！","info",function(){
						$('#editPwdWindow').window('close');
						location.href = "${pageContext.request.contextPath }/login.jsp";
					});
				}else if(result.success=="3"){
					$.messager.alert("系统提示","原密码不正确","warning",function(){
					});
				}else{
					$.messager.alert("系统提示","修改密码失败！","error",function(){
					});
				}
			},"json");
			
		}else{
			$.messager.alert("系统提示","两次密码不相同","warning",function(){
			});
		}
	}
	jQuery(document).ready(function(){
		$('#editPwdWindow').dialog({
		    onClose:function(){
		    	$("#fm").form("reset");
		  	}
		});
	});
	function logoutFun() {
		$.messager
		.confirm('系统提示','您确定要退出本次登录吗?',function(isConfirm) {
			if (isConfirm) {
				location.href = '${pageContext.request.contextPath }/user/logout.html';
			}
		});
	}
</script>
</head>
<body class="easyui-layout">
    <div region="north" style="height: 78px;background-color: white;overflow: hidden;">
    	<img src="${pageContext.request.contextPath }/images/logo.png" height="78px">
    	<div id="sessionInfoDiv"
			style="position: absolute;right: 5px;top:10px;">
			[<strong style="color: red;" id="loginUser">${loginUser.userName }</strong>]，欢迎你！
		</div>
		<div style="position: absolute; right: 5px; bottom: 10px; ">
			<a href="javascript:void(0);" class="easyui-menubutton"
				data-options="menu:'#layout_north_kzmbMenu',iconCls:'icon-help'">控制面板</a>
		</div>
    	<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
			<div onclick="editPassword();">修改密码</div>
			<div class="menu-sep"></div>
			<div onclick="logoutFun();">退出系统</div>
		</div>
    </div>
    <div region="center">
    	<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" data-options="iconCls:'icon-home'">
				<div align="center" style="padding-top: 100px"><font color="red" size="10">欢迎使用</font></div>
			</div>
		</div>
    </div>
    <div region="west"  style="width: 200px" title="导航菜单" split="true">
    	<div class="easyui-accordion" fit="true" border="false">
			<div title="基本功能" data-options="iconCls:'icon-mini-add'" style="overflow:auto">
				<ul id="treeMenu" class="ztree"></ul>
			</div>
			<c:if test="${admin==1}">
				<div title="系统管理" data-options="iconCls:'icon-mini-add'" style="overflow:auto">  
					<ul id="adminMenu" class="ztree"></ul>
				</div>
			</c:if>
		</div>
    </div>
    <div region="south" style="height: 40px;padding: 5px" align="center">
    
    </div>
    <!--修改密码窗口-->
    <div id="editPwdWindow" class="easyui-window" title="修改密码" collapsible="false" minimizable="false" modal="true" closed="true" resizable="false"
        maximizable="false" icon="icon-save"  style="width: 350px; height: 230px; padding: 5px;
        background: #fafafa">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <form id="fm">
	               <table cellpadding=3>
	                   <tr>
	                       <td>原密码：</td>
	                       <td><input id="originPass" type="Password" class="easyui-validatebox" required="true" /></td>
	                   </tr>
	                   <tr>
	                       <td>新密码：</td>
	                       <td><input id="txtNewPass" type="Password" class="easyui-validatebox" required="true" /></td>
	                   </tr>
	                   <tr>
	                       <td>确认密码：</td>
	                       <td><input id="txtRePass" type="Password" class="easyui-validatebox" required="true"/></td>
	                   </tr>
	               </table>
                </form>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:resetPass()" >确定</a> 
                <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:closeDialog()">取消</a>
            </div>
        </div>
    </div>
</body>
</html>