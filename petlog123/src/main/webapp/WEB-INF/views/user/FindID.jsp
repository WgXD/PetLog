<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
  body {
    font-family: "Malgun Gothic", sans-serif;
    background-color: #fff5f5;
    margin: 0;
    padding: 0;
  }

  .wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }

  .find-box {
    background-color: #ffffff;
    padding: 40px 30px;
    border-radius: 20px;
    box-shadow: 0 0 15px rgba(0,0,0,0.05);
    width: 420px;
    text-align: center;
  }

  .find-box h2 {
    margin-bottom: 30px;
    color: #333;
    font-size: 24px;
  }

  .input-group {
 	width: 100%;  
    margin-bottom: 20px;
    text-align: left;
  }

  label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #555;
  }

  input[type="text"] {
    display: block;
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 14px;
    box-sizing: border-box;
  }

  button {
    width: 100%;
    padding: 12px;
    background-color: #f5bcbc;
    color: #333;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
    margin-top: 10px;
  }

  #resultMessage {
    margin-top: 20px;
    text-align: center;
    color: #cc3366;
    font-weight: bold;
  }

  .link-box {
    margin-top: 25px;
    font-size: 13px;
    color: #666;
  }

  .link-box a {
    color: #666;
    text-decoration: none;
    margin: 0 10px;
  }

  .link-box a:hover {
    text-decoration: underline;
  }
  .email-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 8px;
  margin-bottom: 20px;
}

.email-row input,
.email-row select {
  flex: 1;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 8px;
  font-size: 14px;
  box-sizing: border-box;
}
</style>
</head>
<body>

<div class="wrapper">
  <div class="find-box">
    <h2>아이디 찾기</h2>
    <form id="findIdForm">
    
      <div class="input-group">
        <label for="name">이름</label>
        <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>
      </div>
      
      <!-- 이메일 아이디 + 도메인 분리 -->
      <div class="input-group">
      <label for="emailId">이메일</label>
		<div class="email-row">
		  <input type="text" id="emailId" placeholder="이메일 아이디 입력" required>
		  <select id="emailDomain">
		    <option value="@naver.com">@naver.com</option>
		    <option value="@gmail.com">@gmail.com</option>
		    <option value="@daum.net">@daum.net</option>
		    <option value="@kakao.com">@kakao.com</option>
		  </select>
		</div>
		</div>
		<input type="hidden" name="email" id="fullEmail">
		
	 <div class="input-group">
        <label for="phone">전화번호</label>
        <input type="text" id="phone" name="phone" placeholder="전화번호를 입력하세요" required>
      </div>
      <button type="button" onclick="findId()">아이디 찾기</button>
    </form>
    <p id="resultMessage"></p>

    <div class="link-box">
      <a href="${pageContext.request.contextPath}/login">로그인</a> |
      <a href="${pageContext.request.contextPath}/findPwPage">비밀번호 찾기</a>
    </div>
  </div>
</div>
<script>
function findId() {
    // ✅ 이메일 먼저 조합
    const emailId = document.getElementById("emailId").value.trim();
    const emailDomain = document.getElementById("emailDomain").value;
    const fullEmail = emailId + emailDomain;
    document.getElementById("fullEmail").value = fullEmail;

    // ✅ Ajax로 전달할 formData 구성
    var formData = {
        name: $("#name").val(),
        email: fullEmail, // 조합된 이메일 사용
        phone: $("#phone").val()
    };

    $.ajax({
        type: "post",
        url: "${pageContext.request.contextPath}/findId",
        data: formData,
        success: function(data){
            $("#resultMessage").text(data);
        },
        error: function(){
            $("#resultMessage").text("오류가 발생했습니다. 다시 시도해 주세요.");
        }
    });
}
</script>

</body>
</html>
