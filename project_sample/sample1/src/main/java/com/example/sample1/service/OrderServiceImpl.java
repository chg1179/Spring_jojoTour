package com.example.sample1.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sample1.mapper.OrderMapper;
import com.example.sample1.model.Order;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	OrderMapper orderMapper;
	
	@Override
	public List<Order> searchOrderList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectOrderList(map);
	}

	@Override
	public int editOrderSign(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.updateOrderSign(map);
	}

	@Override
	public int addOrder(HashMap<String, Object> map, List<Map<String, String>> productList) {
		// TODO Auto-generated method stub
		
		//키값으로 구성된 json 제품 리스트(productDataList) 받아오기
		System.out.println("<주문 품목>");
		orderMapper.insertOrder(map); // 주문내역 추가
		for (Map<String, String> productData : productList) {
            String productKind = productData.get("productKind");
            String productNo = productData.get("productNo");
            map.put("productKind", productKind);
        	map.put("productNo", productNo);
        	map.put("sReserveDate", productData.get("sReserveDate"));
        	map.put("lReserveDate", productData.get("lReserveDate"));
        	
            // 분류별 인원 수 컬럼을 구분하여 동일한 이름으로 통일
            if(productKind.equals("STAY")){
            	map.put("payment", productData.get("sprice")); // 총 금액
            	map.put("people", productData.get("roomDaysDiff")); // 며칠인지
            } else if(productKind.equals("RENT")){
            	map.put("payment", productData.get("rprice"));
            	map.put("people", productData.get("rentDaysDiff")); // 며칠인지
            } else if(productKind.equals("LEISURE")) {
            	int leisurePrice = Integer.parseInt(productData.get("leisurePrice"));
            	double leisureSales = Double.parseDouble(productData.get("leisureSales"));
            	map.put("people", productData.get("people"));
            	int people = Integer.parseInt(productData.get("people"));
            	int lprice = (int) (leisurePrice * leisureSales * people); // 티켓 수에 따른 레저 결제 금액
            	map.put("payment", lprice);
    			// 레저는 구매일 기준으로 한달 뒤까지 사용이 가능하다고 설정하기 때문에 현재 날짜를 받아옴
    	        LocalDate currentDate = LocalDate.now(); // 현재 날짜 가져오기

    	        // DateTimeFormatter를 사용하여 날짜를 원하는 포맷으로 변환
    	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    	        String formattedCurrentDate = currentDate.format(formatter);
    	        
    	        // 현재 달에서 다음 달 변환. 12월이면 다음 년도 1월으로 바뀐다.
                String nextMonthDate = currentDate.plusMonths(1).format(formatter);
                map.put("lReserveDate", nextMonthDate);
            }
            System.out.println("제품 분류: " + productKind + ", 제품 번호: " + productNo);
            
    		orderMapper.insertOrderProduct(map); // 주문내역 별 주문제품 매치
            orderMapper.deleteCartList(map); // 주문한 제품은 장바구니에서 제거
        }
		orderMapper.usePoint(map); // 주문에 포인트 사용시 포인트 차감
		return 1; //주문 번호 하나 
	}

}
