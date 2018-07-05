package com.example.demo.config;

import com.example.demo.repository.CredentialRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DefaultConfig {

    @Bean
    public GoogleAuthenticator geoGoogleAuthenticator(CredentialRepository geoCredentialRepository) {
        GoogleAuthenticator googleAuthenticator = new GoogleAuthenticator();
        googleAuthenticator.setCredentialRepository(geoCredentialRepository);
        return googleAuthenticator;
    }

}
