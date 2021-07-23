<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>회원가입</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			// 취소
			$(".cencle").on("click", function(){
				
				location.href = "/board/listPageSearch?num=1";
						    
			})
		
			$("#submit").on("click", function(){
				if($("#userId").val()==""){
					alert("아이디를 입력해주세요.");
					$("#userId").focus();
					return false;
				}if($("#userId").val().length < 6){
					alert("아이디를 최소 6글자 이상 작성해 주세요.");
					$("#userId").focus();
					return false;
				}
				if($("#userPass").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				if($("#userPass").val().length < 8){
					alert("비밀번호를 8글자 이상으로 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("성명을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				if($("#userPhon").val()==""){
					alert("전화번호를 입력해주세요.");
					$("#userPhon").focus();
					return false;
				}
				if($("#useraddr1").val()==""){
					alert("주소를 입력해주세요.");
					$("#useraddr1").focus();
					return false;
				}
			});
			
				
			
		})
	</script>
	<body>
	<div id="nav"> <%@ include file="../include/nav.jsp"%></div>
	<article>
		<div class="container col-md-6" role="main">
			<div class="card">
				<div class="card-header">Register</div>
				<div class="card-body">
					<form action="/member/signup" method="post">
						<div class="col-md-5">
							<label class="control-label" for="userId">아이디</label>
							<input class="form-control" type="text" id="userId" name="userId" />
						</div>
						<div class="col-md-5">
							<label class="control-label" for="userPass">패스워드</label>
							<input class="form-control" type="password" id="userPass" name="userPass" />
						</div>
						<div class="col-md-5">
							<label class="control-label" for="userName">성명</label>
							<input class="form-control" type="text" id="userName" name="userName" />
						</div>
						<div class="col-md-5">
							<label class="control-label" for="userPhon">휴대폰 번호</label>
							<input class="form-control" type="text" id="userPhon" name="userPhon" />
						</div>
						<div class="col-md-5">
							<label class="control-label" for="useraddr1">주소</label>
							<input class="form-control" type="text" id="useraddr1" name="useraddr1" />
						</div>
						<div class="col-md-5">
							<button class="btn btn-success" type="submit" id="submit">회원가입</button>
							<button class="cencle btn btn-danger" type="button">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</article>
	</body>
	
</html>