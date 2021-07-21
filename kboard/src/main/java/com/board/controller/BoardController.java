package com.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.board.domain.BoardVO;
import com.board.domain.Page;
import com.board.domain.ReplyVO;
import com.board.service.BoardService;
import com.board.service.ReplyService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	private BoardService service;
	
	@Inject
	private ReplyService replyService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void getList(Model model) throws Exception {

		List list = null;
		list = service.list();
		model.addAttribute("list", list);
	}

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getWrite() throws Exception {

	}

//게시물 작성
	@PostMapping("/write")
	public String postWrite(BoardVO vo) throws Exception {
		service.write(vo);

		return "redirect:/board/listPageSearch?num=1";
	}

	// 게시물 조회
	@RequestMapping(value = "/view", method = {RequestMethod.GET, RequestMethod.POST})
	public void getView(@RequestParam("bno") int bno, Model model) throws Exception {
		BoardVO vo = service.view(bno);

		model.addAttribute("view", vo);

		// 댓글 조회
		List<ReplyVO> reply = null;
		reply = replyService.list(bno);
		model.addAttribute("reply", reply);
		model.addAttribute("replyVO", new ReplyVO());

	}
	

	// 게시물 수정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify(@RequestParam("bno") int bno, Model model) throws Exception {

		BoardVO vo = service.view(bno);

		model.addAttribute("view", vo);

	}

	// 게시물 수정
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(BoardVO vo) throws Exception {

		service.modify(vo);

		return "redirect:/board/view?bno=" + vo.getBno();
	}

	// 게시물 삭제 + 해당 bno 번호 댓글 전부 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("vbno") int bno, ReplyVO vo) throws Exception {
		replyService.replyDelete(vo);
		service.delete(bno);
		return "redirect:/board/listPageSearch?num=1";
	}
	// 게시물 삭제 
	@RequestMapping(value = "/ndelete", method = RequestMethod.GET)
	public String getnDelete(@RequestParam("vbno") int bno) throws Exception {
		service.delete(bno);
		return "redirect:/board/listPageSearch?num=1";
	}

	// 게시물 목록 + 페이징 추가
	@RequestMapping(value = "/listpage", method = RequestMethod.GET)
	public void getListPage(Model model) throws Exception {

		List list = null;
		list = service.list();
		model.addAttribute("list", list);
	}

	// 게시물 목록 + 페이징 추가
	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void getListPage(Model model, @RequestParam("num") int num) throws Exception {
		
		Page page = new Page();
		
		page.setNum(num);
		page.setCount(service.count());  

		List list = null; 
		list = service.listPage(page.getDisplayPost(), page.getPostNum());

		model.addAttribute("list", list);   
		model.addAttribute("page", page);
		model.addAttribute("select", num);

	}
	
	// 게시물 목록 + 페이징 추가 + 검색
	@RequestMapping(value = "/listPageSearch", method = {RequestMethod.GET, RequestMethod.POST})
	public void getListPageSearch(Model model,
			@RequestParam("num") int num, 
			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword
	  ) throws Exception {
	 
		 Page page = new Page();
		 
		 page.setNum(num);
		 //page.setCount(service.count()); 
		 page.setCount(service.searchCount(searchType, keyword));
		 
		 // 검색 타입과 검색어
		 page.setSearchTypeKeyword(searchType, keyword);
		 
		 List<BoardVO> list = null; 
		 //list = service.listPage(page.getDisplayPost(), page.getPostNum());
		 list = service.listPageSearch(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
		 
		 model.addAttribute("list", list);
		 model.addAttribute("page", page);
		 model.addAttribute("select", num);
		 
		 model.addAttribute("searchType", searchType);
		 model.addAttribute("keyword", keyword);
	 
	}
	// 글 쓰기
		@RequestMapping(value="/insertBoard.do") 
		public String insertBoard(BoardVO vo) throws IOException { 
				// 파일 업로드 처리
				String fileName=null;
				MultipartFile uploadFile = vo.getUploadFile();
				if (!uploadFile.isEmpty()) {
					String originalFileName = uploadFile.getOriginalFilename();
					String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
					UUID uuid = UUID.randomUUID();	//UUID 구하기
					fileName=uuid+"."+ext;
					uploadFile.transferTo(new File("D:\\upload" + fileName));
					vo.setUfile_name(originalFileName);
				}
				
				vo.setFileName(fileName);
				try {
					service.insertBoard(vo);
				} catch (Exception e) {
					e.printStackTrace();
				} 
				return "redirect:/board/listPageSearch?num=1";
		}
	
}