package com.example.sample1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sample1.model.Leisure;
import com.example.sample1.model.LeisureImg;
import com.example.sample1.service.LeisureMainService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LeisureMainController {
	
	@Autowired
	LeisureMainService leisureMainService;
	
	@Autowired
	HttpSession session;
	//수상레저
	@RequestMapping("/water/leisure.do") 
    public String WaterLeisure(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/leisure/water-leisure";
    }
	//수상레저 상세보기
	@RequestMapping("water/leisure/view.do") 
    public String WaterLeisureView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "leisure/water-leisure-view";
    }
	//지상레저
	@RequestMapping("/ground/leisure.do") 
    public String GroundLeisure(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/leisure/ground-leisure";
    }
	//지상레저 상세보기
	@RequestMapping("ground/leisure/view.do") 
    public String GroundLeisureView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "leisure/ground-leisure-view";
    }
	//수상레저 출력
	@RequestMapping(value = "water/leisure/leisureInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String WaterLeisureInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Leisure info = leisureMainService.searchLeisureInfo(map);
		resultMap.put("info", info);
		//수상레저 디테일
		LeisureImg detailImg = leisureMainService.searchWaterDetailImg(map);
		resultMap.put("detailImg", detailImg);
		return new Gson().toJson(resultMap);
	}
	//수상레저 종류별 출력
	@RequestMapping(value = "/water/kindCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String WaterLeisureKind(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = leisureMainService.searchWaterLeisureKindList(map);
		return new Gson().toJson(resultMap);
	}
	//수상레저 검색 정보 출력
	@RequestMapping(value = "/water/waterSearchList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String waterSearchList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = leisureMainService.searchWaterSearchList(map);
		return new Gson().toJson(resultMap);
	}
	//수상레저 상세정보 출력
	@RequestMapping(value = "/water/leisure.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String WaterLeisure(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = leisureMainService.searchWaterLeisureList(map);
		return new Gson().toJson(resultMap);
	}
	//레저 찜 인서트
	@RequestMapping(value = "/leisure/jjimAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addleisurejjim(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		leisureMainService.addJjim(map);
		return new Gson().toJson(resultMap);
	}
	
	//레저 찜 해제 인서트
	@RequestMapping(value = "/leisure/jjimDel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String delleisurejjim(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		leisureMainService.delJjim(map);
		return new Gson().toJson(resultMap);
	}
	
	
	
	
	//지상레저 출력
	@RequestMapping(value = "/ground/leisure.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String GroundLeisure(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = leisureMainService.searchGroundLeisureList(map);
		return new Gson().toJson(resultMap);
	}
	//지상레저 종류별 출력
	@RequestMapping(value = "/ground/kindCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String GroundLeisureKind(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = leisureMainService.searchGroundLeisureKind(map);
		return new Gson().toJson(resultMap);
	}
	//지상레저 검색 정보 출력
	@RequestMapping(value = "/ground/groundSearchList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String groundSearchList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = leisureMainService.searchGroundSearchList(map);
		return new Gson().toJson(resultMap);
	}
	//지상레저 출력
	@RequestMapping(value = "ground/leisure/leisureInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String GroundLeisureInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Leisure info = leisureMainService.searchLeisureInfo(map);
		resultMap.put("info", info);
		//지상레저 디테일
		LeisureImg detailImg = leisureMainService.searchGroundDetailImg(map);
		resultMap.put("detailImg", detailImg);
		return new Gson().toJson(resultMap);
		
	}

}
