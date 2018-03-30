package com.test.board.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class sawonDAO{
	@Autowired
	private SqlSession session;

	public void insertSawon(sawonDTO sawonDTO) {
		this.session.insert("Test.insertSawon", sawonDTO);
	}

	public void updateSawon(sawonDTO sawonDTO) {
		this.session.update("Test.updateSawon", sawonDTO);
	}

	public void deleteSawon(int no) {
		this.session.delete("Test.deleteSawon",no);
	}

	public List<sawonDTO> selectList(pagingDTO pagingDTO) {
		return this.session.selectList("Test.selectList");
	}

	public int pageCount(pagingDTO pagingDTO) {
		return this.session.selectOne("Test.pageCount");
	}

	public sawonDTO viewSawon(int no) {
		return this.session.selectOne("Test.viewSawon", no);
	}

	public int checkJumin(String jumin) {
		return this.session.selectOne("Test.checkJumin",jumin);
	}

	public int checkJuminNo(sawonDTO sawonDTO) {
		return this.session.selectOne("Test.checkJuminNo", sawonDTO);
	}
}
