package com.sport.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.Binarizer;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;

public class QrcodeTool {
	public static boolean getCodeImagesZipFile(String dirName,String imgParentDir, String zipName) {
		boolean re = false;
		try {
			File filepath=new File(dirName);
			if(!filepath.exists())
				filepath.mkdirs();
			filepath=new File(imgParentDir);
			if(!filepath.exists())
				filepath.mkdirs();
			CompressTool.zipFiles(imgParentDir, dirName+File.separator+zipName);
			re = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}
	//二维码图片内容为防伪码+服务器防伪验证地址，名字为产品编号，后者为服务器实际存放目录
	public static boolean encodeBatch(List<String> codes,List<String> productNumbers, String url,
			String parentDir) {
		boolean re = false;
		try {
			File path=new File(parentDir);
			if(!path.exists())
				path.mkdirs();
			String diskName;
			String qrcode;
			int index = 0;
			for (String code : codes) {
				qrcode = url + code;
				diskName = parentDir + File.separator + productNumbers.get(index) + ".jpg";
				encode(qrcode, diskName);
				index++;
			}
			re = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}
	

	@SuppressWarnings({ "unchecked", "deprecation" })
	public static void encode(String contents, String diskName) {
		MultiFormatWriter formatWriter = new MultiFormatWriter();
		@SuppressWarnings("rawtypes")
		Map hints = new HashMap();
		hints.put(EncodeHintType.CHARACTER_SET, QrcodeImage.DEFAULT_CHARSET);
		try {
			// 按照指定的宽度，高度和附加参数对字符串进行编码
			
			BitMatrix bitMatrix = formatWriter.encode(contents,
					BarcodeFormat.QR_CODE, QrcodeImage.DEFAULT_WIDTH,
					QrcodeImage.DEFAULT_HEIGHT, hints);
			
			File imageFile = new File(diskName);
			if(!imageFile.exists())
				imageFile.createNewFile();
			// 写入文件
			MatrixToImageWriter.writeToFile(bitMatrix, "png", imageFile);
			
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings({ "unchecked", "deprecation" })
	public static void encode(String contents,OutputStream stream) {
		MultiFormatWriter formatWriter = new MultiFormatWriter();
		@SuppressWarnings("rawtypes")
		Map hints = new HashMap();
		hints.put(EncodeHintType.CHARACTER_SET, QrcodeImage.DEFAULT_CHARSET);
		try {
			// 按照指定的宽度，高度和附加参数对字符串进行编码
			
			BitMatrix bitMatrix = formatWriter.encode(contents,
					BarcodeFormat.QR_CODE, QrcodeImage.DEFAULT_WIDTH,
					QrcodeImage.DEFAULT_HEIGHT, hints);
			
			// 写入文件
			MatrixToImageWriter.writeToStream(bitMatrix, "png", stream);
			
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	public static String decode(String imagePath) {
		String contents = null;

		MultiFormatReader formatReader = new MultiFormatReader();

		BufferedImage image;
		try {
			image = ImageIO.read(new File(imagePath));
			
			// 将图像数据转换为1 bit data
			LuminanceSource source = new BufferedImageLuminanceSource(image);
			Binarizer binarizer = new HybridBinarizer(source);
			// BinaryBitmap是ZXing用来表示1 bit data位图的类，Reader对象将对它进行解析
			BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);

			Map hints = new HashMap();
			hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");

			// 对图像进行解码
			Result result = formatReader.decode(binaryBitmap, hints);
			contents = result.toString();

			System.out.println("barcode encoding format :\t "
					+ result.getBarcodeFormat());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (NotFoundException e) {
			e.printStackTrace();
		}

		return contents;
	}
	public static String decode(File file) throws FileNotFoundException{
		return decode(new FileInputStream(file));
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	public static String decode(InputStream input) {
		String contents = null;
		MultiFormatReader formatReader = new MultiFormatReader();
		BufferedImage image;
		try {
			image = ImageIO.read(input);
			
			// 将图像数据转换为1 bit data
			LuminanceSource source = new BufferedImageLuminanceSource(image);
			Binarizer binarizer = new HybridBinarizer(source);
			// BinaryBitmap是ZXing用来表示1 bit data位图的类，Reader对象将对它进行解析
			BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);

			Map hints = new HashMap();
			hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");

			// 对图像进行解码
			Result result = formatReader.decode(binaryBitmap, hints);
			contents = result.toString();

			System.out.println("barcode encoding format :\t "
					+ result.getBarcodeFormat());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (NotFoundException e) {
			e.printStackTrace();
		}

		return contents;
	}
}
