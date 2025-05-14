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
    padding: 50px 60px;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  }

  h2 {
    text-align: center;
    font-size: 26px;
    color: #f48aa5;
    font-weight: normal;
    margin-top: 0;
    margin-bottom: 30px;
  }

  .form-group {
    display: flex;
    align-items: flex-start;
    margin-bottom: 20px;
  }

  .form-group label {
    flex: 0 0 120px;
    font-weight: bold;
    font-size: 15px;
    color: #555;
    margin-top: 8px;
  }

  .form-group input[type="text"],
  .form-group input[type="file"],
  .form-group textarea {
    flex: 1;
    padding: 12px 16px;
    font-size: 15px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fffdfd;
    font-family: 'Pretendard', sans-serif;
    box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
    box-sizing: border-box;
  }

  .form-group textarea {
    resize: vertical;
    height: 160px;
  }

  #contentDiv {
    flex: 1;
    min-height: 200px;
    border: 1px solid #ccc;
    border-radius: 6px;
    padding: 10px;
    font-size: 15px;
    line-height: 1.6;
    background: #fff;
  }

  .form-actions {
    text-align: center;
    margin-top: 30px;
  }

  input[type="submit"],
  input[type="reset"] {
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
  input[type="reset"]:hover {
    background-color: #db7093;
  }
  
    #contentDiv img {
  max-width: 200px !important;
  height: auto !important;
  display: block !important;
  margin: 10px auto !important;
  
}
</style>
</head>
<body>
<div class="container">
  <h2 style="color: #f48aa5">📘 게시글 수정하기</h2>
  <form action="PostModifySave" method="post" enctype="multipart/form-data" onsubmit="return beforeSubmit()">
    <input type="hidden" name="mnum" value="${dto.post_id}">
    <input type="hidden" name="himage" value="${dto.post_image}">
    <input type="hidden" name="mid" value="${dto.user_id}">

    <div class="form-group">
      <label for="post_title">제목</label>
      <input type="text" name="post_title" id="post_title" value="${dto.post_title}" required>
    </div>

    <div class="form-group">
      <label for="contentDiv">내용</label>
      <div id="contentDiv" contenteditable="true">${dto.post_content}</div>
      <input type="hidden" name="post_content" id="hiddenContent">
    </div>

    <div class="form-group">
      <label for="post_image">사진</label>
      <input type="file" id="post_image" name="post_image" accept="image/*" onchange="insertImage()" multiple>
    </div>

    <div class="form-actions">
      <input type="submit" value="💾 수정">
      <input type="reset" value="❌ 취소" onclick="history.back()">
    </div>
  </form>
</div>
<script>
function beforeSubmit() {
  document.getElementById('hiddenContent').value = document.getElementById('contentDiv').innerHTML;
  return true;
}
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