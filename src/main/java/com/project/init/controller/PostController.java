package com.project.init.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.project.init.dao.PostDao;
import com.project.init.dto.CommentsDto;
import com.project.init.dto.PostDto;
import com.project.init.util.Constant;


@Controller
@RequestMapping("/post")
//post로 매핑한 이유가 있을까? 그냥해도되는데
//post로 연결되서 들어오는건 이 controller에서 처리하는 거임
//href 나 url에 /post하고 하니까 계속안되서 그냥쓰니까 되네
// /이거 붙이면 url 그..base부터 바뀜 그니까.. init/post 여야하는데 post로 잡혀서 안돼
//나 작업할거 좀 남았는데 그냥 이렇게해 ? 아니면 init/post로해?
// 지금 여기 컨트롤러로 들어오는건 init/post/~~~~ 이렇게 들어오는 거임
// tomcat server에 init이 기본 url로 박혀있고 그 뒤로 post/~~ 이렇게 붙는거고
// /post 하면 init 자리에 post로 들어가서 매핑이 안맞는거임
//그럼 작업을 ........? post/postMain 하면 매핑이 안돼?
//지금 되는데  ajax는 앞에 post/를 안붙히고사용중

// 나도 확실치는 않는데 ajax같은거는 현재 주소 뒤에 붙음 그래서 그냥 저절로 되는거같아
//ㅇㅋㅇㅋ 그럼 내가 user가 필요한데 한번 해볼게 ㄱㄷ
//일단은 떳음 보이지?ㅇㅇ 왜이라노 아까는 몇번왔다갔다하니까 null뜨던데 뭐여 이거때문에 곤란했는디
// 서버 재가동 되면 user 정보 날아감 로그인한다음에도.. 그거 왠진 모르지만 그럼
//그럼 작업가능하겠다 근데 결국 채팅 들어감?ㅇㅇ 형이 뭐 만들어왓더라고 잘 될거같음
//나 수욜부터 바로 학원간당? ㅇㅇ 얼른 합쳐서 이번주에 끝내자 
//일단 이거도 데이터 불러오는거만 할꺼임 그리고 ui손보는걸로 얍 오늘 join이랑 login modal 일단 대충 다 잡아놨음
//굿 나는 근데 담주에 부산에 면접갔다와야함ㅇㅇ 다녀와 근데 뭐 보여줄게 없자너 그니껭 완성해서 들고가야징
// 나도 면접 보고싶은데 프로젝트가 안끝나서 맘 조급한 상태임.. 근데 이번주내로 되려나.... 모르겠네
//나는 가능할듯  허접하게 들고가면 좀 그렇자너
//ㄱㅊ 신입한테 뭘바람 일단은 최대한 해보자 너도 id 해서 잘 완성지어보고 됐다싶음 말해 그냥 내가 먼저 합쳐볼께 ㅇㅋㅋ
//마지막으로 heart만 하고 일단 댓글heart는 빼고 진행함 댓글은 여유나면 그때 함  ㅇㅋ 뭐라도 완성해보자 아직 한개도 완성된거 없음 ㅎㅎ..
//ㅋㅋ ㅇㅋㅇㅋ ㄳㄱ수고해라 ㄳㄳ
public class PostController {
	@Autowired
	private PostDao dao;
	

//	@RequestMapping("")
//	public String list(Model model) {
//		
//		ArrayList<PostDto> list = dao.list();
//		model.addAttribute("list", list);
//		model.addAttribute("user",Constant.username);
//		System.out.println(Constant.username);
//		return "post/postMain";
//	}
	
	@RequestMapping("postMain")
	public String postMain(Model model) {
		
		ArrayList<PostDto> list = dao.list();
		model.addAttribute("list", list);
		model.addAttribute("user",Constant.username);
		System.out.println(Constant.username);
		return "post/postMain";
	}
	
	@RequestMapping("addPost")
	public String addPost() {	
		return "post/addPost";
	}
	
	@RequestMapping(value = "uploadMulti", method = { RequestMethod.POST })
	public String uploadMulti(MultipartHttpServletRequest multi, Model model) {
		System.out.println("ddddddd");
		String images = "";
		String titleImage="";
		String tmp="";
		List<MultipartFile> fileList = multi.getFiles("img");
				
		//������ �۾��ҽ�
		String path = "C:/Fsunny/project_init/src/main/webapp/resources/images/";
		//�п����� �۾��ҽ�
		//String path = "C:/Users/310-02/git/projectTest/whereRU/src/main/webapp/resources/images/";
		
		for (MultipartFile mf : fileList) {
			String originalFileName = mf.getOriginalFilename();
			UUID prefix = UUID.randomUUID();
			
			try {
				mf.transferTo(new File(path + prefix + originalFileName));
				tmp+=prefix + originalFileName+"/";
			
			} catch (IllegalStateException | IOException e) {
				e.getMessage(); 
				System.out.println(e.getMessage());
			}
		}
		
		images = tmp;
		String[] test = images.split("/");
		titleImage = test[0];
		PostDto dto = new PostDto(multi.getParameter("content"),multi.getParameter("hashtag"),multi.getParameter("location"),titleImage,images);
		dao.write(dto);
		return "redirect:postMain";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="getlist.do")
	public ArrayList<PostDto> getlist(@RequestParam("postNo") String postNo) {
		
		ArrayList<PostDto> dto = dao.getlist(postNo);
		
		return dto;
	}
	
	@RequestMapping("delete.do")
	public String delete(HttpServletRequest request,Model model) {
		String postNo = request.getParameter("postNo");
		dao.deleteBoard(postNo);
		return "redirect:list";
	}
	
	@RequestMapping("modify")
	public String modify(HttpServletRequest request,Model model) {
		String postNo = request.getParameter("postNo");
		ArrayList<PostDto> list =dao.modifyList(postNo);
		
		model.addAttribute("list", list);
		return "modify";
	}
	
	@RequestMapping(value = "modifyExcute.do", method = { RequestMethod.POST })
	public String modifyExcute(MultipartHttpServletRequest multi, Model model) {
		String images = "";
		String titleImage="";
		String tmp="";

		
		List<MultipartFile> fileList = multi.getFiles("img");
		
		//������ �۾��ҽ�
		String path = "C:/Fsunny/project_init/src/main/webapp/resources/images/";
		//�п����� �۾��ҽ�
		//String path = "C:/Users/310-02/git/projectTest/whereRU/src/main/webapp/resources/images/";
		
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
		images = tmp;
		String[] test =  images.split("/");
		titleImage = test[0];
		
		PostDto dto = new PostDto(multi.getParameter("postNo"),multi.getParameter("content"),multi.getParameter("hashtag"),multi.getParameter("location"),titleImage,images);
		dao.modifyExcute(dto);
		return "redirect:list";
	}
	
	@ResponseBody
	@RequestMapping("addcomments.do")
	public void addcomments(@RequestParam("postNo") String postNo, @RequestParam("content") String content,@RequestParam("grpl") String grpl){
		int Igrpl = Integer.parseInt(grpl);
		CommentsDto dto = new CommentsDto(postNo,content,Igrpl);
		dao.addcomments(dto);
		
	}
	
	@ResponseBody
	@RequestMapping("addReplyComments.do")
	public void addReplyComments(@RequestParam("postNo") String postNo,@RequestParam("grp") String grp, @RequestParam("content") String content,@RequestParam("grpl") String grpl,@RequestParam("grps") String grps){
		int Igrp = Integer.parseInt(grp);
		int Igrpl = Integer.parseInt(grpl);
		int Igrps = Integer.parseInt(grps);
		CommentsDto dto = new CommentsDto(postNo,Igrp,content,Igrpl,Igrps);
		dao.addReplyComments(dto);
		
	}
	
	@ResponseBody
	@RequestMapping("deleteReplyComments.do")
	public void deleteReplyComments(@RequestParam("commentNo") String commentNo){
		dao.deleteReplyComments(commentNo);		
	}
	
	@ResponseBody
	@RequestMapping(value="getcomments.do")
	public ArrayList<CommentsDto> getcomments(@RequestParam("postNo") String postNo) {
		
		ArrayList<CommentsDto> dto = dao.getcomments(postNo);
		
		return dto;
	}
	
	@RequestMapping("searchPage")
	public String searchPage(HttpServletRequest request, Model model) {
		String keyword = request.getParameter("keyword");
		String searchVal = request.getParameter("searchVal");
		ArrayList<PostDto> list = dao.search(keyword,searchVal);
		model.addAttribute("list", list);
		
		return "postMain";
	}

	@RequestMapping("addLike.do")
	public String addLike(@RequestParam("postNo") String postNo) {
		//이메일 추가예정
		dao.addLike(postNo);
		return "redirect:postMain";
	}

	@RequestMapping("deleteLike.do")
	public String deleteLike(@RequestParam("postNo") String postNo) {
		//이메일 추가예정
		dao.deleteLike(postNo);
		return "redirect:postMain";
	}
}
