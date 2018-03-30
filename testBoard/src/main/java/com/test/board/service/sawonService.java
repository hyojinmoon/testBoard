package com.test.board.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.test.board.model.pagingDTO;
import com.test.board.model.sawonDAO;
import com.test.board.model.sawonDTO;
import com.test.board.utill.excelFile;
import com.test.board.utill.imageFile;
import com.test.board.utill.pagination;

@Service
public class sawonService {
	@Autowired
	private sawonDAO sawonDAO;
	@Autowired
	private imageFile imageFile;
	@Autowired
	private excelFile excelFile;
	@Autowired
	private pagingDTO pagingDTO;
	@Autowired
	private pagination pagination;
	
	public Map selectList(int page, pagingDTO pagingDTO) {
		pagingDTO.setPageIndex(page);
		pagination.setCurrentPageNo(pagingDTO.getPageIndex());
		pagination.setRecordCountPerPage(pagingDTO.getPageUnit());
		pagination.setPageSize(pagingDTO.getPageSize());

		pagingDTO.setFirstIndex(pagination.getFirstRecordIndex());
		pagingDTO.setLastIndex(pagination.getLastRecordIndex());
		pagingDTO.setRecordCountPerPage(pagination.getRecordCountPerPage());
		
		// 다중검색 단어 처리
		String searchWord = pagingDTO.getSearchWord();
		if(searchWord.contains(",")) {
			String[] splitWords= searchWord.split(",");
			String word1 = splitWords[0].trim();
			String word2 = splitWords[1].trim();
			pagingDTO.setSearchWord(word1);
			pagingDTO.setSearchWord2(word2);
		}
		
		List<sawonDTO> sawonList = this.sawonDAO.selectList(pagingDTO);
		int totCnt = this.sawonDAO.pageCount(pagingDTO);
		pagination.setTotalRecordCount(totCnt);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sawonList", sawonList);
		map.put("totCnt", totCnt);
		map.put("pagination", pagination);
		
		return map;
	}
	
	public void insertSawonService(sawonDTO sawonDTO, String file_Txt, MultipartFile file) throws IOException {
		// 업로드 이미지 파일 path 저장
		if(!(file_Txt.equals(""))){
			String image = imageFile.uploadFile(file.getOriginalFilename(), file.getBytes());	
			sawonDTO.setImage(image);			
		}else{
			sawonDTO.setImage("");	
		}
		// 주민번호 합본
		if(!(sawonDTO.getJumin_Nof().equals("")) || !(sawonDTO.getJumin_Nob().equals(""))){
			sawonDTO.setJumin(sawonDTO.getJumin_Nof()+"-"+sawonDTO.getJumin_Nob());			
		}else{
			sawonDTO.setJumin("");
		}
		//생년월일 합본
		if(!(sawonDTO.getBirth1().equals("")) || !(sawonDTO.getBirth2().equals("")) || !(sawonDTO.getBirth3().equals(""))){
			sawonDTO.setBirth(sawonDTO.getBirth1()+"-"+sawonDTO.getBirth2()+"-"+sawonDTO.getBirth3());			
		}else{
			sawonDTO.setBirth("");		
		}
		//전화번호 합본
		if(!(sawonDTO.getPhone1().equals("")) || !(sawonDTO.getPhone2().equals("")) || !(sawonDTO.getPhone3().equals(""))){
			sawonDTO.setPhone(sawonDTO.getPhone1()+"-"+sawonDTO.getPhone2()+"-"+sawonDTO.getPhone3());			
		}else{
			sawonDTO.setPhone("");		
		}
		
		this.sawonDAO.insertSawon(sawonDTO);
	}

	public void updateSawonService(int no, sawonDTO sawonDTO, String file_Txt, MultipartFile file) throws IOException {
		sawonDTO.setNo(no);
		// 업로드 이미지 파일 path 저장
		if(!(file_Txt.equals(""))){
			String image = imageFile.uploadFile(file.getOriginalFilename(), file.getBytes());	
			sawonDTO.setImage(image);			
		}else{
			sawonDTO.setImage("");	
		}
		// 주민번호 합본
		if(!(sawonDTO.getJumin_Nof().equals("")) || !(sawonDTO.getJumin_Nob().equals(""))){
			sawonDTO.setJumin(sawonDTO.getJumin_Nof()+"-"+sawonDTO.getJumin_Nob());			
		}else{
			sawonDTO.setJumin("");
		}
		//생년월일 합본
		if(!(sawonDTO.getBirth1().equals("")) || !(sawonDTO.getBirth2().equals("")) || !(sawonDTO.getBirth3().equals(""))){
			sawonDTO.setBirth(sawonDTO.getBirth1()+"-"+sawonDTO.getBirth2()+"-"+sawonDTO.getBirth3());			
		}else{
			sawonDTO.setBirth("");		
		}
		//전화번호 합본
		if(!(sawonDTO.getPhone1().equals("")) || !(sawonDTO.getPhone2().equals("")) || !(sawonDTO.getPhone3().equals(""))){
			sawonDTO.setPhone(sawonDTO.getPhone1()+"-"+sawonDTO.getPhone2()+"-"+sawonDTO.getPhone3());			
		}else{
			sawonDTO.setPhone("");		
		}
		
		this.sawonDAO.updateSawon(sawonDTO);
	}

	public void deleteSawonService(HttpServletRequest request) {
		/*		
		//단일 선택 삭제
		int no = Integer.parseInt(request.getParameter("check"));
		this.service.deleteSawonService(no);
		 */
		String[] arrayCheck = request.getParameterValues("check");
		for(String no : arrayCheck){
			this.sawonDAO.deleteSawon(Integer.parseInt(no));
		}
	}

	public sawonDTO viewSawonService(HttpServletRequest request) {
		int no = Integer.parseInt(request.getParameter("check"));
		sawonDTO sawonDTO= this.sawonDAO.viewSawon(no);
		String image = sawonDTO.getImage();
		if(image!=null){
			int index = image.lastIndexOf("/");
			String imageName = image.substring(index+1);
			sawonDTO.setImage(imageName);			
		}
		return sawonDTO;
	}

	public String checkJuminService(String jumin_f, String jumin_b, String sawonNo) {
		String data = "";
		String jumin = jumin_f+"-"+jumin_b;
		if(sawonNo=="") {
			int check_jumin = this.sawonDAO.checkJumin(jumin);
			if(check_jumin == 0) {
				data = "사용가능";
			}else {
				data = "중복";
			}			
		}else {
			sawonDTO sawonDTO = new sawonDTO();
			sawonDTO.setJumin(jumin);
			sawonDTO.setNo(Integer.parseInt(sawonNo));
			int check_jumin = this.sawonDAO.checkJuminNo(sawonDTO);
			if(check_jumin == 0) {
				data = "사용가능";
			}else {
				data = "중복";
			}		
		}
		return data;
	}

	public sawonDTO excelFileUpload(MultipartFile uploadFile) throws Exception {
	   	sawonDTO sawonDTO = new sawonDTO();
    	String[] dataArray = null;
        File destFile = new File("C:/temp/"+uploadFile.getOriginalFilename());
        uploadFile.transferTo(destFile);
        if(uploadFile==null || uploadFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택해 주세요.");
        }else {
            try {
                Workbook wbs = WorkbookFactory.create(new FileInputStream(destFile));
                Sheet sheet = (Sheet) wbs.getSheetAt(0);
     
                int lastCellNum = 0;
     
                for (int i = sheet.getFirstRowNum(); i <= sheet.getLastRowNum(); i++) {
                    Row row = sheet.getRow(i);
                    if (i == 0) {
                        lastCellNum = row.getLastCellNum();
                        if (lastCellNum != 23) { throw new Exception("양식이 잘못되었습니다."); }
     
                        Cell cell = row.getCell(0);
                        if (!cell.getRichStringCellValue().getString().trim().equals("한글이름")) { throw new Exception("[관리번호] 헤더가 일치 하지 않습니다."
                                + cell.getRichStringCellValue().equals("한글이름")); }
                    } else {
                        	sawonDTO.setKor_Name(excelFile.cellValue(row.getCell(0)));
                        	sawonDTO.setEng_Name(excelFile.cellValue(row.getCell(1)));
                            sawonDTO.setChn_Name(excelFile.cellValue(row.getCell(2)));
                            sawonDTO.setJumin_Nof(excelFile.cellValue(row.getCell(3)));
                            sawonDTO.setJumin_Nob(excelFile.cellValue(row.getCell(4)));
                            sawonDTO.setImage(excelFile.cellValue(row.getCell(5)));
                            sawonDTO.setBirth1(excelFile.cellValue(row.getCell(6)));
                            sawonDTO.setBirth2(excelFile.cellValue(row.getCell(7)));
                            sawonDTO.setBirth3(excelFile.cellValue(row.getCell(8)));
                            sawonDTO.setSol_Flag(excelFile.cellValue(row.getCell(9)));
                            sawonDTO.setSex(excelFile.cellValue(row.getCell(10)));
                            sawonDTO.setMarry_Flag(excelFile.cellValue(row.getCell(11)));
                            sawonDTO.setWork_Year(excelFile.cellValue(row.getCell(12)));
                            sawonDTO.setPayment_Type(excelFile.cellValue(row.getCell(13)));
                            sawonDTO.setDesire_Dept(excelFile.cellValue(row.getCell(14)));
                            sawonDTO.setJop_Type(excelFile.cellValue(row.getCell(15)));
                            sawonDTO.setAddress(excelFile.cellValue(row.getCell(16)));
                            sawonDTO.setPhone1(excelFile.cellValue(row.getCell(17)));
                            sawonDTO.setPhone2(excelFile.cellValue(row.getCell(18)));
                            sawonDTO.setPhone3(excelFile.cellValue(row.getCell(19)));
                            sawonDTO.setEmail(excelFile.cellValue(row.getCell(20)));
                            sawonDTO.setTech_Lev(excelFile.cellValue(row.getCell(21)));
                            sawonDTO.setLiquor(excelFile.cellValue(row.getCell(22)));
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw new Exception("오류가 있는 데이터가 있습니다." + e.getMessage());
            }
        }
        destFile.delete();
		return sawonDTO;
	}
	
	public void excelFileDownload(HttpServletRequest request, HttpServletResponse response) {
		int no = Integer.parseInt(request.getParameter("no"));
        sawonDTO sawonDTO= this.sawonDAO.viewSawon(no);
        String sawon = sawonDTO.toString();
        String[] sawonArray = sawon.split(",");
        String[] titleArray = new String[]{"한글이름", "영문이름", "한자이름", "주민번호 앞자리",
        													  "주민번호 뒷자리", "이미지", "생년", "월", "일", "양력/음력",
        													  "성별", "결혼 유무", "년차", "급여 지급유형", "희망직무", 
        													  "입사유형", "주소", "연락처1", "연락처2", "연락처3", "이메일", 
        													  "기술등급", "주량"};

        Workbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상
        Sheet sheet1 = xlsxWb.createSheet("firstSheet");
        Row row = null;
        Cell cell = null;

        for(int i=0; i<2; i++) {
        	row = sheet1.createRow(i);
        	if(i==0) {
        		for(int j=0; j<titleArray.length; j++) {
        			String title = titleArray[j];
            		cell = row.createCell(j);
            		cell.setCellValue(title);
            	}
        	}
        	if(i==1) {
        		for(int j=0; j<titleArray.length; j++) {
                	String sawonInfo = sawonArray[j];
            		cell = row.createCell(j);
            		cell.setCellValue(sawonInfo);
            	}
        	}
        }
        
        // excel 파일 저장
        String sawonName  = sawonDTO.getKor_Name()+"_Info.xlsx";

        try {
            File xlsxFile = new File("C:/Users/Administrator/Downloads/"+sawonName);
            FileOutputStream fileOut = new FileOutputStream(xlsxFile);
            xlsxWb.write(fileOut);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
}
