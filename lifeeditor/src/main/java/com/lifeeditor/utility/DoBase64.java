package com.lifeeditor.utility;

import java.io.UnsupportedEncodingException;
import java.util.Base64;

public class DoBase64 {
	public final static Base64.Encoder encoder = Base64.getEncoder();
	public final static Base64.Decoder decoder = Base64.getDecoder();
	
	public static String encode(String txt) {
		byte[] txtBytes = null;
		try {
			txtBytes = txt.getBytes("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return encoder.encodeToString(txtBytes);
	}
	
	public static String decode(String encodeTxt) {
		try {
			return new String(decoder.decode(encodeTxt),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
}
