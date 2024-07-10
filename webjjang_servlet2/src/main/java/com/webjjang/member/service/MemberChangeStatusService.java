package com.webjjang.member.service;

import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;
import com.webjjang.member.dao.MemberDAO;
import com.webjjang.member.vo.MemberVO;

public class MemberChangeStatusService implements Service {

	private MemberDAO dao;
	
	//dao setter 
	public void setDAO(DAO dao) {
		this.dao=(MemberDAO) dao;
	}
	
	@Override
	public Integer service(Object obj) throws Exception {		
		// MemberController - (Execute) - [MemberChangeStatusService] - MemberDAO.changeStatus()
		return dao.changeStatus((MemberVO)obj);
	}

	

}
