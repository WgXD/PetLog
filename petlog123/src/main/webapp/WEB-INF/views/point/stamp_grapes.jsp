<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    com.mbc.pet.user.UserDTO loginUser = (com.mbc.pet.user.UserDTO) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/login?error=login_required");
        return;
    }

    int grapeCount = loginUser.getGrape_count();
    int maxGrape = 100;
    request.setAttribute("grapeCount", grapeCount);
    request.setAttribute("maxGrape", maxGrape);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>포도송이 성장 게이지</title>
    <style>
        body {
            font-family: "Nanum Gothic", sans-serif;
            background-image: url("${pageContext.request.contextPath}/image/vineyard_bg.png"); /* 배경이미지 있으면 여기로 */ /*지금은 없음!!!!*/
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            margin: 0;
            padding: 50px;
        }

        .grape-container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
            background-color: rgba(255,255,255,0.8);
            border-radius: 20px;
            padding: 40px;
        }

        .grape-label {
            font-size: 22px;
            font-weight: bold;
            color: #6c3483;
            margin-bottom: 15px;
        }

.grape-bar {
    width: 100%;
    background-color: #e8d8f0; /* 연한 보라색 배경 */
    border-radius: 30px;
    height: 30px;
    overflow: hidden;
    box-shadow: inset 0 0 5px rgba(0,0,0,0.1);
}

.grape-fill {
    height: 100%;
    background: linear-gradient(to right, #a678b3, #7b3fa1); /* 진한 보라 그라디언트 */
    width: ${grapeCount * 100 / maxGrape}%;
    transition: width 0.5s ease;
}

        .grape-count {
            margin-top: 15px;
            color: #6c3483;
            font-weight: bold;
            font-size: 16px;
        }

        .grape-button {
            margin-top: 40px;
            background-color: #fcdfff;
            color: #6e2e90;
            font-weight: bold;
            padding: 12px 22px;
            border-radius: 70px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
        }

        .grape-button:hover {
            background-color: #fdeef4;
            transform: scale(1.1);
        }

	.grape-bar-wrapper {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    gap: 15px;
	    margin-bottom: 10px;
	}
	
	.grape-img {
	    height: 75px;   /* 게이지바와 같은 높이 */
	    width: auto;    /* 비율 유지하면서 자동 조정 */
	}       
    </style>
</head>
<body>

<div class="grape-container">
    <div class="grape-label">🍇 포도 성장률</div>

    <div class="grape-bar-wrapper">
        <div class="grape-bar">
            <div class="grape-fill"></div>
        </div>
        <img src="${pageContext.request.contextPath}/image/vine.png" class="grape-img" alt="vine"/>
    </div>

    <div class="grape-count">${grapeCount} / ${maxGrape}개</div>

    <form action="${pageContext.request.contextPath}/items_out" method="get">
        <input type="submit" value="포도 쓰러가기 🍇" class="grape-button">
    </form>
</div>

</body>
</html>