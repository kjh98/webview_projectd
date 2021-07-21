package com.board.controller;

import java.util.List;

import javax.inject.Inject;



import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.RestController;

import com.board.domain.ReplyVO;
import com.board.service.BoardService;





@RestController

@RequestMapping("/reply/*")
public class RestBoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);



	@Inject
	private BoardService boardService;
	@Inject
	private com.board.service.ReplyService ReplyService;

	

	@RequestMapping(value = "/getReqlyList", method = RequestMethod.POST)

	public void getReplyList(@RequestParam("bno") int bno, Model model) throws Exception {
		
		List<ReplyVO> reply = ReplyService.list(bno);
		model.addAttribute("reply", reply);


	}



}
