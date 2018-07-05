package com.example.demo.repository;

import com.warrenstrange.googleauth.ICredentialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class CredentialRepository implements ICredentialRepository {

    @Autowired
    private UserRepository userRepository;

    @Override
    public String getSecretKey(String userId) {
        return null;
    }

    @Override
    public void saveUserCredentials(String userId, String secretKey, int validationCode, List<Integer> scratchCodes) {

    }
}
