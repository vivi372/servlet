package com.webjjang.qna.service;


import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;
import com.webjjang.qna.dao.QnaDAO;
import com.webjjang.qna.vo.QnaVO;

public class QnaWriteService implements Service {

	private QnaDAO dao;
	
	//dao setter 
	public void setDAO(DAO dao) {
		this.dao=(QnaDAO) dao;
	}
	
	@Override
	public Integer service(Object obj) throws Exception {
		QnaVO vo =(QnaVO)obj;
		long no = dao.getNo();
		vo.setNo(no);
		if(vo.isQuestion()) {
			//질문 - refNo를 no와 같은 번호 세팅
			vo.setRefNo(no);
		}else {
			//답변 - ref와 순서번호와 같거나 큰 데이터의 순서 번호를 1증가 시켜준다.
			dao.incOrdNo(vo);
		}
		
		// DB qna에서 리스트 쿼리 실행해서 데이터 가져오기 - 리턴
		
		// QnaController - (Execute) - [QnaWriteService] - BoardDAO.question()			
		return dao.write(vo);
	}

	

}
