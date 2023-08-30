package com.skilldistillery.flavorscapeapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.RestaurantReview;

public interface RestaurantReviewRepository extends JpaRepository<RestaurantReview, Integer>{
	
	public List<RestaurantReview> findByRestaurant_Id(int restaurantId);

	public List<RestaurantReview> findByUser_Id(int userId);
	
	public RestaurantReview findByIdAndRestaurant_Id(int restaurantReviewId, int restaurntId);

	
	
}
