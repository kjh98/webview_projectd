package com.board.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.domain.MemberVO;

@Repository

public class MemberDAOImpl implements MemberDAO {
	@Inject
	private SqlSession sql;
	private static String namespace = "com.board.mappers.member";


	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		
		return sql.selectOne(namespace + ".login", vo);
		
	}
	
	@Override
	public MemberVO SignUp(MemberVO vo) throws Exception {
		
		return sql.selectOne(namespace + ".SignUp", vo);
		
	}

}
