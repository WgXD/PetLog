<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
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
    h1 {
        font-size: 30px;
        margin-bottom: 30px;
        color: #333;
    }
    form {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    label {
        font-size: 16px;
        color: #555;
        margin: 10px 0 5px;
        align-self: flex-start;
    }
    input[type="text"],
    input[type="file"] {
        width: 100%;
        max-width: 400px;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 15px;
    }
    button, input[type="button"] {
        background: linear-gradient(135deg, #ffc1cc, #fbe5c8);
        color: #5a5a5a;
        border: none;
        padding: 12px 24px;
        border-radius: 30px;
        font-size: 15px;
        cursor: pointer;
        font-weight: bold;
        margin: 10px;
        transition: all 0.3s;
    }
    button:hover, input[type="button"]:hover {
        background: linear-gradient(135deg, #fba0b2, #f8d7af);
        color: #333;
    }
</style>
</head>
<body>
<div class="container">
    <h1>회원정보수정</h1>
    <form action="updateProfile" method="post" enctype="multipart/form-data">
        <input type="hidden" name="user_login_id" value="${dto.user_login_id}">
        
        <label for="name">이름</label>
        <input type="text" name="name" value="${dto.name}">
       
        <label for="phone">전화번호</label>
        <input type="text" name="phone" value="${dto.phone}">
        
        <label for="email">이메일</label>
        <input type="text" name="email" value="${dto.email}">
        
        <label for="profileimg">프로필 이미지</label>
        <input type="file" name="profileimg">
        
        <div>
            <button type="submit">저장</button>
            <input type="button" value="취소"  onclick="location.href='./mypage'">
        </div>
    </form>
</div>
</body>
</html>