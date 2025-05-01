<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

    body {
        font-family: 'Nanum Gothic', sans-serif;
        background-color: #ffffff;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 700px;
        margin: 50px auto;
        background-color: #ffffff;
        padding: 40px;
        border-radius: 20px;
        text-align: center;
    }
    .profile-img {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        object-fit: cover;
        object-position: center;
        border: 5px solid #ffc1cc;
        margin-bottom: 25px;
    }
    h1 {
        font-size: 30px;
        margin-bottom: 25px;
        color: #333;
    }
    h3 {
        font-size: 22px;
        color: #555;
    }
    .info {
        text-align: left;
        margin: 25px 0;
        font-size: 17px;
        color: #444;
    }
    .info p {
        margin: 10px 0;
    }

    .btn-group {
        margin-top: 30px;
    }
    .btn-group a {
        display: inline-block;
        background: linear-gradient(135deg, #ffc1cc, #fbe5c8);
        color: #5a5a5a;
        text-decoration: none;
        padding: 12px 24px;
        border-radius: 30px;
        font-size: 15px;
        cursor: pointer;
        font-weight: bold;
        margin: 0 10px;
        transition: all 0.3s;
    }
    .btn-group a:hover {
        background: linear-gradient(135deg, #fba0b2, #f8d7af);
        color: #333;
    }
</style>
</head>
<body>
<div class="container">
    <h1>마이페이지</h1>
    <!-- 프로필 이미지 -->
    <img src="./image/${dto.profileimg != null ? dto.profileimg : 'default.png'}" class="profile-img">
    <h3>${dto.name}님의 회원정보</h3>

    <!-- 회원 정보 -->
    <div class="info">
        <p><strong>아이디:</strong> ${dto.user_login_id}</p>
        <p><strong>이름:</strong> ${dto.name}</p>
        <p><strong>전화번호:</strong> ${dto.phone}</p>
        <p><strong>포도알:</strong> 🍇 ${dto.grape_count}개</p>
        <p><strong>퀴즈 등급:</strong> ${dto.rank}</p>
    </div>

    <!-- 버튼 그룹 -->
    <div class="btn-group">
        <a href="UserEditProfile">회원정보 수정</a>
        <a href="petProfile">펫 정보</a>
    </div>
</div>
</body>
</html>
