<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수제 간식 레시피 공유하기</title>

<style>
  body {

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
    height: 180px;
  }

  .form-group input:focus,
  .form-group textarea:focus {
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
  <h2>수제 간식 레시피 공유하기 ❤</h2>

  <form action="snack_save" method="post" enctype="multipart/form-data">

    <div class="form-group">
      <label for="snack_title">레시피명 :</label>
      <input type="text" id="snack_title" name="snack_title" required>
    </div>

    <div class="form-group">
      <label for="snack_recipe">레시피 :</label>
      <textarea id="snack_recipe" name="snack_recipe" required></textarea>
    </div>

    <div class="form-group">
      <label for="snack_image">이미지 :</label>
      <input type="file" id="snack_image" name="snack_image">
    </div>

    <div class="form-group">
      <label for="snack_date">게시일 :</label>
      <input type="date" id="snack_date" name="snack_date">
    </div>

    <div class="form-actions">
      <input type="submit" value="💾 공유하기">
      <input type="reset" value="❌ 취소하기" onclick="history.back()">
    </div>

  </form>
</div>

</body>
</html>