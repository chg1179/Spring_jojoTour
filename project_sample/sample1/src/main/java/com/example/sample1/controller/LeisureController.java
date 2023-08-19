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
import com.example.sample1.service.LeisureService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class LeisureController {
	@Autowired
	LeisureService leisureService;
	
	//레저 관리 페이지
	@RequestMapping("/host/leisure.do") 
    public String leisure(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/host/host-leisure";
    }
	
	// 레저 수정 페이지
	@RequestMapping("/host/leisureEdit.do") 
	public String leisureEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/host/host-leisure-edit";
	}
	
	@RequestMapping(value = "/host/leisure.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String leisureList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Product> list = leisureService.searchLeisureList(map);
		resultMap.put("leisureList", list);
		return new Gson().toJson(resultMap);
	}
}
