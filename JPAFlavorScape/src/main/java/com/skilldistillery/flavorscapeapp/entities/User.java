package com.skilldistillery.flavorscapeapp.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String username;
	private String password;
	private boolean enabled;
	private String role;
	
	@OneToOne
	@JoinColumn (name = "address_id")
	private Address address;
	
	@OneToMany(mappedBy ="user")
	private List<Comment> comments;
	
	@ManyToMany(mappedBy = "commentUpvotes")
	private List<Comment> upvotedComments;
	
	public void addUpvotedComment(Comment comment) {
		if (upvotedComments == null) { upvotedComments = new ArrayList<>();}
		if (! upvotedComments.contains(comment)) {
			upvotedComments.add(comment);
			comment.addUpvotedUser(this);
		}
	}
	
	public void removeUpvotedComment (Comment comment) {
		if (upvotedComments != null && upvotedComments.contains(comment)) {
			upvotedComments.remove(comment);
			comment.removeUpvotedUser(this);
		}
	}
	
	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Comment> getUpvotedComments() {
		return upvotedComments;
	}

	public void setUpvotedComments(List<Comment> upvotedComments) {
		this.upvotedComments = upvotedComments;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + "]";
	}

}
