package com.board.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.board.dao.MemberDAO;
import com.board.domain.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		
		return dao.login(vo);
				
	}
	@Override
	public MemberVO SignUp(MemberVO vo) throws Exception {
		
		return dao.SignUp(vo);
				
	}
	

	

}