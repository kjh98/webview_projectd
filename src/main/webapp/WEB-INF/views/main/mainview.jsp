<%--
  Created by IntelliJ IDEA.
  User: kjh48
  Date: 2021-10-25
  Time: 오전 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/message_list.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <c:set var="path" value="${pageContext.request.contextPath}" />
</head>
<body>
    <div class="msg-container">

        <div class="messaging">
            <div class="inbox_msg">
                <%--메세지 목록 영역--%>
                <div class="inbox_people">
                    <div class="headind_srch">
                        <div class="recent_heading">
                            <h4>Recent</h4>
                        </div>
                        <!-- 메세지 검색 -->
                        <div class="srch_bar">
                            <div class="stylish-input-gorup">
                                <input type="text" class="search-bar" placeholder="Search">
                                <span class="input-group-addon">
                                    <button type="button"><i class="fa fa-search" aria-hidden="true"></i> </button>
                                    <a href="message_ajax_list.do"></a>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 메세지 리스트 -->
                <div class="inbox_chat">

                </div>
                <%-- 메세지 내용 영역--%>
                <div class="mesgs">
                    <%--메세지 내용 목록--%>
                    <div class="msg_history" name="contentList">
                        <%--메세지 내용이 올자리--%>
                    </div>
                    <div class="send_message">
                    </div>
                    <%--메세지 입력란이 올자리--%>
                </div>
            </div>
        </div>
    </div>
    <script>
    //가장 처음 메세지 리스트를 가져온다.
    /*const FirstMessageList = function (){
        $.ajax({
            url:"message_ajax_list.do",
            method:"get",
            data:{},
            success:function (data){
                console.log("메세지 리스트 경고");

                $('.inbox_chat').html(data);

                //메세지 리스트 중 하나를 클릭했을 때
                $('.chat_list').on('click', function (){
                    let room = $(this).attr('room');
                    let other_nick = $(this).attr('other-nick');

                    //선택한 메세지빼고 나머지는 active 효과 해제하기
                    $('.chat_list_box').not('.chat_lsit_box.chat_list_box'+room).removeClass('active_chat');
                    //선택한 메세지만 active 효과 주기
                    $('.chat_list_box' + room).addClass('active_chat');

                    let send_msg = "";
                    send_msg += "<div class='type_msg'>";
                    send_msg += "   <div class='input_msg_write row>";
                    send_msg += "       <div class='col-11'>";
                    send_msg += "           <input type='text' class='write_msg form-control' placeholder='메세지를 입력...' />";
                    send_msg += "       </div>";
                    send_msg += "       <div class='col-1'>";
                    send_msg += "           <button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
                    send_msg += "       </div>";
                    send_msg += "   </div>";
                    send_msg += "</div>";

                    //메세지를 입력, 전송 칸을 보인다.
                    $('.send_message').html(send_msg);

                    //메세지 전송버튼을 눌렀을 때
                    $('.msg_send_btn').on('click',function (){

                        //메세지 함수 호출
                        SendMessage(room, other_nick);

                        // 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
                        //이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드 되면 세세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
                    });

                    //메세지 내용을 불러오는 함수 호출
                    MessageContentList(room);
                });
            }
        })
    };*/


    //가장 처음 메세지 리스트를 가져온다.
/*    const FirstMessageList = function (){
        $.ajax({
            url:"test.jsp",
            method:"get",
            data:{

            },
            success:function (data){
                console.log("data" + data);

            }
        })
    };*/
    $(document).ready(function(){
        $.ajax({
            type: 'get',   //get방식으로 명시
            url : 'message_ajax_list.do',  //이동할 jsp 파일 주소
            dataType:'JSON',   //문자형식으로 받기
            success: function(data){   //데이터 주고받기 성공했을 경우 실행할 결과
                //function(data)를 쓰게 되면 전달받은 데이터가 data안에 담아서 들어오게 된다.
                alert(data);
            },
            error:function(){   //데이터 주고받기가 실패했을 경우 실행할 결과
                alert('실패');
            }
        })
    });

    //메세지 리스트를 다시 가져온다.
    /*const MessageList = function(){
        $.ajax({
            url:"message_ajax_list.do",
            method: "GET",
            data:{
            },
            success:function (data){
                console.log("메세지 리스트 리로드 성공");
              $('.inbox_chat').html(data);

              //메세지 리스트중 하나를 클릭했을 때
                $('.chat_list').on('click', function (){
                    let room = $(this).attr('room');
                    let other_nick = $(this).attr('other-nick');

                    //선택한 메세지빼고 나머지는 active 효과 해제하기
                    $('.chat_list_box').not('.chat_list_box.chat_list_box'+room).removeClass('active_chat');
                    //선택한 메세지만 active 효과 주기
                    $('.chat_list_box' + room).addClass('active_chat');

                    let send_msg = "";
                    send_msg += "<div class='type_msg'>";
                    send_msg += "   <div class='input_msg_write row>";
                    send_msg += "       <div class='col-11'>";
                    send_msg += "           <input type='text' class='write_msg form-control' placeholder='메세지를 입력...' />";
                    send_msg += "       </div>";
                    send_msg += "       <div class='col-1'>";
                    send_msg += "           <button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
                    send_msg += "       </div>";
                    send_msg += "   </div>";
                    send_msg += "</div>";


                    //메세지를 입력, 전송 칸을 보인다.
                    $('.send_message').html(send_msg);

                    //메세지 전송버튼을 눌렀을 때
                    $('.msg_send_btn').on('click',function (){

                        //메세지 함수 호출
                        SendMessage(room, other_nick);

                        // 전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다.
                        //이걸 해결하기 위해 메세지 전송버튼을 누르고 메세지 리스트가 리로드 되면 세세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
                    });
                    //메세지 내용을 불러오는 함수 호출
                    MessagecontentList(room);
                });
                //전송버튼을 누르면 메세지 리스트가 리로드 되면서 현재 열린 메세지의 선택됨 표시가 사라진다
                //이걸 해결하기 위해 메세지 전송 버튼을 누르고 메세지 리스트가 리로드 되면 메세지 리스트의 첫번째 메세지(현재 열린 메세지)가 선택됨 표시 되도록 한다.
                $('.chat_list_box:first').addClass('active_chat');
            }
        });
    };*/
    //메세지 내용을 가져온다.
    //읽지 않은 메세지들을 읽음으로 바꾼다.
   /* const MessageContentList = function (room){
        $.ajax({
            url:"message_content_list.do",
            method:"GET",
            data:{
                room : room
            },
            success:function (data){
                console.log("메세지 내용 가져오기 성고");

                //메세지 내용을 html에 넣는다
                $('.msg_history').html(data);

                // 이 함수로 메세지 내용을 가져올때마다 스크롤을 맨 아래로 가게 한다.
                $('.msg_history').scrollTop($('.msg_history')[0].scrollHeight);
            },
            error : function () {
                    alert('서버에러');
            }
        });
        $('.unread'+room).empty();
    };*/

    //메세지를 전송하는 함수
    /*const SendMessage = function (room, other_nick){
        let  content = $('.write_msg').val();

        content = content.trim();

        if (content == ""){
            alert("메세지를 입력하세요!");
        }else {
            $.ajax({
                url:"message_send_inlist.do",
                method:"GET",
                data:{
                    room : room,
                    other_nick : other_nick,
                    content : content
                },
                success:function (data){
                    console.log("메세지 전송 성공");

                    //메세지 입력칸 비우기
                    $('.write_msg').val("");

                    //메세지 내용 리로드
                    MessageContentList(room);

                    //메세지 리스트 리로드
                    MessageList();
                },
                error : function () {
                    alert('서버에러');
                }
            });
        }

    };*/

/*    $(document).ready(function (){
        FirstMessageList();
    });*/

</script>
</body>
</html>
