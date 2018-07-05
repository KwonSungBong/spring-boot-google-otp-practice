package com.example.demo.controller;

import com.example.demo.entity.User;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import com.warrenstrange.googleauth.GoogleAuthenticatorQRGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value="/otp")
public class OtpController {

    @RequestMapping("/disable")
    public ModelAndView disable() {
        ModelAndView modelAndView = new ModelAndView("disableOtp");
        return modelAndView;
    }

    @RequestMapping("/enable")
    public ModelAndView enable() {
        ModelAndView modelAndView = new ModelAndView("enableOtp");
        return modelAndView;
    }

    @Autowired
    private GoogleAuthenticator googleAuthenticator;

    public Map<String, Object> activeOtp(Map<String, Object> parameter, User user) {
        // OTP Key 생성
        String issuer = "Test";
        String userId = String.valueOf(user.getId());

        GoogleAuthenticatorKey credentials = googleAuthenticator.createCredentials(userId);
        String url = GoogleAuthenticatorQRGenerator.getOtpAuthURL(issuer, userId, credentials);
        String otpSecretKey = googleAuthenticator.getCredentialRepository().getSecretKey(userId);

        Map<String, Object> rtnObject = new HashMap<String, Object>();
        rtnObject.put("url", url);
        rtnObject.put("otpSecretKey", otpSecretKey);
        return null;
    }

    public Map<String, Object> inactiveOtp(User user) {
        user.setEnabledOtp(false);
        user.setOtpSecretKey(null);
        return null;
    }

    public int insertOTP(Map<String, Object> parameter, User user) throws Exception {
        String userId = String.valueOf(user.getId());
        int verificationCode = (int) parameter.get("otpCode");
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.SECOND, 30);

        boolean isCodeValid = googleAuthenticator.authorizeUser(userId, verificationCode, calendar.getTimeInMillis());
        if(!isCodeValid) {
            throw new Exception("인증번호가 일치하지 않습니다.");
        }

        // 기존 OTP 인증과 관련된 내용이 있는지 검사

        return 1;
    }
}
