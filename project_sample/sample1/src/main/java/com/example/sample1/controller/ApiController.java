package com.example.sample1.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.sample1.model.ProductData;

import jakarta.servlet.http.HttpSession;

@RestController
public class ApiController {

    @GetMapping("/api/getProductList")
    public ResponseEntity<List<ProductData>> getProductList(HttpSession session) {
        List<ProductData> productList = (List<ProductData>) session.getAttribute("productList");
        return ResponseEntity.ok(productList);
    }
}