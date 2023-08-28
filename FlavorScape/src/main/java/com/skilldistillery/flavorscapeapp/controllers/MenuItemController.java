package com.skilldistillery.flavorscapeapp.controllers;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.flavorscapeapp.entities.MenuItem;
import com.skilldistillery.flavorscapeapp.services.RestaurantService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost" })
public class MenuItemController {

	@Autowired
	private RestaurantService restaurantService;

	@PostMapping("/users/{username}/menuitems/favorite")
	public List<MenuItem> createFavoriteMenuItem(@PathVariable String username, @RequestBody MenuItem menuItem) {
		List<MenuItem> updatedMenuItems = restaurantService.createFavorite(username, menuItem);

		return updatedMenuItems;
	}
}