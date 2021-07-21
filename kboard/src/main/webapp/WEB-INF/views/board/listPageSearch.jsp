<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
</head>
<body>
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>
<div class="inner_index" style="height:auto !important;">
	<table>
		<thead>
			<tr class="tr">
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>작성자</th>
				<th>조회수</th>
			</tr>
		</thead>

		<tbody>
		<c:choose>
			<c:when test="${empty list}" >
				<tr><td colspan="10" align="center">게시물이 없습니다.</td></tr>
			</c:when> 
			<c:when test="${!empty list}">
				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.rownum}</td>
						<td><a href="/board/view?bno=${list.bno}"> ${list.title} </a></td>
						<td><fmt:formatDate value="${list.regDate}" pattern="yy-MM-dd" /></td>
						<td>${list.writer}</td>
						<td>${list.viewCnt}</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
		</tbody>
	</table>
	<div class="paging">
		<c:if test="${page.prev}">
			<span>[ <a
				href="/board/listPageSearch?num=${page.startPageNum - 1}${page.searchTypeKeyword}">이전</a>
				]
			</span>
		</c:if>

		<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			<span> <c:if test="${select != num}">
					<a href="/board/listPageSearch?num=${num}${page.searchTypeKeyword}">${num}</a>
				</c:if> <c:if test="${select == num}">
					<b>${num}</b>
				</c:if>

			</span>
		</c:forEach>

		<c:if test="${page.next}">
			<span> <a href="/board/listPageSearch?num=${page.endPageNum + 1}${page.searchTypeKeyword}">다음</a>
				
			</span>
		</c:if>
		<div>
			<select name="searchType">
				<option value="title"
					<c:if test="${searchType eq 'title'}">selected</c:if>>제목</option>
				<option value="content"
					<c:if test="${searchType eq 'content'}">selected</c:if>>내용</option>
				<option value="title_content"
					<c:if test="${searchType eq 'title_content'}">selected</c:if>>제목+내용</option>
				<option value="writer"
					<c:if test="${searchType eq 'writer'}">selected</c:if>>작성자</option>
			</select> <input type="text" name="keyword" value="${keyword}" />

			<button type="button" id="searchBtn">검색</button>
		</div>
	</div>


	<div id="footer">
		<%@ include file="../include/footer.jsp"%>
	</div>
</div> <!-- inner index </div>-->	
	<script>
		document.getElementById("searchBtn").onclick = function() {

			let searchType = document.getElementsByName("searchType")[0].value;
			let keyword = document.getElementsByName("keyword")[0].value;

			location.href = "/board/listPageSearch?num=1" + "&searchType="
					+ searchType + "&keyword=" + keyword;

			console.log(searchType)
			console.log(keyword)
		};
	</script>
</body>
</html>