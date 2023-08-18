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

import com.example.sample1.model.RentCar;
import com.example.sample1.service.RentCarMainService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RentCarMainController {
	
	@Autowired
	RentCarMainService rentCarMainService;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping("/rentcar.do") 
    public String rentcar(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/rentcar-main";
    }
	
	@RequestMapping(value = "/rentCarMain.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentcarList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = rentCarMainService.searchCarList(map);
	    System.out.println(map);
	    System.out.println(resultMap);

		return new Gson().toJson(resultMap);
	}
}
