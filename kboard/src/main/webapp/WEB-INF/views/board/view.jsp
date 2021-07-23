<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- Bootstrap CSS -->




<meta charset="UTF-8">
<title>게시물 조회</title>
</head>
<body>
	<div id="nav"> <%@ include file="../include/nav.jsp"%></div>
<div class="inner_index" style="height:auto !important;">

	<div class="container" role="main">
		<div class="bg-white rounded shadow-sm">

			<div class="board_content">제목: <c:out value="${view.title}"/></div>
			
			<div class="board_info_box">
				 <span class="board_author">작성자: ${view.writer}</span>
			</div><hr>
			
			 <div class="board_title"> <c:out value="${view.content}"/></div>
			
		</div>
	</div>
	<c:if test="${member.userName == view.writer}">
		<div class="button">
			<a href="/board/modify?bno=${view.bno}">게시물 수정</a>
			<form action="ndelete" method="get" id="vdelete">
				<input type="hidden" name="vbno" value="${view.bno}">
				<input type="hidden" name="bno" value="${reply[0].bno}">
				<button type="submit" onclick="dbtn()">게시물 삭제</button>
			</form>
		</div>
	</c:if>
	<hr/>
		<div class="reply">
			<form id="reply" method="post" action="/reply/write">
				<p>
					<label>현재 댓글 작성자: </label>${member.userName} <input type="hidden" name="writer" value="${member.userName}">
				</p>
				<p>
					<textarea rows="5" cols="50" name="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요" id="rcontent"></textarea>
				</p>
				<p>
					<input type="hidden" name="bno" value="${view.bno}">
					<c:choose>
						<c:when test="${member != null}">
							<button id="btn" type="submit" class="btn btn-sm btn-primary" onclick="rbtn()" >댓글 작성</button>
						</c:when>
						
						<c:otherwise>
							<p>로그인 후 댓글 작성 가능 합니다.</p>
						</c:otherwise>
					</c:choose>
				</p>
				
			</form>
			
			<form method="get" action="fileDownload.do" accept-charset="UTF-8">
			<c:if test="${view.file_name ne null}">
				<tr>
					<td bgcolor="orange">첨부파일:${view.ufile_name}</td>
					<td align="left">
					 	<input type="hidden"name="userfileName" value="${view.ufile_name}">
						<input type="hidden" name="bno" value="${view.bno}">
						<input type="hidden" name="fileName" value="${view.file_name}">
						<button id="btn" type="submit">다운로드</button>
					</td>
				</tr>
			</c:if>
		</form>	
		<c:forEach items="${reply}" var="reply">
			<li>
				<div class="media text-muted pt-3">
					<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">
						<title>Placeholder</title>
						<rect width="100%" height="100%" fill="#007bff"></rect>
						<text x="50%" fill="#007bff" dy=".3em">32x32</text>
					</svg>
					<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">
						<span class="d-block">
							<strong class="text-gray-dark"> ${reply.writer}</strong>
							<span style="padding-left: 7px; font-size: 9pt">
							<fmt:formatDate value="${reply.regDate}" pattern="yy-MM-dd" />
								<span style="padding-left: 7px; font-size: 9pt">
								
								
								</span>
							</span>
						</span>
						<c:out value="${reply.content}" />

					</p>
					<c:if test="${member.userName == reply.writer}">
						<form id="reply" method="post" action="/reply/delete">
							<input type="hidden" name="rno" value="${reply.rno}">
							<input type="hidden" name="bno" value="${reply.bno}">
							<button id="rdbtn" type="submit" onclick = "rdbtn()">댓글 삭제</button>
						</form>
					</c:if>
				</div>
			</li>
		</c:forEach>
		</div>
		<div id="footer">
			<%@ include file="../include/footer.jsp"%>
		</div>
</div>

<script type="text/javascript">
function dbtn(){
	var rbno = ${reply[0].bno}
	var conf = confirm("a");
		if(rbno==null){
			return false;
		}else if(rbno!=null){
			$("#vdelete").attr("action", "delete");
		}
		
	}
function rbtn(){
	var conf = confirm("댓글 작성 하시겠습니까?");
	if(conf==false){
		alert('false');
		
	}
		return false;
}
/* $("#btn").on("click", function(){
	
} */

</script>
	
		
</body>
</html>