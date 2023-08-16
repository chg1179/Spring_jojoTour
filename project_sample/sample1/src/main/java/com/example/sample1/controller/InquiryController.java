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

import com.example.sample1.model.Inquiry;

import com.example.sample1.service.InquiryService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class InquiryController {
	
	@Autowired
	InquiryService inquiryService;
	
	@RequestMapping("/inquiry/list.do") 
    public String inquiry(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/inquiry-list";
    }
	
	@RequestMapping("/inquiry/add.do") 
    public String inquiryadd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/inquiry-add";
    }
	
	@RequestMapping("/inquiry/view.do") 
	public String inquiryview(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/inquiry-view";
	}
	
	@RequestMapping("/inquiry/edit.do") 
    public String inquiryEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/inquiry-add";
    }
	
	@RequestMapping("/inquiry/answer.do") 
	public String inquiryAnser(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/inquiry-answer";
	}
	
	@RequestMapping(value = "/inquiry/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Inquiry> list = inquiryService.searchInquiryList(map);
		resultMap.put("inquiryList", list);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/inquiry/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		inquiryService.addInquiry(map);
		return new Gson().toJson(resultMap);
	}	
	
	@RequestMapping(value = "/inquiry/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = inquiryService.searchInquiryInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/inquiry/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		inquiryService.removeInquiry(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/inquiry/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		inquiryService.editInquiry(map);
		return new Gson().toJson(resultMap);
	}
	
	//체크박스를 이용해 게시글 삭제
	@RequestMapping(value = "/inquiry/removeInquiryCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeInquiryCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map.get("selectItem"));
		String json = map.get("selectItem").toString(); //Object 형으로 받고 있기 때문에 오류가 난다. 문자열으로 리턴
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);//쿼리에 list 라는 값으로 보내줬음을 기억하
		inquiryService.removeInquiryCheck(map);
		resultMap.put("message", "success");
		return new Gson().toJson(resultMap);
	}	
	
	@RequestMapping(value = "/inquiry/answer.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryAnswer(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    String iNo = (String) map.get("iNo");
	    map.put("iNo", iNo);
	    inquiryService.replyInquiry(map);
	    return new Gson().toJson(resultMap);
	}

}
