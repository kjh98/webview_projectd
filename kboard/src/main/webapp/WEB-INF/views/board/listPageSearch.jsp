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
	<div class="time"></div>
	<div class="calendar"></div>

<div class="inner_index" style="height:auto !important;">
	<div class="container">	
		<div class="table-responsive">
			<table class="table table-striped table-sm">
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
								<td><a href="/board/view?bno=${list.bno}"><c:out value="${list.title}"/>  </a></td>
								<td><fmt:formatDate value="${list.regDate}" pattern="yy-MM-dd" /></td>
								<td><c:out value="${list.writer}"/></td>
								<td>${list.viewCnt}</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
				</tbody>
			</table>
		</div>
	</div>
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

			<button type="button" id="searchBtn" >검색</button>
		</div>
	</div>
	<div id="footer">
		<%@ include file="../include/footer.jsp"%>
	</div>
</div> <!-- inner index </div>-->	
	<div id="calendarForm"></div>
	<div id="time" class="time"></div>
	<div id="date" class="date"></div>
	<script>
		document.getElementById("searchBtn").onclick = function() {

			let searchType = document.getElementsByName("searchType")[0].value;
			let keyword = document.getElementsByName("keyword")[0].value;

			location.href = "/board/listPageSearch?num=1" + "&searchType="
					+ searchType + "&keyword=" + keyword;

			console.log(searchType)
			console.log(keyword)
		};
		
		
		$("#calendarForm").hide();
		$("#date").hide();
		$("#time").hide();


		$(".nav1 li:nth-of-type(5)").click(function() {
			$(".inner_index").css("display","none");
			$("#calendarForm").show();
			$("#date").show();
			$("#time").show();
		});
		
		
		
		(function () {
		    calendarMaker($("#calendarForm"), new Date());
		})();

		var nowDate = new Date();
		function calendarMaker(target, date) {
		    if (date == null || date == undefined) {
		        date = new Date();
		    }
		    nowDate = date;
		    if ($(target).length > 0) {
		        var year = nowDate.getFullYear();
		        var month = nowDate.getMonth() + 1;
		        $(target).empty().append(assembly(year, month));
		    } else {
		        console.error("custom_calendar Target is empty!!!");
		        return;
		    }
		    var NowMonth = new Date(nowDate.getFullYear(), nowDate.getMonth()+1, nowDate.getDate());
		    var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
		    var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, 0);
// 		    console.log("this"+thisMonth.getDay());

		    var tag = "<tr>";
		    var cnt = 0;
		    var a=1;
		    //빈 공백 만들어주기
		    for (i = 0; i < thisMonth.getDay(); i++) {
		        tag += "<td></td>";
		        cnt++;
		    }

		    //날짜 채우기
		    for (i = 1; i <= thisLastDay.getDate(); i++) {
// 		    	console.log('thisLastDay.getDate()' + NowMonth.getDate());
// 		    	console.log('i' + i);
		        if (cnt % 7 == 0) { tag += "<tr>"; }
// 		        console.log("year:"+ year +" " +"month:" +month +" " +"i:"+ i +" "+"NowMonth.getDate():"+NowMonth.getDate() )
		        var nowmd = new Date();
		        var nowmt = nowmd.getMonth() + 1;
		        var dayday = nowmd.getFullYear()+"-"+ nowmt +"-"+ nowmd.getDate();
		        var nday = year+"-"+month+"-"+ i
// 		        console.log("dayday: "+ dayday);
// 		        console.log("nday: "+nday);
			        if(dayday == nday){
			        	tag += "<td class='currentdate'>" + i + "</td>";
		        	}else{
				        tag += "<td>" + i + "</td>";
	        		}
			    	    cnt++;
		        if (cnt % 7 == 0) {
		            tag += "</tr>";
		        }
		        
		    }
		    $(target).find("#custom_set_date").append(tag);
		    calMoveEvtFn();

		    function assembly(year, month) {
		        var calendar_html_code =
		            "<table class='custom_calendar_table'>" +
		            "<colgroup>" +
		            "<col style='width:81px'/>" +
		            "<col style='width:81px'/>" +
		            "<col style='width:81px'/>" +
		            "<col style='width:81px'/>" +
		            "<col style='width:81px'/>" +
		            "<col style='width:81px'/>" +
		            "<col style='width:81px'/>" +
		            "</colgroup>" +
		            "<thead class='cal_date'>" +
		            "<th><button type='button' class='prev'><</button></th>" +
		            "<th colspan='5'><p><span>" + year + "</span>년 <span>" + month + "</span>월</p></th>" +
		            "<th><button type='button' class='next'>></button></th>" +
		            "</thead>" +
		            "<thead  class='cal_week'>" +
		            "<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>" +
		            "</thead>" +
		            "<tbody id='custom_set_date'>" +
		            "</tbody>" +
		            "</table>";
		        return calendar_html_code;
		    }

		    function calMoveEvtFn() {
		        //전달 클릭
		        $(".custom_calendar_table").on("click", ".prev", function () {
		            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
		            calendarMaker($(target), nowDate);
		        });
		        //다음날 클릭
		        $(".custom_calendar_table").on("click", ".next", function () {
		            nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
		            calendarMaker($(target), nowDate);
		        });
		        //일자 선택 클릭
		        $(".custom_calendar_table").on("click", "td", function () {
		            $(".custom_calendar_table .select_day").removeClass("select_day");
		            $(this).removeClass("select_day").addClass("select_day");
		        });
		    }
		}



		function setClock(){
			var timer_dateInfo = new Date();
			var timer_hour = modifyNumber(timer_dateInfo.getHours());
			var timer_min = modifyNumber(timer_dateInfo.getMinutes());
			var timer_sec = modifyNumber(timer_dateInfo.getSeconds());
			var timer_year = timer_dateInfo.getFullYear();
			var timer_month = timer_dateInfo.getMonth()+1; //monthIndex를 반환해주기 때문에 1을 더해준다.
			var timer_date = timer_dateInfo.getDate();
			document.getElementById("time").innerHTML = timer_hour + ":" + timer_min  + ":" + timer_sec;
			document.getElementById("date").innerHTML = timer_year + "년 " + timer_month + "월 " + timer_date + "일";
		}
		function modifyNumber(time){
			if(parseInt(time)<10){
				return "0"+ time;
			}
			else
				return time;
		}
		window.onload = function(){
			setClock();
			setInterval(setClock,1000); //1초마다 setClock 함수 실행
		}
	</script>
</body>
</html>