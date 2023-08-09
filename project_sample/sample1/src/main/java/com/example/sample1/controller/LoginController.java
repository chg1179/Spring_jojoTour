package com.example.sample1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sample1.model.User;
import com.example.sample1.service.UserService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping("/main.do") 
	public String test(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		session.invalidate();
		return "/main";
	}
	
	@RequestMapping("/userlogin.do") 
    public String userlogin(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		session.invalidate();
		return "/userlogin";
    }
	
	@RequestMapping("/hostlogin.do") 
	public String hostlogin(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		session.invalidate();
		return "/hostlogin";
	}
	
	@RequestMapping(value = "/userlogin.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.userLogin(map);
		if(resultMap.containsKey("user")) {
			User user = (User)resultMap.get("user");
			session.setAttribute("sessionId", user.getuId());
			session.setAttribute("sessionName", user.getuName());
			session.setAttribute("sessionStatus", user.getStatus());
		}
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/selectjoin.do") 
	public String selectjoin(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/selectjoin";
	}
	
	@RequestMapping("/userjoin.do") 
    public String userjoin(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/userjoin";
    }
	
	@RequestMapping("/hostjoin.do") 
	public String hostjoin(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/hostjoin";
	}
	
	@RequestMapping("/hostacess.do") 
	public String hostacess(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/hostacess";
	}
	
	@RequestMapping("/useracess.do") 
	public String useracess(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/useracess";
	}
	
	@RequestMapping(value = "/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = userService.searchUserCnt(map);
		resultMap.put("cnt", cnt);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping("/addr.do") 
    public String addr(Model model, @RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception{
		
		return "/jusoPopup";
    }
}
