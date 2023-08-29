package com.skilldistillery.flavorscapeapp.services;

import java.util.List;
import java.util.Set;

import com.skilldistillery.flavorscapeapp.entities.MenuItem;
import com.skilldistillery.flavorscapeapp.entities.Restaurant;

public interface RestaurantService {
	
	public List<Restaurant> index();
	public Restaurant show(String username, int restaurantId);
	public Restaurant create(String username, Restaurant restaurant);
	public Restaurant update(String username, int restaurantId, Restaurant restaurant);
	public boolean destroy(String username, int restaurantId);
	public List<Restaurant> findCityByKeyword(String city);
	public List<Restaurant> findStateByKeyword(String state);
	public List<MenuItem> createFavorite(String username, MenuItem menuItem);
	public Set<Restaurant> findByCuisine(int cuisineId);
}
