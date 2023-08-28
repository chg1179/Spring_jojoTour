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
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	HttpSession session;


	@RequestMapping("/my/change.do") 
    public String join(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-change";
    }
	@RequestMapping(value = "/my/change.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String myChange(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		userService.updateMyInfo(map);
		resultMap = userService.searchInfo(map);
		if(resultMap.containsKey("user")) {
			User user = (User)resultMap.get("user");
			session.setAttribute("sessionName", user.getuName());
			session.setAttribute("sessionNickname", user.getNickname());
			session.setAttribute("sessionBirth", user.getBirth());
			session.setAttribute("sessionPhone", user.getPhone());
			session.setAttribute("sessionEmail", user.getEmail());
			session.setAttribute("sessionAddr", user.getAddr());
			session.setAttribute("sessionAddrDetail", user.getAddrDetail());
			session.setAttribute("sessionZipNo", user.getZipno());
		}
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/delYn.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String delId(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		userService.removeId(map);
		session.invalidate();
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/userInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User info = userService.searchUserInfo(map);
		resultMap.put("userInfo", info);
		return new Gson().toJson(resultMap);
	}
}
