package com.skilldistillery.flavorscapeapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.Restaurant;

public interface RestaurantRepository extends JpaRepository<Restaurant, Integer>{
	
	List<Restaurant> findByAddressCity(String city);
	List<Restaurant> findByAddressState(String state);
	
}
