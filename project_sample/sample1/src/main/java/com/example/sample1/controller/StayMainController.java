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

import com.example.sample1.model.Stay;
import com.example.sample1.service.StayMainService;
import com.example.sample1.service.StayService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class StayMainController {
	@Autowired
	StayMainService stayMainService;
	
	@RequestMapping("/stay/hotel.do") 
	public String mainStay(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/hotel-main";
	}
	
	//숙소 업체 정보 출력
	@RequestMapping(value = "/stay/stayList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Stay> list = stayMainService.showStayList(map);
		resultMap.put("stayList", list);
		
		List<Stay> list2 = stayMainService.searchServiceList(map);
		resultMap.put("serviceList", list2);
		
		
		return new Gson().toJson(resultMap);
		
	}
}
