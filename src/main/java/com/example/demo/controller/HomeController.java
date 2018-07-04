package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/home")
public class HomeController {

    @RequestMapping
    public ModelAndView home(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("home");
        return modelAndView;
    }

//    @RequestMapping("/test")
//    public RedirectView test(HttpServletRequest request) {
//        return new RedirectView("/home");
//    }

    @RequestMapping("/test")
    public ModelAndView test() {
        ModelAndView modelAndView = new ModelAndView("redirect:/home");
        return modelAndView;
    }

}
