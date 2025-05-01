<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 포도알 하나씩 찍어주는 페이지 -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포도송이</title>
    <style>
        /* 포도송이를 감싸는 부분 */
        .grape-bunch {
            display: flex;
            flex-direction: column-reverse; /* 역삼각형 모양으로 배치 */
            align-items: center;
            gap: 15px;
            margin: 30px auto;
        }

        /* 각 포도알 스타일 */
        .grape-row {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .grape {
            width: 60px;
            height: 60px;
            border-radius: 50%; /* 원 모양으로 만들기 */
            background-color: #c38ec7; /* 보라색 포도 */
            position: relative;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        /* 포도알에 애니메이션 추가 */
        .grape:hover {
            transform: scale(1.1); /* 마우스 올리면 커짐 */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* 마우스 올리면 그림자 강해짐 */
        }

        /* 보라색 포도 색깔 조정 */
        .filled {
            background-color: #9b59b6;
        }

        /* 마우스를 올렸을 때 색상 변경 */
        .grape:hover {
            background-color: #9b59b6; /* 마우스 올리면 색상 변경 */
            transform: scale(1.1); /* 마우스 올리면 커짐 */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); /* 그림자 강해짐 */
        }

        /* 포도알을 더 동글동글하게 보이게 하는 효과 */
        .grape:before {
            content: '';
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }
    </style>
</head>
<body>

<!-- 누적 포도알 몇 개인지 보여주는 부분!!! -->

<form action="${pageContext.request.contextPath}/items_out" method="get">
<!-- get:조회 // post:등록/수정 -->


    <div class="grape-bunch">
        <!-- 1개 포도알 -->
        <div class="grape-row">
            <div class="grape"></div>
        </div>
    
        <!-- 2개 포도알 -->
        <div class="grape-row">
            <div class="grape"></div>
            <div class="grape"></div>
        </div>

        <!-- 3개 포도알 -->
        <div class="grape-row">
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
        </div>

        <!-- 4개 포도알 -->
        <div class="grape-row">
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
        </div>

        <!-- 5개 포도알 -->
        <div class="grape-row">
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
        </div>

        <!-- 6개 포도알 -->
        <div class="grape-row">
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
            <div class="grape"></div>
        </div>
    </div>

    <!-- 포도가 열렸어요 버튼 -> item shop으로 이동 -->
    <input type="submit" value="포도 쓰러가기 🍇" class="grape-button">


<br> <br> <br> <br> <br> <br>


</form>   
</body>

<!-- 포도가 열렸어요 버튼 스타일! -->
<style>
    /* 버튼 스타일링 */
    .grape-button {
        background-color: #fcdfff; /* 보라색 */
        color: white; /* 텍스트 색 */
        font-size: 15px; /* 텍스트 크기 */
        font-weight: bold; /* 텍스트 굵게 */
        padding: 12px 22px; /* 버튼 크기 */
        border-radius: 70px; /* 동글동글한 모서리 */
        border: none; /* 테두리 없애기 */
        cursor: pointer; /* 마우스 커서 변경 */
        transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
    }

    /* 버튼에 마우스를 올렸을 때 */
    .grape-button:hover {
        background-color: fdeef4; /* 밝은 보라색 */
        transform: scale(1.1); /* 버튼이 커지는 효과 */
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
    }

    /* 버튼 클릭 시 애니메이션 */
    .grape-button:active {
        transform: scale(0.95); /* 클릭할 때 조금 작아짐 */
    }
</style>

</html>

