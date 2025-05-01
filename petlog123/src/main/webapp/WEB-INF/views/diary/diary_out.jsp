<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
    
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
	
.pagination { /* 페이징 스타일 */ 
  margin-top: 20px;
  text-align: center;
}

.pagination a {
  display: inline-block;
  margin: 0 5px;
  padding: 8px 12px;
  background-color: #f2e9ff;
  color: #5e478e;
  border-radius: 10px;
  text-decoration: none;
  font-weight: bold;
  transition: background-color 0.2s;
}

.pagination a:hover {
  background-color: #e0d2f7;
}

.pagination a.current {
  background-color: #d7c9f3;
  color: white;
}


</style>

<meta charset="UTF-8">
<title>일기 보기</title>
</head>
<body>
<header><h2>일기 읽기 📔</h2></header>

<table class="dotted-rounded-table">
<tr>
	<th>글번호</th> <th>일기 제목</th> <th>날짜</th> <th>이미지</th> <th>일기 내용</th>
</tr>

<c:forEach items="${list}" var="di" >

<tr>
<td> ${di.diary_id} </td>
<td><a href="diary_detail?unum=${di.diary_id}">${di.diary_title}</a> </td>
<!-- 위에꺼 공백 있으면 오류남 -->
<td> ${di.diary_date} </td>
<td><img src="./image/${di.diary_image}" width="70px"></td>
<td> ${di.diary_content} </td>
</tr>

</c:forEach>
</table>

<!-- 페이징 숫자 출력 1 2 3... -->
<br><br>
<div class="pagination">
  <c:forEach var="i" begin="1" end="${page_count}">
    <a href="diary_out?page=${i}" 
       class="${i == page ? 'current' : ''}">
       ${i}
    </a>
  </c:forEach>
</div>

</body>
</html>