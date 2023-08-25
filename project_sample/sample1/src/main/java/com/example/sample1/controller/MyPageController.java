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
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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

        return "/my/my-order";
    }
	
	@RequestMapping("/my/order/view.do") 
    public String orderView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-order-view";
    }

	@RequestMapping("/my/point.do") 
    public String point(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-point";
    }

	@RequestMapping("/my/review.do") 
    public String review(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-review";
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
	
	@RequestMapping("/my/jjim.do") 
	public String jjim(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

		return "/my/my-jjim";
	}	
	
	@RequestMapping(value = "order.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String order(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		List<MyPage> list = myPageService.searchOrderList(map);
		resultMap.put("list", list);
		List<MyPage> listAccept = myPageService.searchOrderAcceptList(map);
		resultMap.put("listAccept", listAccept);
		List<MyPage> listCompletion = myPageService.searchOrderCompletionList(map);
		resultMap.put("listCompletion", listCompletion);
		List<MyPage> listCancel = myPageService.searchOrderCancelList(map);
		resultMap.put("listCancel", listCancel);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "orderInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		MyPage orderInfo = myPageService.searchOrderInfo(map);
		resultMap.put("orderInfo", orderInfo);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/my/jjim.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String jjim(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int startNum = Integer.parseInt(String.valueOf(map.get("startNum")));
		int lastNum = Integer.parseInt(String.valueOf(map.get("lastNum")));
		map.put("startNum", startNum);
		map.put("lastNum", lastNum);
		resultMap = myPageService.searchJjim(map);
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
	
	//체크박스를 이용해 게시글 삭제
	@RequestMapping(value = "/my/removeJjimCheck.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeJjimCheck(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map.get("selectItem"));
		String json = map.get("selectItem").toString(); //Object 형으로 받고 있기 때문에 오류가 난다. 문자열으로 리턴
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);//쿼리에 list 라는 값으로 보내줬음을 기억하
		myPageService.removeJjimCheck(map);
		resultMap.put("message", "success");
		return new Gson().toJson(resultMap);
	}
	//예약취소
	@RequestMapping(value = "bookingCancel.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bookingCancel(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		myPageService.searchBookingCancel(map);
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


}
