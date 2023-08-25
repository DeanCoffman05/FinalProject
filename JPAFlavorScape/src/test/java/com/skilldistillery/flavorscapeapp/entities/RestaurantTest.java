package com.skilldistillery.flavorscapeapp.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class RestaurantTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Restaurant restaurant;
	private 

	@BeforeAll
	 static void setUpBeforeClass() throws Exception {
	  emf = Persistence.createEntityManagerFactory("JPAFlavorScape");
	 }

	 @AfterAll
	 static void tearDownAfterClass() throws Exception {
	  emf.close();
	 }

	 @BeforeEach
	 void setUp() throws Exception {
	  em  = emf.createEntityManager();
	  restaurant = em.find(Restaurant.class, 1);
	 }

	 @AfterEach
	 void tearDown() throws Exception {
	  em.close();
	  restaurant= null;
	 }
	 
	 @Test
	 void test_restaurant_entity() {
		 assertNotNull(restaurant);
		 assertNotNull(restaurant.getName());
		 assertEquals("jacobs seafood shack", restaurant.getName());
		 
	 }
	 
	 @Test
	 void test_restuarant_mapping() {
		 assertNotNull();
		 assertNotNull(restaurant.);
	 }

}
