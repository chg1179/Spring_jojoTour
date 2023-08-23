package com.example.sample1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sample1.model.Cart;
import com.example.sample1.service.CartService;
import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PayController {
	
	//@Autowired
	//PayService payService;
	
	//@Autowired
	//HttpSession session;
	
	@RequestMapping("/payment.do") 
    public String cart(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		String[] list = request.getParameterValues("list");
        return "/pay/payment";
    }

}
