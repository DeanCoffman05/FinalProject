package com.skilldistillery.flavorscapeapp.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "menu_item_review_rating")
public class MenuItemReviewRating {

	@EmbeddedId
	private MenuItemReviewRatingId id;


	@Column(name = "create_date")
	private LocalDateTime createDate;
	@Column(name = "update_date")
	private LocalDateTime updateDate;
	private int rating;

	public MenuItemReviewRating() {
		super();
	}
	
	

	public MenuItemReviewRatingId getId() {
		return id;
	}


	public void setId(MenuItemReviewRatingId id) {
		this.id = id;
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

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	@Override
	public int hashCode() {
		return Objects.hash(rating);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if ((obj == null) || (getClass() != obj.getClass()))
			return false;
		MenuItemReviewRating other = (MenuItemReviewRating) obj;
		return rating == other.rating;
	}

	@Override
	public String toString() {
		return "MenuItemReviewRating [createDate=" + createDate + ", updateDate=" + updateDate + ", rating=" + rating
				+ "]";
	}

}
