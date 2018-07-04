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

    public User(String email, String password, String otpCode) {
        this.email = email;
        this.password = password;
        this.otpCode = otpCode;
    }

    @Id
    @GeneratedValue
    private long id;

    private String email;

    private String password;

    private String otpCode;

}
