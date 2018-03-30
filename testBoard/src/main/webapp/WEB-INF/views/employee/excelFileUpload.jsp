<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>엑셀파일 업로드</title>
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
</head>
<script type="text/javascript">
	$(function(){
		$("#upload_ok").click(function(){
			var uploadFile = $("#uploadFile").val();
		    if (uploadFile == "" || uploadFile == null) {
		        alert("파일을 선택해주세요.");
		        return false;
		    } else if (!checkFileType(uploadFile)) {
		        alert("엑셀 파일만 업로드 가능합니다.");
		        return false;
		    }else{
				$("#fileSubmit").submit();
		    }
		});
	});
	 function checkFileType(filePath) {
		    var fileFormat = filePath.split(".");
		    if (fileFormat.indexOf("xlsx") > -1) {
		        return true;
		    } else {
		        return false;
		    }
		}
</script>
<body>
<form action="${pageContext.request.contextPath}/employee/excelFileUpload_ok" method="post" enctype="multipart/form-data" id="fileSubmit">
	<input type="file" id="uploadFile" name="uploadFile">
	<button type="button" id="upload_ok">확인</button>
</form>
</body>
</html>