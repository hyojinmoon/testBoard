<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<c:set var="page" value="${insertMap.page}"/>
<c:set var="totalPage" value="${insertMap.totalPage}"/>
<c:set var="sawonList" value="${insertMap.sawonList}"/>
<c:set var="pageList" value="${insertMap.pageList}"/>
<c:set var="front" value="${insertMap.front}"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 목록</title>
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<style type="text/css">
.frame .frame_left, .frame .frame_right{
	overflow: auto;
	float: left;
} 
</style>
<script>
	$(function(){
		// 검색
		$("#search").click(function(){
			var selectGroup = $("#selectCol option:selected").val();
			if($("#searchWord").val() == null || $("#searchWord").val() == ""){
				location.href="${pageContext.request.contextPath}/employee/empList/1";
			}else{
				var f =  document.multiForm;
				f.method="get";
				f.action="${pageContext.request.contextPath}/employee/search/"+selectGroup+"/1";
				f.submit();
			}
		});	
		
/* 		
		if($("select[name=selectCol]").val()=="all"){
			$("#search").click(function(){
				if($("#searchWord").val() == null || $("#searchWord").val() == ""){
					location.href="${pageContext.request.contextPath}/employee/empList/1"
				}else{
					var f =  document.multiForm;
					f.method="get";
					f.action="${pageContext.request.contextPath}/employee/searchAll/1";
					f.submit();
				}
			});			
		}
*/
/* 
		if($("select[name=selectCol]").val()=="kor_Name"){
			$("#search").click(function(){
				if($("#searchWord").val() == null || $("#searchWord").val() == ""){
					location.href="${pageContext.request.contextPath}/employee/empList/1"
				}else{
					var f =  document.multiForm;
					f.method="get";
					f.action="${pageContext.request.contextPath}/employee/searchKor_Name/1";
					f.submit();
				}
			});			
		}
		if($("select[name=selectCol]").val()=="sex"){
			$("#search").click(function(){
				if($("#searchWord").val() == null || $("#searchWord").val() == ""){
					location.href="${pageContext.request.contextPath}/employee/empList/1"
				}else{
					var f =  document.multiForm;
					f.method="get";
					f.action="${pageContext.request.contextPath}/employee/searchSex/1";
					f.submit();
				}
			});			
		}
		if($("select[name=selectCol]").val()=="tech_Lev"){
			$("#search").click(function(){
				if($("#searchWord").val() == null || $("#searchWord").val() == ""){
					location.href="${pageContext.request.contextPath}/employee/empList/1"
				}else{
					var f =  document.multiForm;
					f.method="get";
					f.action="${pageContext.request.contextPath}/employee/searchTech_Lev/1";
					f.submit();
				}
			});			
		}
*/
		
		// 등록
		$("#bt_Insert").click(function(){
			location.href="${pageContext.request.contextPath}/employee/empViewInsert";
		});
		$("#checkAll").click(function(){
	        //클릭되었으면
	        if($("#checkAll").prop("checked")){
	            $("input[name=check]").prop("checked",true);
	            //클릭이 안되있으면
	        }else{
	            $("input[name=check]").prop("checked",false);
	        }
	    });
		
	});
/* 	
	//단일 선택 삭제
	function checkDelete(){
		var checkLeng = $('input:checkbox[name="check"]:checked').length;
		var checkVal = $("input[name='check']:checked").val();
		if(checkLeng>= 2){
			alert("한 사람만 선택해 주세요.");
		}else if(checkLeng==0){
			alert("삭제할 사원을 선택해 주세요.");
		}else{
			var deleteConf = confirm("이 사원을 삭제하시겠습니까?");
			if(deleteConf == true){
			var f =  document.multiForm;
				f.method="get";
				f.action="${pageContext.request.contextPath}/employee/empDelete";
				f.submit();		
			}else{
				deleteConf.close();
			}
		}
	}
*/
	function checkDelete(){
		var checkLeng = $('input:checkbox[name="check"]:checked').length;
		var checkVal = $("input[name='check']:checked").val();
		if(checkLeng==0){
			alert("삭제할 사원을 선택해 주세요.");
		}else{
			var deleteConf = confirm("선택한 사원을 삭제할까요?");
			if(deleteConf == true){				
				var f =  document.multiForm;
				f.method="get";
				f.action="${pageContext.request.contextPath}/employee/empDelete";
				f.submit();
			}else{
				location.href="${pageContext.request.contextPath}/employee/empViewInsert";
			}
		}
	
	}
	
	function checkUpdate(){
		var checkLeng = $('input:checkbox[name="check"]:checked').length;
		var checkVal = $("input[name='check']:checked").val();
		if(checkLeng>= 2){
			alert("한 사람만 선택해 주세요.");
		}else if(checkLeng==0){
			alert("수정할 사원을 선택해 주세요.");
		}else{
			var f =  document.multiForm;
			f.method="post";
			f.action="${pageContext.request.contextPath}/employee/empView";
			f.submit();				
		}
	}
</script>
</head>
<body topmargin="0" leftmargin="0">
<div class="frame">
<div class="frame_left">
	<jsp:include page="left.jsp"/>
</div>
<div class="frame_right">
<form name="multiForm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td height="25"><img src="${pageContext.request.contextPath}/resources/image/icon.gif" width="9" height="9" align="absmiddle"> 
      <strong>사원조회</strong></td>
  </tr>
  <tr> 
    <td><table width="640" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right">
          	<select id="selectCol" name="selectCol" class="INPUT">
              <option value="all">::::: 전체 :::::</option>
              <option value="kor_Name">이름</option>
              <option value="sex">성별</option>
              <option value="tech_Lev">기술등급</option>
              <option value="name_Sex">이름+성별</option>
              <option value="name_Tech_Lev">이름+기술등급</option>
              <option value="sex_Tech_Lev">성별+기술등급</option>
            </select> 
            <input id="searchWord" type="text" class="INPUT" id="searchWord" name="searchWord">
            <img src="${pageContext.request.contextPath}/resources/image/search.gif" width="49" height="18" border="0" onclick="document.getElementById('search').click();" />
			<input type="button"id="search" style="display:none;"/>
           </td>
        </tr>
        <tr> 
          <td><table width="640" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="3" background="${pageContext.request.contextPath}/resources/image/bar_bg1.gif"></td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="26" align="right" bgcolor="F8F8F8" style="padding-right:10"><img src="${pageContext.request.contextPath}/resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="javascript:void(0)" onclick="checkUpdate();">수정</a> <img src="${pageContext.request.contextPath}/resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">인사기록카드</a> <img src="${pageContext.request.contextPath}/resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">경력정보</a> <img src="${pageContext.request.contextPath}/resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">근무정보</a> </td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="1" align="right" bgcolor="B1B1B1"></td>
              </tr>
              <tr> 
                <td>
				<!-------------------------  리스트 ------------------------------>
				<table width="640" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="50" align="center">
					  	<input type="checkbox" id="checkAll"/>
					  </td>
                      <td width="85" align="center">이름</td>
                      <td width="153" align="center">주민번호</td>
                      <td width="91" align="center">성별</td>
                      <td width="91" align="center">기술등급</td>
                      <td width="91" align="center">상태</td>
                      <td width="94" align="center">근무</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="${pageContext.request.contextPath}/resources/image/line_bg.gif"></td>
                    </tr>
                  
                    <c:if test="${empty sawonList}">
                    	<tr>
                    		<td colspan="7">등록된 사원이 없습니다.</td>
                    	</tr>
                    </c:if>
                    <c:forEach var="sawon" items="${sawonList}">
	                   <tr> 
	                     <td height="20" align="center"><input type="checkbox" name="check" value="${sawon.no}"></td>
	                     <td align="center">${sawon.kor_Name}</td>
	                     <td align="center">${sawon.jumin}</td>
	                      <td align="center">${sawon.sex}</td>
	                      <td align="center">${sawon.tech_Lev}</td>
	                      <td align="center">${sawon.jop_Type}</td>
	                      <td align="center">${sawon.desire_Dept}</td>
	                    </tr>
                    </c:forEach>

                    <tr> 
                      <td colspan="7" background="${pageContext.request.contextPath}/resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="35" colspan="7" align="center" style="padding-bottom:3">
                     <a href="${pageContext.request.contextPath}/employee/empList/1">
                     	<img src="${pageContext.request.contextPath}/resources/image/prev.gif" width="42" height="15" border="0" align="absmiddle">
                     </a>&nbsp; 
                     
                   	<a href="${pageContext.request.contextPath}/employee/empList">
                   		<img src="${pageContext.request.contextPath}/resources/image/pre.gif" width="42" height="15" border="0" align="absmiddle">
                   	</a>

                      	&nbsp; 
	                       <c:forEach  var="page" items="${pageList}">
	                       		<a href="${pageContext.request.contextPath}/employee/empList/${page}"><c:out value="${page}"/></a> &nbsp;| &nbsp;
	                       </c:forEach>
                        &nbsp;
   

                     	<a href="${pageContext.request.contextPath}/employee/empList">
                     		<img src="${pageContext.request.contextPath}/resources/image/next.gif" width="42" height="15" border="0" align="absmiddle">
                     	</a>

                        &nbsp;
                        <a href="${pageContext.request.contextPath}/employee/empList">
                        	<img src="${pageContext.request.contextPath}/resources/image/next_.gif" width="42" height="15" border="0" align="absmiddle">
                        </a>
                      </td>
                    </tr>
                  </table>
 				<!-------------------------  리스트 ------------------------------>
				  </td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="1" align="right" bgcolor="B1B1B1"></td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="26" align="right" bgcolor="F8F8F8" style="padding-right:10"><img src="${pageContext.request.contextPath}/resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="javascript:void(0)" onclick="checkDelete();">삭제</a> <img src="${pageContext.request.contextPath}/resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">인사기록카드</a> <img src="${pageContext.request.contextPath}/resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">경력정보</a> <img src="${pageContext.request.contextPath}/resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">근무정보</a> </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="3" background="${pageContext.request.contextPath}/resources/image/bar_bg1.gif"></td>
        </tr>
      </table></td>
  </tr>
</table>
</form>
</div>
</div>
</body>
</html>
