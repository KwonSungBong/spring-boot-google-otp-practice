package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import com.warrenstrange.googleauth.GoogleAuthenticatorQRGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping(value="/api/otp")
public class OtpRestController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private GoogleAuthenticator googleAuthenticator;

    @RequestMapping("/active")
    public Map<String, Object> active(HttpServletRequest request) {
        if(request.getSession().getAttribute("user") != null) {
            User user = (User) request.getSession().getAttribute("user");

            // OTP Key 생성
            String issuer = "Test";
            String userEmail = user.getEmail();

            GoogleAuthenticatorKey credentials = googleAuthenticator.createCredentials(userEmail);
            String url = GoogleAuthenticatorQRGenerator.getOtpAuthURL(issuer, userEmail, credentials);
            String otpSecretKey = googleAuthenticator.getCredentialRepository().getSecretKey(userEmail);

            Map<String, Object> result = new HashMap<>();
            result.put("url", url);
            result.put("otpSecretKey", otpSecretKey);
            return result;
        } else {
            return null;
        }
    }

    @RequestMapping("/inactive")
    public boolean inactive(HttpServletRequest request) {
        if(request.getSession().getAttribute("user") != null) {
            User sessionuUser = (User) request.getSession().getAttribute("user");
            User user = userRepository.findById(sessionuUser.getId()).orElse(null);
            user.setEnabledOtp(false);
            user.setOtpSecretKey(null);
            userRepository.save(user);
            request.getSession().setAttribute("user", user);
            return true;
        } else {
            return false;
        }
    }

    @RequestMapping("/insert")
    public boolean insert(@RequestParam String otpSecretKey, @RequestParam int otpCode, HttpServletRequest request) throws Exception {
        if(request.getSession().getAttribute("user") != null) {
            User sessionuUser = (User) request.getSession().getAttribute("user");
            User user = userRepository.findById(sessionuUser.getId()).orElse(null);

            String userEmail = user.getEmail();
            int verificationCode = otpCode;
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.SECOND, 30);

            boolean isCodeValid = googleAuthenticator.authorizeUser(userEmail, verificationCode, calendar.getTimeInMillis());
            if(!isCodeValid) {
                throw new Exception("인증번호가 일치하지 않습니다.");
            }

            user.setEnabledOtp(true);
            user.setOtpSecretKey(otpSecretKey);
            userRepository.save(user);
            request.getSession().setAttribute("user", user);
            return true;
        } else {
            return false;
        }
    }

    @RequestMapping("/check")
    public boolean check(@RequestParam int otpCode, HttpServletRequest request) throws Exception {
        if(request.getSession().getAttribute("user") != null) {
            User user = (User) request.getSession().getAttribute("user");
            String userEmail = user.getEmail();
            return checkOtpCode(userEmail, otpCode);
        } else {
            return false;
        }
    }

    private boolean checkOtpCode(String userEmail, int otpCode) {
        int verificationCode = otpCode;
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.SECOND, 30);
        return googleAuthenticator.authorizeUser(userEmail, verificationCode, calendar.getTimeInMillis());
    }

}
