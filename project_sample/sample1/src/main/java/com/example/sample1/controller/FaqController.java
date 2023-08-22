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

import com.example.sample1.model.Faq;
import com.example.sample1.model.Test;
import com.example.sample1.service.BoardService;
import com.example.sample1.service.FaqService;
import com.example.sample1.service.TestService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class FaqController {
	
	@Autowired
	FaqService faqService;
	

	@RequestMapping("/faq/list.do") 
    public String faqlist(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/faq-list";
    }
	
	@RequestMapping("/faq/add.do") 
	public String faqadd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/faq-add";
	}
	
	@RequestMapping("/faq/view.do") 
	public String faqview(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/faq-view";
	}
	
	@RequestMapping("/faq/edit.do") 
	public String faqEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
		return "/faq-add";
	}
	
	@RequestMapping(value = "/faq/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String faqAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		faqService.addFaq(map);
		return new Gson().toJson(resultMap);
	}
	
	// 문의 게시판 리스트 출력
	@RequestMapping(value = "/faq/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String faqoticeList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Faq> list = faqService.searchFaqList(map);
		resultMap.put("faqList", list);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/faq/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String faqView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = faqService.searchFaqInfo(map);
		return new Gson().toJson(resultMap);
	}

	
	@RequestMapping(value = "/faq/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String faqEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		faqService.editFaq(map);
		return new Gson().toJson(resultMap);
	}
	//체크박스를 이용해 게시글 삭제
	@RequestMapping(value = "/faq/removeFaqCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeFaqCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map.get("selectItem"));
		String json = map.get("selectItem").toString(); //Object 형으로 받고 있기 때문에 오류가 난다. 문자열으로 리턴
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);//쿼리에 list 라는 값으로 보내줬음을 기억하
		faqService.removeFaqCheck(map);
		resultMap.put("message", "success");
		return new Gson().toJson(resultMap);
	}

	
	
	
	
}
