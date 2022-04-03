package com.whereru.main.BoardDAO;

import java.util.ArrayList;

import com.whereru.main.BoardDTO.CommentsDTO;
import com.whereru.main.BoardDTO.MainDTO;

public interface InterfaceBoardDAO {
	
	
	
	public MainDTO write(MainDTO dto);
	public ArrayList<MainDTO> list();
	public ArrayList<MainDTO> getlist(String boardNum);
	public void deleteBoard(String boardNum);
	public void addLike(String postNo);
	public void deleteLike(String postNo);
	public ArrayList<MainDTO> modifyList(String boardNum);
	public void modifyExcute(MainDTO dto);
	public void addcomments(CommentsDTO dto);
	public void addReplyComments(CommentsDTO dto);
	public void deleteReplyComments(String commentNo);
	public ArrayList<CommentsDTO> getcomments(String postNo);
	public ArrayList<MainDTO> search(String keyword,String searchVal);
	
}
