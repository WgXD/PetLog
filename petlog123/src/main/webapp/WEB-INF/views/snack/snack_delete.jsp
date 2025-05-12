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
    padding: 0;
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

<script type="text/javascript">

function confirm_delete() {
	
	return confirm("정말 삭제하시겠습니까?😥")
	
}

</script>


<header>레시피 삭제하기</header>
<!-- onsubmit="return confirm_Delete()" =>alert 띄우기 -->
<form action="delete_recipe" method="post" enctype="multipart/form-data" onsubmit="return confirm_delete()">

<table class="dotted-rounded-table">

      <tr>
        <th><label for="snack_id">글번호 : </label></th>
        <td>
        <input type="text" id="snack_id" name="snack_id" value="${dto.snack_id}" readonly>
        <input type="hidden" name="snack_id" value="${dto.snack_id}">
        </td>
      </tr>
      
      <tr>
        <th><label for="snack_title">제목 : </label></th>
        <td>
        <input type="text" id="snack_title" name="snack_title" value="${dto.snack_title}" readonly>
        <input type="hidden" name="snack_title" value="${dto.snack_title}">
        </td>
      </tr>
      
      <tr>
        <th><label for="snack_image">이미지 : </label></th>
        <td>
        <img src="./image/${dto.snack_image}" width="120px">
        <input type="hidden" name="himage" value="${dto.snack_image}">
        </td>
      </tr>
      
      <tr>
        <th><label for="snack_date">날짜 : </label></th>
        <td>
        <input type="text" id="snack_date" name="snack_date" value="${dto.snack_date}" readonly>
        <input type="hidden" name="snack_date" value="${dto.snack_date}">
        </td>
      </tr>

      <tr>
      <td colspan="2" style="text-align: center">
      <input type="submit" value="💥 삭제하기">
      <input type="reset" value="❌ 취소하기" onclick="history.back()"> 
      <!-- 전 페이지로 return -->
      </td>
      </tr>


</table>
</form>
</body>
</html>