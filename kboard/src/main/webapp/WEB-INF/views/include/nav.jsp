<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" type="text/css" href="/resources/css/nav.css">
<link rel="stylesheet" type="text/css" href="/resources/css/view.css">
<link rel="stylesheet" 
href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
 integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" 
 crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

 
<h1>게시판</h1>
<div class="h_list">
	<h3 style="text-align:center;">게시판</h3>
	<ul class="nav1">
		<li>
			<c:if test="${member != null}">
				<p>${member.userName}님 안녕하세요.</p>
			</c:if>
		</li>
		<li>
			<c:if test="${member != null}"><a href="/member/logout">로그아웃</a></c:if>
			<c:if test="${member == null}"><a href="/member/login">로그인</a></c:if>
		</li>
		<c:if test="${member == null}">
			<li><a href="/member/signup">회원가입</a></li>
		</c:if>
		<li><a href="/board/listPageSearch?num=1">글 목록</a></li>
		
		<c:if test="${member != null}">
			<li><a href="/board/write">글 작성</a></li>
		</c:if>
		<li><a href="#">달력</a></li>

	</ul>
</div>

