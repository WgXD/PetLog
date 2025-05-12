<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 일기</title>

<style>
  body {
    background-color: #fefefe;
    text-align: center;
    padding: 0;
    margin: 0;
    color: #333;
  }

  h2 {
    font-size: 1.8em;
    font-weight: bold;
    color: #db7093;
    margin-bottom: 30px;
  }

  .btn-back {
    background-color: #f8d7da;
    color: #a94442;
    border: 1px solid #f5c6cb;
    padding: 6px 14px;
    font-size: 13px;
    border-radius: 16px;
    font-weight: bold;
    cursor: pointer;
    margin-bottom: 20px;
  }

  .btn-back:hover {
    background-color: #f5c6cb;
  }

  .table-wrapper {
    width: 90%;
    max-width: 900px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    padding: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
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
    font-weight: 600;
  }

  td img {
    max-width: 70px;
    height: auto;
  }

  td a {
    color: #333;
    text-decoration: none;
    font-weight: 500;
  }

  td a:hover {
    color: #db7093;
    text-decoration: underline;
  }
</style>
</head>
<body>

<h2>📔 내 일기</h2>

<div>
  <input type="reset" value="⬅ 뒤로가기" onclick="history.back()" class="btn-back">
</div>

<div class="table-wrapper">
  <table>
    <thead>
      <tr>
        <th>글번호</th>
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
        <td>${dto.diary_id}</td>
        <td>${dto.pet_name}</td>
        <td>${dto.diary_title}</td>
        <td>${dto.diary_date.substring(0, 10)}</td>
        <td><img src="./image/${dto.diary_image}" alt="일기 이미지" /></td>
        <td>${dto.diary_content}</td>
        <td><a href="diary_update?update=${dto.diary_id}&dfimage=${dto.diary_image}">✏️</a></td>
        <td><a href="diary_delete?delete=${dto.diary_id}&dfimage=${dto.diary_image}">🗑️</a></td>
      </tr>
    </tbody>
  </table>
</div>

</body>
</html>