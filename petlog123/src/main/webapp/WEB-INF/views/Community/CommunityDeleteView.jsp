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

    td input[type="text"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 14px;
      background-color: #fdfdfd;
    }

    #contentDiv {
      width: 100%;
      min-height: 200px;
      border: 1px solid #ddd;
      padding: 12px;
      border-radius: 8px;
      background-color: #fdfdfd;
      line-height: 1.6;
    }

    #contentDiv img {
      max-width: 80%;
      height: auto;
      display: block;
      margin: 10px auto;
      border-radius: 8px;
    }

    .form-actions {
      text-align: center;
      margin-top: 30px;
    }

    input[type="button"],
    input[type="reset"] {
      background-color: #ffe1e1;
      color: #333;
      border: none;
      padding: 10px 24px;
      border-radius: 10px;
      font-size: 15px;
      cursor: pointer;
      margin: 0 10px;
      transition: background-color 0.3s ease;
    }

    input[type="button"]:hover,
    input[type="reset"]:hover {
      background-color: #ffd2d2;
    }
    
      #contentDiv img {
  max-width: 200px !important;
  height: auto !important;
  display: block !important;
  margin: 10px auto !important;
  
}
  </style>
  <script>
    function confirmDelete(postId) {
      const dfimage = document.querySelector('input[name="dfimage"]').value;
      if (confirm('정말 삭제하시겠습니까? 😥')) {
        window.location.href = 'PostDeleteSave?dnum=' + postId + '&dfimage=' + encodeURIComponent(dfimage);
      }
    }
  </script>
</head>
<body>
  <div class="container">
    <h2>📕 게시글 삭제하기</h2>

    <form action="DetailSave" method="post" enctype="multipart/form-data">
      <input type="hidden" name="post_id" value="${dto.post_id}">
      <input type="hidden" name="dfimage" value="${dto.post_image}">
      <input type="hidden" name="dlogin_id" value="${dto.user_id}">
      <input type="hidden" name="post_content" id="hiddenContent">

      <table>
        <tr>
          <th>제목</th>
          <td><input type="text" value="${dto.post_title}" readonly></td>
        </tr>
        <tr>
          <th>작성일자</th>
          <td><input type="text" value="${dto.post_date}" readonly></td>
        </tr>
        <tr>
          <th>내용</th>
          <td>
            <div id="contentDiv" contenteditable="true">${dto.post_content}</div>
          </td>
        </tr>
      </table>

      <div class="form-actions">
        <input type="button" value="💥 삭제하기" onclick="confirmDelete('${dto.post_id}')">
        <input type="reset" value="❌ 취소하기" onclick="history.back()">
      </div>
    </form>
  </div>
</body>
</html>