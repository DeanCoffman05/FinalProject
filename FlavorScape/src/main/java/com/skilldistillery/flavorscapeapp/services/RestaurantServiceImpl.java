package com.skilldistillery.flavorscapeapp.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.Restaurant;
import com.skilldistillery.flavorscapeapp.repositories.RestaurantRepository;
import com.skilldistillery.flavorscapeapp.repositories.UserRepository;

@Service
public class RestaurantServiceImpl implements RestaurantService {
	
	@Autowired
	private RestaurantRepository restaurantRepo;
	
	@Autowired
	private UserRepository userRpo;
	
	@Override
	public List<Restaurant> index() {
		return restaurantRepo.findAll();
	}

	@Override
	public Restaurant show(String username, int restaurantId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Restaurant create(String username, Restaurant restaurant) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Restaurant update(String username, int restaurantId, Restaurant restaurant) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int restaurantId) {
		// TODO Auto-generated method stub
		return false;
	}

}
