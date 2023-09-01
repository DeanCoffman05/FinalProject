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

class CuisineTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Cuisine cuisine;

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
	  cuisine = em.find(Cuisine.class, 1);
	 }

	 @AfterEach
	 void tearDown() throws Exception {
	  em.close();
	  cuisine = null;
	 }

	@Test
	void test() {
		assertNotNull(cuisine);
		assertNotNull(cuisine.getType());
		assertEquals("Dessert", cuisine.getType());
	}
	
	@Test
	void test_mapping_cuisine_to_menue_items() {
		assertNotNull(cuisine);
		assertNotNull(cuisine.getMenuItems().size() > 0);
	}
	

}
