package com.sport.exception;

public class RootException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//通用提示信息相关常量
		//增、删、改、查信息不完善提示错误
		public final static String NEED_MORE_ADD_INFO="您需要输入更多信息才能添加该记录！";
		public final static String NEED_MORE_UPDATE_INFO="您需要输入更多信息才能更新该记录！";
		public final static String NEED_MORE_DELETE_INFO="您需要输入更多信息才能删除该记录！";
		public final static String NEED_MORE_FIND_INFO="需要输入所有必要信息，才能查找您想要的信息！";		
		//添加或更新数据时出现的错误信息
		public final static String ALREADY_EXISTS="已经存在该记录了,无法继续添加!";
		public final static String NOT_EXISTS="不存在该条记录，无法删除或修改！请检查您的信息是否完善！";
		public final static String NOT_ALLOWED="不允许删除或修改该信息！";
		//提示
		public final static String INPUT_ERROR_INFO="输入信息有误,请重新输入!";
		//系统内部错误
		public final static String SYSTEM_ERROR="系统内部错误，请稍后再试！";
		public RootException(String message){
			super(message);
		}
		@Override
		public String toString() {
			return this.getMessage();
		}
}
