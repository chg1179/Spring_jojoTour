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

import com.example.sample1.model.Room;
import com.example.sample1.service.RoomService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RoomController {
	
	@Autowired
	RoomService roomService;
	
	//숙박 방 페이지
	@RequestMapping("/host/room.do") 
	public String room(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		if(!status.equals("H")) { 
			return "redirect:../main.do"; //호스트가 아닐 때
		}
		else {
			request.setAttribute("map", map);
			return "/host-room";
		}
	}
	
	//숙박 방 페이지
	@RequestMapping("/host/roomAdd.do") 
	public String roomAdd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		if(!status.equals("H")) { 
			return "redirect:../main.do"; //호스트가 아닐 때
		}
		else {
			request.setAttribute("map", map);
			return "/host-room-add";
		}
	}
	
	//숙박 방 상세정보 페이지
	@RequestMapping("/host/roomView.do") 
	public String roomView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		if(!status.equals("H")) { 
			return "redirect:../main.do"; //호스트가 아닐 때
		}
		else {
			request.setAttribute("map", map);
			return "/host-room-view";
		}
	}
	
	//숙박 방 수정 페이지
	@RequestMapping("/host/roomEdit.do") 
	public String roomEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		if(!status.equals("H")) { 
			return "redirect:../main.do"; //호스트가 아닐 때
		}
		else {
			request.setAttribute("map", map);
			return "/host-room-edit";
		}
	}
	
	// 방 목록 출력
	@RequestMapping(value = "/host/roomList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Room> list = roomService.searchRoomList(map);
		resultMap.put("roomList", list);
		return new Gson().toJson(resultMap);
	}
	// 객실 삭제
	@RequestMapping(value = "/host/roomRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		roomService.removeRoom(map);
		resultMap.put("success", "객실 삭제 성공");
		return new Gson().toJson(resultMap);
	}
	
	// 방 정보 출력
	@RequestMapping(value = "/host/roomInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Room info = roomService.searchRoomInfo(map);
		resultMap.put("roomInfo", info);
		return new Gson().toJson(resultMap);
	}
	
	// 객실 등록
	@RequestMapping(value = "/host/roomAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectServiceList").toString();
		
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		
		resultMap = roomService.addRoom(map);
		/* resultMap.put("success", "객실 등록 성공"); */
		return new Gson().toJson(resultMap);
	}
	
	// 객실 정보 수정
	@RequestMapping(value = "/host/roomEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		roomService.editRoom(map);
		resultMap.put("success", "객실 수정 성공");
		return new Gson().toJson(resultMap);
	}
	
	// 객실 패키지 신청
	@RequestMapping(value = "/host/roomPackAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomPackAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		roomService.addRoomPack(map);
		resultMap.put("success", "객실 수정 성공");
		return new Gson().toJson(resultMap);
	}
	
	// 객실 패키지 신청
	@RequestMapping(value = "/host/roomPackDel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomPackDel(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		roomService.removeRoomPack(map);
		resultMap.put("success", "객실 수정 성공");
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 옵션 리스트(타입, 편의시설)
	@RequestMapping(value = "/host/roomOption.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomOption(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Room> list = roomService.searchServiceList(map);
		resultMap.put("roomServiceList", list);
		return new Gson().toJson(resultMap);
	}
		
}
