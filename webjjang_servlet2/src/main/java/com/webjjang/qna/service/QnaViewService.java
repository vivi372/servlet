package com.webjjang.qna.service;


import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;
import com.webjjang.qna.dao.QnaDAO;
import com.webjjang.qna.vo.QnaVO;

public class QnaViewService implements Service {
	
	private QnaDAO dao;
	
	//dao setter 
	public void setDAO(DAO dao) {
		this.dao=(QnaDAO) dao;
	}

	@Override
	public QnaVO service(Object obj) throws Exception {			
	
		// DB 처리는 DAO에서 처리 - BoardDAO.list()
		// QnaController - (Execute) - [QnaViewService] - QnaDAO.view()
		return dao.view((Long)obj);
	}

	

}
