package com.skilldistillery.flavorscapeapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.Address;

public interface AddressRepository extends JpaRepository<Address, Integer> {
	
}
