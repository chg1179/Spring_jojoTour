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
	
	@RequestMapping("/userLogin.do") 
    public String userlogin(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/userLogin";
    }
	@RequestMapping("/useracess.do") 
	public String useracess(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/useracess";
	}
	@RequestMapping("/userjoin.do") 
    public String userjoin(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/userjoin";
    }
	@RequestMapping("/userList.do") 
    public String userList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/userList";
    }
	
	@RequestMapping(value = "/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
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
	
	@RequestMapping(value = "/userList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userlist(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<User> list = userService.listUser(map);
		resultMap.put("list", list);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = userService.searchUserCnt(map);
		resultMap.put("cnt", cnt);
		return new Gson().toJson(resultMap);
	}
}
