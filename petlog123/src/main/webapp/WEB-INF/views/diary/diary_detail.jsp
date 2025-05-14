<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

  .table-wrapper {
    background-color: white;
    width: 100%;
    max-width: 1200px;
    margin: 40px auto 80px auto;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }

  .back-btn-wrap {
    text-align: left;
    margin-bottom: 10px;
  }

  .back-btn {
    background-color: #ffe1e1;
    color: #444;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-size: 1em;
    cursor: pointer;
  }

  .back-btn:hover {
    background-color: #ffd2d2;
  }

  h2 {
    text-align: center;
    color: #f48aa5;
    font-weight: normal;
    font-size: 1.8em;
    margin-top: 0;
    margin-bottom: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    border-radius: 8px;
    overflow: hidden;
  }

  th, td {
    padding: 14px 12px;
    font-size: 1em;
    border-bottom: 1px solid #eee;
    text-align: center;
  }

  th {
    background-color: #fff0f4;
    color: #555;
    font-weight: bold;
  }

  td a {
    color: #333;
    text-decoration: none;
    font-weight: 500;
  }

  td a:hover {
    color: #d65b7b;
    text-decoration: underline;
  }

  td img {
    max-width: 70px;
    height: auto;
  }
</style>
</head>
<body>
  <div class="table-wrapper">

    <!-- 뒤로가기 버튼 줄 -->
    <div class="back-btn-wrap">
      <button class="back-btn" onclick="history.back()">⬅ 뒤로가기</button>
    </div>

    <!-- 제목 줄 -->
    <h2>📔 내 일기</h2>

      <table>

      <colgroup>
    <col style="width: 10%;">  <!-- 이름 -->
    <col style="width: 15%;">  <!-- 일기 제목 -->
    <col style="width: 10%;">  <!-- 날짜 -->
    <col style="width: 10%;">  <!-- 이미지 -->
    <col style="width: 45%;">  <!-- 일기 내용 -->
    <col style="width: 5%;"> 
    <col style="width: 5%;">  
  </colgroup>
  <thead>
    <tr>
      <th>이름</th>
      <th>일기 제목</th>
      <th>날짜</th>
      <th>이미지</th>
      <th>일기 내용</th>
      <th>수정</th>
      <th>삭제</th>
    </tr>
      </thead>
      <tbody>
        <tr>
          <td>${dto.pet_name}</td>
          <td>${dto.diary_title}</td>
          <td>${dto.diary_date.substring(0, 10)}</td>
          <td><img src="./image/${dto.diary_image}" alt="일기 이미지" /></td>
          <td>
          <div style="white-space: pre-line; text-align: center; width: 100%; min-height: 100px; padding: 10px;">
	      ${dto.diary_content}
          </div>
          </td>
          <td><a href="diary_update?update=${dto.diary_id}&dfimage=${dto.diary_image}">✏️</a></td>
          <td><a href="diary_delete?delete=${dto.diary_id}&dfimage=${dto.diary_image}">🗑️</a></td>
        </tr>
      </tbody>
    </table>

  </div>
</body>
</html>