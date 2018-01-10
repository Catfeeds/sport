package com.sport.dto;

import javax.annotation.Resource;

import com.sport.entity.Comment;
import com.sport.entity.Product;
import com.sport.service.CommentService;

public class AvgComment {
	private int score;//某产品的平均得分
	private boolean half;//是否有半星，1舍2入
	private Comment comment;//谁的评论
	private CommentService commentService;
	public AvgComment init(CommentService commentService,Comment comment){
		this.commentService=commentService;
		double aveScore=commentService.getCommentNumber(comment);
		score=(int)aveScore;
		if((aveScore-score)>0.3&&((aveScore-score)<0.8))
			half=true;
		else if((aveScore-score)>=0.8){
			score=5;
			half=false;
		}
		System.out.println("avgScore:"+aveScore+" score:"+score+" half:"+half);
		return this;
	}
	public int getScore() {
		return score;
	}
	public AvgComment setScore(int score) {
		this.score = score;
		return this;
	}
	public boolean isHalf() {
		return half;
	}
	public AvgComment setHalf(boolean half) {
		this.half = half;
		return this;
	}
	
	public CommentService getCommentService() {
		return commentService;
	}

	public AvgComment setCommentService(CommentService commentService) {
		this.commentService = commentService;
		return this;
	}
	public Comment getComment() {
		return comment;
	}
	public AvgComment setComment(Comment comment) {
		this.comment = comment;
		return this;
	}
	
}
