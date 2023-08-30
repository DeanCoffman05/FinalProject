package com.skilldistillery.flavorscapeapp.repositories;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.Restaurant;

public interface RestaurantRepository extends JpaRepository<Restaurant, Integer>{
	
	List<Restaurant> findByAddressCity(String city);
	List<Restaurant> findByAddressState(String state);
	List<Restaurant> findByAddressCityOrAddressState(String city, String state);
	Set<Restaurant> findByMenus_MenuItems_Cuisines_Id(int cuisineId);
	
}
