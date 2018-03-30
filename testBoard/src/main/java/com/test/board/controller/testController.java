package com.test.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.test.board.model.pagingDTO;
import com.test.board.model.sawonDTO;
import com.test.board.service.sawonService;

@Controller
public class testController {
	@Autowired
	private sawonService service;

	@RequestMapping(value="/")
	public String index(){
		return "/index";
	}

	// 다중 검색 - 동적쿼리이용
	@RequestMapping(value="/employee/empList/{page}", produces = "application/text; charset=utf8")
	public String empListSearch(@PathVariable int page, 
												   pagingDTO pagingDTO,
												   Model model) {	
		model.addAttribute("insertMap",this.service.selectList(page, pagingDTO));
		return "/employee/empList";
	}
	
	// 등록창
	@RequestMapping("/employee/empViewInsert")
	public String EmpViewInsert(){
		return "/employee/empViewInsert";
	}
	
	
	/*	한글 이름 비동기 유효성 검사 방법1
	 * @RequestMapping(value="/employee/regConf_Name")
		public void reConf_Name(@RequestParam("warning") String warning, HttpServletResponse response){
			try {
				if(warning.equals("false")) {
					response.getWriter().print("한글로만 입력해주세요.");				
				}
			} catch (IOException e) {
				System.out.println(e);
			}
		}*/
	
	//	한글 이름 비동기 유효성 검사 방법2
	@RequestMapping(value="/employee/regConf_Name", produces = "application/text; charset=utf8")
	public @ResponseBody String reConf_Name(@RequestParam("warning") String warning){
		return warning;
	}
	
	//	주민번호 비동기 유효성 검사
	@RequestMapping(value="/employee/check_Jumin", produces = "application/text; charset=utf8")
	public @ResponseBody String checkJumin(@RequestParam("jumin_f") String jumin_f,
																		@RequestParam("jumin_b") String jumin_b,
																		@RequestParam("sawonNo") String sawonNo){
		String data = this.service.checkJuminService(jumin_f, jumin_b, sawonNo);
		return data;
	}
	// 등록 확인
	@RequestMapping("/employee/empViewInsert_ok")
	public String EmpViewInsertOk(sawonDTO sawonDTO,
											   @RequestParam("file_Txt") String file_Txt,
											   @RequestParam("file") MultipartFile file) throws IOException{

		this.service.insertSawonService(sawonDTO, file_Txt, file);
		return "redirect:/employee/empList/1";
	}
	// 사원 상세 정보
	@RequestMapping(value="/employee/empView")
	public String empView(HttpServletRequest request, Model model){
		model.addAttribute("sawonDTO", this.service.viewSawonService(request));
		return "/employee/empView";
	}
	// 사원 정보 업데이트
	@RequestMapping(value="/employee/empUpdate/{no}", method=RequestMethod.POST)
	public String empUpdate(@PathVariable int no,
										sawonDTO sawonDTO,
										@RequestParam("file_Txt") String file_Txt,
									   @RequestParam("file") MultipartFile file) throws IOException{
		this.service.updateSawonService(no, sawonDTO, file_Txt, file);
		return "redirect:/employee/empList/1";
	}

	@RequestMapping(value="/employee/empDelete")
	public String empDelete(HttpServletRequest request){
		this.service.deleteSawonService(request);
		return "redirect:/employee/empList/1";
	}
	

	// 엑셀 파일 업로드
	@RequestMapping(value = "/employee/excelFileUpload")
    public String excelFileUpload(){
        return "/employee/excelFileUpload";
    }
    @RequestMapping(value = "/employee/excelFileUpload_ok")
    public String excelFileUploadOk(@RequestParam("uploadFile") MultipartFile uploadFile, Model model)  throws Exception{
    	model.addAttribute(this.service.excelFileUpload(uploadFile));
        return "/employee/empViewInsert";
    }
    
    //엑셀파일로 다운로드
    @ResponseBody
    @RequestMapping(value = "/employee/excelFileDownload")
    public void excelDownloadAjax(HttpServletRequest request,
    													HttpServletResponse response) throws IOException{
        this.service.excelFileDownload(request, response);
    }
}
