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
<script
	src="${pageContext.request.contextPath }/js/jquery.ocupload-1.1.2.js"
	type="text/javascript"></script>

<script type="text/javascript">
	var url;
	function seachMajor() {
		var collegeId=$("#college").val();
		var majorName=$("#major").val();
		var url="${pageContext.request.contextPath}/major/listPage.html?majorName="+majorName+"&&collegeId="+collegeId;
		$("#dg").datagrid({
			url:url
		});
		$("#dg").datagrid("reload");
	}
	function preSetTuition() {
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","设置专业学费");
		$("#fm").form("load",row);
		url="${pageContext.request.contextPath}/major/setTuition.html";
	}
	function setTuition() {
		$("#fm").form("submit",{
			url:url,
			success:function(result){
				result = eval("("+result+")");
				if(result.success){
					$.messager.alert("系统提示","设置专业学费成功","info",function(){
							$("#dlg").dialog("close");
						   $('#dg').datagrid('reload');
					});
				}
			}
		});
	}
	function closeDialog() {
		$("#dlg").dialog("close");
	}
	function closeDialog1() {
		$("#dlg1").dialog("close");
		$("#thingName").val("");
	}
	function closeDialog2() {
		$("#dlg2").dialog("close");
	}
	function preAddThing() {
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		}
		var row=selectedRows[0];
		$("#dlg1").dialog("open").dialog("setTitle","添加发放的物品");
		$("#fm1").form("load",row);
		url="${pageContext.request.contextPath}/major/addThing.html";
	}
	function addThing() {
		$("#fm1").form("submit",{
			url:url,
			success:function(result){
				result = eval("("+result+")");
				if(result.success){
					$.messager.alert("系统提示","添加物品成功","info",function(){
							$("#thingName").val("");
							$("#dlg1").dialog("close");
						   $('#dg').datagrid('reload');
					});
				}else{
					$.messager.alert("系统提示","物品已经存在","error",function(){
						$("#thingName").val("");
						$("#dlg1").dialog("close");
					   $('#dg').datagrid('reload');
					});
				}
			}
		});
	}
	function preDeleteThing() {
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		}
		var row=selectedRows[0];
		var things=selectedRows[0].thingString;
		$("#dlg2").dialog("open").dialog("setTitle","删除物品");
		$("#fm2").form("load",row);
		url="${pageContext.request.contextPath}/major/deleteThing.html";
		if((things!=null)&&(things!="")){
			var thingArr=things.split('、');
		}
		if(thingArr[0]!=""){
			for(var i=0;i<thingArr.length;i++){
				$("#delThing").append("<form id='form"+i+"' method='post' action='"+url+"?thingName="+thingArr[i]+"&&majorId="+selectedRows[0].id+"' style='padding-top:10px;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;物品名称:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' id='thingName' name='thingName' value='"+thingArr[i]+"'disabled='disabled' />&nbsp;&nbsp;&nbsp;&nbsp;<a id='del"+i+"' href='javascript:deleteThing("+i+")' title='删除'><img src='${pageContext.request.contextPath}/images/delete.png'></img></a></form>");
			}
		}
	}
	
	jQuery(document).ready(function(){
		$('#dlg2').dialog({
		    onClose:function(){
		    	$("#delThing").remove();
		    	$('#dlg2').append("<div id='delThing'></div>");
		    	$('#dg').datagrid('reload');
		  	}
		});
	});
	jQuery(document).ready(function(){
		$('#dlg1').dialog({
		    onClose:function(){
		    	$("#thingName").val("");
		  	}
		});
	});
	function deleteThing(flag) {
		var id="#del"+flag;
		var formId="#"+$(id).closest("form").attr("id");
		$(formId).form("submit",{
			success:function(result){
				result = eval("("+result+")");
				if(result.success){
					$.messager.alert("系统提示","删除物品成功","info",function(){
						$(formId).remove();
					});
				}
			}
		});
	}
</script>
</head>
<body>
	<table id="dg" title="专业信息管理" class="easyui-datagrid" pagination="true"
		rownumbers="true"
		url="${pageContext.request.contextPath}/major/listPage.html" fit="true"
		toolbar="#tb">
		<thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center" hidden="true">编号</th>
				<th field="majorName" width="100" align="center">专业名称</th>
				<th field="collegeName" width="200" align="center">所属学院</th>
				<th field="tuition" width="100" align="center">学费</th>
				<th field="thingString" width="300" align="center">物品</th>
			</tr>
		</thead>
	</table>
	<div id="tb">
		<div style="padding-top: 15px;">
			学院: <input class="easyui-combobox" style="width: 220px; height: 25px"
				id="college" name="college"
				data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'collegeName',
			url:'${pageContext.request.contextPath}/college/list.html'" />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 专业: <input type="text"
				class="easyui-validatebox" id="major" name="major" style="height: 20px;width: 240px;" onkeydown="if(event.keyCode==13) return seachMajor()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
				href="javascript:seachMajor()" id="searchMajor"
				class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
			<script type="text/javascript">
				$("#college")
						.combobox(
								{
									onSelect : function(college) {
										var majorName=$("#major").val();
										var url = "${pageContext.request.contextPath}/major/listPage.html?collegeId="+college.id+"&&majorName="+majorName;
										$("#dg").datagrid({
											url : url
										});
										$("#dg").datagrid("reload");
									}
								});
			</script>
		</div>
		<div>
			&nbsp;&nbsp; <a href="javascript:preSetTuition()"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true">设置学费</a>
			<a href="javascript:preAddThing()" class="easyui-linkbutton"
				iconCls="icon-add" plain="true">添加物品</a> <a
				href="javascript:preDeleteThing()" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true">删除物品</a>
		</div>
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 350px; height: 400px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellpadding="15px">
				<tr>
					<td>专业名称:</td>
					<td><input type="text" id="majorName" name="majorName"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
				<tr>
					<td>所属学院:</td>
					<td><input type="text" id="collegeName" name="collegeName"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
				<tr>
					<td>学费:</td>
					<td><input type="text" id="tuition" name="tuition"
						class="easyui-numberbox" required="true"
						data-options="min:0,precision:2" /></td>
				</tr>
				<tr>
					<td><input type="hidden" name="id" id="id" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg1" class="easyui-dialog"
		style="width: 350px; height: 400px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons1">
		<form id="fm1" method="post">
			<table cellpadding="15px">
				<tr>
					<td>专业名称:</td>
					<td><input type="text" id="majorName" name="majorName"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
				<tr>
					<td>所属学院:</td>
					<td><input type="text" id="collegeName" name="collegeName"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
				<tr>
					<td>物品名称:</td>
					<td><input type="text" id="thingName" name="thingName"
						class="easyui-validatebox" required="true" /></td>
				</tr>
				<tr>
					<td><input type="hidden" name="id" id="id" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg2" class="easyui-dialog"
		style="width: 450px; height: 400px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons2">
		<form id="fm2" method="post">
			<input type="hidden" name="id" id="id" style="display: none;"/>
			<table cellpadding="15px">
				<tr>
					<td>专业名称:</td>
					<td><input type="text" id="majorName" name="majorName"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
				<tr>
					<td>所属学院:</td>
					<td><input type="text" id="collegeName" name="collegeName"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
			</table>
		</form>
		<div id="delThing">
		</div>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:setTuition()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="dlg-buttons1">
		<a href="javascript:addThing()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog1()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="dlg-buttons2">
		<a href="javascript:closeDialog2()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>