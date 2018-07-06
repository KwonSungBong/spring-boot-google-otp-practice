<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>CheckOtp</title>
</head>
<link rel="stylesheet" href="/webjars/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="/webjars/jquery/3.1.0/jquery.js"></script>
<script src="/webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<body>
    <div>
        CheckOtp
    </div>
    <div>
        <div>
            <form name="authOtpFrm" >
                <input type="number" name="otpCode" placeholder="OTP인증번호(6자리)">
            </form>
            <button class="btn-otp-check">check</button>
            <a href="javascript:history.back()">Go Back</a>
        </div>
    </div>
<script type="text/javascript">
    $(function() {
        $("button.btn-otp-check").on("click", checkOtp);
    });

    function checkOtp() {
        var $frm = $("form[name=authOtpFrm]");
        var url = "${pageContext.request.contextPath}/api/otp/check";
        var paramMap = $frm.serialize();
        $.ajax({
            url: url,
            data: paramMap,
            dataType: "json",
            // error: errorHandler,
            success: function (data, textStatus, jqXHR) {
                if(data) {
                    alert("성공");
                    location.href = "/home";
                } else {
                    alert("실패");
                }
            },
            complete: function (jqXHR, textStatus) {
            }
        });
    }
</script>
</body>
</html>
