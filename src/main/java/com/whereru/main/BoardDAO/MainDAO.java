package com.whereru.main.BoardDAO;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.whereru.main.BoardDTO.MainDTO;

public class MainDAO implements InterfaceBoardDAO{
	
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public MainDTO write(MainDTO dto) {
		sqlSession.insert("write", dto);
		return null;
	}

	@Override
	public ArrayList<MainDTO> list() {
		@SuppressWarnings({ "unchecked", "rawtypes" })
		ArrayList<MainDTO> list =  (ArrayList)sqlSession.selectList("list");
		
		return list;
	}

	@Override
	public String images(String boardNum) {
		String images = sqlSession.selectOne("images",boardNum);
		
		return images;
	}
	
	
	
}
