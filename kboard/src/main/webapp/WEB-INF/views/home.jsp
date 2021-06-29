<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>Home</title>
<link href="/resources/css/test.css" rel="stylesheet" />
</head>
<body>
	<h1>Hello world!</h1>

	<P>The time on the server is ${path}.</P>

	<p>
		<a href="/board/list">게시물 목록</a>
	</p>
	<p>
		<a href="/board/write">게시물 작성</a>
	</p>
	<img src="${pageContext.request.contextPath}/resources/img/image.png" />
	<p>
		스크립트,css 불러오기
	</p>
	
</body>
</html>
