<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 조회</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<div id="nav"> <%@ include file="../include/nav.jsp"%></div>

	<div class="content">
		<label>작성자:</label> ${view.writer} <br />
		
		<label>제목:</label> ${view.title}	<br />
	
		<label>내용:</label> ${view.content}
	</div>
		<div class="button">
			<a href="/board/modify?bno=${view.bno}">게시물 수정</a>
			<a href="/board/delete?bno=${view.bno}">게시물 삭제</a>
		</div>
	<hr/>
	
		<div class="reply">
			<form id="reply" method="post" action="/reply/write">
				<p>
					<label>현재 댓글 작성자</label>${member.userId} <input type="hidden" name="writer" value="${member.userId}">
				</p>
				<p>
					<textarea rows="5" cols="50" name="content"></textarea>
				</p>
				<p>
					<input type="hidden" name="bno" value="${view.bno}">
					<button id="btn" type="submit" onclick="reply_btn();">댓글 작성</button>
				</p>
			</form>
			
			<c:forEach items="${reply}" var="reply">
			<li>
				<div>
					<p>${reply.writer} / <fmt:formatDate value="${reply.regDate}" pattern="yy-MM-dd" /></p>f
					
				${reply.content}
				</div>
			</li>
		</c:forEach><hr/>

		</div>
	
<script>
function reply_btn(){
	var id = '<%=session.getAttribute("member")%>';
	
	if(id == 'null'){
		alert("로그인이 필요한 항목입니다.");
		$("#reply").attr("action", "/board/view?bno=${list.bno}");
	}
}
</script>

	
		
</body>
</html>