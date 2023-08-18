package com.example.sample1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sample1.model.Admin;
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
	@RequestMapping("/admin/packagereq.do")
    public String adminPackage(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/package-req";
    }
	@RequestMapping("/admin/package.do")
    public String packageList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
        return "/package";
    }
	
	@RequestMapping(value = "/userList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<User> list = adminService.listUser(map);
		resultMap.put("list", list);
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/packageRentList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String packageRentList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Admin> list = adminService.requestRent(map);
		resultMap.put("list", list);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/packageRoomList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String packageRoomList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Admin> list = adminService.requestRoom(map);
		resultMap.put("list", list);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/packageLeisureList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String packageLeisureList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Admin> list = adminService.requestLeisure(map);
		resultMap.put("list", list);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/requestApp.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String requestApp(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		adminService.appRequest(map);
		adminService.requestInsert(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/packageList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String packageList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Admin> list = adminService.searchReqList(map);
		resultMap.put("list", list);
		return new Gson().toJson(resultMap);
	}
}
