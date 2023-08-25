package com.skilldistillery.flavorscapeapp.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.flavorscapeapp.entities.User;
import com.skilldistillery.flavorscapeapp.services.UserProfileService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class UserProfileController {

	@Autowired
	private UserProfileService userProfileService;
	
	@GetMapping("users/profiles")
	public User showUser(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		User user = userProfileService.showLoggedInUser(principal.getName());
		if(user == null) {
			res.setStatus(404);
		}
		return user;
	}

	@PutMapping("users/profiles")
	public User updateProfile(Principal principal, HttpServletRequest req, HttpServletResponse res
		, @RequestBody User user) {
		try {
			user = userProfileService.userUpdate(principal.getName(), user);
			if(user == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			user = null;
		}
		return user;

	}

}
