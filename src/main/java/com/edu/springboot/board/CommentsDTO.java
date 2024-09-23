package com.edu.springboot.board;

import java.sql.Date;

import lombok.Data;

@Data
public class CommentsDTO {
	private int comm_idx;
	private Date postdate;
	private String content;
	private int board_ref;
	private String writer_ref;
}