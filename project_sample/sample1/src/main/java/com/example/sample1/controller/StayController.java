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

import com.example.sample1.model.Product;
import com.example.sample1.service.StayService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class StayController {
	
	@Autowired
	StayService stayService;
	
	//숙박 관리 페이지
	@RequestMapping("/host/stay.do") 
    public String stay(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/host-stay";
    }
	
	// 숙박 업체 추가 페이지
	@RequestMapping("/host/stayAdd.do") 
	public String stayAdd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/host-stay-add";
	}
	
	//숙소 업체 정보 출력
	@RequestMapping(value = "/host/stayList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Product> list = stayService.searchStayList(map);
		resultMap.put("stayList", list);
		return new Gson().toJson(resultMap);
	}
	
}
