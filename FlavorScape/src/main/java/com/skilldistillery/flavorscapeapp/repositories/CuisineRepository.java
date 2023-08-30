package com.skilldistillery.flavorscapeapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.Cuisine;

public interface CuisineRepository extends JpaRepository<Cuisine, Integer>{

	
}
