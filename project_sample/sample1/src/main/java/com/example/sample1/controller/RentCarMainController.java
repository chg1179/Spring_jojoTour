package com.example.sample1.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;
import com.example.sample1.service.RentCarMainService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class RentCarMainController {
	
	@Autowired
	RentCarMainService rentCarMainService;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping("/rentcar.do") 
    public String rentcar(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/rentcar/rentcar-main";
    }
	@RequestMapping("/rentcar/view.do") 
    public String rentcarView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/rentcar/rentcar-view";
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
	@RequestMapping(value = "/kindCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentcarKind(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = rentCarMainService.searchCarKind(map);
	    System.out.println(map);
	    System.out.println(resultMap);

		return new Gson().toJson(resultMap);
	}
	
	//렌트카 상세정보 출력
	@RequestMapping(value = "/rentcar/rentCarInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCarInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		RentCar info = rentCarMainService.searchRentCarInfo(map);
		resultMap.put("rentcarinfo", info);
		return new Gson().toJson(resultMap);
	}
	//렌트카 정보 리스트 출력
	@RequestMapping(value = "/rentcar/carImgList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCarImgList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<RentCarImg> list = rentCarMainService.searchCarImgList(map);
		resultMap.put("carImgList", list);
		return new Gson().toJson(resultMap);
	}
	//렌트카 검색 정보 출력
	@RequestMapping(value = "/rentCarSearchList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCarSearchList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = rentCarMainService.searchCarSearchList(map);
	    System.out.println(map);
	    System.out.println(resultMap);
		return new Gson().toJson(resultMap);
	}
	//숙소 찜 인서트
	@RequestMapping(value = "/rentcar/jjimAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addjjim(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		rentCarMainService.addJjim(map);
		return new Gson().toJson(resultMap);
	}
	
	//숙소 찜 해제 인서트
	@RequestMapping(value = "/rentcar/jjimDel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deljjim(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		rentCarMainService.delJjim(map);
		return new Gson().toJson(resultMap);
	}

}
