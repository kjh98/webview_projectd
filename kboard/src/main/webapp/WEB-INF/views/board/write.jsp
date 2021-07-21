<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" type="text/css" href="/resources/css/write.css">
<script type="text/javascript" src="/resources/js/common.js"></script>
<meta charset="UTF-8">
<title>게시물 작성</title>
</head>
<body>
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>
<!--  	<form method="post">
		<div class="form">
			<label>작성자</label> ${member.userName} <input type="hidden"
				name="writer" value="${member.userName}" />
			<hr />
			<label>제목</label> <input type="text" name="title" />
			<hr />
			<label>내용</label>
			<textarea cols="50" rows="5" name="content"></textarea>
			<br />
			<c:choose>
				<c:when test="${member != null}">
					<button type="submit">작성</button>
				</c:when>

				<c:otherwise>
					<p>로그인 후 작성 가능 합니다.</p>
				</c:otherwise>
			</c:choose>

		</div> 
	</form>-->
	
	<form action="insertBoard.do" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
		<div class="form">
			<label>작성자</label> ${member.userName} <input type="hidden"
				name="writer" value="${member.userName}" />
			<hr />
			<label>제목</label> <input type="text" name="title" />
			<hr />
			<label>내용</label>
			<textarea cols="50" rows="5" name="content"></textarea>
			<br />
			<c:choose>
				<c:when test="${member != null}">
					<input type="file" name="uploadFile"/></td>
					<button type="submit">작성</button>
				</c:when>

				<c:otherwise>
					<p>로그인 후 작성 가능 합니다.</p>
				</c:otherwise>
			</c:choose>

		</div>
	</form>
</body>
</html>

