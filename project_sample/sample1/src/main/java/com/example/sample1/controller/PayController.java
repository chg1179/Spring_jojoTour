package com.example.sample1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.sample1.model.ProductData;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class PayController {
	
	//@Autowired
	//PayService payService;
	
	//@Autowired
	//HttpSession session;
	
	@RequestMapping("/payment.do")
	public ModelAndView payment(HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    List<ProductData> productList = (List<ProductData>) session.getAttribute("productList");

	    ModelAndView modelAndView = new ModelAndView("/pay/payment");
	    modelAndView.addObject("productList", productList);
	    
	    System.out.println(productList);
	    return modelAndView;
	}
	
	// 제품 리스트를 받아오면서 이동할 페이지를 리턴
	@PostMapping("/goPayment.dox")
	public ResponseEntity<Map<String, String>> goPayment(@RequestBody List<Map<String, String>> productDataList, HttpServletRequest request) {
	    Map<String, String> responseMap = new HashMap<>();

	    HttpSession session = request.getSession();
	    session.setAttribute("productList", productDataList);

	    responseMap.put("redirectUrl", "/payment.do");

	    return ResponseEntity.ok(responseMap);
	}
}
