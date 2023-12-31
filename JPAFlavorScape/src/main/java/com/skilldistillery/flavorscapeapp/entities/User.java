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
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String username;
	private String password;
	private boolean enabled;
	private String role;
	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	private String email;
	@Column(name = "image_url")
	private String imageUrl;
	@Column(name = "about_me")
	private String aboutMe;
	@Column(name = "create_date")
	@CreationTimestamp
	private LocalDateTime createDate;
	private String latitude;
	private String longitude;

	@OneToMany(mappedBy = "user")
	@JsonIgnoreProperties(value = {"user"})
	private List<RestaurantReview> restaurantReviews;

	@ManyToMany(mappedBy = "users")
	private List<Restaurant> restaurants;

	@OneToMany(mappedBy = "user")
	@JsonIgnore
	private List<MenuItemReview> menuItemReviews;

	@OneToOne
	@JoinColumn(name = "address_id")
	private Address address;

	@OneToMany(mappedBy = "user")
	@JsonIgnore
	private List<Comment> comments;

	@ManyToMany(mappedBy = "commentUpvotes")
	@JsonIgnore
	private List<Comment> upvotedComments;

	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public List<RestaurantReview> getRestaurantReviews() {
		return restaurantReviews;
	}

	public void setRestaurantReviews(List<RestaurantReview> restaurantReviews) {
		this.restaurantReviews = restaurantReviews;
	}

	public List<Restaurant> getRestaurants() {
		return restaurants;
	}

	public void setRestaurants(List<Restaurant> restaurants) {
		this.restaurants = restaurants;
	}

	public List<MenuItemReview> getMenuItemReviews() {
		return menuItemReviews;
	}

	public void setMenuItemReviews(List<MenuItemReview> menuItemReviews) {
		this.menuItemReviews = menuItemReviews;
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

	public List<Comment> getUpvotedComments() {
		return upvotedComments;
	}

	public void setUpvotedComments(List<Comment> upvotedComments) {
		this.upvotedComments = upvotedComments;
	}
	

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	public void addComments(Comment comment) {
		if (comments == null) {
			comments = new ArrayList<>();
		}
		if (!comments.contains(comment)) {
			comments.add(comment);
			comment.setUser(this);
		}
	}

	public void removeComment(Comment comment) {
		if (comments != null && comments.contains(comment)) {
			comments.remove(comment);
			comment.setUser(null);
		}
	}

	public void addRestaurant(Restaurant restaurant) {
		if (restaurants == null) {
			restaurants = new ArrayList<>();
		}
		if (!restaurants.contains(restaurant)) {
			restaurants.add(restaurant);
			restaurant.addUser(this);
		}
	}

	public void removeRestaurants(Restaurant restaurant) {
		if (restaurants != null && restaurants.contains(restaurant)) {
			restaurants.remove(restaurant);
			restaurant.removeUser(this);
		}
	}

	public void addUpvotedComment(Comment comment) {
		if (upvotedComments == null) {
			upvotedComments = new ArrayList<>();
		}
		if (!upvotedComments.contains(comment)) {
			upvotedComments.add(comment);
			comment.addUpvotedUser(this);
		}
	}

	public void removeUpvotedComment(Comment comment) {
		if (upvotedComments != null && upvotedComments.contains(comment)) {
			upvotedComments.remove(comment);
			comment.removeUpvotedUser(this);
		}
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", imageUrl=" + imageUrl + ", aboutMe=" + aboutMe + ", createDate=" + createDate + "]";
	}

}
