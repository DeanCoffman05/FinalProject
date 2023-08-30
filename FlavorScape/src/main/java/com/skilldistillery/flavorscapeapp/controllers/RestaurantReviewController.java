package com.skilldistillery.flavorscapeapp.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.flavorscapeapp.entities.Restaurant;
import com.skilldistillery.flavorscapeapp.entities.RestaurantReview;
import com.skilldistillery.flavorscapeapp.repositories.RestaurantRepository;
import com.skilldistillery.flavorscapeapp.services.RestaurantReviewService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class RestaurantReviewController {

	@Autowired
	private RestaurantReviewService restaurantReviewService;
	
	@Autowired
	private RestaurantRepository restaurantRepo;

	@GetMapping("restaurants/{restaurantId}/reviews")
	public List<RestaurantReview> showRestaurantReview(HttpServletResponse res, @PathVariable Integer restaurantId) {
		List<RestaurantReview> reviews = restaurantReviewService.getRestaurantReviews(restaurantId);
		if (reviews == null) {
			res.setStatus(404);
		}

		return reviews;
	}

	@PostMapping("restaurants/{restaurantId}/reviews")
	public RestaurantReview createRestaurantReview(Principal principal, HttpServletRequest req, HttpServletResponse res, 
			@PathVariable Integer restaurantId,
			@RequestBody RestaurantReview restaurantReview) {
		Restaurant restaurant = restaurantRepo.findById(restaurantId).orElse(null);
		if(restaurant == null) {
			res.setStatus(404);
			return null;
		}
		restaurantReview = restaurantReviewService.createRestaurantReview(principal.getName(), restaurant, restaurantReview);
		return restaurantReview;
	}
}
