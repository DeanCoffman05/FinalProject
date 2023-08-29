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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.flavorscapeapp.entities.Restaurant;
import com.skilldistillery.flavorscapeapp.entities.RestaurantReviewRatings;
import com.skilldistillery.flavorscapeapp.services.RestaurantService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class RestaurantController {

	@Autowired
	private RestaurantService restaurantService;

	@GetMapping("restaurants")
	public List<Restaurant> showAll() {
		return restaurantService.index();
	}

	@GetMapping("restaurants/city/{city}")
	public List<Restaurant> findCityByKeyword(HttpServletResponse res, @PathVariable String city) {

		List<Restaurant> restaurants = restaurantService.findCityByKeyword(city);

		if (restaurants == null) {
			res.setStatus(404);
		}

		return restaurants;

	}

	@GetMapping("restaurants/state/{state}")
	public List<Restaurant> findStateByKeyword(HttpServletResponse res, @PathVariable String state) {

		List<Restaurant> restaurants = restaurantService.findStateByKeyword(state);

		if (restaurants == null) {
			res.setStatus(404);
		}

		return restaurants;

	}

	@GetMapping("restaurants/{id}")
	public Restaurant show(HttpServletResponse res, Principal principal, @PathVariable Integer id) {

		Restaurant restaurant = restaurantService.show(principal.getName(), id);
		if (restaurant == null) {
			res.setStatus(404);
		}
		return restaurant;

	}

	@PostMapping("restaurants")
	public Restaurant addRestaurant(HttpServletResponse res, HttpServletRequest req, Principal principal,
			@RequestBody Restaurant restaurant) {
		restaurant = restaurantService.create(principal.getName(), restaurant);
		if (restaurant == null) {
			res.setStatus(401);
		} else {
			res.setStatus(201);
		}
		return restaurant;

	}

	@PutMapping("restaurants/{id}")
	public Restaurant updateRestaurant(HttpServletResponse res, HttpServletRequest req, Principal principal,
			@RequestBody Restaurant restaurant, @PathVariable Integer id) {
		try {
			restaurant = restaurantService.update(principal.getName(), id, restaurant);
			res.setStatus(200);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			restaurant = null;
		}
		return restaurant;
	}

	@PutMapping("restaurants/delete/{id}")
	public void destroyRestaurant(HttpServletResponse res, HttpServletRequest req, Principal principal,
			@PathVariable Integer id) {
		
		try {
			if(restaurantService.destroy(principal.getName(), id)) {
				res.setStatus(204);
			}else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}

	}
	@PostMapping("restaurants/{id}/rate/{rating}")
	public RestaurantReviewRatings addRestaurantReviewRating(HttpServletResponse res, HttpServletRequest req, @PathVariable Integer id, @PathVariable Integer rating, Principal principal) {
		RestaurantReviewRatings restReviewRating = restaurantService.createRating(principal.getName(),id ,rating);
		return restReviewRating;
	}

}
