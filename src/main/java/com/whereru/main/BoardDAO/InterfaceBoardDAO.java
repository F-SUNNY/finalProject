package com.whereru.main.BoardDAO;

import java.util.ArrayList;

import com.whereru.main.BoardDTO.MainDTO;

public interface InterfaceBoardDAO {
	
	
	
	public MainDTO write(MainDTO dto);
	public ArrayList<MainDTO> list();
	public ArrayList<MainDTO> getlist(String boardNum);
}
