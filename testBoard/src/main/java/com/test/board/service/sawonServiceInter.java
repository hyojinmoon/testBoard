package com.test.board.service;

import java.util.HashMap;
import java.util.List;

import com.test.board.model.sawonDTO;

public interface sawonServiceInter {
	void insertSawonService(sawonDTO sawonDTO);
	void updateSawonService(sawonDTO sawonDTO);
	void deleteSawonService(int no);
	List<sawonDTO> selectListService();
	int pageCountService(int pageSize);
	sawonDTO viewSawonService(int no);
	List<sawonDTO> searchAllService(String searchWord);
	List<sawonDTO> searchNameService(String searchWord);
	List<sawonDTO> searchSexService(String searchWord);
	List<sawonDTO> searchTecService(String searchWord);
	int pageSearchAllService(int pageSize, String searchWord);
	int pageSearchNameService(int pageSize, String searchWord);
	int pageSearchSexService(int pageSize, String searchWord);
	int pageSearchTecService(int pageSize, String searchWord);
	int checkJuminService(String jumin);
	int checkJuminNoService(sawonDTO sawonDTO);
	List<sawonDTO> searchService(HashMap searchMap);
	int pageSearchService(int pageSize, HashMap searchMap);
}
