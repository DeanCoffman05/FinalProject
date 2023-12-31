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

class AddressTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Address address;

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
	  address = em.find(Address.class, 1);
	 }

	 @AfterEach
	 void tearDown() throws Exception {
	  em.close();
	  address = null;
	 }

	@Test
	void test() {
		assertNotNull(address);
		assertNotNull(address.getCity());
		assertEquals("Denver", address.getCity());
	}
	

	
	@Test
	void test_mapping_address_to_restaurant() {
		assertNotNull(address);
		assertNotNull(address.getRestaurant());
		assertEquals("Izakaya Den", address.getRestaurant().getName());

	}

}
