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

import com.example.sample1.model.Stay;
import com.example.sample1.model.StayImg;
import com.example.sample1.service.StayService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class StayController {
	
	@Autowired
	StayService stayService;
	
	//숙박 관리 페이지
	@RequestMapping("/host/stay.do") 
    public String stay(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		
		request.setAttribute("map", map);
		return "/host/host-stay";
    }
	
	// 숙박 업체 추가 페이지
	@RequestMapping("/host/stayAdd.do") 
	public String stayAdd(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		
		request.setAttribute("map", map);
		return "/host/host-stay-add";
	}
	
	// 숙박 업체 수정 페이지
	@RequestMapping("/host/stayEdit.do") 
	public String stayEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅

		request.setAttribute("map", map);
		return "/host/host-stay-edit";
	}
	
	//숙소 업체 정보 출력
	@RequestMapping(value = "/host/stayList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = stayService.searchStayList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 슥소 업체 등록
	@RequestMapping(value = "/host/stayAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String json = map.get("selectServiceList").toString();
		
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("serviceList", list);
		
		resultMap = stayService.addStay(map);
		
		//resultMap.put("message", "success");
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 옵션 리스트(타입, 편의시설, 체크된 편의시설)
	@RequestMapping(value = "/host/stayOption.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayOption(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>(); 
		List<Stay> list = stayService.searchStayTypeList(map);
		resultMap.put("stayTypeList", list);
		
		List<Stay> list2 = stayService.searchServiceList(map);
		resultMap.put("stayServiceList", list2);
		
		return new Gson().toJson(resultMap);
		
	}
	
	// 숙소 삭제 리스트
	@RequestMapping(value = "/host/stayRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		stayService.removeStay(map);
		resultMap.put("success", "숙소삭제성공");
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 삭제 리스트
	@RequestMapping(value = "/host/stayInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Stay info = stayService.searchStayInfo(map);
		resultMap.put("stayInfo", info);
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 수정
	@RequestMapping(value = "/host/stayEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stayEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String json = map.get("checkList").toString();
		
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("jsonCheckList", list);
		
		stayService.removeService(map);
		resultMap = stayService.editStayInfo(map);
		
	    resultMap.put("message", "success");
	    return new Gson().toJson(resultMap);
	}
	
	// 체크된 서비스 리스트
	@RequestMapping(value = "/host/checkList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Stay> list = stayService.checkServiceList(map);
		resultMap.put("checkList", list);
		return new Gson().toJson(resultMap);
	}
	
	// 숙소 이미지 추가
	@RequestMapping("/host/stayFileUpload.dox")
    public String result(@RequestParam("files") MultipartFile multi, @RequestParam("stayNo") int stayNo, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        String path="c:\\img\\stay";
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
            System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img\\stay");
            if(!multi.isEmpty())
            {
                File file = new File(path2 + "\\src\\main\\webapp\\img\\stay", saveFileName);
                multi.transferTo(file);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("imgName", originFilename);
                map.put("imgSaveName", saveFileName);
                map.put("imgPath", "../img/stay/" + saveFileName);
                map.put("stayNo", stayNo);
                
                // insert 쿼리 실행
                stayService.addStayImg(map);
                
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
    
  //숙소 이미지 수정
  	@RequestMapping("/host/stayFileChange.dox")
  	public String change(@RequestParam("files") MultipartFile multi, @RequestParam("imgNo") int imgNo, HttpServletRequest request, HttpServletResponse response, Model model)
  	{
  		String url = null;
          String path="c:\\img\\stay";
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
              System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img\\stay");
              if(!multi.isEmpty())
              {
                  File file = new File(path2 + "\\src\\main\\webapp\\img\\stay", saveFileName);
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
                  stayService.editStayImg(map);
                  
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
  	@RequestMapping(value = "/host/stayImgInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
  	@ResponseBody
  	public String stayImgList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
  		HashMap<String, Object> resultMap = new HashMap<String, Object>();
  		StayImg info = stayService.searchStayImgInfo(map);
  		resultMap.put("imgInfo", info);
  		return new Gson().toJson(resultMap);
  	}
}
