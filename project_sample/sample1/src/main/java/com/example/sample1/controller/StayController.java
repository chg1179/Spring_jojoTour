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
import com.example.sample1.service.StayService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class StayController {
	
	@Autowired
	StayService stayService;
	
	//숙박 관리 페이지
	@RequestMapping("/host/stay.do") 
    public String stay(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		/*if(!status.equals("H")) { 
			return "redirect:../main.do"; //호스트가 아닐 때
		}
		else {*/
			request.setAttribute("map", map);
			return "/host-stay";
//		}
    }
	
	// 숙박 업체 추가 페이지
	@RequestMapping("/host/stayAdd.do") 
	public String stayAdd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		/*if(!status.equals("H")) { 
			return "redirect:../main.do"; //호스트가 아닐 때
		}
		else { */
			request.setAttribute("map", map);
			return "/host-stay-add";
			/* } */
	}
	
	// 숙박 업체 수정 페이지
	@RequestMapping("/host/stayEdit.do") 
	public String stayEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		if(!status.equals("H")) { 
			return "redirect:../main.do"; //호스트가 아닐 때
		}
		else {
			request.setAttribute("map", map);
			return "/host-stay-edit";
		}
	}
	
	//숙소 업체 정보 출력
	@RequestMapping(value = "/host/stayList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Stay> list = stayService.searchStayList(map);
		resultMap.put("stayList", list);
		return new Gson().toJson(resultMap);
	}
	
	// 슥소 업체 등록
	@RequestMapping(value = "/host/stayAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Integer> list = (List<Integer>) map.get("selectServiceList");
		map.put("list", list);
		
		for(int i=0; i<list.size(); i++) {
			int str = list.get(i);
			System.out.println(str);
		} 
		
		stayService.addStay(map);
		resultMap.put("message", "success");
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 옵션 리스트(타입, 편의시설)
	@RequestMapping(value = "/host/stayOption.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayOption(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>(); 
		List<Stay> list = stayService.searchStayTypeList(map);
		resultMap.put("stayTypeList", list);
		
		List<Stay> list2 = stayService.searchServiceList(map);
		resultMap.put("stayServiceList", list2);
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 삭제 리스트
	@RequestMapping(value = "/host/stayRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		stayService.removeStay(map);
		resultMap.put("success", "숙소삭제성공");
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 삭제 리스트
	@RequestMapping(value = "/host/stayInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Stay info = stayService.searchStayInfo(map);
		resultMap.put("stayInfo", info);
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 수정
	@RequestMapping(value = "/host/stayEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		stayService.editStayInfo(map);
		return new Gson().toJson(resultMap);
	}
	
			
}
