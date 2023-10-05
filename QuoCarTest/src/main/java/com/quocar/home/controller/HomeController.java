package com.quocar.home.controller;

import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Locale locale, Model model) {
//		session.setAttribute("category", "");	//로고를 클릭하면 category 값을 빈 문자열로 바꿈
		session.removeAttribute("category"); // category 값을 제거

		return "home";
	}


    // 로그인
    @RequestMapping("/login")
    public  String   login() {
       return  "user/login";
    }
}
