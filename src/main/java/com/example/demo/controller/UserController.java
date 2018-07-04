package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/user")
public class UserController {

    @RequestMapping(value = "/login")
    public String login(HttpServletRequest request) {
        System.out.println("login()");
        HttpSession httpSession = request.getSession();
//        httpSession.getAttribute();
        return "redirect:/home";
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        System.out.println("logout()");
        HttpSession httpSession = request.getSession();
        httpSession.invalidate();
        return "redirect:/home";
    }

}
