package com.skilldistillery.flavorscapeapp.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

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
	 void test_restaurant_entity_manager() {
		 assertNotNull(restaurant);
		 assertNotNull(restaurant.getName());
		 assertEquals("Izakaya Den", restaurant.getName());
		 
	 }
	 
	 @Test
	 void test_restaurant_mapping_to_review() {
		 assertNotNull(restaurant.getRestaurantReviews());
		 assertTrue(restaurant.getRestaurantReviews().size() > 0);
		
	 }
	 @Test
	 void test_restaurant_to_users() {
		 assertNotNull(restaurant.getUsers());
		 assertTrue(restaurant.getUsers().size() > 0);
	 }
	 @Test
	 void test_restaurant_to_menu() {
		 assertNotNull(restaurant.getMenus());
		 assertTrue(restaurant.getUsers().size() > 0);
	 }
	 @Test
	 void test_restaurant_to_address() {
		 assertNotNull(restaurant.getAddress());
		 assertEquals("123",restaurant.getAddress().getStreet());
	 }
	 @Test
	 void test_restaurant_to_comments() {
		 assertNotNull(restaurant.getComments());
		 assertTrue(restaurant.getComments().size() > 0);
	 }
	 
}
