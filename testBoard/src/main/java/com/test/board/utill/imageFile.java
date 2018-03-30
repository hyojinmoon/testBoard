package com.test.board.utill;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.util.FileCopyUtils;

public class imageFile {
	@Resource(name="uploadPath")
	private String uploadPath;
	
	// 파일 업로드
	public String uploadFile(String originalName, byte[] uploadData) throws IOException{
			UUID uid = UUID.randomUUID();
			String savedName = uid.toString()+"_"+originalName;
			File target = new File(uploadPath, savedName);
			FileCopyUtils.copy(uploadData, target);
		return uploadPath+"/"+savedName;
	}
}
