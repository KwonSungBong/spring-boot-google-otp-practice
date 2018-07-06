package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/otp")
public class OtpController {

    @RequestMapping("/enable")
    public ModelAndView enable() {
        ModelAndView modelAndView = new ModelAndView("enableOtp");
        return modelAndView;
    }

    @RequestMapping("/disable")
    public ModelAndView disable() {
        ModelAndView modelAndView = new ModelAndView("disableOtp");
        return modelAndView;
    }

    @RequestMapping("/check")
    public ModelAndView check() {
        ModelAndView modelAndView = new ModelAndView("checkOtp");
        return modelAndView;
    }
}
