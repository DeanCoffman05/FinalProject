package com.skilldistillery.flavorscapeapp.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.Restaurant;
import com.skilldistillery.flavorscapeapp.entities.User;
import com.skilldistillery.flavorscapeapp.repositories.AddressRepository;
import com.skilldistillery.flavorscapeapp.repositories.RestaurantRepository;
import com.skilldistillery.flavorscapeapp.repositories.UserRepository;

@Service
public class RestaurantServiceImpl implements RestaurantService {
	
	@Autowired
	private RestaurantRepository restaurantRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private AddressRepository addressRepo;
	
	@Override
	public List<Restaurant> index() {
		return restaurantRepo.findAll();
	}

	@Override
	public Restaurant show(String username, int restaurantId) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			Optional<Restaurant> restaurantOpt = restaurantRepo.findById(restaurantId);
			Restaurant restaurant = null;
			if(restaurantOpt.isPresent()) {
				restaurant = restaurantOpt.get();
			}
			return restaurant;
		}
		return null;
	}

	@Override
	public Restaurant create(String username, Restaurant restaurant) {
		User user = userRepo.findByUsername(username);
		if(user != null ) {
			
		if(restaurant.getAddress() != null) {
			addressRepo.save(restaurant.getAddress());
		}
		restaurant.setEnabled(true);
		restaurantRepo.saveAndFlush(restaurant);
		return restaurant;
		}
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
