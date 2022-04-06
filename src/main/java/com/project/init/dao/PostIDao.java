package com.project.init.dao;

import java.util.ArrayList;

import com.project.init.dto.CommentsDto;
import com.project.init.dto.PostDto;
import com.project.init.dto.PostLikeDto;
import com.project.init.dto.PostViewDto;


public interface PostIDao {

	public PostDto write(PostDto dto);
	public ArrayList<PostDto> list(String email);
	public ArrayList<PostDto> getlist(String boardNum);
	public void deleteBoard(String boardNum);
	public void addLike(PostLikeDto dto);
	public String addView(PostViewDto dto);
	public ArrayList<PostDto> modifyList(String boardNum);
	public void modifyExcute(PostDto dto);
	public void addcomments(CommentsDto dto);
	public void addReplyComments(CommentsDto dto);
	public void deleteReplyComments(String commentNo);
	public ArrayList<CommentsDto> getcomments(String postNo);
	public ArrayList<PostDto> search(String keyword,String searchVal);
	
}
