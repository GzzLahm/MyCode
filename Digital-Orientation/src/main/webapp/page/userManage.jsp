<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/usericons/myicon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath }/js/jquery.ocupload-1.1.2.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.cityselect.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function addUser() {
		$("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
	}
	function delUser() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		$.messager
		.confirm('系统提示','您确定要删除该用户吗?',function(isConfirm) {
			if (isConfirm) {
				$.post("${pageContext.request.contextPath }/user/delete.html",{"id":selectedRows[0].id},function(result){
					if(result.success){
						$.messager.alert("系统提示", "删除用户成功", "info", function() {
							$("#dlg").dialog("close");
							$('#dg').datagrid('reload');
						});
					}else{
						$.messager.alert("系统提示", "删除用户失败", "error", function() {
						});
					}
				},"json");
			}
		});
	}
	function editUser() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row = selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
		$("#fm").form("load", row);
		$("#password").val("");
	}
	function closeDialog() {
		$("#dlg").dialog("close");
	}
	function save() {

		$.extend($.fn.validatebox.defaults.rules, {   
		    phoneNum: { //验证手机号  
		        validator: function(value, param){
		         return /^1[3-9]+\d{9}$/.test(value);
		        },   
		        message: '请输入正确的手机号码。'  
		    }
		});
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath }/user/add.html",
			success : function(result) {
				result = eval("(" + result + ")");
				if(result.success==0){
					$.messager.alert("系统提示", "用户名已经存在", "warning", function() {
					});
				}else if(result.success==1){
					$.messager.alert("系统提示", "用户添加成功", "info", function() {
						$("#dlg").dialog("close");
						$('#dg').datagrid('reload');
					});
				}else if(result.success==3){
					$.messager.alert("系统提示", "用户修改成功", "info", function() {
						$("#dlg").dialog("close");
						$('#dg').datagrid('reload');
					});
				}
			}
		});
	}
	jQuery(document).ready(function(){
		$('#dlg').dialog({
		    onClose:function(){
		    	$("#fm").form("reset");
		  	}
		});
	});
	function auth() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		$("#dlg1").dialog("open").dialog("setTitle", "授予用户角色");
	}
	function assignRole() {
		var selectedRows = $("#dg").datagrid("getSelections");
		var row = selectedRows[0];
		var roleId=$("#role").val();
		$.post("${pageContext.request.contextPath }/user/assignRole.html",{"roleId":roleId,"userId":row.id},function(result){
			alert(result.success);
			if(result.success==0){
				$.messager.alert("系统提示", "该角色已经存在", "warning", function() {
				});
			}else if(result.success==1){
				$.messager.alert("系统提示", "角色添加成功", "info", function() {
					$("#dlg1").dialog("close");
					$('#dg').datagrid('reload');
				});
			}else if(result.success==3){
				$.messager.alert("系统提示", "请选择角色", "warning", function() {
				});
			}
		},"json");
	}
	function delAuth() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		$("#dlg2").dialog("open").dialog("setTitle", "授予用户角色");
	}
	function delRole() {
		var selectedRows = $("#dg").datagrid("getSelections");
		var row = selectedRows[0];
		var roleId=$("#role1").val();
		$.post("${pageContext.request.contextPath }/user/delRole.html",{"roleId":roleId,"userId":row.id},function(result){
			if(result.success==1){
				$.messager.alert("系统提示", "删除角色成功", "info", function() {
					$("#dlg2").dialog("close");
					$('#dg').datagrid('reload');
				});
			}else if(result.success==2){
				$.messager.alert("系统提示", "该角色未拥有", "warning", function() {
				});
			}else if(result.success==3){
				$.messager.alert("系统提示", "请选择角色", "warning", function() {
				});
			}
		},"json");
	}
</script>
</head>
<body>
	<table id="dg" title="用户信息管理" class="easyui-datagrid" pagination="true"
		rownumbers="true" 
		url="${pageContext.request.contextPath}/user/list.html" fit="true"
		toolbar="#tb">
		<thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="10" align="center" hidden="true">编号</th>
				<th field="userName" width="100" align="center">用户名</th>
				<th field="phone" width="150" align="center">电话</th>
				<th field="email" width="150" align="center">邮箱</th>
				<th field="majorName" width="150" align="center">专业</th>
				<th field="allRole" width="150" align="center">所拥有的角色</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding: 10px;">
		<a href="javascript:addUser()"
			id="add" class="easyui-linkbutton" iconCls="icon-add"
			plain="true">添加</a>
		<a href="javascript:editUser()"
			id="edit" class="easyui-linkbutton" iconCls="icon-edit"
			plain="true">修改</a>
		<a href="javascript:delUser()"
			id="del" class="easyui-linkbutton" iconCls="icon-remove"
			plain="true">删除</a>
		<a href="javascript:auth()"
			id="auth" class="easyui-linkbutton" iconCls="icon-man"
			plain="true">分配角色</a>
		<a href="javascript:delAuth()"
			id="auth" class="easyui-linkbutton" iconCls="icon-man"
			plain="true">删除角色</a>
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 350px; height: 300px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellpadding="5px">
				<tr>
					<td>用户名:</td>
					<td><input type="text" id="userName" name="userName"
						class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input type="text" id="password" name="password"
						class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td>电话:</td>
					<td><input type="text" id="phone" name="phone"
						class="easyui-validatebox" required="true" validType="phoneNum" missingMessage="电话不能空"/></td>
				</tr>
				<tr>
					<td>邮箱:</td>
					<td><input type="text" id="email" name="email"
						class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td>专业:</td><td> <input class="easyui-combobox" style="width: 220px; height: 25px"
						id="major" name="major.id"
						data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'majorName',
					url:'${pageContext.request.contextPath}/major/list.html'" /> </td>
				</tr>
			</table>
			<input type="hidden" id="id" name="id">
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:save()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
	<div id="dlg1" class="easyui-dialog"
		style="width: 350px; height: 300px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons1">
		<table>
			<tr>
				<td>角色:</td><td> <input class="easyui-combobox" style="width: 220px; height: 25px"
					id="role" name="role.id"
					data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'roleName',
				url:'${pageContext.request.contextPath}/role/alllist.html'" /> </td>
			</tr>
		</table>
	</div>
	<div id="dlg-buttons1">
		<a href="javascript:assignRole()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="dlg2" class="easyui-dialog"
		style="width: 350px; height: 300px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons2">
		<table>
			<tr>
				<td>角色:</td><td> <input class="easyui-combobox" style="width: 220px; height: 25px"
					id="role1" name="role.id"
					data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'roleName',
				url:'${pageContext.request.contextPath}/role/alllist.html'" /> </td>
			</tr>
		</table>
	</div>
	<div id="dlg-buttons2">
		<a href="javascript:delRole()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>