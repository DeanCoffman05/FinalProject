package com.skilldistillery.flavorscapeapp.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.flavorscapeapp.entities.MenuItem;
import com.skilldistillery.flavorscapeapp.services.MenuService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost" })
public class MenuItemController {

	@Autowired
	private MenuService menuService;

	@PostMapping("restaurants/{restaurantId}/menus/{menuId}/menuItems")
	public MenuItem createFavoriteMenuItem(Principal principal, Integer restaurantId, Integer menuId, @RequestBody MenuItem menuItem) {
		menuItem = menuService.addNewMenuItem(principal.getName(), restaurantId, menuId, menuItem);

		return menuItem;
	}
}