package com.skilldistillery.flavorscapeapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.Restaurant;

public interface RestaurantRepository extends JpaRepository<Restaurant, Integer>{
	
	
}
