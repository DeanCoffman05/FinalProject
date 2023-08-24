package com.skilldistillery.flavorscapeapp.entities;

import java.time.LocalDateTime;
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

@Entity
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String content;
	@Column(name = "create_date")
	private LocalDateTime createDate;
	@Column(name = "update_date")
	private LocalDateTime updateDate;
	private boolean enabled;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToOne
	@JoinColumn(name = "restaurant_id")
	private Restaurant restaurant;

	@ManyToMany
	@JoinTable(name = "comment_upvote", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "comment_id"))
	private List<User> commentUpvotes;

	public void addUpvotedUser(User user) {
		if (commentUpvotes == null) {
			commentUpvotes = new ArrayList<>();
		}
		if (!commentUpvotes.contains(user)) {
			commentUpvotes.add(user);
			user.addUpvotedComment(this);
		}
	}

	public void removeUpvotedUser(User user) {
		if (commentUpvotes != null && commentUpvotes.contains(user)) {
			commentUpvotes.remove(user);
			user.removeUpvotedComment(this);
		}
	}

	public Comment() {
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

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public LocalDateTime getUpdateDate() {
		return updateDate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public void setUpdateDate(LocalDateTime updateDate) {
		this.updateDate = updateDate;
	}

	public Restaurant getRestaurant() {
		return restaurant;
	}

	public void setRestaurant(Restaurant restaurant) {
		this.restaurant = restaurant;
	}

	public List<User> getCommentUpvotes() {
		return commentUpvotes;
	}

	public void setCommentUpvotes(List<User> commentUpvotes) {
		this.commentUpvotes = commentUpvotes;
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
		Comment other = (Comment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Comment [Id=" + id + ", content=" + content + ", createDate=" + createDate + ", updateDate="
				+ updateDate + ", enabled=" + enabled + "]";
	}

}
