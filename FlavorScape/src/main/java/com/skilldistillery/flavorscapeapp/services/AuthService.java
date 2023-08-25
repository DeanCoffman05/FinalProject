package com.skilldistillery.flavorscapeapp.services;

import com.skilldistillery.flavorscapeapp.entities.Address;
import com.skilldistillery.flavorscapeapp.entities.User;

public interface AuthService {
public User register(User user);
public User getUserByUsername(String username);
	
}
