package com.example.sample1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sample1.model.MyPage;
import com.example.sample1.service.MyPageService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageController {
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	HttpSession session;


	@RequestMapping("/my/order.do") 
    public String join(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my-order";
    }
	@RequestMapping(value = "order.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String delId(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		MyPage order = myPageService.searchOrder(map);
		resultMap.put("order", order);
		return new Gson().toJson(resultMap);
	}
}
