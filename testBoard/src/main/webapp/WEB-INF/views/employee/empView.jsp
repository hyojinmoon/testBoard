<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="sawonDTO" value="${sawonDTO}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 등록</title>
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
.frame .frame_left, .frame .frame_right{
	overflow: auto;
	float: left;
}
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	//chapter2
	// 유효성 검사 확인
	// 등록과 kor_Name_Flag, 주민번호 Flag 가 다름
	var kor_Name_Flag = true;
	var eng_Name_Flag = false;
	var chn_Name_Flag = false; 
	var tech_Lev_Flag = false; 
	var jumin_Nof_Flag = true; 
	var jumin_Nob_Flag = true; 
	var birth1_Flag = false;
	var birth2_Flag = false;
	var birth3_Flag = false;
	var work_Year_Flag = false;
	var phone1_Flag = false; 
	var phone2_Flag = false; 
	var phone3_Flag = false; 
	
	//유효성 검사 대상
	var kor_Name = $("#kor_Name");
	var eng_Name = $("#eng_Name");
	var chn_Name = $("#chn_Name");
	var tech_Lev = $("#tech_Lev");

	var jumin_Nof = $("#jumin_Nof");
	var jumin_Nob = $("#jumin_Nob");
	var birth1 = $("#birth1");
	var birth2 = $("#birth2");
	var birth3 = $("#birth3");
	var work_Year = $("#work_Year");
	var phone1 = $("#phone1");
	var phone2 = $("#phone2");
	var phone3 = $("#phone3");
	
	//정규식
	var reg_kor = /^[가-힣]+$/ ;
	var reg_eng = /^[a-zA-Z\s]+$/;
	var reg_han = /[\u4E00-\u9FD5]/g;//한자는 다시 검사할때 기존의 value가 정규식검사에 걸린다.
	var reg_T = /[~!@\#$%<>^&*\()\-=+_\’]/gi; 
	var reg_num = /^[0-9]+$/;
	
	// 파일 업로드 / 미리보기 / 파일이름 보여주기
	$("#file").change(function(){
		var fileName = $("#file").val();
		
		var extensionIndex = fileName.indexOf('.');
		var extension = fileName.substring(extensionIndex, fileName.length);
		if(extension==".jpg" || extension==".JPG"){
			imageURL(this);
			$("#file_Txt").val(this.value);			
		}else{
			alert("확장자 JPG 파일만 등록할 수 있습니다.");
			$("#file").val("");
			$("#file_Txt").val("");	
			$('#Imge_ex').attr('src', "");
		}
	});
	
	//주민번호
 	jumin_Nof.focusout(function(){
		if(jumin_Nof.val() == ""){	
			jumin_Nof.focus();
		}
	});
	jumin_Nob.focusout(function(){
		var front_ok = false;
		var back_ok = false;
		if(jumin_Nof.val() == "" || jumin_Nob.val() != ""){
			if(!reg_num.test(jumin_Nof.val()) || !reg_num.test(jumin_Nob.val())){
				alert("주민번호를 숫자로 띄어쓰기 없이 입력해주세요.");
				jumin_Nof.val("");
				jumin_Nob.val("");
				jumin_Nof.focus();
				jumin_Nof_Flag = false;
				jumin_Nob_Flag = false;
			}else{
				//생년월일 자동 입력 : 자릿수, 형식 검사 포함
				var birth = jumin_Nof.val();
				var century = birth.substring(0,1);
				var year = birth.substring(0,2);
				var month = birth.substring(2,4);
				var date = birth.substring(4,6);
				var jumin_sex = jumin_Nob.val();
				var sex = jumin_sex.substring(0,1);
				if(jumin_Nof.val()!=""){
					if(birth.length!=6 || month>12 || date >31){
						alert("주민번호 앞자리가 부적절합니다.");
						jumin_Nof.val("");
						jumin_Nof.focus();
						birth2.val("");
						birth3.val("");
						front_ok = false;
					}else{
						if(century <= 3){
							birth1.val("20"+year);
							birth2.val(month);
							birth3.val(date);
							front_ok = true;
						}else{
							birth1.val("19"+year);
							birth2.val(month);
							birth3.val(date);
							front_ok = true;
						}				
					}
				}else{
					jumin_Nof.focus();
					birth1.val("");
					birth2.val("");
					birth3.val("");
					front_ok = false;
				}
				if(jumin_sex != ""){
					if(jumin_sex.length !=7){
						alert("주민번호 뒷자리는 7자리입니다.");
						jumin_Nob.focus();
						jumin_Nob.val("");
						back_ok = false;
					}else{
						if(sex == 1 || sex == 3){
							$("#sex_Man").attr('checked', 'checked');
							$("#sex_Woman").removeAttr('checked');
							back_ok = true;
						}else if(sex == 2 || sex == 4){
							$("#sex_Man").prop("checked", false);
							$("#sex_Woman").prop("checked", true);
							back_ok = true;
						}else{
							alert("주민번호 뒷자리가 부적절합니다.");
							jumin_Nob.focus();
							jumin_Nob.val("");
							back_ok = false;
						}			
					}
				}
				// 주민번호 중복 검사
				if(front_ok = true && back_ok == true){
					var no = ${sawonDTO.no};
					$.ajax({
						url: '${pageContext.request.contextPath}/employee/check_Jumin',
						type: 'get',
						data: {
							jumin_f : jumin_Nof.val(),
							jumin_b : jumin_Nob.val(),
							sawonNo : no
						},
						success: function(data){
							if(data.trim() == "중복"){
								alert("중복된 주민번호입니다.");
								jumin_Nof.focus();
								jumin_Nof.val("");
								jumin_Nob.val("");
								birth1.val("");
								birth2.val("");
								birth3.val("");
								$("#sex_Man").prop("checked", false);
								$("#sex_Woman").removeAttr('checked');
								jumin_Nof_Flag = false;
								jumin_Nob_Flag = false;
							}else{
								jumin_Nof_Flag = true;
								jumin_Nob_Flag = true;
							}
						}
					});
				}else{
					alert("주민번호가 부적절합니다.");
				}
			}// 유효성 검사
		}else{// 주민번호 빈칸 확인
			jumin_Nob.focus();
			jumin_Nof_Flag = false;
			jumin_Nob_Flag = false;
		}
	});//focusout

	
	// 유효성 검사
	// 한글 이름
	kor_Name.focusout(function(){
		if(kor_Name.val() != ""){
			$("#name_Reg").text("");
			if(!reg_kor.test(kor_Name.val())){
				$.ajax({
					url : '${pageContext.request.contextPath}/employee/regConf_Name',
					type : 'post',
					data : {warning : "한글로만 입력해주세요."},
					success : function(data){
						$("#name_Reg").text(data);
						kor_Name.focus();
					}
				});
			}else{
				$("#name_Reg").text("");
				kor_Name_Flag = true;
			}
		}else{
			$("#name_Reg").text("이름을 입력해주세요.");
			kor_Name.focus();
			kor_Name_Flag = false;
		}
	});
	
	$("#bt_Update").click(function(){
		// 한글 이름
		if(kor_Name.val() == ""){
			alert("한글 이름을 입력해주세요.");
			kor_Name.focus();
			kor_Name_Flag = false;
		}
		//영문 이름
		if(eng_Name.val() != ""){
			if(!reg_eng.test(eng_Name.val())){
				alert("영문만 입력해주세요.");
				eng_Name.val("");
				eng_Name.focus();
				eng_Name_Flag = false;
			}else{
				eng_Name_Flag = true;
			}
		}else{
			alert("영문 이름을 입력해주세요.");
			eng_Name.focus();
			eng_Name_Flag = false;
		}
		//한문 이름
		if(chn_Name.val() != ""){
			if(reg_T.test(chn_Name.val()) || reg_num.test(chn_Name.val())){
				alert("한자만 띄어쓰기 없이 입력해주세요.");
				chn_Name.val("");
				chn_Name.focus();
				chn_Name_Flag = false;
			}else{
				chn_Name_Flag = true;
			}
		}else{
			alert("한문 이름을 입력해주세요.");
			chn_Name.focus();
			chn_Name_Flag = false;
		}
 		
		// 주민번호
		if(jumin_Nof.val() == "" || jumin_Nob.val() == ""){
			alert("주민등록번호를 입력해주세요.");
			jumin_Nof.focus();
			jumin_Nof_Flag = false;
			jumin_Nob_Flag = false;
		}

/* 		//주민번호
		if(jumin_Nof.val() != "" || jumin_Nob.val() != ""){
			if(!reg_num.test(jumin_Nof.val()) && !reg_num.test(jumin_Nob.val())){
				alert("주민번호를 숫자로 띄어쓰기 없이 입력해주세요.");
				jumin_Nof.val("");
				jumin_Nob.val("");
				jumin_Nof.focus();
				jumin_Nof_Flag = false;
				jumin_Nob_Flag = false;
			}else{
				jumin_Nof_Flag = true;
				jumin_Nob_Flag = true;
			}
		}else{
			alert("주민등록번호를 입력해주세요.");
			jumin_Nof.focus();
			jumin_Nof_Flag = false;
		}
		 */
		
		//생년월일
		if(birth1.val() != "" || birth2.val() != "" || birth3.val() != ""){
			if(!reg_num.test(birth1.val()) && !reg_num.test(birth2.val()) && !reg_num.test(birth3.val())){
				alert("생년월일을 숫자로 띄어쓰기 없이 입력해주세요.");
				birth1.val("");
				birth2.val("");
				birth3.val("");
				birth1.focus();
				birth1_Flag = false;
				birth2_Flag = false;
				birth3_Flag = false;
			}else{
				birth1_Flag = true;
				birth2_Flag = true;
				birth3_Flag = true;
			}
		}else{
			alert("생년월일을 입력해주세요.");
			birth1.focus();
			birth1_Flag = false;
			birth2_Flag = false;
			birth3_Flag = false;
		}
		//년차
		if(work_Year.val() != ""){
			if(!reg_num.test(work_Year.val())){
				alert("년차을 숫자로 띄어쓰기 없이 입력해주세요.");
				work_Year.val("");
				work_Year.focus();
				work_Year_Flag = false;
			}else{
				work_Year_Flag = true;
			}
		}else{
			alert("년차를 입력해주세요.");
			work_Year.focus();
			work_Year_Flag = false;
		}
		//연락처
		if(phone1.val() != "" || phone2.val() != "" || phone3.val() != ""){
			if(!reg_num.test(phone1.val()) && !reg_num.test(phone2.val()) && !reg_num.test(phone3.val())){
				alert("연락처를 숫자로 띄어쓰기 없이 입력해주세요.");
				phone1.val("");
				phone2.val("");
				phone3.val("");
				phone1.focus();
				phone1_Flag = false;
				phone2_Flag = false;
				phone3_Flag = false;
			}else{
				phone1_Flag = true;
				phone2_Flag = true;
				phone3_Flag = true;
			}
		}else{
			alert("연락처를 입력해주세요.");
			phone1.focus();
			phone1_Flag = false;
			phone2_Flag = false;
			phone3_Flag = false;
		}
		//기술등급
		if(tech_Lev.val() != ""){
			if(!reg_kor.test(tech_Lev.val())){
				alert("기술 등급을 한글로 띄어쓰기 없이 입력해주세요.");
				tech_Lev.val("");
				tech_Lev.focus();
				tech_Lev_Flag = false;
			}else{
				tech_Lev_Flag = true;
			}
		}else{
			alert("기술 등급 이름을 입력해주세요.");
			tech_Lev.focus();
			tech_Lev_Flag = false;
		}
		// 최종 확인
		if(kor_Name_Flag && eng_Name_Flag && chn_Name_Flag && tech_Lev_Flag && 
		   jumin_Nof_Flag && jumin_Nob_Flag && birth1_Flag && birth2_Flag && birth3_Flag &&
		   work_Year_Flag && phone1_Flag && phone2_Flag && phone3_Flag){
			var updateConf = confirm("이 사원의 정보를 수정하시겠습니까?");
			if(updateConf == true){
				var f =  document.updateForm;
				f.method="post";
				f.enctype="multipart/form-data";
				f.action="${pageContext.request.contextPath}/employee/empUpdate/${sawonDTO.no}";
				f.submit();	
			}else{
				updateConf.close();
			}
		}else{
/* 			alert(kor_Name_Flag+", "+eng_Name_Flag+", "+chn_Name_Flag+", "+tech_Lev_Flag+", "+
					   jumin_Nof_Flag+", "+jumin_Nob_Flag+", "+birth1_Flag+", "+birth2_Flag+", "+birth3_Flag+", "+
					   work_Year_Flag+", "+phone1_Flag+", "+phone2_Flag+", "+phone3_Flag); */
			alert("등록에 실패했습니다.");
		}
	});	
	
	$("#bt_ToList").click(function(){
		history.back();
	});
	
	var sol_Flag = "${sawonDTO.sol_Flag}";
		if(sol_Flag == "양력"){
			$("#sol_Flag_Sun").attr({
				checked: "checked"
			}); 
		}else if(sol_Flag == "음력"){
			$("#sol_Flag_Moon").attr({
				checked: "checked"
			});
			/* $("#sol_Flag_Sun").removeAttr("checked"); */
		} 
	var sex = "${sawonDTO.sex}";
	if(sex == "남자"){
		$("#sex_Man").attr({
			checked: "checked"
		});
	}else if(sex == "여자"){
		$("#sex_Woman").attr({
			checked: "checked"
		});
	} 
	var marry_Flag = "${sawonDTO.marry_Flag}";
	if(marry_Flag == "무"){
		$("#marry_Flag_No").attr({
			checked: "checked"
		});
	}else if(marry_Flag == "유"){
		$("#marry_Flag_Yes").attr({
			checked: "checked"
		});
	} 
	if($("#payment_Type") != null){
		$("select[name=payment_Type]").val("${sawonDTO.payment_Type}");
	}
	if($("#desire_Dept") != null){
		$("select[name=desire_Dept]").val("${sawonDTO.desire_Dept}");
	}
	if($("#jop_Type") != null){
		$("select[name=jop_Type]").val("${sawonDTO.jop_Type}");
	}

	

}); 
function imageURL(upload) {
    if (upload.files && upload.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
            $('#Imge_ex').attr('src', e.target.result)
             .width(100)
             .height(110);
        }

        reader.readAsDataURL(upload.files[0]);
    }
}
// 엑셀 파일 다운로드
function excelDownload(){
	var sawonNo = ${sawonDTO.no};
	$.ajax({
		url: '${pageContext.request.contextPath}/employee/excelFileDownload',
		type: 'post',
		data: {
			no : sawonNo
		},
		success: function(data){
			alert("다운로드되었습니다.");
		}
	});
}
</script>
</head>
<body topmargin="0" leftmargin="0">
<form name="updateForm">
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="640">&nbsp;</td>
  </tr>
  <tr> 
    <td height="25"><img src="${pageContext.request.contextPath}/resources/image/icon.gif" width="9" height="9" align="absmiddle"> 
      <strong>사원 등록</strong></td>
  </tr>
  <tr> 
    <td><table width="640" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="15" align="left"><table width="640" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><table width="640" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td height="2" background="${pageContext.request.contextPath}/resources/image/bar_bg1.gif"></td>
                    </tr>
                    <tr align="center" bgcolor="F8F8F8"> 
                      <td height="26" align="center" bgcolor="#E4EBF1" style="padding-right:10"><table width="600" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td align="center"><strong>교육정보 | 자격증. 보유기술정보 | 프로젝트 
                              정보 |경력정보 | 근무정보</strong></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr align="center" bgcolor="F8F8F8"> 
                      <td height="3" align="right" background="${pageContext.request.contextPath}/resources/image/bar_bg1.gif"></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="6" align="center" valign="top">&nbsp;</td>
        </tr>
        <tr>
          <td height="7" align="center" valign="top"><table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#CCCCCC"><table width="600" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td height="135" align="center" bgcolor="#E4EBF1"><table width="600" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="144" height="119" align="center"><table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td height="112" bgcolor="#CCCCCC"><table width="100" border="0" cellspacing="1" cellpadding="0">
                                  <tr>
                                    <td height="110" bgcolor="#FFFFFF">
                                    	<img src="<c:url value="../resources/uploadFile/${sawonDTO.image}"/>"  id="Imge_ex" width="100" height="110">
									</td>
                                  </tr>
                              </table></td>
                            </tr>
                          </table></td>
                          <td width="456">
                          	
                          	<table width="423" border="0" cellspacing="2" cellpadding="0">
                            <tr>
                              <td height="2" colspan="2"></td>
                              </tr>
                            <tr>
                              <td width="107" height="26" align="right"><strong>한글이름 :</strong>&nbsp;</td>
                              <td width="310" height="26"><input type="text" id="kor_Name" name="kor_Name" value="${sawonDTO.kor_Name}" maxlength="5">
                              <span id="name_Reg" style="color:red"></span>
                              </td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>영문이름 :&nbsp;</strong></td>
                              <td height="26"><input type="text" id="eng_Name" name="eng_Name" value="${sawonDTO.eng_Name}" maxlength="15"></td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>한문이름:</strong>&nbsp;</td>
                              <td height="26"><input type="text" id="chn_Name" name="chn_Name" value="${sawonDTO.chn_Name}" maxlength="5"></td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>주민등록번호 :</strong>&nbsp;</td>
                              <td height="26"><input id="jumin_Nof" name="jumin_Nof" type="text" value="${sawonDTO.jumin_Nof}" size="15" maxlength="6">
      -
        <input id="jumin_Nob" name="jumin_Nob" type="text" value="${sawonDTO.jumin_Nob}" size="15" maxlength="7"></td>
                            </tr>
                          </table></td>
                        </tr>
                      </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="7" align="center" valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td height="13" align="center"><table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#CCCCCC"><table width="600" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="526" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>사진파일명 :&nbsp;</strong></td>
                            <td width="268"><input type="text" size="40" id="file_Txt" name="file_Txt" value="${sawonDTO.image}"></td>
                            <td width="146"><font color="#FF0000">
                           		<img src="${pageContext.request.contextPath}/resources/image/bt_search.gif" onclick="document.getElementById('file').click();" />
								<input type="file" size="30" name="file" id="file" style="display:none;"/>
								</font></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>생년월일 :&nbsp;</strong></td>
                            <td width="391"><input id="birth1" name="birth1" type="text" value="${sawonDTO.birth1}" size="15" maxlength="4">년 
                              <input type="text" id="birth2" name="birth2" value="${sawonDTO.birth2}" size="7" maxlength="2">월 
                              <input type="text" id="birth3" name="birth3" value="${sawonDTO.birth3}" size="7" maxlength="2">일 ( 
                              <input type="radio" name="sol_Flag" id="sol_Flag_Sun" value="양력">
                              양력 
                              <input type="radio" name="sol_Flag" id="sol_Flag_Moon" value="음력">
                              음력 )</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>성별 :&nbsp; </strong></td>
                            <td width="391"> <input type="radio" name="sex" id = "sex_Man" value="남자">
                              남자 
                              <input type="radio" name="sex" id="sex_Woman" value="여자">
                              여자</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>결혼유무 :&nbsp;</strong></td>
                            <td width="391"> <input type="radio" name="marry_Flag" id="marry_Flag_No" value="무">
                              미혼 
                              <input type="radio" name="marry_Flag" id="marry_Flag_Yes" value="유">
                              기혼</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>년차 :&nbsp;</strong></td>
                            <td width="392"><input id="work_Year" name="work_Year" type="text" value="${sawonDTO.work_Year}" size="5" maxlength="2"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>급여 지급유형 :&nbsp;</strong></td>
                            <td width="392"> <select name="payment_Type">
                                <option value="월급">월급</option>
                                <option value="주급">주급</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>희망직무 :&nbsp;</strong></td>
                            <td width="392"> <select name="desire_Dept">
                                <option value="SI">SI</option>
                                <option value="SM">SM</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>입사유형:&nbsp;</strong></td>
                            <td width="392"> <select name="jop_Type">
                                <option value="정규직">정규직</option>
                                <option value="계약직">계약직</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주소:&nbsp;</strong></td>
                            <td width="392">
                              <input name="address" type="text" value="${sawonDTO.address}" size="40" maxlength="30"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>연락처:&nbsp;</strong></td>
                            <td width="392"><input id="phone1" name="phone1" type="text" value="${sawonDTO.phone1}" size="10" maxlength="3">
                              - 
                              <input id="phone2" name="phone2" type="text" value="${sawonDTO.phone2}" size="10" maxlength="4">
                              - 
                              <input id="phone3" name="phone3" type="text" value="${sawonDTO.phone3}" size="10" maxlength="4"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>이메일:&nbsp;</strong></td>
                            <td width="392"><input name="email" type="text" value="${sawonDTO.email}" size="20" maxlength="30"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>기술등급:&nbsp;</strong></td>
                            <td width="392"><input id="tech_Lev" name="tech_Lev" type="text" value="${sawonDTO.tech_Lev}" size="20" maxlength="5"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주량:&nbsp;</strong></td>
                            <td width="392"><input name="liquor" type="text" value="${sawonDTO.liquor}" size="20" maxlength="5"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    
                    <!-- 액셀파일 다운로드 -->
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>액셀로 다운로드:&nbsp;</strong></td>
                            <td width="392"><button type="button" id="bt_excelDownload" onclick="excelDownload()">다운로드</button>
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="3" align="center">&nbsp;</td>
        </tr>
        <tr>
          <td height="3" align="center"><table width="107" border="0" cellpadding="1" cellspacing="1">
            <tr>
              <td width="49">
              	<button type="button" id ="bt_Update" style="border:0px; background-color:white;"><img src="${pageContext.request.contextPath}/resources/image/bt_remove.gif" width="49" height="18"></button>
             </td>
              <td width="51">
              	<button type="button" id="bt_ToList" style="border:0px; background-color:white;"><img src="${pageContext.request.contextPath}/resources/image/bt_cancel.gif" width="49" height="18" ></button></td>
            </tr>
          </table>            </td>
        </tr>
        <tr> 
          <td height="7" align="right">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
</form>
</body>
</html>
