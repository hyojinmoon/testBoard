package com.test.board.model;

public class pagingDTO {
	/** 검색조건 */
	private String selectGroup = "";

	/** 검색Keyword */
	private String searchWord = "";
	
	/** 검색Keyword */
	private String searchWord2 = "";

	/** 검색사용여부 */
	private String searchUse = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** 페이지갯수 */
	private int pageUnit = 5;

	/** 페이지사이즈 */
	private int pageSize = 5;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 5;

	public pagingDTO() {	}

	public pagingDTO(String selectGroup, String searchWord, String searchWord2, String searchUse, int pageIndex,
			int pageUnit, int pageSize, int firstIndex, int lastIndex, int recordCountPerPage) {
		super();
		this.selectGroup = selectGroup;
		this.searchWord = searchWord;
		this.searchWord2 = searchWord2;
		this.searchUse = searchUse;
		this.pageIndex = pageIndex;
		this.pageUnit = pageUnit;
		this.pageSize = pageSize;
		this.firstIndex = firstIndex;
		this.lastIndex = lastIndex;
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSelectGroup() {
		return selectGroup;
	}

	public void setSelectGroup(String selectGroup) {
		this.selectGroup = selectGroup;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getSearchWord2() {
		return searchWord2;
	}

	public void setSearchWord2(String searchWord2) {
		this.searchWord2 = searchWord2;
	}

	public String getSearchUse() {
		return searchUse;
	}

	public void setSearchUse(String searchUse) {
		this.searchUse = searchUse;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	
}
