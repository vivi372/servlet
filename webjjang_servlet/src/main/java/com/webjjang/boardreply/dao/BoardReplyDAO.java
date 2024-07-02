package com.webjjang.boardreply.dao;

import java.util.ArrayList;
import java.util.List;
import com.webjjang.boardreply.vo.BoardReplyVO;
import com.webjjang.main.dao.DAO;
import com.webjjang.util.db.DB;
import com.webjjang.util.page.ReplyPageObject;

public class BoardReplyDAO extends DAO{

	
	// 필요한 객체 선언 - 상속
	// 접속 정보 - DB 사용 - connection을 가져오게 하는 메서드만 이용
	
	// 1-2. 리스트 처리
	// BoardController - (Execute) - BoardListService - [BoardDAO.list()]
	public List<BoardReplyVO> list(ReplyPageObject pageObj) throws Exception{
		// 결과를 저장할 수 있는 변수 선언.
		List<BoardReplyVO> list = null;		
		try {
			// 1. 드라이버 확인 - DB
			// 2. 연결
			con = DB.getConnection();
			// 3. sql - 아래 LIST
			System.out.println(LIST);
			// 4. 실행 객체 & 데이터 세팅
			pstmt = con.prepareStatement(LIST);
			// 검색에 대한 데이터 세팅 - list() 에서만 사용			
			pstmt.setLong(1, pageObj.getNo()); // 기본 값 = 1
			pstmt.setLong(2, pageObj.getStartRow()); // 기본 값 = 1
			pstmt.setLong(3, pageObj.getEndRow()); // 기본 값 = 10
			// 5. 실행
			rs = pstmt.executeQuery();
			// 6. 표시 또는 담기
			if(rs != null) {
				while(rs.next()) {
					// rs - > vo -> list
					// list가 null이면 생성해서 저장할 수 있게 해줘야 한다.
					if(list == null) list = new ArrayList<BoardReplyVO>();
					// rs -> vo
					BoardReplyVO vo = new BoardReplyVO();
					vo.setRno(rs.getLong("rno"));
					vo.setNo(rs.getLong("no"));
					vo.setContent(rs.getString("content"));
					vo.setWriter(rs.getString("writer"));
					vo.setWriteDate(rs.getString("writeDate"));					
					// vo -> list
					list.add(vo);
				} // end of while
			} // end of if
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			// 7. 닫기
			DB.close(con, pstmt, rs);
		} // end of try ~ catch ~ finally
		
		// 결과 데이터를 리턴해 준다.
		return list;
	} // end of list()
	
	// 1-1. 리스트 처리
	// BoardController - (Execute) - BoardListService - [BoardDAO.list()]
	public Long getTotalRow(ReplyPageObject pageObj) throws Exception{
		// 결과를 저장할 수 있는 변수 선언.
		long totalRow = 0;
		try {
			// 1. 드라이버 확인 - DB
			// 2. 연결
			con = DB.getConnection();
			// 3. sql - 아래 LIST
			System.out.println(GETTOTALROW);
			// 4. 실행 객체 & 데이터 세팅
			pstmt = con.prepareStatement(GETTOTALROW);		
			pstmt.setLong(1, pageObj.getNo());
			// 5. 실행
			rs = pstmt.executeQuery();
			// 6. 표시 또는 담기
			if(rs != null && rs.next()) {								
				totalRow = rs.getLong(1);
			} // end of if				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			// 7. 닫기
			DB.close(con, pstmt, rs);
		} // end of try ~ catch ~ finally			
		// 결과 데이터를 리턴해 준다.
		
		return totalRow;
	} // end of list()
	
	// 댓글 상세보기는 리스트에서 내용이 다 표시되어 필요하지 않는다.
	
	// 2. 글등록 처리
	// BoardReplyController - (Execute) - BoardReplyWriteService - [BoardReplyDAO.wirte()]
	public int write(BoardReplyVO vo) throws Exception{
		// 결과를 저장할 수 있는 변수 선언.
		int result = 0;
		
		try {
			// 1. 드라이버 확인 - DB
			// 2. 연결
			con = DB.getConnection();
			// 3. sql - 아래 LIST
			// 4. 실행 객체 & 데이터 세팅
			pstmt = con.prepareStatement(WRITE);
			pstmt.setLong(1, vo.getNo());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getWriter());
			pstmt.setString(4, vo.getPw());
			// 5. 실행 - update : executeUpdate() -> int 결과가 나옴.
			result = pstmt.executeUpdate();
			// 6. 표시 또는 담기
			System.out.println();
			System.out.println("*** 댓글 등록이 완료 되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			// 그외 처리 중 나타나는 오류에 대해서 사용자가 볼수 있는 예외로 만들어 전달한다.
			throw new Exception("예외 발생 : 게시판 댓글등록 DB 처리 중 예외가 발생했습니다.");
		} finally {
			// 7. 닫기
			DB.close(con, pstmt);
		}
		
		// 결과 데이터를 리턴해 준다.
		return result;
	} // end of write()
	
	
	// 3. 글수정 처리
	// BoardReplyController - (Execute) - BoardReplyViewService - [BoardReplyDAO.update()]
	public int update(BoardReplyVO vo) throws Exception{
		// 결과를 저장할 수 있는 변수 선언.
		int result = 0;
		
		try {
			// 1. 드라이버 확인 - DB
			// 2. 연결
			con = DB.getConnection();
			// 3. sql - 아래 UPDATE
			// 4. 실행 객체 & 데이터 세팅
			pstmt = con.prepareStatement(UPDATE);			
			pstmt.setString(1, vo.getContent());
			pstmt.setString(2, vo.getWriter());
			pstmt.setLong(3, vo.getRno());
			pstmt.setString(4, vo.getPw());
			// 5. 실행 - update : executeUpdate() -> int 결과가 나옴.
			result = pstmt.executeUpdate();
			// 6. 표시 또는 담기
			if(result == 0) { // 글번호가 존재하지 않는다. -> 예외로 처리한다.
				throw new Exception("예외 발생 : 댓글 비밀번호가 맞지 않습니다. 정보를 확인해 주세요.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 특별한 예외는 그냥 전달한다.
			if(e.getMessage().indexOf("예외 발생") >= 0) throw e;
			// 그외 처리 중 나타나는 오류에 대해서 사용자가 볼수 있는 예외로 만들어 전달한다.
			else throw new Exception("예외 발생 : 게시판 댓글수정 DB 처리 중 예외가 발생했습니다.");
		} finally {
			// 7. 닫기
			DB.close(con, pstmt);
		}
		
		// 결과 데이터를 리턴해 준다.
		return result;
	} // end of update()
	
	
	// 4. 글삭제 처리
	// BoardReplyController - (Execute) - BoardReplyDeleteService - [BoardReplyDAO.delete()]
	public int delete(BoardReplyVO vo) throws Exception{
		// 결과를 저장할 수 있는 변수 선언.
		int result = 0;
		
		try {
			// 1. 드라이버 확인 - DB
			// 2. 연결
			con = DB.getConnection();
			// 3. sql - 아래 UPDATE
			// 4. 실행 객체 & 데이터 세팅
			pstmt = con.prepareStatement(DELETE);
			pstmt.setLong(1, vo.getRno());
			pstmt.setString(2, vo.getPw());
			// 5. 실행 - update : executeUpdate() -> int 결과가 나옴.
			result = pstmt.executeUpdate();
			// 6. 표시 또는 담기
			if(result == 0) { // 글번호가 존재하지 않거나 비번 틀림. -> 예외로 처리한다.
				throw new Exception("예외 발생 : 댓글 비밀번호가 맞지 않습니다. 정보를 확인해 주세요.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 특별한 예외는 그냥 전달한다.
			if(e.getMessage().indexOf("예외 발생") >= 0) throw e;
			// 그외 처리 중 나타나는 오류에 대해서 사용자가 볼수 있는 예외로 만들어 전달한다.
			else throw new Exception("예외 발생 : 게시판 댓글삭제 DB 처리 중 예외가 발생했습니다.");
		} finally {
			// 7. 닫기
			DB.close(con, pstmt);
		}
		
		// 결과 데이터를 리턴해 준다.
		return result;
	} // end of delete()
	
	
	// 실행할 쿼리를 정의해 놓은 변수 선언.
	// 리스트의 페이지 처리 절차 - 원본 -> 순서 번호 -> 해당 페이지 데이터만 가져온다.
//	final String LIST = "select no, title, writer, "
//			+ " to_char(writeDate, 'yyyy-mm-dd') writeDate, hit "
//			+ " from board "
//			+ " order by no desc"; 
	final String GETTOTALROW="select count(*) cnt from Board_Reply where no = ?";
	final String LIST = "select rno,no,content,writer,writeDate "
			+ " from("
			+ "    select rownum rnum, rno,no,content,writer,writeDate "
			+ "    from("
			+ "         select rno,no,content,writer,to_char(writeDate, 'yyyy-mm-dd') writeDate from Board_Reply "
			+ "			where no=? order by rno desc "
			+ "    )"
			+ ") "
			+ " where (rnum between ? and ?)";	
	
	
	final String WRITE = "insert into Board_Reply(rno,no,content,writer,pw)	VALUES(Board_Reply_seq.nextval,?,?,?,?)"; 
	final String UPDATE= "update Board_Reply "
			+ " set content = ?, writer = ? "
			+ " where rno = ? and pw = ?"; 
	final String DELETE= "delete from Board_Reply "
			+ " where rno = ? and pw = ?"; 
	
}
