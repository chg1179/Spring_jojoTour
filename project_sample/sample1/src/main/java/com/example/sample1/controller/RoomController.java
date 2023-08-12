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
import com.example.sample1.service.RoomService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class RoomController {
	
	@Autowired
	RoomService roomService;
	
	//숙박 방 페이지
	@RequestMapping("/host/room.do") 
	public String room(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		return "/host-room";
	}
	
	
	// 방 목록 출력
	@RequestMapping(value = "/host/roomList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Product> list = roomService.searchRoomList(map);
		resultMap.put("roomList", list);
		return new Gson().toJson(resultMap);
	}
	
}