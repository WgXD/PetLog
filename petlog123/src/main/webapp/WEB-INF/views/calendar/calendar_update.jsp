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

<script type="text/javascript">

	function confirm_update() {
		
		return confirm("일정을 수정합니다 😊")
		
	}

</script>

<header>🗓 일정 수정하기</header>
<form action="cupdate_save" method="post" onsubmit="return confirm_update()">
  <input type="hidden" name="cal_id" value="${cdto.cal_id}">
  <input type="hidden" name="pet_id" value="${cdto.pet_id}">
  <input type="hidden" name="year" value="${current_year}">
  <input type="hidden" name="month" value="${current_month}">
  
<table class="dotted-rounded-table">

      <tr>
        <th><label for="cal_title">제목 : </label></th>
        <td><input type="text" id="cal_title" name="cal_title" value="${cdto.cal_title}" required></td>
      </tr>

      <tr>
        <th><label for="cal_date">날짜 : </label></th>
        <td><input type="date" id="cal_date" name="cal_date" value="${cdto.cal_date}" required></td>
      </tr>

      <tr>
        <th><label for="cal_content">내용 : </label></th>
        <td><textarea rows="10" cols="60" id="cal_content" name="cal_content" required>${cdto.cal_content}</textarea></td>
      </tr>
      
      <tr>
      <td colspan="2" style="text-align: center">
      <input type="submit" value="💾 수정하기">
      <input type="reset" value="❌ 취소하기" onclick="history.back()">
      </td>
      </tr>
          
</table>
</form>
</body>
</html>