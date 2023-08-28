package com.skilldistillery.flavorscapeapp.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.flavorscapeapp.entities.Menu;
import com.skilldistillery.flavorscapeapp.services.MenuService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost" })
public class MenuController {

	@Autowired
	private MenuService menuService;

	@GetMapping("restaurants/{restaurantId}/menus")
	public List<Menu> getRestaurantMenus(@PathVariable Integer restaurantId, HttpServletResponse res, HttpServletRequest req) {
		List<Menu> menus = menuService.getRestaurantMenus(restaurantId);
		if(menus == null) {
			res.setStatus(404);
		}

		return menus;
	}
}