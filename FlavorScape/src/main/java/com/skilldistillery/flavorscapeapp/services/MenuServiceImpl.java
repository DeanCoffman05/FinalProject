package com.skilldistillery.flavorscapeapp.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.Menu;
import com.skilldistillery.flavorscapeapp.entities.MenuItem;
import com.skilldistillery.flavorscapeapp.entities.User;
import com.skilldistillery.flavorscapeapp.repositories.MenuItemRepository;
import com.skilldistillery.flavorscapeapp.repositories.MenuRepository;
import com.skilldistillery.flavorscapeapp.repositories.RestaurantRepository;
import com.skilldistillery.flavorscapeapp.repositories.UserRepository;

@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuRepository menuRepo;
	
	@Autowired
	private MenuItemRepository menuItemRepo;


	@Autowired
	private RestaurantRepository restaurantRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Menu> getRestaurantMenus(int restaurantId) {

		if (restaurantRepo.existsById(restaurantId)) {
			return menuRepo.findByRestaurant_Id(restaurantId);
		}
		return null;
	}

	@Override
	public MenuItem addNewMenuItem(String username, int restaurantId, int menuId, MenuItem menuItem) {
		User user = userRepo.findByUsername(username);
		Menu menu = menuRepo.findByIdAndRestaurant_Id(menuId, restaurantId);
		
		if(user != null && menu != null) {
			menuItem.setMenu(menu);
			return menuItemRepo.saveAndFlush(menuItem);
		}
		return null;
	}

}
