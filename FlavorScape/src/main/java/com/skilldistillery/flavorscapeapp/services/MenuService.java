package com.skilldistillery.flavorscapeapp.services;

import java.util.List;

import com.skilldistillery.flavorscapeapp.entities.Menu;
import com.skilldistillery.flavorscapeapp.entities.MenuItem;

public interface MenuService {
	
	public List<Menu> getRestaurantMenus(int restaurantId);
	public MenuItem addNewMenuItem(String username, int restaurantId, int menuId, MenuItem menuItem);
}
