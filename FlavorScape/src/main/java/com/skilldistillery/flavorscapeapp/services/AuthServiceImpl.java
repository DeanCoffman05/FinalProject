package com.skilldistillery.flavorscapeapp.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.Address;
import com.skilldistillery.flavorscapeapp.entities.User;
import com.skilldistillery.flavorscapeapp.repositories.AddressRepository;
import com.skilldistillery.flavorscapeapp.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private AddressRepository addressRepo;

	@Autowired
	private PasswordEncoder encoder;

	@Override
	public User register(User user) {
		if (user.getAddress() != null) {
			addressRepo.save(user.getAddress());
		}
		System.out.println(user + "*************");
		System.out.println(user.getAddress() + "*************");
		user.setEnabled(true);
		user.setRole("standard");
		String encrypted = encoder.encode(user.getPassword());
		user.setPassword(encrypted);
		userRepo.saveAndFlush(user);
		return user;
	}

	@Override
	public User getUserByUsername(String username) {

		return userRepo.findByUsername(username);
	}

}
