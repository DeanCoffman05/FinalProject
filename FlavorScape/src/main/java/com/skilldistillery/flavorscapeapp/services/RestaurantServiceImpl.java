package com.skilldistillery.flavorscapeapp.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.flavorscapeapp.entities.Menu;
import com.skilldistillery.flavorscapeapp.entities.MenuItem;
import com.skilldistillery.flavorscapeapp.entities.Restaurant;
import com.skilldistillery.flavorscapeapp.entities.User;
import com.skilldistillery.flavorscapeapp.repositories.AddressRepository;
import com.skilldistillery.flavorscapeapp.repositories.MenuItemRepository;
import com.skilldistillery.flavorscapeapp.repositories.MenuRepository;
import com.skilldistillery.flavorscapeapp.repositories.RestaurantRepository;
import com.skilldistillery.flavorscapeapp.repositories.UserRepository;

@Service
public class RestaurantServiceImpl implements RestaurantService {

	@Autowired
	private RestaurantRepository restaurantRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private AddressRepository addressRepo;

	@Autowired
	private MenuRepository menuRepo;

	@Autowired
	private MenuItemRepository menuItemRepo;

	@Override
	public List<Restaurant> index() {
		return restaurantRepo.findAll();
	}

	@Override
	public Restaurant show(String username, int restaurantId) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			Optional<Restaurant> restaurantOpt = restaurantRepo.findById(restaurantId);
			Restaurant restaurant = null;
			if (restaurantOpt.isPresent()) {
				restaurant = restaurantOpt.get();
			}
			return restaurant;
		}
		return null;
	}

	@Override
	public Restaurant create(String username, Restaurant restaurant) {
		User user = userRepo.findByUsername(username);
		if (user != null) {

			if (restaurant.getAddress() != null) {
				addressRepo.save(restaurant.getAddress());
			}
			restaurant.setEnabled(true);
			restaurantRepo.saveAndFlush(restaurant);
			return restaurant;
		}
		return null;
	}

	@Override
	public Restaurant update(String username, int restaurantId, Restaurant restaurant) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			Optional<Restaurant> optRestaurant = restaurantRepo.findById(restaurantId);
			if (optRestaurant.isPresent()) {
				Restaurant existingRestaurant = optRestaurant.get();
				existingRestaurant.setName(restaurant.getName());
				existingRestaurant.setDescription(restaurant.getDescription());
				existingRestaurant.getAddress().setStreet(restaurant.getAddress().getStreet());
				existingRestaurant.getAddress().setStreet2(restaurant.getAddress().getStreet2());
				existingRestaurant.getAddress().setCity(restaurant.getAddress().getCity());
				existingRestaurant.getAddress().setState(restaurant.getAddress().getState());
				existingRestaurant.getAddress().setZipcode(restaurant.getAddress().getZipcode());
				existingRestaurant.getAddress().setCountry(restaurant.getAddress().getCountry());

				return restaurantRepo.saveAndFlush(existingRestaurant);
			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int restaurantId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Restaurant> findCityByKeyword(String city) {
		return restaurantRepo.findByAddressCityOrAddressState(city, city);
	}

	@Override
	public List<Restaurant> findStateByKeyword(String state) {
		return restaurantRepo.findByAddressState(state);
	}

	@Override
	public List<MenuItem> createFavorite(String username, MenuItem menuItem) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			List<Menu> menus = getMenuForRestaurant(menuItem.getMenu().getRestaurant().getId());
			if (menus != null && !menus.isEmpty()) {
				for (Menu menu : menus) {
					menuItem.setMenu(menu);
					menuItemRepo.save(menuItem);
				}
				
				return getMenuItemsForRestaurant(menuItem.getMenu().getRestaurant().getId());
			}
		}
		return null;
	}

	public List<MenuItem> getMenuItemsForRestaurant(int restaurantId) {
		return menuItemRepo.findByMenu_RestaurantId(restaurantId);
	}

	public List<Menu> getMenuForRestaurant(int restaurantId) {
		Optional<Restaurant> restaurantOpt = restaurantRepo.findById(restaurantId);
		if (restaurantOpt.isPresent()) {
			Restaurant restaurant = restaurantOpt.get();
			return restaurant.getMenus();
		}
		return null;
	}

}
