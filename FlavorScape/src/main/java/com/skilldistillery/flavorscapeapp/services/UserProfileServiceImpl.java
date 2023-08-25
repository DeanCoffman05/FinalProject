package com.skilldistillery.flavorscapeapp.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.User;
import com.skilldistillery.flavorscapeapp.repositories.UserRepository;

@Service
public class UserProfileServiceImpl implements UserProfileService {

	@Autowired
	private UserRepository userRepo;

	@Override
	public User userUpdate(String username, int userId, User user) {
		User managedUser = userRepo.findByUsername(username);
		if (managedUser != null) {
			Optional<User> optUser = userRepo.findById(userId);
			if (optUser.isPresent()) {
				User existingUser = optUser.get();
				if (existingUser.getId() == user.getId()) {
					existingUser.setFirstName(user.getFirstName());
					existingUser.setLastName(user.getLastName());
					existingUser.setAboutMe(user.getAboutMe());
					existingUser.setEmail(user.getEmail());
					existingUser.setImageUrl(user.getImageUrl());
					existingUser.setUsername(user.getUsername());
					existingUser.setPassword(user.getPassword());
					return userRepo.saveAndFlush(existingUser);
				}
			}
		}

		return null;
	}

	@Override
	public boolean userDelete(String username, int userId) {
		// TODO Auto-generated method stub
		return false;
	}

}
