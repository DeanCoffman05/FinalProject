package com.skilldistillery.flavorscapeapp.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.RestaurantReview;
import com.skilldistillery.flavorscapeapp.entities.User;
import com.skilldistillery.flavorscapeapp.repositories.RestaurantRepository;
import com.skilldistillery.flavorscapeapp.repositories.RestaurantReviewRepository;
import com.skilldistillery.flavorscapeapp.repositories.UserRepository;

@Service
public class RestaurantReviewServiceImpl implements RestaurantReviewService {

	@Autowired
	private RestaurantReviewRepository restaurantReviewRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private RestaurantRepository restaurantRepo;

	@Override
	public List<RestaurantReview> getRestaurantReviews(int restaurantId) {
		if (restaurantRepo.existsById(restaurantId)) {
			return restaurantReviewRepo.findByRestaurant_Id(restaurantId);
		}

		return null;
	}

	@Override
	public RestaurantReview createRestaurantReview(String username, RestaurantReview restaurantReview) {
		User user = userRepo.findByUsername(username);
		if (user != null) {

			if (restaurantReview.getRestaurant() != null) {
				restaurantRepo.save(restaurantReview.getRestaurant());
			}
			restaurantReview.setEnabled(true);
			restaurantRepo.save(restaurantReview);
			return restaurantReview;
		}
		return null;
	}
}