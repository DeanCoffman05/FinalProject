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

@Entity
public class Cuisine {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String type;
	private String description;
	@Column(name = "icon_url")
	private String iconUrl;

	@ManyToMany
	@JoinTable(name = "menu_item_has_cuisine", joinColumns = @JoinColumn(name = "menu_item_id"), inverseJoinColumns = @JoinColumn(name = "cuisine_id"))
	private List<MenuItem> menuItems;

	public void addMenuItem(MenuItem menuItem) {
		if (menuItems == null) {
			menuItems = new ArrayList<>();
		}
		if (!menuItems.contains(menuItem)) {
			menuItems.add(menuItem);
			menuItem.addCuisine(this);

		}

	}

	public void removeMenuItem(MenuItem menuItem) {
		if (menuItems != null && menuItems.contains(menuItem)) {
			menuItems.remove(menuItem);
			menuItem.removeCuisine(this);
		}
	}

	public Cuisine() {
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIconUrl() {
		return iconUrl;
	}

	public void setIcon_url(String icon_url) {
		this.iconUrl = iconUrl;
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
		Cuisine other = (Cuisine) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Cuisine [id=" + id + ", type=" + type + ", description=" + description + ", iconUrl=" + iconUrl + "]";
	}

}
