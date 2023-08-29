package com.skilldistillery.flavorscapeapp.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.flavorscapeapp.services.CuisineService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost" })
public class CuisineController {

	@Autowired
	private CuisineService cuisineService;
	
	
	

	
	
}
