<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="${pageContext.request.contextPath}/webjars/jquery/3.1.0/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/lib/jsrender.min.js"></script>
</head>
<body>
	<div class="wrap">
		<!-- container -->
		<div class="container">
        		<div class="container-acnt">
				<div class="content content-otp-top content-before pb40">
					<div class="panel panel-form">
						<div class="panel-heading">
							<div class="panel-title">
								<h2>구글 OTP 해제</h2>
							</div>
						</div>
						<div class="panel-body">
							<div class="btn-block">
								<%--<button type="button" class="btn btn-md btn-black btn-otp-expire">해제</button>--%>
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
									해제
								</button>
							</div>
							<div class="btn-block pt10">
								<a href="javascript:history.back()">Go Back</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- //container -->
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">OTP 인증</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>
						<span>OTP 인증번호를 입력해주세요.</span>
					</p>
					<form name="authOtpFrm" >
						<div class="form-group">
							<div class="input-group-time">
								<label for="" class="hide">인증번호</label>
								<input type="number" name="otpCode" class="form-control" placeholder="인증번호">
								<span class="input-time"></span>
							</div>
						</div>
						<div class="input-alert">
							<span class="validate-msg text-money hide">인증번호를 입력해 주세요.</span>
						</div>
					</form>
					<br/><span class="text-warning">인증시간이 만료되면 자동으로 입력창이 닫힙니다.</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-close-otp" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-warning btn-check-otpCode">인증요청</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
        $("button.btn-check-otpCode").on("click", checkOtp);
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
                    // startTimer();
                    requestExpire();
                } else {
                    alert("실패");
                }
            },
            complete: function (jqXHR, textStatus) {
            }
        });
	}

	function requestExpire() {
        var url = "${pageContext.request.contextPath}/api/otp/inactive";
        var paramMap = {};
        $.ajax({
            url: url,
            data: paramMap,
            dataType: "json",
            // error: errorHandler,
            success: function (data, textStatus, jqXHR) {
                // stopTimer();
				alert("구글 OTP 해지완료");
                location.href = "/home";
            },
            complete: function (jqXHR, textStatus) {
            }
		});
	}
</script>
</html>
