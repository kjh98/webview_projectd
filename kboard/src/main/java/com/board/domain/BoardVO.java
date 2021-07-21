package com.board.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
/*
 create table tbl_board(
 bno in not null auto_increment,
 title varchar(50) not null,
 content text not null,
 writer varchar(30) not null,
 regDate timestamp not null default now(),
 viewCnt in default 0,
 primary key(bno)
 ); 
 */
	private int bno;
	private int rownum;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private int viewCnt;
	private String ufile_name;
	private String file_name;
	private String fileName;
	private MultipartFile uploadFile;
	

	public String getUfile_name() {
		return ufile_name;
	}
	public void setUfile_name(String ufile_name) {
		this.ufile_name = ufile_name;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	
	
}
