<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   
<% 
    Integer userIdObj = (Integer) session.getAttribute("user_id");
    Integer petIdObj = (Integer) session.getAttribute("pet_id");

  //  int userId = (userIdObj != null) ? userIdObj : 0;  // 기본값 0 할당
  //  int petId = (petIdObj != null) ? petIdObj : 0;      // 기본값 0 할당
%>


  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 일기</title>

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

</head>
<body>

  <header><h2>일기 쓰기 📔</h2></header>

  <form action="diary_save" method="post" enctype="multipart/form-data">
    <table class="dotted-rounded-table">
    
    <p>등록된 반려동물 수: ${fn:length(list)}</p>
    
     <tr>
      <th><label for="pet_id">반려동물 : </label></th>
      <td>
        <select name="pet_id" id="pet_id" required>
          <c:forEach var="pet" items="${list}">
            <option value="${pet.pet_id}">${pet.pet_name}</option>
          </c:forEach>
        </select>
      </td>
    </tr>
    
    
      <tr>
        <th><label for="diary_title">제목 : </label></th>
        <td><input type="text" id="diary_title" name="diary_title"></td>
      </tr>

      <tr>
        <th><label for="diary_date">날짜 : </label></th>
        <td><input type="date" id="diary_date" name="diary_date"></td>
      </tr>

      <tr>
        <th><label for="diary_image">이미지 : </label></th>
        <td><input type="file" id="diary_image" name="diary_image"></td>
      </tr>

      <tr>
        <th><label for="diary_content">내용 : </label></th>
        <td><textarea rows="10" cols="60" id="diary_content" name="diary_content"></textarea></td>
      </tr>
      
      <tr>
      <td colspan="2" style="text-align: center">
      <input type="submit" value="💾 저장하기">
      <input type="reset" value="❌ 취소하기" onclick="history.back()">
      </td>
      </tr>
      
      
    </table>
  </form>

</body>
</html>