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
	
	//로그인창으로 이동
	@RequestMapping("/login.do") 
    public String login(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/login/login";
    }
	
	// 아이디 검색창으로 이동
	@RequestMapping("/id-search.do") 
    public String idSearch(Model model, @RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception{
		
		return "/login/id-search";
	}
	//로그아웃 되서 메인창으로 리다렉트
	@RequestMapping("/logout.do") 
    public String logout(Model model, @RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception{
		session.invalidate();
		return "redirect:main.do";
	}
	//패스워드 검색창
	@RequestMapping("pwd/search.do") 
    public String pwdSearch(Model model, @RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception{
		request.setAttribute("map", map);
		return "/login/pwd-search";
	}
	//패스워드 변경창
	@RequestMapping("pwd/change.do") 
    public String pwdChange(Model model, @RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception{
		request.setAttribute("map", map);
		return "/login/pwd-change";
	}

	//로그인
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
			session.setAttribute("sessionUpwd", user.getuPwd());
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
	//로그인 창에서 유저값을 기본 U로 해줌
	@RequestMapping(value = "/loginCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCar(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		return new Gson().toJson(resultMap);
	}
	//아이디 검색
	@RequestMapping(value = "/id-search.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String idSearch(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.selectId(map);
		return new Gson().toJson(resultMap);
	}
	//비번 검색
	@RequestMapping(value = "/pwd/search.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String pwdSearch(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userService.selectPwd(map);
		return new Gson().toJson(resultMap);
	}
	//비번 변경
	@RequestMapping(value = "/pwd/change.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updatePwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		userService.updatePwd(map);
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
	@RequestMapping(value = "/ban.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userBan(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		userService.banUser(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/reset.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userReset(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		userService.resetUser(map);
		return new Gson().toJson(resultMap);
	}
}
