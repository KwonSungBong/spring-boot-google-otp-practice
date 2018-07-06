package com.example.demo.repository;

import com.example.demo.entity.User;
import com.warrenstrange.googleauth.ICredentialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class CredentialRepository implements ICredentialRepository {

    @Autowired
    private UserRepository userRepository;

    @Override
    public String getSecretKey(String userEmail) {
        User user = userRepository.findByEmail(userEmail);
        return user.getOtpSecretKey();
    }

    @Override
    public void saveUserCredentials(String userEmail, String secretKey, int validationCode, List<Integer> scratchCodes) {
        User user = userRepository.findByEmail(userEmail);
        user.setOtpSecretKey(secretKey);
        userRepository.save(user);
    }
}
