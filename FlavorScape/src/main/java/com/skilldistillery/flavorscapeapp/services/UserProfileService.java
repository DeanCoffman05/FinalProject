package com.skilldistillery.flavorscapeapp.services;

import com.skilldistillery.flavorscapeapp.entities.User;

public interface UserProfileService {

	public User showLoggedInUser (String username);
	public User userUpdate(String username, User user);
	public boolean userDelete(String username);
}
