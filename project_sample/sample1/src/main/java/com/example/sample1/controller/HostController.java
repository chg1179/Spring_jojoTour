package com.example.sample1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sample1.model.Test;
import com.example.sample1.service.TestService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HostController {
	
	//호스트 관리 페이지
	@RequestMapping("/host/main.do") 
    public String test(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); 
		String status = (String) session.getAttribute("sessionStatus"); //다운캐스팅
				
		//if(!status.equals("H")) { 
		//	return "redirect:../main.do"; //호스트가 아닐 때
		//}
		//else {
			return "/host-main";
		//}
    }
	
}
