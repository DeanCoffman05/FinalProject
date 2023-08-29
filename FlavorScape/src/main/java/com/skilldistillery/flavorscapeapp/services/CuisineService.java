package com.skilldistillery.flavorscapeapp.services;

import java.util.List;

import com.skilldistillery.flavorscapeapp.entities.Cuisine;

public interface CuisineService {
	
	public List<Cuisine> listAllCuisines();
	
	public List<Cuisine> findCuisineByRestaurantId(int restaurantId);

}
