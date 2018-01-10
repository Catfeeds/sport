package com.sport.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sport.entity.Comment;
import com.sport.entity.Company;
import com.sport.entity.Order;
import com.sport.entity.OrderItem;
import com.sport.entity.User;
import com.sport.exception.PromptException;
import com.sport.exception.RootException;
import com.sport.exception.ServerErrorException;
import com.sport.service.CommentService;
import com.sport.service.OrderItemService;
import com.sport.service.OrderService;
@Component
@Scope("prototype")
public class CommentAction extends RootAction{
	private Comment comment;
	private CommentService commentService;
	private List<Comment> comments;
	private OrderItem item;
	private Order order;
	private OrderService orderService;
	private OrderItemService orderItemService;
	
	//为某订单项添加一条评论
	public void addComment() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		User u=(User)session.get("currentUser");
		try {
			item=orderService.load(order).getItems().get(0);	//目前只对第一个订单项评论	
			comment.setUser(item.getOrder().getBuyer());
			comment.setProduct(item.getProduct())
					.setCoach(item.getCoach())
					.setCompany(item.getOrder().getCompany());
					
			Company company=null;	
			if(item.getPlace()!=null){
				company=item.getPlace().getSite().getCompany();
			}else{
				company=item.getCoach().getCompany();
			}
			comment.setCompany(company);		
			commentService.add(comment);
			item.setComment(comment);
			orderItemService.update(item);
			json.add(true);
			json.add("发表评论成功！");
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		}catch(Exception e){
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	//删除一条评论,平台管理员才能具有该权限
	public void deleteComment() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			//System.out.println("删除评论开始!");
			commentService.delete(comment);			
			json.add(true);
			
		} catch(Exception e){
			e.printStackTrace();
			json.add(false);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	//举报某评论
	public void reportComment() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			Comment c=commentService.load(comment);
			c.setHasReport(true).setReportCause(comment.getReportCause());
			commentService.update(c);
			json.add(true);
			json.add("举报评论成功，请耐心等待管理员回复！");
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		}catch(Exception e){
			json.add(true);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	//管理员回复某评论
	public void replyComment() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try {
			Comment c=commentService.load(comment);
			c.setReplyContent(comment.getReplyContent()).setHasReply(true);
			commentService.update(c);
			json.add(true);
			json.add("回复评论成功！");
		} catch (RootException e) {
			json.add(false);
			json.add(e.toString());
		}catch(Exception e){
			json.add(true);
			json.add(RootException.SYSTEM_ERROR);
		}
		out.println(json);
		this.closeOut();
	}
	//分页查看满足某条件的评论信息,可根据传参决定查看谁的评论
	public String commentList() throws PromptException, ServerErrorException{
		try{
			comments=new ArrayList<Comment>();
			page.setTotalItemNumber(commentService.findComments(comments, comment, page.getPageNumber(),page.getPageSize()));
		}catch(Exception e){
			e.printStackTrace();
			throw new ServerErrorException();
		}
		return "commentList";
	}
	//批量删除评论
	public void deleteSelectedComments() throws ServerErrorException{
		this.getResponseAndOut();
		JSONArray json=new JSONArray();
		try{
			commentService.deleteSelectedComments(ids);
			json.add(true);
		}catch(Exception e){
			e.printStackTrace();
			json.add(false);
			json.add("批量删除评论失败！");
		}
		out.println(json);
		this.closeOut();		
	}
	//查看操作均放在其他需要评论的模块里即可
	/************注入代码**********/
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	public CommentService getCommentService() {
		return commentService;
	}
	@Resource
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	public Comment getComment() {
		return comment;
	}
	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public OrderItem getItem() {
		return item;
	}
	public void setItem(OrderItem item) {
		this.item = item;
		
	}
	public OrderItemService getOrderItemService() {
		return orderItemService;
	}
	@Resource
	public void setOrderItemService(OrderItemService orderItemService) {
		this.orderItemService = orderItemService;
		
	}
	public OrderService getOrderService() {
		return orderService;
	}
	@Resource
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
		
	}
	
}
