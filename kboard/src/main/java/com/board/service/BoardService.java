package com.board.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.board.dao.BoardDAO;
import com.board.domain.BoardVO;

public interface BoardService {

	// 게시물 목록
    List<BoardVO> list() throws Exception;

	// 게시물 작성
    void write(BoardVO vo) throws Exception;

	// 게시물 조회
    BoardVO view(int bno) throws Exception;
	
	//게시물 수정
    void modify(BoardVO vo) throws Exception;
	
	// 게시물 삭제
    void delete(int bno) throws Exception;
	
	// 게시물 총 갯수
    int count() throws Exception;
	
	// 게시물 목록 + 페이징
    List listPage(int displayPost, int postNum) throws Exception;
	
	// 게시물 목록 + 페이징 + 검색
    List<BoardVO> listPageSearch
    (int displayPost, int postNum, String searchType, String keyword) throws Exception;
	
	
	// 게시물 총 갯수 + 검색 적용
    int searchCount(String searchType, String keyword) throws Exception;

	public void insertBoard(BoardVO vo) throws Exception;
	
	
}
