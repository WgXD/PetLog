<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>일기 쓰기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
  <style>
    .diary-table {
      width: 100%;
      border-collapse: separate;
      border: 2px dotted #ccc;
      border-radius: 20px;
      background-color: #fff;
      padding: 20px;
    }

    .diary-table td, .diary-table th {
      padding: 12px;
      font-size: 15px;
      vertical-align: top;
    }

    .diary-table th {
      text-align: right;
      width: 130px;
      color: #5e478e;
    }

    .diary-table input[type="text"],
    .diary-table input[type="date"],
    .diary-table input[type="file"],
    .diary-table select,
    .diary-table textarea {
      width: 100%;
      padding: 8px;
      border-radius: 10px;
      border: 1px solid #ccc;
      box-sizing: border-box;
      font-size: 14px;
    }

    .diary-table textarea {
      resize: vertical;
    }

    .diary-buttons {
      text-align: center;
      padding-top: 20px;
    }
  </style>
</head>
<body>

<div class="main-wrapper">
  <div class="box">
    <h2>📔 오늘의 일기 작성</h2>
    <p>등록된 반려동물 수: ${fn:length(list)}</p>

    <form action="diary_save" method="post" enctype="multipart/form-data">
      <table class="diary-table">
        <tr>
          <th><label for="pet_id">반려동물</label></th>
          <td>
            <select name="pet_id" id="pet_id" required>
              <c:forEach var="pet" items="${list}">
                <option value="${pet.pet_id}">${pet.pet_name}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th><label for="diary_title">제목</label></th>
          <td><input type="text" id="diary_title" name="diary_title" required></td>
        </tr>
        <tr>
          <th><label for="diary_date">날짜</label></th>
          <td><input type="date" id="diary_date" name="diary_date" required></td>
        </tr>
        <tr>
          <th><label for="diary_image">이미지</label></th>
          <td><input type="file" id="diary_image" name="diary_image"></td>
        </tr>
        <tr>
          <th><label for="diary_content">내용</label></th>
          <td><textarea id="diary_content" name="diary_content" rows="8" required></textarea></td>
        </tr>
      </table>

      <div class="diary-buttons">
        <input type="submit" value="💾 저장하기" class="btn btn-mint">
        <input type="reset" value="❌ 취소하기" class="btn btn-pink" onclick="history.back()">
      </div>
    </form>
  </div>
</div>

</body>
</html>