package com.whereru.main.BoardDTO;

import java.sql.Timestamp;

public class CommentsDTO {
	private String commentNo; //시퀀스 증가
	private String postNo; //게시물 번호
	private String email; //useremail
	private String content; //내용
	private Timestamp time;//시간
	private int likes;//업 횟
	private int reply;
	private int grp;
	private int grpl;
	private int grps;
	
	public CommentsDTO(String commentNo, String postNo, String email, String content, Timestamp time, int likes,
			int reply, int grp, int grpl, int grps) {
		super();
		this.commentNo = commentNo;
		this.postNo = postNo;
		this.email = email;
		this.content = content;
		this.time = time;
		this.likes = likes;
		this.reply = reply;
		this.grp = grp;
		this.grpl = grpl;
		this.grps = grps;
	}
	
	
	public CommentsDTO() {
		super();
	}


	public CommentsDTO(String postNo, int grp, String content) {
		super();
		this.postNo = postNo;
		this.content = content;
		this.grp = grp;
	}

	public CommentsDTO(String postNo, String content,int grpl) {
		super();
		this.postNo = postNo;
		this.content = content;
		this.grpl = grpl;
	}
	public int getReply() {
		return reply;
	}
	public String getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getGrpl() {
		return grpl;
	}
	public void setGrpl(int grpl) {
		this.grpl = grpl;
	}
	public int getGrps() {
		return grps;
	}
	public void setGrps(int grps) {
		this.grps = grps;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
	
	
	

	
	
}
