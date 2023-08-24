package com.skilldistillery.flavorscapeapp.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class MenuItemReviewRatingId implements Serializable {
	private static final long serialVersionUID = 1L;
	

	@Column(name = "user_id")
	private int userId; 
	
	@Column(name = "menu_item_review_id")
	private int menuItemReivewId;

	
	public MenuItemReviewRatingId() {
		super();
	}
	
	
	
	public MenuItemReviewRatingId(int userId, int menuItemReivewId) {
		super();
		this.userId = userId;
		this.menuItemReivewId = menuItemReivewId;
	}



	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getMenuItemReivewId() {
		return menuItemReivewId;
	}

	public void setMenuItemReivewId(int menuItemReivewId) {
		this.menuItemReivewId = menuItemReivewId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(menuItemReivewId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MenuItemReviewRatingId other = (MenuItemReviewRatingId) obj;
		return menuItemReivewId == other.menuItemReivewId && userId == other.userId;
	}
	
	
	
}
