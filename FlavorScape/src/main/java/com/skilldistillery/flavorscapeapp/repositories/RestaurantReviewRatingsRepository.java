package com.skilldistillery.flavorscapeapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.RestaurantReviewRatingId;
import com.skilldistillery.flavorscapeapp.entities.RestaurantReviewRatings;

public interface RestaurantReviewRatingsRepository extends JpaRepository<RestaurantReviewRatings, RestaurantReviewRatingId>{
	

}
