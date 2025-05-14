<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <style>
    body {
      background-color: #fff6f6;
      margin: 0;
      padding: 0;
      font-family: 'Pretendard', sans-serif;
      color: #333;
    }

    .container {
      max-width: 1000px;
      margin: 60px auto 100px auto;
      background: #fff;
      padding: 60px 80px;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }

    h2 {
      text-align: center;
      font-size: 26px;
      color: #f48aa5;
      font-weight: bold;
      margin-top: 0;
      margin-bottom: 30px;
    }

    .pet-count {
      text-align: center;
      font-size: 15px;
      margin-bottom: 30px;
      color: #555;
    }

    .pet-count strong {
      color: #f06292;
    }

    .form-group {
      display: flex;
      align-items: center;
      margin-bottom: 20px;
    }

    .form-group label {
      flex: 0 0 120px;
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
      padding: 12px 16px;
      font-size: 15px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fffdfd;
      font-family: 'Pretendard', sans-serif;
      transition: all 0.2s ease-in-out;
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    .form-group textarea {
      resize: vertical;
      height: 140px;
    }

    .form-group input:focus,
    .form-group textarea:focus,
    .form-group select:focus {
      border-color: #f48aa5;
      box-shadow: 0 0 0 3px rgba(244, 138, 165, 0.2);
      outline: none;
    }

    .form-actions {
      text-align: center;
      margin-top: 40px;
    }

    input[type="submit"],
    input[type="reset"] {
      background-color: #f48aa5;
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 10px;
      font-size: 15px;
      font-weight: normal;
      margin: 0 10px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover,
    input[type="reset"]:hover {
      background-color: #db7093;
    }

    @media screen and (max-width: 768px) {
      .form-group {
        flex-direction: column;
        align-items: flex-start;
      }

      .form-group label {
        margin-bottom: 8px;
      }

      .container {
        padding: 40px 24px;
      }
      }
  </style>
</head>
<body>
  <div class="container">
    <h2 style="font-weight: normal">📔 일기 쓰기</h2>
    <div class="pet-count">
      등록한 반려동물 : <strong style="color:#8dd3c7">${fn:length(list)}마리</strong>
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
