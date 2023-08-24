package com.skilldistillery.flavorscapeapp.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
@Embeddable
public class RestaurantReviewRatingId implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Column(name = "user_id")
	private int userId;
	@Column(name = "restaurant_review_rating")
	private int restaurantRatingReviewId;
	
	
	public RestaurantReviewRatingId() {
		super();
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getRestaurantRatingReviewId() {
		return restaurantRatingReviewId;
	}
	public void setRestaurantRatingReviewId(int restaurantRatingReviewId) {
		this.restaurantRatingReviewId = restaurantRatingReviewId;
	}
	public static long getSerailversionuid() {
		return serialVersionUID;
	}
	@Override
	public int hashCode() {
		return Objects.hash(restaurantRatingReviewId, userId);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RestaurantReviewRatingId other = (RestaurantReviewRatingId) obj;
		return restaurantRatingReviewId == other.restaurantRatingReviewId && userId == other.userId;
	}
	@Override
	public String toString() {
		return "RestaurantReviewRatingId [userId=" + userId + ", restaurantRatingReviewId=" + restaurantRatingReviewId
				+ "]";
	}
	
	

}
