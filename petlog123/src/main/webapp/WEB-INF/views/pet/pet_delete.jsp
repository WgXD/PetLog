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

	function confirm_delete() {
		
		return confirm("정말 삭제하시겠습니까?😥")
		
	}

</script>

<header><h2>펫 정보 삭제하기 🐾</h2></header>
  <form action="pet_delete_check" method="post" enctype="multipart/form-data" onsubmit="return confirm_delete()">
    
    <input type="hidden" name="himage" value="${dto.pet_img }">
    
    <table class="dotted-rounded-table">
    
      <tr>
        <th><label for="pet_id">No. </label></th>
        <td><input type="text" id="pet_id" name="pet_id" value="${dto.pet_id}" readonly="readonly">
        	<input type="hidden" name="pet_id" value="${dto.pet_id}">
        </td>
      </tr>
    
      <tr>
        <th><label for="pet_name">이름 : </label></th>
        <td><input type="text" id="pet_name" name="pet_name" readonly="readonly"></td>
      </tr>

      <tr>
        <th><label for="pet_bog">성별 : </label></th>
        <td>
        <input type="radio" name="pet_bog_radio" value="수컷💙" <c:if test="${dto.pet_bog eq '수컷💙'}">checked</c:if> disabled> 수컷💙
        <input type="radio" name="pet_bog_radio" value="암컷💛" <c:if test="${dto.pet_bog eq '암컷💛'}">checked</c:if> disabled> 암컷💛
      	</td>
      </tr>
      
      <tr> <!-- 중성화 순서 바꿈 -->
        <th><label for="pet_neuter">중성화 여부 : </label></th>
        <td>
        <input type="radio" name="pet_neuter_radio" value="⭕" <c:if test="${dto.pet_neuter eq '⭕'}">checked</c:if> disabled> ⭕
        <input type="radio" name="pet_neuter_radio" value="❌" <c:if test="${dto.pet_neuter eq '❌'}">checked</c:if> disabled> ❌
      	</td>
      </tr>

      <tr>
        <th><label for="pet_hbd">생일 : </label></th>
        <td><input type="date" id="pet_hbd" name="pet_hbd" readonly="readonly"></td>
      </tr>

      <tr>
        <th><label for="pet_img">사진 : </label></th>
        <td><input type="file" id="pet_img" name="pet_img"></td> <!-- image에는 readonly 할 수 x -->
      </tr>
      
      <tr>
      <td colspan="2" style="text-align: center">
      <input type="submit" value="💾 삭제하기">
      <input type="reset" value="❌ 취소하기" onclick="history.back()">
      </td>
      </tr>
      
      
    </table>
  </form>
</body>
</html>