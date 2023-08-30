package com.skilldistillery.flavorscapeapp.services;

import java.util.List;

import com.skilldistillery.flavorscapeapp.entities.Restaurant;
import com.skilldistillery.flavorscapeapp.entities.RestaurantReview;

public interface RestaurantReviewService {

	public List<RestaurantReview> getRestaurantReviews(int restaurantId);
	public RestaurantReview createRestaurantReview(String username, Restaurant restaurant, RestaurantReview restaurantReview);
	
}
