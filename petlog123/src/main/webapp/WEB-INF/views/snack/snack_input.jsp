<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style>
  body {
    font-family: 'Arial', sans-serif;
    background-color: #fff8f0;
    text-align: center;
    padding: 30px;
  }

  h2 {
   color: #5e478e;
  }

  form {
    display: inline-block;
    text-align: left;
  }

  .dotted-rounded-table {
    border-collapse: separate;
    border: 2px dotted #aaa;
    border-radius: 16px;
    overflow: hidden;
    background-color: #fff;
    margin: 0 auto;
    box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
  }

  .dotted-rounded-table td,
  .dotted-rounded-table th {
    border: 1px dotted #ccc;
    padding: 12px 16px;
    font-size: 14px;
  }

  input[type="text"],
  input[type="date"],
  input[type="file"],
  textarea {
    width: 100%;
    padding: 8px;
    border-radius: 8px;
    border: 1px solid #ddd;
    box-sizing: border-box;
  }

  textarea {
    resize: vertical;
  }
  
	  button,
	input[type="submit"],
	input[type="reset"] {
	  background-color: #d7c9f3; /* 연보라 */
	  border: none;
	  color: #5e478e; /* 진보라 텍스트 */
	  padding: 10px 22px;
	  margin: 12px 6px;
	  border-radius: 24px;
	  font-size: 15px;
	  font-weight: bold;
	  cursor: pointer;
	  transition: background-color 0.3s ease, transform 0.15s ease;
	  box-shadow: 2px 2px 5px rgba(100, 80, 160, 0.2);
	}
	
	button:hover,
	input[type="submit"]:hover,
	input[type="reset"]:hover {
	  background-color: #e8defc; /* 좀 더 크리미한 보라 */
	  transform: scale(1.05);
	}
	
	button:active,
	input[type="submit"]:active,
	input[type="reset"]:active {
	  transform: scale(0.95);
	}

</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header><h2>수제 간식 레시피 공유하기 ❤</h2></header>
<form action="snack_save" method="post" enctype="multipart/form-data">
<table class="dotted-rounded-table">
<tr>
<th><label for="snack_title">레시피명 : </label></th>
<th><input type="text" id="snack_title" name="snack_title"></th>
</tr>

<tr>
<th><label for="snack_recipe">레시피 : </label></th>
<th><textarea rows="12" cols="65" id="snack_recipe" name="snack_recipe"></textarea></th>
</tr>

<tr>
<th><label for="snack_image">이미지 : </label></th>
<th><input type="file" id="snack_image" name="snack_image"></th>
</tr>

<tr>
<th><label for="snack_date">게시일 : </label></th>
<th><input type="date" id="snack_date" name="snack_date"></th>
</tr>

      <tr>
      <td colspan="2" style="text-align: center">
      <input type="submit" value="💾 공유하기">
      <input type="reset" value="❌ 취소하기">
      </td>
      </tr>

</table>
</form>
</body>
</html>