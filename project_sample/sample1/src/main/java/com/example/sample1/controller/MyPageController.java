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

import com.example.sample1.model.Inquiry;
import com.example.sample1.model.MyPage;
import com.example.sample1.service.MyPageService;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageController {
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	HttpSession session;
	@RequestMapping("/my/page.do") 
    public String page(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-page";
    }

	@RequestMapping("/my/order.do") 
    public String order(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "my/my-order";
    }

	@RequestMapping("/my/point.do") 
    public String point(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-point";
    }

	@RequestMapping("/my/review.do") 
    public String review(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-review";
    }	

	@RequestMapping("my/review/edit.do") 
    public String reviewEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/my/my-review-edit";
    }	
	
	@RequestMapping("/my/inquiry.do") 
    public String inquiry(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-inquiry";
    }
	
	@RequestMapping("my/inquiry/edit.do") 
    public String inquiryEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/my/my-inquiry-edit";
    }	
	@RequestMapping(value = "order.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String order(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		MyPage order = myPageService.searchOrder(map);
		resultMap.put("order", order);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/userPoint.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String point(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		MyPage point = myPageService.searchPoint(map);
		resultMap.put("point", point);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/userReview.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String review(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		List<MyPage> list = myPageService.searchReview(map);
		resultMap.put("list", list);
		int reviewCnt = myPageService.searchReviewCnt(map);
		resultMap.put("reviewCnt", reviewCnt);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/r_remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String remove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		myPageService.removeReview(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/review/reviewInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String reviewInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		MyPage info = myPageService.searchReviewInfo(map);
		resultMap.put("info", info);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/review/reviewEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String reviewEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		myPageService.updateReview(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/inquiry.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String myInquiry(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Inquiry> list = myPageService.searchInquiry(map);
		resultMap.put("list", list);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/i_remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteInquiry(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		myPageService.removeInquiry(map);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/inquiry/inquiryInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Inquiry info = myPageService.searchInquiryInfo(map);
		resultMap.put("info", info);
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/my/inquiry/inquiryEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String inquiryEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		myPageService.updateInquiry(map);
		return new Gson().toJson(resultMap);
	}
}
