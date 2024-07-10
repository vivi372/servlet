package com.webjjang.member.service;

import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;
import com.webjjang.member.dao.MemberDAO;
import com.webjjang.member.vo.MemberVO;

public class MemberChangeGradeService implements Service {

	private MemberDAO dao;
	
	//dao setter 
	public void setDAO(DAO dao) {
		this.dao=(MemberDAO) dao;
	}
	
	@Override
	public Integer service(Object obj) throws Exception {		
		// MemberController - (Execute) - [MemberChangeGradeService] - MemberDAO.changeGrade()
		return dao.changeGrade((MemberVO)obj);
	}

	

}
