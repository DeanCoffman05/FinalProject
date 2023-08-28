package com.skilldistillery.flavorscapeapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.skilldistillery.flavorscapeapp.entities.MenuItem;


public interface MenuItemRepository extends JpaRepository<MenuItem, Integer> {
	
	public List<MenuItem> findByMenu_RestaurantId(int restaurantId);

}
