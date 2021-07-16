<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<html>
<head>
<title>로그인</title>
</head>
<body>
	<h1>
		<a href="#" class="login_text">로그인 화면</a>
	</h1>
	<div class="login">
		<form name="homeForm" method="post" action="/member/login">
			<c:if test="${member == null}">
				<div>
					<label for="userId"></label> <input type="text" id="userId"
						name="userId" placeholder="아이디">
				</div>
				<hr>
				<div>
					<label for="userPass"></label> <input type="password" id="userPass"
						name="userPass" placeholder="비밀번호">
				</div>
				<hr>
				<div class="login_btn">
					<button type="submit">로그인</button>
				</div>
			</c:if>
		
			<c:if test="${member != null}">
				<div>
					<p>${member.userId}님환영 합니다.</p>
					<button id="logoutBtn" type="button">로그아웃</button>
				</div>
			</c:if>
		
		</form>
		<div class="login_btn">
			<a href="/member/signup"><button type="button">회원가입</button></a>
		</div>
				<c:if test="${msg == false}">
					<p style="color: red;">로그인 실패! 아이디와 비밀번호를 확인 해 주세요!</p>
				</c:if>
	</div>
</body>

</html>