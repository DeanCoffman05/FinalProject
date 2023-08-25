package com.skilldistillery.flavorscapeapp.services;

import com.skilldistillery.flavorscapeapp.entities.User;

public interface UserProfileService {

	public User userUpdate(String username, int userId, User user);
	public boolean userDelete(String username, int userId);
}
