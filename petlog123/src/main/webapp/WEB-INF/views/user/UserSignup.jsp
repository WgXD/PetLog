<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
/* 전체 폼 감싸는 부분 */
.signup-wrapper {
  max-width: 400px; /* ★ 작게 조정 */
  width: 90%;
  margin: 40px auto;
  background-color: #ffffff;
  padding: 30px 30px; /* ★ padding 줄여서 더 아담하게 */
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.06);
}

/* 제목 스타일 */
.signup-wrapper h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #3e312b;
}

/* 입력폼 그룹 */
.form-group {
  margin-bottom: 20px;
}

/* 라벨 공통 스타일 */
label {
  display: block;
  margin-bottom: 8px;
  font-size: 15px;
  color: #5c5147;
  font-weight: 500;
  text-align: left;
}

/* 아이디 입력창 + 버튼 나란히 */
.input-row {
  display: flex;
  gap: 10px;
}

/* 텍스트 입력, 패스워드 입력 기본 스타일 */
input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 12px;
  font-size: 14px;
  border: 1px solid #d8d2cc;
  border-radius: 8px;
  box-sizing: border-box;
}

/* 입력 포커스시 테두리 색 변경 */
input[type="text"]:focus,
input[type="password"]:focus {
  outline: none;
  border-color: #b89b86;
}

/* 중복확인 버튼 스타일 */
.id-check-btn {
  padding: 12px 14px;
  background-color: #f4a7b9; /* 핑크 */
  color: white;
  font-size: 13px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  white-space: nowrap;
  transition: background-color 0.3s;
}

/* 중복확인 버튼 hover */
.id-check-btn:hover {
  background-color: #e989a0;
}

/* 전송/취소 버튼 묶음 */
.button-group {
  display: flex;
  justify-content: space-between;
  margin-top: 30px;
}

/* 전송/취소 버튼 개별 스타일 */
.button-group input {
  width: 48%;
  padding: 12px 0;
  font-size: 15px;
  border: none;
  border-radius: 8px;
  background-color: #f7cac9;
  color: #5c5147;
  cursor: pointer;
  transition: background-color 0.3s;
}

/* 전송/취소 버튼 hover */
.button-group input:hover {
  background-color: #f3b3b2;
}
</style>
</head>
<body>
<div class="signup-wrapper">
<h2>회원가입</h2>
  <!-- 회원가입 form 시작 -->
  <form action="SignupSave" method="post" onsubmit="return validateForm()">
    <!-- 아이디 입력 + 중복확인 -->
    <div class="form-group">
      <label for="id">아이디</label>
      <div class="input-row">
        <input type="text" id="id" name="user_login_id" placeholder="아이디를 입력하세요.">
        <button type="button" class="id-check-btn" id="idcheck">중복확인</button>
      </div>
    </div>
    <!-- 비밀번호 입력 -->
    <div class="form-group">
      <label for="password">비밀번호</label>
      <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요." required oninput="checkPasswordMatch()">
    </div>
    <!-- 비밀번호 확인 입력 -->
    <div class="form-group">
      <label for="confirm_password">비밀번호 확인</label>
      <input type="password" id="confirm_password" name="confirm_password" placeholder="비밀번호를 다시 입력하세요." oninput="checkPasswordMatch()" required>
      <!-- 비밀번호 불일치 메시지 출력 -->
      <div id="pw-message" style="color: red; font-size: 12px; margin-top: 5px; min-height: 16px;"></div>
    </div>
    <!-- 이름 입력 -->
    <div class="form-group">
      <label for="name">이름</label>
      <input type="text" id="name" name="name" placeholder="이름을 입력하세요." required>
    </div>
    <!-- 전화번호 입력 -->
    <div class="form-group">
      <label for="phone">전화번호</label>
      <input type="text" id="phone" name="phone" placeholder="숫자만 입력하세요." oninput="formatPhoneNumber(this)" maxlength="13" required>
      <!-- 전화번호 입력시 실시간 하이픈(-) 자동 생성 -->
    </div>
    <!-- 주소 입력 -->
    <div class="form-group">
      <label for="address">주소</label>
      <input type="text" id="address" name="address" placeholder="주소를 입력하세요.">
      <!-- 추가 hidden값 (초기 프로필, 등급, 권한) -->
      <input type="hidden" name="profileimg" value="default.png">
      <input type="hidden" name="rank" value="브론즈">
      <input type="hidden" name="user_role" value="user">
    </div>
    <!-- 전송/취소 버튼 -->
    <div class="button-group">
      <input type="submit" value="전송">
      <input type="reset" value="취소">
    </div>
  </form>
  <!-- 회원가입 form 끝 -->
</div>

<!-- jQuery (아이디 중복검사용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 아이디 중복검사 처리 -->
<script>
$(document).ready(function(){
  $("#idcheck").click(function(){
    var id = $("#id").val().trim();
    if(id === "") {
      alert("아이디를 입력하세요.");
      return;
    }
    $.ajax({
      type: "post",
      url: "idcheck",
      data: { user_login_id: id },
      success: function(data){
        if(data === "ok"){
          alert("사용 가능한 ID입니다.");
        } else {
          alert("이미 사용 중인 ID입니다.");
        }
      }
    });
  });
});
</script>
<!-- 비밀번호 일치 검사 -->
<script>
function checkPasswordMatch() {
  const pw = document.getElementById("password").value;
  const cpw = document.getElementById("confirm_password").value;
  const msg = document.getElementById("pw-message");

  if (pw !== cpw) {
    msg.textContent = "비밀번호가 일치하지 않습니다.";
  } else {
    msg.textContent = "";
  }
}
<!-- 최종 form 제출할 때 비밀번호 재검사 -->
function validateForm() {
  const pw = document.getElementById("password").value;
  const cpw = document.getElementById("confirm_password").value;

  if (pw !== cpw) {
    alert("비밀번호가 일치하지 않습니다!");
    return false;
  }
  return true;
}
</script>
<!-- 전화번호 하이픈(-) 자동 포맷 -->
<script>
function formatPhoneNumber(input) {
  let numbers = input.value.replace(/\D/g, ""); // 숫자 아닌 문자 제거
  let formatted = "";

  if (numbers.length < 4) {
    formatted = numbers;
  } else if (numbers.length < 8) {
    formatted = numbers.slice(0, 3) + "-" + numbers.slice(3);
  } else {
    formatted = numbers.slice(0, 3) + "-" + numbers.slice(3, 7) + "-" + numbers.slice(7, 11);
  }
  input.value = formatted;
}
</script>
</body>
</html>
