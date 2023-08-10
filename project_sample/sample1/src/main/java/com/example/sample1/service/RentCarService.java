package com.example.sample1.service;

import java.util.HashMap;
import java.util.List;

import com.example.sample1.model.RentCar;

public interface RentCarService {
	List<RentCar> searchRentCarList(HashMap<String, Object> map);
}
