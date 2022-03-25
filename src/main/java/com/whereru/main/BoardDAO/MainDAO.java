package com.whereru.main.BoardDAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.whereru.main.BoardDTO.CommentsDTO;
import com.whereru.main.BoardDTO.MainDTO;

public class MainDAO implements InterfaceBoardDAO{
	
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public MainDTO write(MainDTO dto) {
		sqlSession.insert("write", dto);
		return null;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public ArrayList<MainDTO> list() {
		ArrayList<MainDTO> list =  (ArrayList)sqlSession.selectList("list");
		
		return list;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public ArrayList<MainDTO> getlist(String postNo) {
		ArrayList<MainDTO> dto = (ArrayList)sqlSession.selectList("getlist",postNo);
		
		return dto;
	}

	@Override
	public void deleteBoard(String postNo) {
		sqlSession.delete("deleteBoard", postNo);
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public ArrayList<MainDTO> modifyList(String postNo) {
		ArrayList<MainDTO> list =  (ArrayList)sqlSession.selectList("modifyList",postNo);
		
		return list;
	}

	@Override
	public void modifyExcute(MainDTO dto) {
		sqlSession.update("modifyExcute", dto);
	}

	@Override
	public void addcomments(CommentsDTO dto) {
		sqlSession.insert("addcomments", dto);
	}
	
	
	@Override
	public void addReplyComments(CommentsDTO dto) {
		sqlSession.update("beforeAddReply", dto);
		sqlSession.insert("addReplyComments", dto);
	}

	@Override
	public ArrayList<CommentsDTO> getcomments(String postNo) {
		ArrayList<CommentsDTO> dto =(ArrayList)sqlSession.selectList("getcomments",postNo);
		
		return dto;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public ArrayList<MainDTO> search(String keyword, String searchVal) {
		ArrayList<MainDTO> dto = new ArrayList<MainDTO>();
		System.out.println( "keyword ="+  keyword);
		System.out.println("searchVal = "+searchVal);
		if(searchVal.equals("title")) {
			dto = (ArrayList)sqlSession.selectList("searchTitle", keyword);
			System.out.println("Ÿ��Ʋ ����");
			return dto;
		}else if(searchVal.equals("content")) {
			dto = (ArrayList)sqlSession.selectList("searchContent", keyword);
			System.out.println("������ ����");
			return dto;
		}else {
			dto = (ArrayList)sqlSession.selectList("searchWriter", keyword);			
			System.out.println("�ۼ��� ����");
			return dto;
		}
		
		
	}

	
}
