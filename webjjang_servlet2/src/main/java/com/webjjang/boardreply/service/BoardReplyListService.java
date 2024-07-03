package com.webjjang.boardreply.service;

import java.util.List;
import com.webjjang.boardreply.dao.BoardReplyDAO;
import com.webjjang.boardreply.vo.BoardReplyVO;
import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;
import com.webjjang.util.page.ReplyPageObject;

public class BoardReplyListService implements Service {
	private BoardReplyDAO dao;
	
	//dao setter 
	public void setDAO(DAO dao) {
		this.dao=(BoardReplyDAO) dao;
	}
	
	@Override
	public List<BoardReplyVO> service(Object obj) throws Exception {
		ReplyPageObject pageObj = (ReplyPageObject) obj;		
		// DB board_reply에서 리스트 쿼리 실행해서 데이터 가져오기 - 리턴
		//전체 데이터의 개수
		pageObj.setTotalRow(dao.getTotalRow(pageObj));
		// DB 처리는 DAO에서 처리 - BoardReplyDAO.list()
		// BoardController - (Execute) - [BoardReplyListService] - BoardReplyDAO.list()
		return dao.list(pageObj);
	}

}
