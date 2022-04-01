package com.whereru.main.BoardDTO;

import java.sql.Timestamp;

public class MainDTO {
	private String postNo;
	private String email;
	private String plan;
	private String titleImage;
	private String images;
	private String title;
	private String content;
	private String hashtag;
	private Timestamp regDate;
	private String location;
	private int views;
	private int comments;
	private int likes;
	private String authority;

	public MainDTO() {
		super();
	}


	public MainDTO(String postNo,String content,String hashtag,String location,String titleImage,String images) {
		super();
		this.postNo = postNo;
		this.titleImage = titleImage;
		this.images = images;
		this.content = content;
		this.location = location;
		this.hashtag = hashtag;
		
	}
	
	public MainDTO(String content,String hashtag, String location,String titleImage,String images) {
		super();
		this.hashtag = hashtag;
		this.titleImage = titleImage;
		this.images = images;
		this.content = content;
		this.location = location;
		
	}



	public int getLikes() {
		return likes;
	}


	public void setLikes(int likes) {
		this.likes = likes;
	}


	public int getComments() {
		return comments;
	}


	public void setComments(int comments) {
		this.comments = comments;
	}


	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPlan() {
		return plan;
	}

	public void setPlan(String plan) {
		this.plan = plan;
	}


	public String getTitleImage() {
		return titleImage;
	}

	public void setTitleImage(String titleImage) {
		this.titleImage = titleImage;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	
}