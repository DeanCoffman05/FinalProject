package com.skilldistillery.flavorscapeapp.entities;

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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table (name = "menu_item")
public class MenuItem {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int Id; 
	@Column (name ="item_name")
	private  String itemName; 
	@Column (name ="item_url")
	private  String itemUrl; 
	private  Double price; 
	private  String description;
	private  int calories;
	private boolean enabled;
	


	
	@OneToMany(mappedBy = "menuItem")
	private  List<MenuItemReview> menuItemReviews;
	
	@ManyToOne
	@JoinColumn(name = "menu_id")
	private Menu menu;
	
	@ManyToMany(mappedBy = "menuItems")
	private List<Cuisine> cuisines; 
	
	public void addCuisine(Cuisine cuisine) {
		if (cuisines == null) { cuisines = new ArrayList<>();}
		if (! cuisines.contains(cuisine)) {
			cuisines.add(cuisine);
			cuisine.addMenuItem(this);
			}
		}
	
	public void removeCuisine(Cuisine cuisine) {
		if (cuisines != null && cuisines.contains(cuisine)) {
			cuisines.remove(cuisine);
			cuisine.removeMenuItem(this);
		}
	}
	
	
	public MenuItem() {
		super();
	}
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemUrl() {
		return itemUrl;
	}
	public void setItemUrl(String itemUrl) {
		this.itemUrl = itemUrl;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCalories() {
		return calories;
	}
	public void setCalories(int calories) {
		this.calories = calories;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public List<MenuItemReview> getMenuItemReviews() {
		return menuItemReviews;
	}

	public void setMenuItemReviews(List<MenuItemReview> menuItemReviews) {
		this.menuItemReviews = menuItemReviews;
	}

	public List<Cuisine> getCuisines() {
		return cuisines;
	}

	public void setCuisines(List<Cuisine> cuisines) {
		this.cuisines = cuisines;
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
		MenuItem other = (MenuItem) obj;
		return Id == other.Id;
	}
	@Override
	public String toString() {
		return "MenuItem [Id=" + Id + ", itemName=" + itemName + ", itemUrl=" + itemUrl + ", price=" + price
				+ ", description=" + description + ", calories=" + calories + ", enabled=" + enabled + "]";
	} 
	
	
}
