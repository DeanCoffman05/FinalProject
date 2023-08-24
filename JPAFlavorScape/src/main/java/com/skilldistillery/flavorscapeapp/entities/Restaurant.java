package com.skilldistillery.flavorscapeapp.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
@Entity
public class Restaurant {
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; 
	private String content; 
	private LocalDateTime createDate; 
	private LocalDateTime updateDate;
	private boolean enabled;
	
	@OneToOne
	@JoinColumn (name = "address_id")
	private Address address;
	
	@OneToMany(mappedBy ="restaurant")
	private List<Comment> comments;
	
	public Restaurant() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getCreate_date() {
		return createDate;
	}
	public void setCreate_date(LocalDateTime create_date) {
		this.createDate = create_date;
	}
	public LocalDateTime getUpdate_date() {
		return updateDate;
	}
	public void setUpdate_date(LocalDateTime update_date) {
		this.updateDate = update_date;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
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
		Restaurant other = (Restaurant) obj;
		return id == other.id;
	}
	@Override
	public String toString() {
		return "Restaurant [id=" + id + ", content=" + content + ", createDate=" + createDate + ", updateDate="
				+ updateDate + ", enabled=" + enabled + "]";
	}


	
	
}
