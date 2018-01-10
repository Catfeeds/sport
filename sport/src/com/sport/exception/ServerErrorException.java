package com.sport.exception;

public class ServerErrorException extends RootException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public final static String SERVER_ERROR="服务器内部错误,请稍后再试!";
	public ServerErrorException(){
		super(SERVER_ERROR);
	}
	public ServerErrorException(String message){
		super(message);
	}
}
