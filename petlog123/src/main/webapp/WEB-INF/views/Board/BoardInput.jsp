<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    color: #333;
  }

  .container {
    max-width: 1000px;
    margin: 60px auto;
    background-color: #fff;
    padding: 40px 60px;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  }

  h2 {
    text-align: center;
    color: #f48aa5;
    font-size: 24px;
    margin-bottom: 30px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
  }

  th, td {
    padding: 14px 12px;
    font-size: 15px;
    border-bottom: 1px solid #eee;
    text-align: left;
  }

  th {
    background-color: #fff0f4;
    color: #555;
    font-weight: bold;
    width: 20%;
    text-align: center;
  }

  td input[type="text"],
  td textarea,
  td input[type="file"] {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
    background-color: #fff;
    box-sizing: border-box;
    font-family: 'Pretendard', sans-serif;
  }

  textarea {
    resize: vertical;
    min-height: 250px;
  }

  .form-actions {
    text-align: center;
    margin-top: 30px;
  }

  input[type="submit"],
  input[type="button"] {
    background-color: #f48aa5;
    color: white;
    border: none;
    padding: 12px 30px;
    border-radius: 10px;
    font-size: 15px;
    margin: 0 10px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  input[type="submit"]:hover,
  input[type="button"]:hover {
    background-color: #db7093;
  }
</style>
</head>
<body>
  <div class="container">
    <form action="CommunitySave" method="post" enctype="multipart/form-data">
      <h2 style="color: #f48aa5">📢 공지사항 작성하기</h2>
      <table>
        <c:if test="${sessionScope.user_role eq 'admin'}">
          <tr>
            <th>글 종류</th>
            <td>
              <label><input type="radio" name="post_type" value="notice" checked> 공지사항</label>
              <label style="margin-left:20px;"><input type="radio" name="post_type" value="normal"> 일반글</label>
            </td>
          </tr>
        </c:if>
        <c:if test="${sessionScope.user_role ne 'admin'}">
          <input type="hidden" name="post_type" value="normal" />
        </c:if>

        <tr>
          <th>제목</th>
          <td><input type="text" name="post_title" required placeholder="제목을 입력하세요"></td>
        </tr>

        <tr>
          <th>내용</th>
          <td><textarea name="post_content" required placeholder="내용을 입력하세요"></textarea></td>
        </tr>

        <tr>
          <th>사진 첨부</th>
          <td><input type="file" name="post_image"></td>
        </tr>
      </table>

      <div class="form-actions">
        <input type="submit" value="💾 저장">
        <input type="button" value="❌ 취소" onclick="location.href='./main'">
      </div>
    </form>
  </div>
</body>
</html>