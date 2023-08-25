package com.skilldistillery.flavorscapeapp.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.User;
import com.skilldistillery.flavorscapeapp.repositories.UserRepository;

@Service
public class UserProfileServiceImpl implements UserProfileService {

	@Autowired
	private UserRepository userRepo;

	@Override
	public User showLoggedInUser(String username) {
		User user = userRepo.findByUsername(username);
		return user;
	}
	
	
	
	

	@Override
	public User userUpdate(String username, User user) {
		User existingUser = userRepo.findByUsername(username);
		if (existingUser != null) {
			existingUser.setFirstName(user.getFirstName());
			existingUser.setLastName(user.getLastName());
			existingUser.setAboutMe(user.getAboutMe());
			existingUser.setEmail(user.getEmail());
			existingUser.setImageUrl(user.getImageUrl());
			return userRepo.saveAndFlush(existingUser);
		}

		return null;
	}

	@Override
	public boolean userDelete(String username, int userId) {
		// TODO Auto-generated method stub
		return false;
	}

}
