package com.skilldistillery.flavorscapeapp.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.flavorscapeapp.entities.RestaurantReview;
import com.skilldistillery.flavorscapeapp.services.RestaurantReviewService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class RestaurantReviewController {

	@Autowired
	private RestaurantReviewService restaurantReviewService;

	@GetMapping("restaurants/{restaurantId}/reviews")
	public List<RestaurantReview> showRestaurantReview(HttpServletResponse res, @PathVariable Integer restaurantId) {
		List<RestaurantReview> reviews = restaurantReviewService.getRestaurantReviews(restaurantId);
		if (reviews == null) {
			res.setStatus(404);
		}

		return reviews;
	}

	@PostMapping("reviews")
	public RestaurantReview createRestaurantReview(Principal principal, HandshakeRequest req, HandshakeResponse res,
			@RequestBody RestaurantReview restaurantReview) {
		restaurantReview = restaurantReviewService.createRestaurantReview(principal.getName(), restaurantReview);
		return restaurantReview;
	}
}
