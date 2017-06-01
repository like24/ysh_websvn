package com.yoga.controller.v2.api;
/**
 * 返回错误代码，枚举类
 * @author king
 *
 */
public enum QCode {
	SUCCESS("200","SUCCESS"), 
	ERROR( "-1",   "FAIL"),
	TOKEN_INVALID("-2","TOKEN INVALID");
	
	/**
	 * @param code
	 * @param msg
	 */
	private QCode ( String code ,String msg ) {
		this.code = code;
		this.msg = msg;
	}


	private String code;
	private String msg;

	public String getCode(){
		return code;
	}
	public void setCode(String code){
		this.code = code;
	}
	public String getMsg(){
		return msg;
	}
	public void setMsg(String msg){
		this.msg = msg;
	}
}
