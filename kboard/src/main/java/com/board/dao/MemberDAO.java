package com.board.dao;

import com.board.domain.MemberVO;

public interface MemberDAO {
	//로그인
	public MemberVO login(MemberVO vo) throws Exception;
	//회원가입
	public MemberVO SignUp(MemberVO vo) throws Exception;
}
