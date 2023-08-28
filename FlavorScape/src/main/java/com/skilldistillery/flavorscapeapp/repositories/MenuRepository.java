package com.skilldistillery.flavorscapeapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.Menu;

public interface MenuRepository extends JpaRepository<Menu, Integer> {

	public List<Menu> findByRestaurant_Id(int restaurantId);
	
	public Menu findByIdAndRestaurant_Id(int menuId, int restaurntId);
}
