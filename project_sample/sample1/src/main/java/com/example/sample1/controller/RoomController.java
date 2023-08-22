package com.example.sample1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.sample1.model.Room;
import com.example.sample1.model.RoomImg;
import com.example.sample1.service.RoomService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
		
		request.setAttribute("map", map);
		return "/host/host-room";
	}
	
	//숙박 방 페이지
	@RequestMapping("/host/roomAdd.do") 
	public String roomAdd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		
		request.setAttribute("map", map);
		return "/host/host-room-add";
	}
	
	//숙박 방 상세정보 페이지
	@RequestMapping("/host/roomView.do") 
	public String roomView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		
		request.setAttribute("map", map);
		return "/host/host-room-view";
	}
	
	//숙박 방 수정 페이지
	@RequestMapping("/host/roomEdit.do") 
	public String roomEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		
		request.setAttribute("map", map);
		return "/host/host-room-edit";
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
	
	// 숙소 이미지 추가
	@RequestMapping("/host/roomFileUpload.dox")
    public String result(@RequestParam("files") MultipartFile multi, @RequestParam("roomNo") int roomNo, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        String path="c:\\img\\room";
        try {
 
            //String uploadpath = request.getServletContext().getRealPath(path);
            String uploadpath = path;
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            long size = multi.getSize();
            String saveFileName = genSaveFileName(extName);
            
            System.out.println("uploadpath : " + uploadpath);
            System.out.println("originFilename : " + originFilename);
            System.out.println("extensionName : " + extName);
            System.out.println("size : " + size);
            System.out.println("saveFileName : " + saveFileName);
            String path2 = System.getProperty("user.dir");
            System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img\\room");
            if(!multi.isEmpty())
            {
                File file = new File(path2 + "\\src\\main\\webapp\\img\\room", saveFileName);
                multi.transferTo(file);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("imgName", originFilename);
                map.put("imgSaveName", saveFileName);
                map.put("imgPath", "../img/room/" + saveFileName);
                map.put("roomNo", roomNo);
                
                // insert 쿼리 실행
                roomService.addRoomImg(map);
                
                model.addAttribute("imgName", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                
                return null;
            }
        }catch(Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    // 현재 시간을 기준으로 파일 이름 생성
    private String genSaveFileName(String extName) {
        String fileName = "";
        
        Calendar calendar = Calendar.getInstance();
        fileName += calendar.get(Calendar.YEAR);
        fileName += calendar.get(Calendar.MONTH);
        fileName += calendar.get(Calendar.DATE);
        fileName += calendar.get(Calendar.HOUR);
        fileName += calendar.get(Calendar.MINUTE);
        fileName += calendar.get(Calendar.SECOND);
        fileName += calendar.get(Calendar.MILLISECOND);
        fileName += extName;
        
        return fileName;
    }
    
  //방 이미지 수정
  	@RequestMapping("/host/roomFileChange.dox")
  	public String change(@RequestParam("files") MultipartFile multi, @RequestParam("imgNo") int imgNo, HttpServletRequest request, HttpServletResponse response, Model model)
  	{
  		String url = null;
          String path="c:\\img\\room";
          try {
              //String uploadpath = request.getServletContext().getRealPath(path);
              String uploadpath = path;
              String originFilename = multi.getOriginalFilename();
              String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
              long size = multi.getSize();
              
              String saveFileName = getSaveFileName(extName);
              
              System.out.println("uploadpath : " + uploadpath);
              System.out.println("originFilename : " + originFilename);
              System.out.println("extensionName : " + extName);
              System.out.println("size : " + size);
              System.out.println("saveFileName : " + saveFileName);
              String path2 = System.getProperty("user.dir");
              System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img\\room");
              if(!multi.isEmpty())
              {
                  File file = new File(path2 + "\\src\\main\\webapp\\img\\room", saveFileName);
                  multi.transferTo(file);
                  
                  //이미 테이블에 등록된 파일명을 받아왔을 때
                  HashMap<String, Object> map = new HashMap<String, Object>();
					/*
					 * if(rentCarService.searchImgCnt(map) != 0) { saveFileName += "1"; }
					 */
                  
                  map.put("imgName", originFilename);
                  map.put("imgSaveName", saveFileName);
                  map.put("imgPath", "../img/stay/" + saveFileName);
                  map.put("imgNo", imgNo);
                  
                  // update 쿼리 실행
                  roomService.editRoomImg(map);
                  
                  model.addAttribute("imgName", multi.getOriginalFilename());
                  model.addAttribute("uploadPath", file.getAbsolutePath());
                  
                  return null;
              }
          }catch(Exception e) {
              System.out.println(e);
          }
          return null;
  	}
  	
      // 현재 시간을 기준으로 파일 이름 생성
      private String getSaveFileName(String extName) {
          String fileName = "";
          
          Calendar calendar = Calendar.getInstance();
          fileName += calendar.get(Calendar.YEAR);
          fileName += calendar.get(Calendar.MONTH);
          fileName += calendar.get(Calendar.DATE);
          fileName += calendar.get(Calendar.HOUR);
          fileName += calendar.get(Calendar.MINUTE);
          
          //초 단위의 시간이 겹치면서 파일명 중복이 일어나기 때문에 고유한 파일 이름을 만들도록 하기 위함
          long currentTimeMillis = System.currentTimeMillis();
          fileName += currentTimeMillis;
          fileName += extName;
          
          return fileName;
      }
      
      // 숙소 리스트
	@RequestMapping(value = "/host/roomImgInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String roomImgInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		RoomImg info = roomService.searchRoomImgInfo(map);
		resultMap.put("imgInfo", info);
		return new Gson().toJson(resultMap);
	}

}
