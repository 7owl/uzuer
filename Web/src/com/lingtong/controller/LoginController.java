package com.lingtong.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.lingtong.model.Tenants;


@Controller
public class LoginController {
	
	@RequestMapping("/login")
	public ModelAndView pclogin( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("login");
		return view;
	}
	
	@RequestMapping("/logout")
	public ModelAndView pcloginout( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("login");
		return view;
	}
	
	@RequestMapping("/main")
	public ModelAndView main( HttpServletResponse resp, HttpServletRequest req ){
		ModelAndView view = new ModelAndView("main");
		req.setAttribute("user", new Tenants());
		return view;
	}
}
