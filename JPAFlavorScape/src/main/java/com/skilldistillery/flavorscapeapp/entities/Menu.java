	package com.skilldistillery.flavorscapeapp.entities;

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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Menu {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String type; 
	private boolean enabled; 
	private String description;
	
	
	@OneToMany(mappedBy = "menu")
	private List<MenuItem> menuItems;
	
	
	public void addMenuItem(MenuItem menuItem) {
		if (menuItems == null) {
			menuItems = new ArrayList<>();
		}
		if (!menuItems.contains(menuItem)) {
			menuItems.add(menuItem);
			menuItem.setMenu(this);
		}
	}

	public void removeMenuItem(MenuItem menuItem) {
		if (menuItems != null && menuItems.contains(menuItem)) {
			menuItems.remove(menuItem);
			menuItem.setMenu(null); // Does this delete the entire menu?
		}
	}
	
	
	@ManyToOne
	@JoinColumn(name = "restaurant_id")
	private Restaurant restaurant; 
	
	public Menu() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
	public List<MenuItem> getMenuItems() {
		return menuItems;
	}
	public void setMenuItems(List<MenuItem> menuItems) {
		this.menuItems = menuItems;
	}
	public Restaurant getRestaurant() {
		return restaurant;
	}
	public void setRestaurant(Restaurant restaurant) {
		this.restaurant = restaurant;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Menu other = (Menu) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "Menu [id=" + id + ", type=" + type + ", enabled=" + enabled + ", description=" + description + "]";
	} 

	
	

}
