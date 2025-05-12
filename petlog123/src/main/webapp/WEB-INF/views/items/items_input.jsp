<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>아이템 등록</title>

<style>
  body {
    margin: 0;
    padding: 0;
    color: #333;
  }

  .container {
    max-width: 800px;
    margin: 40px auto 80px auto;
    background: #fff;
    padding: 50px 60px;
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
    border: 1px solid #e0e0e0;
  }

  h2 {
    text-align: center;
    font-size: 28px;
    color: #d85a8a;
    margin-bottom: 40px;
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
  .form-group input[type="number"],
  .form-group input[type="file"] {
    flex: 1;
    padding: 10px 12px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
    transition: border-color 0.3s ease;
  }

  .form-group input:focus {
    border-color: #a3d8cd;
    outline: none;
  }

  .radio-group {
    display: flex;
    gap: 20px;
    align-items: center;
  }

  .radio-group label {
    font-weight: normal;
    font-size: 14px;
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

<%
  String role = (String) session.getAttribute("user_role");
  if (role == null || !role.equals("admin")) {
%>
<script>
  alert("관리자만 접근 가능합니다.");
  history.back();
</script>
<%
  return;
}
%>

<div class="container">
  <h2>🎈 아이템 등록</h2>

  <form action="items_save" method="post" enctype="multipart/form-data">

    <div class="form-group">
      <label for="item_name">아이템명</label>
      <input type="text" id="item_name" name="item_name" required>
    </div>

    <div class="form-group">
      <label for="item_cost">포도알</label>
      <input type="number" id="item_cost" name="item_cost" required>
    </div>

    <div class="form-group">
      <label>카테고리</label>
      <div class="radio-group">
        <label><input type="radio" name="item_category" value="프레임" required> 프레임</label>
        <label><input type="radio" name="item_category" value="스티커" required> 스티커</label>
      </div>
    </div>

    <div class="form-group">
      <label for="item_image">아이템 이미지</label>
      <input type="file" id="item_image" name="item_image" required>
    </div>

    <div class="form-actions">
      <input type="submit" value="💾 저장하기">
      <input type="reset" value="❌ 취소하기">
    </div>

  </form>
</div>

</body>
</html>