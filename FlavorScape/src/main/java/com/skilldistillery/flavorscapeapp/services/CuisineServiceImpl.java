package com.skilldistillery.flavorscapeapp.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.Cuisine;
import com.skilldistillery.flavorscapeapp.entities.Menu;
import com.skilldistillery.flavorscapeapp.entities.MenuItem;
import com.skilldistillery.flavorscapeapp.entities.Restaurant;
import com.skilldistillery.flavorscapeapp.repositories.CuisineRepository;
import com.skilldistillery.flavorscapeapp.repositories.RestaurantRepository;

@Service
public class CuisineServiceImpl implements CuisineService {
	
	@Autowired 
	private RestaurantRepository restaurantRepo;
	
	@Autowired
	private CuisineRepository cuisineRepo;
	
	
	@Override
	public List<Cuisine> listAllCuisines(){
		return cuisineRepo.findAll();
	}
	
	@Override
	public List<Cuisine> findCuisineByRestaurantId(int restaurantId){
		Optional<Restaurant> restaurantOpt = restaurantRepo.findById(restaurantId);
		
		if(restaurantOpt.isPresent()) {
			List<Cuisine> cuisines = new ArrayList<>();
			Restaurant restaurant = restaurantOpt.get();
			for (Menu menu: restaurant.getMenus()) {
				for (MenuItem menuItem : menu.getMenuItems()) {
					cuisines.addAll(menuItem.getCuisines());
				}
			}
			return cuisines;
			
		} else {
			return null;
		}
	}
}

