package com.skilldistillery.flavorscapeapp.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="restaurant_review_ratings")
public class RestaurantReviewRatings {

	
	
	private int rating; 
	@Column(name = "create_date")
	@CreationTimestamp
	private LocalDateTime createDate; 
	@Column(name = "update_date")
	@UpdateTimestamp
	private LocalDateTime updateDate;
	
	@EmbeddedId
	private RestaurantReviewRatingId id;
	
	public RestaurantReviewRatings() {
		super();
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
	public RestaurantReviewRatingId getId() {
		return id;
	}
	public void setId(RestaurantReviewRatingId id) {
		this.id = id;
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
		RestaurantReviewRatings other = (RestaurantReviewRatings) obj;
		return Objects.equals(id, other.id);
	}
	@Override
	public String toString() {
		return "RestaurantReviewRatings [rating=" + rating + ", createDate=" + createDate + ", updateDate=" + updateDate
				+ "]";
	}
	
	
}
