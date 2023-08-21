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

import com.example.sample1.model.RentCar;
import com.example.sample1.model.RentCarImg;
import com.example.sample1.service.RentCarService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class RentCarContoller {
	
	@Autowired
	RentCarService rentCarService;
	
	//렌트카 관리 페이지
	@RequestMapping("/host/rentcar.do") 
    public String rentcar(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		
		return "/host/host-rentcar";
    }
	
	//렌트카 제품 추가 및 수정 페이지
	@RequestMapping("/host/rentcar/edit.do") 
	public String leisureEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
		request.setAttribute("map", map);
		return "/host/host-rentcar-edit";
	}
	
	//렌트카 제품 상세 목록 열람 페이지
	@RequestMapping("/host/rentcar/view.do") 
	public String rentView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession(); String status = (String)
		session.getAttribute("sessionStatus"); //다운캐스팅
				
		request.setAttribute("map", map);
		return "/host/host-rentcar-view";
	}
	
	//주소검색
	@RequestMapping("/host/rentcar/addr.do") 
	public String carAddr(Model model, @RequestParam HashMap<String, Object> map, HttpServletRequest request) throws Exception{
		
		return "/login/juso-popup";
	}
	
	//렌트카 정보 리스트 출력
	@RequestMapping(value = "/host/rentcar.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCar(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = rentCarService.searchRentCarList(map);
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 상세정보 출력
	@RequestMapping(value = "/host/rentcar/carInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCarInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		RentCar info = rentCarService.searchRentCarInfo(map);
		resultMap.put("carInfo", info);
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 차 삭제
	@RequestMapping(value = "/host/rentcar/carRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		rentCarService.removeRentCar(map);
		resultMap.put("success", "렌트카정보삭제완료");
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 패키지 신청
	@RequestMapping(value = "/host/rentPackAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentPackAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		rentCarService.addRentPack(map);
		resultMap.put("success", "렌트카패키지신청완료");
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 패키지 신청 취소
	@RequestMapping(value = "/host/rentPackDel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentPackDel(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		rentCarService.removeRentPack(map);
		resultMap.put("success", "렌트카패키지신청취소");
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 추가
	@RequestMapping(value = "/host/rentcar/addRentCar.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addRentCar(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = rentCarService.addRentCar(map);
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 정보 수정
	@RequestMapping(value = "/host/rentcar/editRentCar.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editRentCar(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = rentCarService.editRentCar(map);
		return new Gson().toJson(resultMap);
	}
	
	//렌트카 이미지 추가
	@RequestMapping("fileUpload.dox")
    public String result(@RequestParam("files") MultipartFile multi, @RequestParam("rentNo") int rentNo, @RequestParam("mainYN") String mainYN, HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        String path="c:\\img\\rentCar";
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
            System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img\\rentCar");
            if(!multi.isEmpty())
            {
                File file = new File(path2 + "\\src\\main\\webapp\\img\\rentCar", saveFileName);
                multi.transferTo(file);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("imgName", originFilename);
                map.put("imgSaveName", saveFileName);
                map.put("imgPath", "../img/rentCar/" + saveFileName);
                map.put("rentNo", rentNo);
                map.put("mainYN", mainYN);
                
                // insert 쿼리 실행
                rentCarService.addRentImg(map);
                
                model.addAttribute("imgName", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                
                return null;
            }
        }catch(Exception e) {
            System.out.println(e);
        }
        return null;
    }
	
	//렌트카 이미지 수정
	@RequestMapping("/host/rentcar/fileChange.dox")
	public String change(@RequestParam("files") MultipartFile multi, @RequestParam("imgNo") int imgNo, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		String url = null;
        String path="c:\\img\\rentCar";
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
            System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img\\rentCar");
            if(!multi.isEmpty())
            {
                File file = new File(path2 + "\\src\\main\\webapp\\img\\rentCar", saveFileName);
                multi.transferTo(file);
                
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("imgName", originFilename);
                map.put("imgSaveName", saveFileName);
                map.put("imgPath", "../img/rentCar/" + saveFileName);
                map.put("imgNo", imgNo);
                
                // insert 쿼리 실행
                rentCarService.editRentCarImg(map);
                
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
    
	//렌트카 정보 리스트 출력
	@RequestMapping(value = "/host/rentcar/carImgList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String rentCarImgList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<RentCarImg> list = rentCarService.searchCarImgList(map);
		resultMap.put("carImgList", list);
		return new Gson().toJson(resultMap);
	}
}
