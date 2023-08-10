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
import com.example.sample1.service.RentCarService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class RentCarContoller {
	
	@Autowired
	RentCarService rentCarService;
	
	//렌트카 관리 페이지
		@RequestMapping("/host/rentcar.do") 
	    public String rentcar(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
	        return "/host-rentcar";
	    }
	
	@RequestMapping(value = "/rentCarList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCarList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<RentCar> list = rentCarService.searchRentCarList(map);
		resultMap.put("carList", list);
		return new Gson().toJson(resultMap);
	}
}
