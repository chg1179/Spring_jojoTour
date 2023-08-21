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

import com.example.sample1.model.Leisure;
import com.example.sample1.model.LeisureImg;
import com.example.sample1.service.LeisureService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class LeisureController {
	@Autowired
	LeisureService leisureService;
	
	//레저 관리 페이지
	@RequestMapping("/host/leisure.do") 
    public String leisure(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		
		return "/host/host-leisure";
    }
	
	//레저 제품 추가 및 수정 페이지
	@RequestMapping("/host/leisure/edit.do") 
	public String leisureEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		request.setAttribute("map", map);
		return "/host/host-leisure-edit";
	}
	
	//레저 제품 상세 목록 열람 페이지
	@RequestMapping("/host/leisure/view.do") 
	public String leisureView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		request.setAttribute("map", map);
		return "/host/host-leisure-view";
	}
	
	//주소검색
	@RequestMapping("/host/leisure/addr.do") 
	public String leisureAddr(Model model, @RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception{
		
		return "/login/juso-popup";
	}
	
	//레저 정보 리스트 출력
	@RequestMapping(value = "/host/leisure.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String leisureList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = leisureService.searchLeisureList(map);
		return new Gson().toJson(resultMap);
	}
	
	//레저 상세정보 출력
	@RequestMapping(value = "/host/leisure/leisureInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String leisureInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Leisure info = leisureService.searchLeisureInfo(map);
		resultMap.put("leisureInfo", info);
		return new Gson().toJson(resultMap);
	}
	
	//레저 차 삭제
	@RequestMapping(value = "/host/leisure/leisureRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String leisureRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		leisureService.removeLeisure(map);
		resultMap.put("success", "레저정보삭제완료");
		return new Gson().toJson(resultMap);
	}
	
	//레저 패키지 신청
	@RequestMapping(value = "/host/leisurePackAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String leisurePackAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		leisureService.addLeisurePack(map);
		resultMap.put("success", "레저패키지신청완료");
		return new Gson().toJson(resultMap);
	}
	
	//레저 패키지 신청 취소
	@RequestMapping(value = "/host/leisurePackDel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String leisurePackDel(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		leisureService.removeLeisurePack(map);
		resultMap.put("success", "레저패키지신청취소");
		return new Gson().toJson(resultMap);
	}
	
	//레저 추가
	@RequestMapping(value = "/host/leisure/addLeisure.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addleisure(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = leisureService.addLeisure(map);
		return new Gson().toJson(resultMap);
	}
	
	//레저 정보 수정
	@RequestMapping(value = "/host/leisure/editLeisure.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editleisure(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = leisureService.editLeisure(map);
		return new Gson().toJson(resultMap);
	}
	
	//레저 이미지 추가
	@RequestMapping("leisureFileUpload.dox")
    public String result(@RequestParam("files") MultipartFile multi, @RequestParam("leisureNo") int leisureNo, @RequestParam("mainYN") String mainYN, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        String path="c:\\img\\leisure";
        try {
        	Thread.sleep(1000);//같은 파일명을 넣지 않기 위해
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
            System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img\\leisure");
            if(!multi.isEmpty())
            {
                File file = new File(path2 + "\\src\\main\\webapp\\img\\leisure", saveFileName);
                multi.transferTo(file);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("imgName", originFilename);
                map.put("imgSaveName", saveFileName);
                map.put("imgPath", "../img/leisure/" + saveFileName);
                map.put("leisureNo", leisureNo);
                map.put("mainYN", mainYN);
                
                // insert 쿼리 실행
                leisureService.addLeisureImg(map);
                
                model.addAttribute("imgName", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                
                return null;
            }
        }catch(Exception e) {
            System.out.println(e);
        }
        return null;
    }
	
	//레저 이미지 수정
	@RequestMapping("/host/leisure/fileChange.dox")
	public String change(@RequestParam("files") MultipartFile multi, @RequestParam("imgNo") int imgNo, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		String url = null;
        String path="c:\\img\\leisure";
        try {
        	Thread.sleep(1000);//같은 파일명을 넣지 않기 위해
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
            System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img\\leisure");
            if(!multi.isEmpty())
            {
                File file = new File(path2 + "\\src\\main\\webapp\\img\\leisure", saveFileName);
                multi.transferTo(file);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("imgName", originFilename);
                map.put("imgSaveName", saveFileName);
                map.put("imgPath", "../img/leisure/" + saveFileName);
                map.put("imgNo", imgNo);
                
                // insert 쿼리 실행
                leisureService.editLeisureImg(map);
                
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
        
        //초 단위의 시간이 겹치면서 파일명 중복이 일어나기 때문에 고유한 파일 이름을 만들도록 하기 위함
        long currentTimeMillis = System.currentTimeMillis();
        fileName += currentTimeMillis;
        fileName += extName;
        
        return fileName;
    }
    
	//레저 정보 리스트 출력
	@RequestMapping(value = "/host/leisure/leisureImgList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String leisureImgList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<LeisureImg> list = leisureService.searchLeisureImgList(map);
		resultMap.put("leisureImgList", list);
		return new Gson().toJson(resultMap);
	}
}
