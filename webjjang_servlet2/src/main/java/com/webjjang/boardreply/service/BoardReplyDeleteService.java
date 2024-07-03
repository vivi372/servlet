package com.webjjang.boardreply.service;


import com.webjjang.boardreply.dao.BoardReplyDAO;
import com.webjjang.boardreply.vo.BoardReplyVO;
import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;

public class BoardReplyDeleteService implements Service {
	private BoardReplyDAO dao;
		
	//dao setter 
	public void setDAO(DAO dao) {
		this.dao=(BoardReplyDAO) dao;
	}
	
	@Override
	public Integer service(Object obj) throws Exception {		
		// DB 처리는 DAO에서 처리 - BoardReplyDAO.delete()
		// BoardReplyController - (Execute) - [BoardReplyDeleteService] - BoardReplyDAO.delete()
		return dao.delete((BoardReplyVO)obj);
	}

	

}
