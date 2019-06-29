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
	function searchStu() {
		var studentId = $("#stuId").val();
		var majorId = $("#major").val();
		var url = "${pageContext.request.contextPath}/student/list.html?studentId="
				+ studentId + "&&majorId=" + majorId;
		$("#dg").datagrid({
			url : url
		});
		$("#dg").datagrid("reload");
	}
	function preDistribute() {
		var selectedRows = $("#dg").datagrid("getSelections");
		if (selectedRows.length != 1) {
			$.messager.alert("系统提示", "请选择一条要编辑的数据！");
			return;
		}
		var row = selectedRows[0];
		var id = row.id;
		var thingGet = row.thingGet;
		$
				.ajax({
					type : "POST",
					url : "${pageContext.request.contextPath}/student/preDistribute.html",
					data : {
						"id" : id,
						"thingGet" : thingGet
					},
					dataType : "json",
					success : function(result) {
						for (var i = 0; i < result.things.length; i++) {
							var strHtml = "<input value='"+result.things[i].id+"' name='things' class='easyui-checkbox' type='checkbox'/>"
									+ "&nbsp;&nbsp;&nbsp;"
									+ result.things[i].thingName + "<br/>";
							$.parser.parse($('#distribute').append(strHtml));
						}
						$("#dlg").dialog("open").dialog("setTitle", "发放物品");
					}
				});
	}
	function distributeThing() {
		var things = document.getElementsByName("things");
		var thingIds = [];
		for (k in things) {
			if (things[k].checked)
				thingIds.push(things[k].value);
		}
		var ids = thingIds.join(",");
		var selectedRows = $("#dg").datagrid("getSelections");
		var row = selectedRows[0];
		var id = row.id;
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/student/distribute.html",
			data : {
				"ids" : ids,
				"id" : id
			},
			dataType : "json",
			success : function(result) {
				if (result.success) {
					$.messager.alert("系统提示", "发放物品成功", "info", function() {
						$("#dlg").dialog("close");
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
	}
	jQuery(document).ready(function() {
		$('#dlg').dialog({
			onClose : function() {
				$("#distribute").remove();
				$('#dlg').append("<div id='distribute'></div>");
				$('#dg').datagrid('reload');
			}
		});
	});
	function searchStu() {
		var studentId = $("#stuId").val();
		var majorId = $("#major").val();
		var stuName = $("#stuName").val();
		var url = "${pageContext.request.contextPath}/student/list.html?studentId="
				+ studentId + "&&majorId=" + majorId + "&&stuName=" + stuName;
		;
		$("#dg").datagrid({
			url : url
		});
		$("#dg").datagrid("reload");
	}
	
	function preDeleteThing() {
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			 return;
		}
		var row=selectedRows[0];
		var things=selectedRows[0].thingGet;
		$("#dlg1").dialog("open").dialog("setTitle","删除物品");
		$("#fm").form("load",row);
		url="${pageContext.request.contextPath}/student/deleteThing.html";
		if((things!=null)&&(things!="")){
			var thingArr=things.split('、');
		}
		if(thingArr[0]!=""){
			for(var i=0;i<thingArr.length;i++){
				$("#delThing").append("<form id='form"+i+"' method='post' action='"+url+"?thingName="+thingArr[i]+"&&sid="+selectedRows[0].id+"' style='padding-top:10px;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;物品名称:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' id='thingName' name='thingName' value='"+thingArr[i]+"'disabled='disabled' />&nbsp;&nbsp;&nbsp;&nbsp;<a id='del"+i+"' href='javascript:deleteThing("+i+")' title='删除'><img src='${pageContext.request.contextPath}/images/delete.png'></img></a></form>");
			
			}
		}
	}
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
	jQuery(document).ready(function(){
		$('#dlg1').dialog({
		    onClose:function(){
		    	$("#delThing").empty();
		    	$('#dg').datagrid('reload');
		  	}
		});
	});
</script>
</head>
<body>
	<table id="dg" title="发放物品管理" class="easyui-datagrid" pagination="true"
		rownumbers="true"
		url="${pageContext.request.contextPath}/student/list.html" fit="true"
		toolbar="#tb">
		<thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center" hidden="true">编号</th>
				<th field="studentId" width="100" align="center">学号</th>
				<th field="studentName" width="200" align="center">学生姓名</th>
				<th field="majorName" width="100" align="center">专业</th>
				<th field="thingGet" width="300" align="center">已经领取的物品</th>
				<th field="thingNotGet" width="300" align="center">未领取的物品</th>
				<th field="isRegister" width="70" align="center">是否报到</th>
				<th field="isGreen_channel" width="70" align="center">绿色通道</th>
				<th field="paiedTuition" width="80" align="center">已交学费</th>
			</tr>
		</thead>
	</table>
	<div id="tb">
		<div style="padding-top: 15px;">
			专业: <input class="easyui-combobox" style="width: 220px; height: 25px"
				id="major" name="major"
				data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'majorName',
			url:'${pageContext.request.contextPath}/major/list.html'" />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 学号: <input type="text"
				style="height: 23px; width: 184px;" class="easyui-validatebox"
				id="stuId" name="stuId"
				onkeydown="if(event.keyCode==13) return searchStu()" />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 姓名: <input type="text"
				style="height: 23px; width: 184px;" class="easyui-validatebox"
				id="stuName" name="stuName"
				onkeydown="if(event.keyCode==13) return searchStu()" />
			<script type="text/javascript">
				$("#major")
						.combobox(
								{
									onSelect : function(major) {
										var studentId = $("#stuId").val();
										var stuName = $("#stuName").val();
										var url = "${pageContext.request.contextPath}/student/list.html?studentId="
												+ studentId
												+ "&&majorId="
												+ major.id
												+ "&&stuName="
												+ stuName;
										$("#dg").datagrid({
											url : url
										});
										$("#dg").datagrid("reload");
									}
								});
			</script>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:searchStu()"
			id="searchStu" class="easyui-linkbutton" iconCls="icon-search"
			plain="true">搜索</a> <br />
		</div>
		<div style="padding-top: 15px;">
			&nbsp;&nbsp; <a href="javascript:preDistribute()"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true">发放物品</a>
			&nbsp;&nbsp; <a href="javascript:preDeleteThing()"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true">更改已领取的物品</a>
		</div>
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 350px; height: 400px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div id="distribute"></div>
	</div>
	<div id="dlg1" class="easyui-dialog"
		style="width: 450px; height: 400px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons1">
		<input type="hidden" name="id" id="id" style="display: none;"/>
		<form id="fm" method="post">
			<table cellpadding="15px">
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;学号:</td>
					<td><input type="text" id="studentId" name="studentId"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;姓名:</td>
					<td><input type="text" id="studentName" name="studentName"
						class="easyui-validatebox" required="true" editable="false" /></td>
				</tr>
			</table>
		</form>
		<div id="delThing">
		</div>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:distributeThing()" class="easyui-linkbutton"
			iconCls="icon-ok">保存</a> <a href="javascript:closeDialog()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="dlg-buttons1">
		<a href="javascript:closeDialog1()"
			class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>