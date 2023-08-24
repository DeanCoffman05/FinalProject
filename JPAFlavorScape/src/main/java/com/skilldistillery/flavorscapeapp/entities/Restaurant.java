package com.skilldistillery.flavorscapeapp.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

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
	private String content;
	private LocalDateTime createDate;
	private LocalDateTime updateDate;
	private boolean enabled;

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCreate_date() {
		return createDate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public LocalDateTime getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(LocalDateTime updateDate) {
		this.updateDate = updateDate;
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

	@Override
	public String toString() {
		return "Restaurant [id=" + id + ", content=" + content + ", createDate=" + createDate + ", updateDate="
				+ updateDate + ", enabled=" + enabled + "]";
	}

}
