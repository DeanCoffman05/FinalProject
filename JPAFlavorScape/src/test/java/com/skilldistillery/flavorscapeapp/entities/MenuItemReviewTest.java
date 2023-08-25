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

class MenuItemReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private MenuItemReview menuItemReview;

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
	  menuItemReview = em.find(MenuItemReview.class, 1);
	 }

	 @AfterEach
	 void tearDown() throws Exception {
	  em.close();
	  menuItemReview = null;
	 }
	 
	 @Test
	 void test_menuItemReviewRating_get_year_review_made() {
		 assertNotNull(menuItemReview);
		 assertNotNull(menuItemReview.getContents());
		 assertEquals("yay food", menuItemReview.getContents());
	 }

}
