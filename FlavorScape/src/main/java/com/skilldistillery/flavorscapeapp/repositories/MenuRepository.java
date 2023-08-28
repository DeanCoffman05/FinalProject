package com.skilldistillery.flavorscapeapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.flavorscapeapp.entities.Menu;

public interface MenuRepository extends JpaRepository<Menu, Integer> {

}
