package com.skilldistillery.flavorscapeapp.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table (name = "restaurant_review")
public class RestaurantReview {

	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; 
	@Column(name="image_url")
	private String imageUrl;
	private String atmosphere; 
	private String smell; 
	private String service; 
	private String price; 
	private String food;
	private int rating; 
	@Column(name = "create_date")
	@CreationTimestamp
	private LocalDateTime createDate; 
	@Column(name = "update_date")
	@UpdateTimestamp
	private LocalDateTime updateDate;
	private boolean enabled;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user; 
	
	@ManyToOne
	@JoinColumn (name = "restaurant_id")
	@JsonIgnoreProperties({"restaurantReviews", "users", "menu", "address", "comments"})
	private Restaurant restaurant;
	
	public RestaurantReview() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getAtmosphere() {
		return atmosphere;
	}

	public void setAtmosphere(String atmosphere) {
		this.atmosphere = atmosphere;
	}

	public String getSmell() {
		return smell;
	}

	public void setSmell(String smell) {
		this.smell = smell;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getFood() {
		return food;
	}

	public void setFood(String food) {
		this.food = food;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
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

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Restaurant getRestaurant() {
		return restaurant;
	}

	public void setRestaurant(Restaurant restaurant) {
		this.restaurant = restaurant;
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
		RestaurantReview other = (RestaurantReview) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "RestaurantReview [id=" + id + ", imageUrl=" + imageUrl + ", atmosphere=" + atmosphere + ", smell="
				+ smell + ", service=" + service + ", price=" + price + ", food=" + food + ", rating=" + rating
				+ ", createDate=" + createDate + ", updateDate=" + updateDate + ", enabled=" + enabled + "]";
	} 
	
	
	
}
