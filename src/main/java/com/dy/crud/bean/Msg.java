package com.dy.crud.bean;
/**
 * 通用的返回的类，用于服务器返回给浏览器的状态
 * @author dy
 *
 */

import java.util.HashMap;
import java.util.Map;

import javax.print.attribute.HashAttributeSet;

public class Msg {
	
	private int code;//状态码100-成功，200-失败
	private String msg;//提示信息
	//用户要返回给浏览器的数据保存在map中
	private Map<String, Object> extend = new HashMap<String, Object>();

	//请求成功
	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("处理成功");//提示消息
		return result;
	}
	//请求失败
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("处理失败");
		return result;
	}

	//能链式操作，仍然返回Msg对象
	//能快捷返回信息的方法
	public Msg add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	
}
