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

@Entity
@Table(name = "menu_item_review")
public class MenuItemReview {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int Id;
	private String contents;
	@Column(name = "item_taste")
	private String itemTaste;
	@Column(name = "item_price")
	private String itemPrice;
	private int rating;
	@Column(name = "create_date")
	private LocalDateTime createDate;
	@Column(name = "update_date")
	private LocalDateTime updateDate;
	private boolean enabled;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToOne
	@JoinColumn(name = "menu_item_id")
	private MenuItem menuItem;

	public MenuItemReview() {
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getItemTaste() {
		return itemTaste;
	}

	public void setItemTaste(String itemTaste) {
		this.itemTaste = itemTaste;
	}

	public String getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(String itemPrice) {
		this.itemPrice = itemPrice;
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

	public MenuItem getMenuItem() {
		return menuItem;
	}

	public void setMenuItem(MenuItem menuItem) {
		this.menuItem = menuItem;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		return Objects.hash(Id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MenuItemReview other = (MenuItemReview) obj;
		return Id == other.Id;
	}

	@Override
	public String toString() {
		return "MenuItemReview [Id=" + Id + ", contents=" + contents + ", itemTaste=" + itemTaste + ", itemPrice="
				+ itemPrice + ", rating=" + rating + ", createDate=" + createDate + ", updateDate=" + updateDate
				+ ", enabled=" + enabled + "]";
	}

}
