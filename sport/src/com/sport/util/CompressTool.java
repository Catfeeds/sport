package com.sport.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.Adler32;
import java.util.zip.CheckedOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class CompressTool {

	// 压缩文件测试
	// 1.zip
	public static boolean zipFiles(String dirName,String zipName) {
		boolean re = false;
		
		// 1.确定需要压缩的文件
		File path = new File(dirName);
		File[] filenames = path.listFiles();
		// 2.创建压缩文件输入流
		ZipOutputStream zipout;
		try {
			zipout = new ZipOutputStream(// 文件压缩流
					new BufferedOutputStream(// 内存缓冲流
							new CheckedOutputStream(
									// 流数据检查
									new FileOutputStream(zipName),
									new Adler32())));// 文件流
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
			return re;
		}
		for (int i = 0; i < filenames.length; i++) {
			BufferedInputStream fin = null;
			try {
				fin = new BufferedInputStream(new FileInputStream(filenames[i]));
			} catch (FileNotFoundException e1) {
				e1.printStackTrace();
			}
			try {
				zipout.putNextEntry(new ZipEntry(filenames[i].getName()));
				int r = -1;
				while ((r = fin.read()) != -1) {
					zipout.write(r);
				}
				re = true;
			} catch (IOException e) {
				e.printStackTrace();
				return re;
			} finally {
				try {
					fin.close();
				} catch (IOException e) {
					e.printStackTrace();
					return re;
				}
			}

		}
		try {
			zipout.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return re;
	}
}
