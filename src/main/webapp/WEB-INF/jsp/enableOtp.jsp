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
				<div class="content content-otp-top pb40">
					<div class="panel">
						<div class="panel-heading">
							<div class="panel-title">
								<h2>구글 OTP 등록</h2>
							</div>
						</div>
						<div class="panel-body">
							<p>OTP 보안을 설정하면, 로그인이나 출금 시 SMS 인증 대신 OTP 확인 절차를 거칩니다.</p>
							<p class="pt5">보안성과 편의성이 강화된 구글 OTP 앱을 이용할 수 있습니다.</p>
							<span class="text-money mt15">1. 고객님의 계정보안과 자산 보호를 위해 휴대폰에 구글OTP 앱을 설치합니다.</span>
							<span class="text-money pt5">2. 설치한 뒤 OTP 앱으로 아래 QR Code를 스캔하거나, 16자리 시크릿 키를 직접 입력해주세요.</span>
						</div>
					</div>
				</div>
				<div class="content content-otp-bottom">
					<div class="content-left">
						<div class="qr-box">
							<div class="googleOtpImg">
							</div>
						</div>
						<form name="otpForm" onsubmit="return false">
						<div class="form-group">
							<lable class="hide">qr코드 주소</lable>
							<div class="input-group">
								<input type="text" id="otpSecretKey" name="otpSecretKey" value="" class="form-control" readonly>
								<span class="input-group-btn">
									<button class="btn btn-black btn-copy-secretKey">복사</button>
								</span>
							</div>
						</div>
						<div class="form-group">
							<div class="form-text pt20">
								<div class="input-group">
									<input type="number" name="otpCode" class="form-control" placeholder="OTP인증번호(6자리)">
								</div>
							</div>
							<div class="btn-block pt10">
								<button type="button" class="btn-otp-regist btn btn-lg btn-black">등록</button>
							</div>
							<div class="btn-block pt10">
								<a href="javascript:history.back()">Go Back</a>
							</div>
						</div>
						</form>			
					</div>
					<div class="content-right">
						<div class="warning">
							<strong class="text-black">주의사항</strong>
							<dl>
								<dd>16자리 시크릿 키는 분실시 복구에 필요하므로 미리 백업해두세요.</dd>
								<dd>본코드는 OTP를 활성화시킬 때마다 변경됩니다.</dd>
								<dd>OTP를 해제하면 본 코드는 더 이상 유효하지 않습니다.</dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //container -->
	</div>
</body>

<script type="text/x-jsrender" id="googleOtpImg-GenHtml">
	<img src="{{:url}}">
</script>
<script type="text/javascript">

	$(function() {
        showOtpGenerator();
        // $("button.btn-copy-secretKey").on("click", otpSecretKey);
        $("button.btn-otp-regist").on("click", registGoogleOtp);
	});

    function showOtpGenerator() {
        var url = "${pageContext.request.contextPath}/api/otp/active";
        var paramMap = {};
        $.ajax({
            url: url,
            data: paramMap,
            dataType: "json",
            // error: errorHandler,
            success: function (data, textStatus, jqXHR) {
                console.log(data);
				var itemData = {
					url : data.url,
                    otpSecretKey : data.otpSecretKey
				}
				var googleOTPHtml = $.templates("#googleOtpImg-GenHtml").render(itemData);
				$("div.googleOtpImg").html(googleOTPHtml);
				$("input[name=otpSecretKey]").val(itemData.otpSecretKey);
            },
            complete: function (jqXHR, textStatus) {
            }
        })
    }

    function registGoogleOtp() {
        var $frm = $('form[name=otpForm]');
        var $tmpOtpCode = $frm.find("input[name=otpCode]");
        if(!$tmpOtpCode.val()) {
            alert("OTP 인증번호를 입력해주세요.");
            return false;
        }

        var url = "${pageContext.request.contextPath}/api/otp/insert";
        var paramMap = $frm.serialize();
        $.ajax({
            url: url,
            data: paramMap,
            dataType: "json",
            // error: errorHandler,
            success: function (data, textStatus, jqXHR) {
                console.log(data);
			    alert("Google OTP 등록이 완료되었습니다.");
                location.href = "/home";
            },
            complete: function (jqXHR, textStatus) {
            }
        })
    }

</script>
</html>
