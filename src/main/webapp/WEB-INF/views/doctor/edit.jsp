<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/doc-edit.css" />
<script>
	function validateWriteForm(form) {
		if (form.name.value == '') {
			alert("이름을 입력하세요.");
			form.name.focus();
			return false;
		}
		if (form.major.value == '') {
			alert("전공을 입력하세요.");
			form.major.focus();
			return false;
		}
		if (form.career.value == '') {
			alert("경력을 입력하세요.");
			form.career.focus();
			return false;
		}
		if (form.hours.value == '') {
			alert("진료 요일 및 시간을 입력하세요.");
			form.hours.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
		
			<h2>정보 수정</h2>
			<form name="writeFrm" method="post" enctype="multipart/form-data"
				action="../doctor/editDoctor.do" onsubmit="return validateWriteForm(this);">
				<div class="doc_info">
					
					<div class="doc_img">
						<!-- 사진 있을 때 없을 때 처리해야 함! -->
						<span class="img">
							<img src="/images/doctor.png" alt="" />
						</span>
						<input type="file" name="file" value="${ doctorDTO.photo }" />
					</div>
					
					
					<table class="info">
						<tr>
							<td class="left">이름</td>
							<td><input type="text" name="name" value="${ doctorDTO.name }" placeholder="필수*" /></td>
						</tr>
						<tr>
							<td class="left">전공</td>
							<td><input type="text" name="major" value="${ doctorDTO.major }" placeholder="필수*" /></td>
						</tr>
						<tr>
							<td class="left">경력</td>
							<td><input type="text" name="career" value="${ doctorDTO.career }" placeholder="필수*" /></td>
						</tr>
						<tr>
							<td class="left">진료 요일 및 시간</td>
							<td><input type="text" name="hours" value="${ doctorDTO.hours }" placeholder="필수*" /></td>
						</tr>
					</table>
					
				</div> 

				<div class="board_btn">
					<button type="button" onclick="location.href='../doctor.do';">취소</button>
					<button type="submit">완료</button>
				</div>
			</form>
			
			
		</div>
	</div>
</main>
<%@include file="../common/main_footer.jsp" %>
</body> 
</html>