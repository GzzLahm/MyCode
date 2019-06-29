<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script type="text/javascript">
	function preAddRole() {
		$("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
	}
	jQuery(document).ready(function(){
		$('#dlg').dialog({
		    onClose:function(){
		    	$("#fm").form("reset");
		  	}
		});
	});
	function closeDialog() {
		$("#dlg1").dialog("close");
	}
	function editRole() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row = selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle", "编辑角色信息");
		$("#fm").form("load", row);
	}
	function save() {
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath }/role/update.html",
			success : function(result) {
				result = eval("(" + result + ")");
				if(result.success==0){
					$.messager.alert("系统提示", "角色名已经存在", "warning", function() {
					});
				}else if(result.success==3){
					$.messager.alert("系统提示", "角色添加成功", "info", function() {
						$("#dlg").dialog("close");
						$('#dg').datagrid('reload');
					});
				}else if(result.success==1){
					$.messager.alert("系统提示", "角色修改成功", "info", function() {
						$("#dlg").dialog("close");
						$('#dg').datagrid('reload');
					});
				}
			}
		});
	}
	function functionAdd() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		$("#dlg1").dialog("open").dialog("setTitle", "添加权限");
	}
	function functionSave() {
		var selectedRows = $("#dg").datagrid("getSelections");
		var row = selectedRows[0];
		var functionId=$("#function1").val();
		alert(row.id);
		$.post("${pageContext.request.contextPath }/role/fuctionSave.html",{"functionId":functionId,"roleId":row.id},function(result){
			if(result.success==0){
				$.messager.alert("系统提示", "请选择权限", "warning", function() {
				});
			}else if(result.success==1){
				$.messager.alert("系统提示", "权限已经存在", "warning", function() {
					$("#dlg1").dialog("close");
				});
			}else if(result.success==2){
				$.messager.alert("系统提示", "权限添加成功", "info", function() {
				});
			}
		},"json");
	}
</script>
</head>
<body>
	<table id="dg" title="角色信息管理" class="easyui-datagrid" pagination="true"
		rownumbers="true" fit="true"
		url="${pageContext.request.contextPath}/role/list.html"
		toolbar="#tb">
		<thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center" hidden="true">编号</th>
				<th field="roleName" width="150" align="center">角色名</th>
				<th field="description" width="300" align="center">角色描述</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding-top: 15px;padding-bottom: 15px;">
		<a href="javascript:preAddRole()" class="easyui-linkbutton"
				iconCls="icon-add" plain="true">添加</a> 
		<a href="javascript:editRole()" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true">修改</a> 
		<a href="javascript:functionAdd()" class="easyui-linkbutton"
				iconCls="icon-man" plain="true">授权</a> 
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 350px; height: 300px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellpadding="5px">
				<tr>
					<td>角色名:</td>
					<td><input type="text" id="roleName" name="roleName"
						class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td>角色描述:</td>
					<td><input type="text" id="description" name="description"
						class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
			<input id="id" name="id" type="hidden"/> 
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:save()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="dlg1" class="easyui-dialog"
		style="width: 350px; height: 300px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons2">
		<table>
			<tr>
				<td>权限:</td><td> <input class="easyui-combobox" style="width: 220px; height: 25px"
					id="function1" name="function.id"
					data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'privilegeName',
				url:'${pageContext.request.contextPath}/function/functionList.html'" /> </td>
			</tr>
		</table>
	</div>
	<div id="dlg-buttons2">
		<a href="javascript:functionSave()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>