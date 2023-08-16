package com.example.sample1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sample1.model.User;
import com.example.sample1.service.AdminService;
import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping("/user-list.do") 
    public String userList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/user-list";
    }

	@RequestMapping("/host-list.do") 
    public String hostList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/host-list";
    }
	@RequestMapping("/admin/user.do") 
    public String userhost(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/admin-user";
    }
	@RequestMapping("/admin/main.do")
    public String adminMain(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/admin-main";
    }
	@RequestMapping("/admin/package.do")
    public String adminPackage(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/package-list";
    }
	
	
	@RequestMapping(value = "/userList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<User> list = adminService.listUser(map);
		resultMap.put("list", list);
		return new Gson().toJson(resultMap);
	}
}