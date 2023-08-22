package com.skilldistillery.flavorscapeapp.security;

import com.skilldistillery.flavorscapeapp.entities.User;

public interface AuthService {
public User register(User user);
public User getUserByUsername(String username);
	
}
