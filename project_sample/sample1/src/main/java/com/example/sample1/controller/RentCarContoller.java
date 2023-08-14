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
	
	//렌트카 제품 추가 및 수정 페이지
	@RequestMapping("/host/rentcar/edit.do") 
	public String leisureEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/host-rentcar-edit";
	}
	
	//렌트카 제품 상세 목록 열람 페이지
	@RequestMapping("/host/rentcar/view.do") 
	public String rentView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/host-rentcar-view";
	}
	
	//주소검색
	@RequestMapping("/host/rentcar/addr.do") 
	public String carAddr(Model model, @RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception{
		
		return "/juso-popup";
	}
	
	//렌트카 정보 리스트 출력
	@RequestMapping(value = "/host/rentcar.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCar(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<RentCar> list = rentCarService.searchRentCarList(map);
		resultMap.put("carList", list);
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 상세정보 출력
	@RequestMapping(value = "/host/rentcar/carInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCarInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		RentCar info = rentCarService.searchRentCarInfo(map);
		resultMap.put("carInfo", info);
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 차 삭제
	@RequestMapping(value = "/host/carRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		rentCarService.removeRentCar(map);
		resultMap.put("success", "렌터카정보삭제완료");
		return new Gson().toJson(resultMap);
	}
}
