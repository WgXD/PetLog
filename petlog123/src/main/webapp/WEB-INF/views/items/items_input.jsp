<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

body {
  font-family: Arial, sans-serif;
  background: #f0f8ff; /* 아주 연한 하늘색 */
  text-align: center;
  padding: 30px;
}

h2 {
  color: #4a6fa5; /* 차분한 블루 */
}

form {
  display: inline-block;
  text-align: left;
}

.dotted-rounded-table {
  border: 2px dotted #8ab6d6;
  border-radius: 16px;
  background: #ffffff;
  margin: auto;
  box-shadow: 2px 2px 10px rgba(0,0,0,0.05);
  border-collapse: separate;
  overflow: hidden;
}

.dotted-rounded-table th,
.dotted-rounded-table td {
  border: 1px dotted #bcdff1;
  padding: 12px 16px;
  font-size: 14px;
}

input[type="text"],
input[type="number"],
input[type="file"],
textarea {
  width: 100%;
  padding: 5px;
  border: 1px solid #cce6f7;
  border-radius: 6px;
  box-sizing: border-box;
  background-color: #f6fbff;
  margin-bottom: 12px;
}

textarea {
  resize: vertical;
}

button,
input[type="submit"],
input[type="reset"] {
  background: #a8d0f0;     /* 파스텔 블루 */
  color: #2e5c8a;           /* 진한 블루 텍스트 */
  border: none;
  border-radius: 24px;
  padding: 10px 22px;
  margin: 12px 6px;
  font-size: 15px;
  font-weight: bold;
  cursor: pointer;
  transition: 0.3s ease;
  box-shadow: 2px 2px 5px rgba(50, 100, 160, 0.2);
}

button:hover,
input[type="submit"]:hover,
input[type="reset"]:hover {
  background: #d3ebff;     /* 더 연한 블루 */
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

<header>✨ 아이템 목록 ✨</header>
<br>
<form action="items_save" method="post" enctype="multipart/form-data">
<table>

      <tr>
        <th><label for="item_name">아이템명 : </label></th>
        <td><input type="text" id="item_name" name="item_name"></td>
      </tr>

      <tr>
        <th><label for="item_cost">포도알 : </label></th>
        <td><input type="number" id="item_cost" name="item_cost"></td>
      </tr>

      <tr>
        <th><label for="item_category">카테고리 : </label></th>
        <td><input type="radio" id="item_category_frame" name="item_category" value="프레임">
        <label for="item_category_frame">프레임</label>
        
      	<input type="radio" id="item_category_sticker" name="item_category" value="스티커">
      	<label for="item_category_sticker">스티커</label></td>
      </tr>

      <tr>
        <th><label for="item_image">아이템 : </label></th>
        <td><input type="file" id="item_image" name="item_image"></td>
      </tr>

      <tr>
      <td colspan="2" style="text-align: center">
      <input type="submit" value="💾 저장하기">
      <input type="reset" value="❌ 취소하기">
      </td>
      </tr>
</table>
</form> 
</body>
</html>