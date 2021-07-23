<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>

	<div id="nav">
	 <%@ include file="../include/nav.jsp" %>
	</div>
<div class="inner_index" style="height:auto !important;">
<div class="card-header">Register</div>
	<div class="container col-md-6" role="main"> 
		<div class="card">
			<form method="post" class="form-signup" role="form">
			
				<label>제목</label>
					<input type="text" name="title" value="${view.title}"/><br />
				
				<label>작성자</label>
					<input type="hidden" name="writer" value="${view.writer}" />${view.writer}<br />
				
				<label>내용</label>
					<textarea cols="50" rows="5" name="content">${view.content}</textarea><br />
				
				<button type="submit">완료</button>
			
			</form>
		</div>
	</div>
	<div id="footer">
			<%@ include file="../include/footer.jsp"%>
	</div>
</div>
</body>
</html>