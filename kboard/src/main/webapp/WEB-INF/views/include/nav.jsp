<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" type="text/css" href="/resources/css/nav.css">
<link rel="stylesheet" type="text/css" href="/resources/css/view.css">

<h1 class="h1">게시판</h1>
<div class="h_list">
	<h3>게시판</h3>
	<ul class="nav">
		<li>
			<c:if test="${member != null}">
				<p>${member.userId}님 안녕하세요.</p>
			</c:if>
		</li>
		<li>
			<c:if test="${member != null}"><a href="/member/logout">로그아웃</a></c:if>
			<c:if test="${member == null}"><a href="/member/login">로그인</a></c:if>
		</li>
	
		<li><a href="/member/signup">회원가입</a></li>

		<li><a href="/board/listPageSearch?num=1">글 목록</a></li>

		<li><a href="/board/write">글 작성</a></li>


	</ul>
</div>