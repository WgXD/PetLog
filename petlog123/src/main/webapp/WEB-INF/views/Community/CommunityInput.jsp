<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
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
    margin-bottom: 40px;
  }

  .form-group {
    display: flex;
    align-items: flex-start;
    margin-bottom: 22px;
  }

  .form-group label {
    flex: 0 0 140px;
    font-weight: bold;
    font-size: 15px;
    color: #555;
    margin-top: 10px;
  }

  .form-group input[type="text"],
  .form-group input[type="file"],
  .form-group select,
  .form-group textarea {
    flex: 1;
    padding: 10px 12px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
    transition: border-color 0.3s ease;
    box-sizing: border-box;
  }

  .form-group textarea {
    resize: vertical;
    height: 180px;
  }

  .form-group input:focus,
  .form-group textarea:focus {
    border-color: #a3d8cd;
    outline: none;
  }

  #contentDiv {
    flex: 1;
    min-height: 250px;
    border: 1px solid #ccc;
    border-radius: 6px;
    padding: 10px;
    font-size: 15px;
    line-height: 1.6;
    background: #fff;
  }

  .form-actions {
    text-align: center;
    margin-top: 40px;
  }

  input[type="submit"],
  input[type="button"] {
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
  input[type="button"]:hover {
    background-color: #c14573;
  }

  .radio-wrapper {
    display: flex;
    gap: 20px;
    padding-top: 5px;
  }

  @media screen and (max-width: 768px) {
    .form-group {
      flex-direction: column;
      align-items: flex-start;
    }

    .form-group label {
      margin-bottom: 8px;
    }

    #contentDiv {
      width: 100%;
    }
  }
</style>
</head>
<body>

<div class="container">
  <h2>📝 게시글 작성</h2>

  <form action="CommunitySave" method="post" enctype="multipart/form-data" onsubmit="return beforeSubmit()">

    <c:if test="${sessionScope.user_role eq 'admin'}">
      <div class="form-group">
        <label>구분</label>
        <div class="radio-wrapper">
          <label><input type="radio" name="post_type" value="notice"> 공지사항</label>
          <label><input type="radio" name="post_type" value="normal" checked> 일반글</label>
        </div>
      </div>
    </c:if>

    <c:if test="${sessionScope.user_role ne 'admin'}">
      <input type="hidden" name="post_type" value="normal" />
    </c:if>

    <div class="form-group">
      <label for="post_title">제목</label>
      <input type="text" id="post_title" name="post_title" required>
    </div>

    <div class="form-group">
      <label for="post_content">내용</label>
      <div id="contentDiv" contenteditable="true"></div>
      <input type="hidden" name="post_content" id="hiddenContent">
    </div>

    <div class="form-group">
      <label for="post_image">사진 추가</label>
      <input type="file" id="post_image" accept="image/*" onchange="insertImage()" multiple>
    </div>

    <div class="form-actions">
      <input type="submit" value="💾 저장">
      <input type="button" value="❌ 취소" onclick="location.href='./main'">
    </div>

  </form>
</div>

<script>
  // 폼 전송 시 div 내용을 숨겨진 input에 넣기
  function beforeSubmit() {
      document.getElementById('hiddenContent').value = document.getElementById('contentDiv').innerHTML;
      return true;
  }

  // 파일 선택 시 이미지 삽입
  function insertImage() {
      const files = document.getElementById('post_image').files;
      const contentDiv = document.getElementById('contentDiv');

      for (let i = 0; i < files.length; i++) {
          if (files[i].name) {
              const reader = new FileReader();
              reader.onload = function(e) {
                  const img = document.createElement('img');
                  img.src = e.target.result;
                  img.style.maxWidth = '80%';
                  img.style.height = 'auto';
                  img.style.display = 'block';
                  img.style.marginTop = '10px';
                  img.style.marginLeft = 'auto';
                  img.style.marginRight = 'auto';
                  contentDiv.appendChild(img);
              }
              reader.readAsDataURL(files[i]);
          }
      }
  }
</script>

</body>
</html>