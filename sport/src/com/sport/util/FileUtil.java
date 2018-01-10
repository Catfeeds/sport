package com.sport.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

import com.sport.exception.PromptException;

public class FileUtil {
	public static String saveFile(File file,String path,String companyIdStr,String fileName)throws PromptException{
		
		try{
			String fullPathName=path+File.separator+companyIdStr+File.separator+fileName;
			File filepath=new File(path+File.separator+companyIdStr);
			if(!filepath.exists())
				filepath.mkdir();
			File f=new File(fullPathName);
			if(f.exists()){
				throw new PromptException("文件"+fileName+"已经存在，请更名后再上传！");
			}
			file.renameTo(f);
			return fullPathName;
		}catch(PromptException e){
			throw e;
		}			
		catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	public static boolean deleteFile(String diskName) throws PromptException{
		boolean re=false;
		try{
			File file=new File(diskName);
			file.delete();
			re=true;
		}catch(Exception e){
			re=false;
			e.printStackTrace();
			throw new PromptException("删除文件失败，请检查文件路径是否无误！");
		}
		return re;		
	}
	public static File renameFile(String oldFileName,String newFileName) throws PromptException{
		File file=new File(oldFileName);
		File newFile=new File(newFileName);
		if(file.renameTo(newFile))
			return newFile;
		throw new PromptException("该文件不存在，无法重命名！");
	}
	public static boolean deleteFiles(String[] pathNames) throws Exception{
		boolean re=false;
		try{
			for(String name:pathNames){
				deleteFile(name);
			}
		}catch(Exception e){
			re=false;
			e.printStackTrace();
			throw e;
		}
		return re;
	}
	 public static OutputStream readFileToStream(String diskName,OutputStream output) throws PromptException {
	        File file = new File(diskName);
	        if (!file.exists() || file.isDirectory()) {
	        	throw new PromptException("该文件不存在，请确认后再下载！");
	        }
	        BufferedInputStream input =null;
	        try {
	            input = new BufferedInputStream(new FileInputStream(file));
	            int r=-1;
				while((r=input.read())!=-1){
					output.write(r);
				}
	        } catch (Exception e) {} finally {
	            try {
	            	if(output!=null)
	            	{
	            		output.flush();
	            		output.close();
	            	}
	                if(null !=input) {
	                    input.close();
	                }
	            } catch (Exception e) {
	            	throw new PromptException("服务器内部错误，请刷新页面重试！");
	            }
	        }
	        return output;
	    }
}
