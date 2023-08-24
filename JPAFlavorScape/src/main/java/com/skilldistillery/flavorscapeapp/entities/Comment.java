package com.skilldistillery.flavorscapeapp.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Comment {
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private int Id; 
	private String content; 
	@Column (name ="create_date")
	private LocalDateTime createDate; 
	@Column (name ="update_date")
	private LocalDateTime updateDate; 
	private boolean enabled;
	public Comment() {
		super();
	}
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getCreateDate() {
		return createDate;
	}
	public void setCreate_date(LocalDateTime create_date) {
		this.createDate = createDate;
	}
	public LocalDateTime getUpdateDate() {
		return updateDate;
	}
	public void setUpdate_date(LocalDateTime update_date) {
		this.updateDate = updateDate;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
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
		Comment other = (Comment) obj;
		return Id == other.Id;
	}
	@Override
	public String toString() {
		return "Comment [Id=" + Id + ", content=" + content + ", createDate=" + createDate + ", updateDate="
				+ updateDate + ", enabled=" + enabled + "]";
	}
	
	
	
	
}
