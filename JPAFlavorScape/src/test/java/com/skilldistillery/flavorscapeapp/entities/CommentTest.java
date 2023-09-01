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

class CommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;

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
	  comment = em.find(Comment.class, 1);
	 }

	 @AfterEach
	 void tearDown() throws Exception {
	  em.close();
	  comment = null;
	 }

	@Test
	void test() {
		assertNotNull(comment);	
	}
	
	@Test
	void test_mapping_comments_to_upvotes() {
		assertNotNull(comment);	
		assertNotNull(comment.getCommentUpvotes());
		assertTrue(comment.getCommentUpvotes().size() > 0);
	}
	
	@Test
	void test_mapping_comments_to_restaurant() {
		assertNotNull(comment);	
		assertNotNull(comment.getRestaurant());
		assertEquals("Izakaya Den", comment.getRestaurant().getName());
	}
	
	@Test
	void test_mapping_comments_to_user() {
		assertNotNull(comment);	
		assertNotNull(comment.getUser());
		assertEquals("John", comment.getUser().getFirstName());
	}

}
