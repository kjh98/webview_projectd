<%--
  Created by IntelliJ IDEA.
  User: kjh48
  Date: 2021-10-25
  Time: 오후 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach var="tmp" items="${list}">
    <div class="chat_list_box${tmp.room} chat_list_box">
        <div type="button" class="chat_list" room="${tmp.room}" other-nick="${tmp.other_nick}">
            <!--active-chat -->
            <div class="chat_people">
                <div class="chat_img">
                    <a href="other_profile.do?other_nick=${tmp.other_nick}">
                        <img src="/resources/image/upload/${tmp.profile}" alt="sunil">
                    </a>
                </div>
                <div class="chat_ib">
                    <h5>${tmp.other_nick}<span class="chat_date">${tmp.send_time}</span></h5>
                    <div class="row">
                        <div class="col-10">
                            <p>${tmp.content}</p>
                        </div>
                            <%--만약 현재 사용자가 안읽은 메세지 갯수가 0보다 클떄만 badge를 표시한다--%>
                        <c:if test="${tmp.unread > 0}">
                            <div class="col-2 unread${tmp.room}">
                                <span class="badge bg-danger">${tmp.unread}</span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

</c:forEach>