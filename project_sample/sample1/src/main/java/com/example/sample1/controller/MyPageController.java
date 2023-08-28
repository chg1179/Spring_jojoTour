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
import com.example.sample1.model.User;
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

	// 주문 내역 페이지
	@RequestMapping("/my/order.do") 
    public String order(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-order";
    }
	
	// 주문 내역 상세 조회 페이지
	@RequestMapping("/my/order/view.do") 
    public String orderView(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/my/my-order-view";
    }

	@RequestMapping("/my/order/changeRequest.do") 
    public String changeRequest(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/my/changeRequest-popup";
    }
	
	@RequestMapping("/my/point.do") 
    public String point(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-point";
    }

	@RequestMapping("/my/review.do") 
    public String review(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{

        return "/my/my-review";
    }	

	// 마이페이지 1:1문의 내역
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
	
	// 아이디별 예약내역 전체 리스트 출력. 총금액, 사용완료, 사용전, 취소 COUNT
	@RequestMapping(value = "order.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String order(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		List<MyPage> orderList = myPageService.searchOrder(map);
		resultMap.put("orderList", orderList);
		return new Gson().toJson(resultMap);
	}

	// 주문 번호 별 내역 조회
	@RequestMapping(value = "orderList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = myPageService.searchOrderInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	// 주문자 정보 수정
	@RequestMapping(value = "/editUserInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editUserInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		myPageService.editUserInfo(map);
		resultMap.put("success", "주문자정보수정완료");
		return new Gson().toJson(resultMap);
	}
	
	// 주문 제품 별 요구사항 수정
	@RequestMapping(value = "/editRequest.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editRequest(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		myPageService.editRequest(map);
		resultMap.put("success", "요청사항수정완료");
		return new Gson().toJson(resultMap);
	}
	
	// 주문 제품 취소 및 포인트 반환
	@RequestMapping(value = "/revokeOrder.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String revokeOrder(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		myPageService.revokeOrder(map);
		resultMap.put("success", "제품취소완료");
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

		User point = myPageService.searchPoint(map);
		resultMap.put("point", point);
		return new Gson().toJson(resultMap);
	}
	
	// 마이페이지 1:1문의내역 출력
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

	// 찜 목록 중복 체크
	@RequestMapping(value = "/checkHeart.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkHeart(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int jjimCnt = myPageService.checkHeart(map);
		resultMap.put("jjimCnt", jjimCnt);
		return new Gson().toJson(resultMap);
	}
}
