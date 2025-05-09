<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>📔 오늘의 일기 작성</title>

  <style>
    body {
      font-family: 'Arial', sans-serif;
      background: linear-gradient(to right, #e6f7f6, #fff0f4);
      margin: 0;
      padding: 0;
      color: #333;
    }

    .container {
      max-width: 900px;
      margin: 100px auto 80px auto;
      background: #fff;
      padding: 50px 60px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
      border: 1px solid #e0e0e0;
    }

    h2 {
      text-align: center;
      font-size: 28px;
      color: #d85a8a;
      margin-top: 0;
      margin-bottom: 20px;
    }

    .form-group {
      display: flex;
      align-items: center;
      margin-bottom: 22px;
    }

    .form-group label {
      flex: 0 0 140px;
      font-weight: bold;
      font-size: 15px;
      color: #555;
    }

    .form-group input[type="text"],
    .form-group input[type="date"],
    .form-group input[type="file"],
    .form-group select,
    .form-group textarea {
      flex: 1;
      padding: 10px 12px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 6px;
      transition: border-color 0.3s ease;
    }

    .form-group textarea {
      resize: vertical;
      height: 160px;
    }

    .form-group input:focus,
    .form-group textarea:focus,
    .form-group select:focus {
      border-color: #a3d8cd;
      outline: none;
    }

    .form-actions {
      text-align: center;
      margin-top: 40px;
    }

    input[type="submit"],
    input[type="reset"] {
      background-color: #d85a8a;
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 6px;
      font-size: 16px;
      font-weight: bold;
      margin: 0 12px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover,
    input[type="reset"]:hover {
      background-color: #c14573;
    }

    .pet-count {
      text-align: center;
      font-size: 14px;
      color: #666;
      margin-bottom: 30px;
    }

    @media screen and (max-width: 768px) {
      .form-group {
        flex-direction: column;
        align-items: flex-start;
      }

      .form-group label {
        margin-bottom: 8px;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <h2>📔 오늘의 일기 작성</h2>
  
<div class="pet-count">
  등록한 반려동물 : <strong style="color:#d85a8a;">${fn:length(list)}마리</strong>
</div>

  <form action="diary_save" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <label for="pet_id">반려동물</label>
      <select name="pet_id" id="pet_id" required>
        <c:forEach var="pet" items="${list}">
          <option value="${pet.pet_id}">${pet.pet_name}</option>
        </c:forEach>
      </select>
    </div>

    <div class="form-group">
      <label for="diary_title">제목</label>
      <input type="text" id="diary_title" name="diary_title" required>
    </div>

    <div class="form-group">
      <label for="diary_date">날짜</label>
      <input type="date" id="diary_date" name="diary_date" required>
    </div>

    <div class="form-group">
      <label for="diary_image">이미지</label>
      <input type="file" id="diary_image" name="diary_image">
    </div>

    <div class="form-group">
      <label for="diary_content">내용</label>
      <textarea id="diary_content" name="diary_content" required></textarea>
    </div>

    <div class="form-actions">
      <input type="submit" value="💾 저장하기">
      <input type="reset" value="❌ 취소하기" onclick="history.back()">
    </div>
  </form>
</div>

</body>
</html>