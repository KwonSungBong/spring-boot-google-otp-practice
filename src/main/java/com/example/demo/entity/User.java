package com.example.demo.entity;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@Data
public class User {

    public User() {
    }

    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public User(String email, String password, String otpSecretKey) {
        this.email = email;
        this.password = password;
        this.enabledOtp = true;
        this.otpSecretKey = otpSecretKey;
    }

    @Id
    @GeneratedValue
    private long id;

    private String email;

    private String password;

    private boolean enabledOtp = false;

    private String otpCode;

    private String otpSecretKey;

}
