<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/write.css">
<meta charset="UTF-8">
<title>게시물 작성</title>
</head>
<body>
	<div id="nav">
	 <%@ include file="../include/nav.jsp" %>
	</div>
		<form method="post">
			<div class="form">
				<label>작성자</label>
					<input type="text" name="writer" /><hr />
				<label>제목</label>
					<input type="text" name="title" /><hr />
				<label>내용</label>
					<textarea cols="50" rows="5" name="content"></textarea><br />
				
				<button type="submit">작성</button>
			</div>
		</form>
</body>
</html>