package com.skilldistillery.flavorscapeapp.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Restaurant {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	@Column(name = "restaurant_url")
	private String restaurantUrl;
	@Column(name = "image_url")
	private String imageUrl;
	@Column(name = "phone_number")
	private String phoneNumber;
	private String description;
	boolean enabled;

	@OneToMany(mappedBy = "restaurant")
	private List<RestaurantReview> restaurantReviews;

	@ManyToMany
	@JoinTable(name = "user_favorite_restaurant", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "restaurant_id"))
	private List<User> users;

	@OneToMany(mappedBy = "restaurant")
	private List<Menu> menus;

	@OneToOne
	@JoinColumn(name = "address_id")
	private Address address;

	@OneToMany(mappedBy = "restaurant")
	private List<Comment> comments;

	public void addMenu(Menu menu) {
		if (menus == null) {
			menus = new ArrayList<>();
		}
		if (!menus.contains(menu)) {
			menus.add(menu);
			menu.setRestaurant(this);
		}
	}

	public void removeMenu(Menu menu) {
		if (menus != null && menus.contains(menu)) {
			menus.remove(menu);
			menu.setRestaurant(null);
		}
	}

	public void addUser(User user) {
		if (users == null) {
			users = new ArrayList<>();
		}
		if (!users.contains(user)) {
			users.add(user);
			user.addRestaurant(this);
		}
	}

	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removeRestaurants(this);
		}
	}

	public Restaurant() {
		super();
	

}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRestaurantUrl() {
		return restaurantUrl;
	}

	public void setRestaurantUrl(String restaurantUrl) {
		this.restaurantUrl = restaurantUrl;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	

	public List<RestaurantReview> getRestaurantReviews() {
		return restaurantReviews;
	}

	public void setRestaurantReviews(List<RestaurantReview> restaurantReviews) {
		this.restaurantReviews = restaurantReviews;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<Menu> getMenus() {
		return menus;
	}

	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	@Override
	public String toString() {
		return "Restaurant [id=" + id + ", name=" + name + ", restaurantUrl=" + restaurantUrl + ", imageUrl=" + imageUrl
				+ ", phoneNumber=" + phoneNumber + ", description=" + description + ", enabled=" + enabled + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Restaurant other = (Restaurant) obj;
		return id == other.id;
	}
	
}
