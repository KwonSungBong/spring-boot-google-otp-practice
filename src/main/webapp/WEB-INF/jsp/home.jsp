<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Home</title>
</head>
<link rel="stylesheet" href="/webjars/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="/webjars/jquery/3.1.0/jquery.js"></script>
<script src="/webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<body>
    <div>
        Home
    </div>
    <div>
        로그인여부 ${isLogin}
    </div>
    <div>
        <c:choose>
            <c:when test="${isLogin eq true}">
                <div>로그아웃</div>
                <form action="/user/logout" method="post">
                    <input type="submit" value="submit" />
                </form>
                <div>
                    <c:choose>
                        <c:when test="${user.enabledOtp eq true}">
                            <a href="${pageContext.request.contextPath}/otp/disable">
                                <span>opt 해제</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/otp/enable">
                                <span>opt 등록</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <div>로그인</div>
                <form action="/user/login" method="post">
                    <input type="text" id="email" name="email" value="rnjstjdqhd39@naver.com" />
                    <input type="text" id="password" name="password" value="password" />
                    <input type="submit" value="submit" />
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
