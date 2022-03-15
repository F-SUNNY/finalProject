package com.whereru.main;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.whereru.main.BoardDAO.MainDAO;
import com.whereru.main.BoardDTO.MainDTO;

@Controller
public class BoardController {
	
	@Autowired
	private MainDAO dao;
	
	@RequestMapping("/uploadMulti")
	public String uploadMulti(MultipartHttpServletRequest multi, Model model) {
		String filenames = "";
		String titleImg="";
		String tmp="";
		
		List<MultipartFile> fileList = multi.getFiles("img");
				
		//집에서 작업할시
		//String path = "C:/Fsunny/whereRU/src/main/webapp/resources/images/";
		
		//학원에서 작업할시
		String path = "C:/Users/310-02/git/projectTest/whereRU/src/main/webapp/resources/images/";
		
		for (MultipartFile mf : fileList) {
			String originalFileName = mf.getOriginalFilename();
			UUID prefix = UUID.randomUUID();
			
			try {
				mf.transferTo(new File(path + prefix + originalFileName));
				tmp+=prefix + originalFileName+"/";
			} catch (IllegalStateException | IOException e) {
				e.getMessage(); 
			}
		}
		filenames = tmp;
		String[] test =  filenames.split("/");
		titleImg = test[0];
		
		MainDTO dto = new MainDTO(multi.getParameter("nickname"),multi.getParameter("title"),multi.getParameter("content"),multi.getParameter("location"),titleImg,filenames);
		dao.write(dto);
		return "home";
	}

	@RequestMapping("/list")
	public String list(Model model) {
		
		ArrayList<MainDTO> list = dao.list();
		model.addAttribute("list", list);
		
		return "list";
	}
	
	@ResponseBody
	@RequestMapping(value="/images.do", produces="application/json; charset=UTF-8")
	public String[] images(@RequestBody String boardNum) {
	
		String tmp = dao.images(boardNum);
		String[] images = tmp.split("/");
		
		
		return images;
	}
	
	
}
