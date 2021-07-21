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

<link rel="stylesheet" 
href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
 integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" 
 crossorigin="anonymous">


<meta charset="UTF-8">
<title>게시물 조회</title>
</head>
<body>
	<div id="nav"> <%@ include file="../include/nav.jsp"%></div>
<div class="inner_index" style="height:auto !important;">

	<div class="content">
		<label>작성자:</label> ${view.writer} <br />
		
		<label>제목:</label> ${view.title}	<br />
	
		<label>내용:</label> ${view.content}
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
					<textarea rows="5" cols="50" name="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
				</p>
				<p>
					<input type="hidden" name="bno" value="${view.bno}">
					<c:choose>
						<c:when test="${member != null}">
							<button id="btn" type="submit" class="btn btn-sm btn-primary">댓글 작성</button>
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
				<div>
				<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">
				<strong class="text-gray-dark"> ${reply.writer}</strong>
					<fmt:formatDate value="${reply.regDate}" pattern="yy-MM-dd" />
					
						<c:if test="${member.userName == reply.writer}">
							<form id="reply" method="post" action="/reply/delete">
								<input type="hidden" name="rno" value="${reply.rno}">
								<input type="hidden" name="bno" value="${reply.bno}">
								<button id="rdbtn" type="submit" onclick = "rdbtn()">댓글 삭제</button>
							</form>
						</c:if>
					</p>
						${reply.content}
				</div>
			
			</li>
		</c:forEach>
		
			<!-- Reply Form {s} -->
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">

				<form:form name="form" id="form" role="form" commandName="replyVO" method="post">

				<form:hidden path="bno" id="bno"/>

				<div class="row">

					<div class="col-sm-10">

						<form:textarea path="content" id="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></form:textarea>

					</div>

					<div class="col-sm-2">

						<form:input path="writer" class="form-control" id="writer" placeholder="댓글 작성자"></form:input>

						<button type="button" class="btn btn-sm btn-primary" id="btnReplySave" style="width: 100%; margin-top: 10px"> 저 장 </button>

					</div>

				</div>

				</form:form>

			</div>
			<!-- Reply Form {e} -->
		</div>
		<div id="footer">
			<%@ include file="../include/footer.jsp"%>
		</div>
</div>

<script type="text/javascript">
function dbtn(){
	alert('게시물이 삭제 되었습니다.');
	if(${reply[0].bno}!=null || ${reply[0].bno}!=""){
		$("#vdelete").attr("action", "delete");
	}
}


function showReplyList(){

	var url = "${pageContext.request.contextPath}/reply/getReqlyList";

	var paramData = {"bno" : "${reply[0].bno}"};

	$.ajax({

        type: 'POST',

        url: url,

        data: paramData,

        dataType: 'json',

        success: function(result) {

           	var htmls = "";

		if(result.length < 1){

			htmls.push("등록된 댓글이 없습니다.");

		} else {

                    $(result).each(function(){

                     htmls += '<div class="media text-muted pt-3" id="rno' + this.rno + '">';

                     htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';

                     htmls += '<title>Placeholder</title>';

                     htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';

                     htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';

                     htmls += '</svg>';

                     htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';

                     htmls += '<span class="d-block">';

                     htmls += '<strong class="text-gray-dark">' + this.writer + '</strong>';

                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';

                     htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.rno + ', \'' + this.writer + '\', \'' + this.content + '\' )" style="padding-right:5px">수정</a>';

                     htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.rno + ')" >삭제</a>';

                     htmls += '</span>';

                     htmls += '</span>';

                     htmls += this.content;

                     htmls += '</p>';

                     htmls += '</div>';


                });	//each end


		}

		$("#replyList").html(htmls);

            

        }	   // Ajax success end

	});	// Ajax end

}
</script>
	
		
</body>
</html>