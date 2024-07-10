package com.webjjang.member.service;

import java.util.List;

import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;
import com.webjjang.member.dao.MemberDAO;
import com.webjjang.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;

public class MemberListService implements Service {

	private MemberDAO dao;
	
	//dao setter 
	public void setDAO(DAO dao) {
		this.dao=(MemberDAO) dao;
	}
	
	@Override
	public List<MemberVO> service(Object obj) throws Exception {		
		PageObject pageObj = (PageObject) obj;
		pageObj.setTotalRow(dao.totalRow(pageObj));
		// MemberController - (Execute) - [MemberListService] - MemberDAO.list()
		return dao.list(pageObj);
	}

	

}
