package com.skilldistillery.flavorscapeapp.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class RestaurantReviewtest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private RestaurantReview restaurantReview;

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
	  restaurantReview = em.find(RestaurantReview.class, 1);
	 }

	 @AfterEach
	 void tearDown() throws Exception {
	  em.close();
	  restaurantReview = null;
	 }
	 
	 @Test
	 void test_RestaurantReview_entity_manager() {
		 assertNotNull(restaurantReview);
		 assertEquals("spicy", restaurantReview.getSmell());
	 }
	 @Test
	 void test_RestaurantReview_touser_manager() {
		 assertNotNull(restaurantReview.getUser());
		 assertEquals("admin", restaurantReview.getUser().getUsername());
	 }
	 @Test
	 void test_RestaurantReview_toRestaurant_manager() {
		 assertNotNull(restaurantReview.getRestaurant());
		 assertEquals("jacobs seafood shack", restaurantReview.getRestaurant().getName());
	 }
}
