<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

body {
    font-family: 'Nanum Gothic', sans-serif;
    background-color: #ffffff;
    margin: 0;
    padding: 0;
}
.container {
    max-width: 600px;
    margin: 50px auto;
    background-color: #ffffff;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 0 12px rgba(0,0,0,0.05);
}
h1 {
    font-size: 28px;
    margin-bottom: 30px;
    text-align: center;
    color: #333;
}

.form-row {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}
.form-row label {
    width: 100px;
    font-weight: bold;
    font-size: 15px;
    color: #444;
}
.form-row input[type="text"],
.form-row input[type="file"],
.form-row select {
    flex: 1;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
}

.email-combo {
    display: flex;
    gap: 6px;
}
.email-combo input {
    flex: 2;
}
.email-combo select {
    flex: 1.2;
}
.email-combo button {
    flex: 1;
    padding: 10px;
    font-size: 14px;
    background-color: #f4a7b9;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}
.email-combo button:hover {
    background-color: #e989a0;
}

.btn-group {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 30px;
}
.btn-group input {
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    background-color: #f4a7b9;
    color: white;
    font-size: 15px;
    cursor: pointer;
}
.btn-group input:hover {
    background-color: #e989a0;
}
</style>
</head>
<body>
<div class="container">
    <h1>👩 회원정보 수정하기</h1>
    <form action="updateProfile" method="post" enctype="multipart/form-data" onsubmit="return combineEmailBeforeSubmit()">
        <input type="hidden" name="user_login_id" value="${dto.user_login_id}">

        <div class="form-row">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" value="${dto.name}" />
        </div>

        <div class="form-row">
            <label for="phone">전화번호</label>
            <input type="text" id="phone" name="phone" value="${dto.phone}" oninput="formatPhoneNumber(this)" maxlength="13"/>
        </div>

        <div class="form-row">
            <label for="emailId">이메일</label>
            <div class="email-combo">
                <input type="text" id="emailId" placeholder="이메일 아이디 입력" />
                <select id="emailDomain">
                    <option value="@naver.com">@naver.com</option>
                    <option value="@gmail.com">@gmail.com</option>
                    <option value="@daum.net">@daum.net</option>
                    <option value="@kakao.com">@kakao.com</option>
                </select>
                <button type="button" id="emailCheckBtn">중복확인</button>
            </div>
        </div>
        <input type="hidden" name="email" id="fullEmail" />

        <div class="form-row">
            <label for="profileimg">프로필 이미지</label>
            <input type="file" name="profileimg" />
        </div>

        <div class="btn-group">
            <input type="submit" value="저장" />
            <input type="button" value="취소" onclick="location.href='./mypage'" />
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
window.onload = function () {
    const email = "${dto.email}";
    if (email) {
        const [id, domain] = email.split("@");
        document.getElementById("emailId").value = id;
        const select = document.getElementById("emailDomain");
        for (let i = 0; i < select.options.length; i++) {
            if (select.options[i].value === "@" + domain) {
                select.selectedIndex = i;
                break;
            }
        }
    }
}

function combineEmailBeforeSubmit() {
    const id = document.getElementById("emailId").value.trim();
    const domain = document.getElementById("emailDomain").value;
    const full = id + domain;
    document.getElementById("fullEmail").value = full;
    return true;
}

$(document).ready(function() {
  $("#emailCheckBtn").click(function() {
    const emailId = $("#emailId").val().trim();
    const domain = $("#emailDomain").val();
    const email = emailId + domain;
    const user_login_id = "${dto.user_login_id}";

    if (emailId === "") {
      alert("이메일 아이디를 입력하세요.");
      return;
    }

    $.ajax({
      type: "post",
      url: "${pageContext.request.contextPath}/emailCheckForUpdate",
      data: {
        email: email,
        user_login_id: user_login_id
      },
      success: function(result) {
        if (result === "ok") {
          alert("사용 가능한 이메일입니다.");
        } else {
          alert("이미 사용 중인 이메일입니다.");
        }
      }
    });
  });
});
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
