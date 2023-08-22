package com.skilldistillery.flavorscapeapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findByUsername(String username);

}
