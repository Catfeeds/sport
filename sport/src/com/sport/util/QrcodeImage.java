package com.sport.util;

public class QrcodeImage {
	public static final int BLACK = 0xff000000;
	public static final int WHITE = 0xFFFFFFFF;
	public static final String 	DEFAULT_CHARSET="utf-8";
	public static final int DEFAULT_WIDTH=200;
	public static final int DEFAULT_HEIGHT=200;
	private String fileName;
	private String charset;
	private int width;
	private int height;
	public String getFileName() {
		return fileName;
	}
	public QrcodeImage setFileName(String fileName) {
		this.fileName = fileName;
		return this;
	}
	public String getCharset() {
		return charset;
	}
	public QrcodeImage setCharset(String charset) {
		this.charset = charset;
		return this;
	}
	public int getWidth() {
		return width;
	}
	public QrcodeImage setWidth(int width) {
		this.width = width;
		return this;
	}
	public int getHeight() {
		return height;
	}
	public QrcodeImage setHeight(int height) {
		this.height = height;
		return this;
	}
	
}
