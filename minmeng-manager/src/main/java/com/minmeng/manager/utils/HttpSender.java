package com.minmeng.manager.utils;

import com.minmeng.manager.action.cms.Content1Action;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.cookie.Cookie;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.log4j.Logger;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.nio.Buffer;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

/**
 * 发送http请求
 */
public class HttpSender {
	static final Logger log = Logger.getLogger(Content1Action.class);

	public static byte[] post(String URL, String json) {
		BasicCookieStore cookieStore = new BasicCookieStore();
		String obj = null;
		InputStream inputStream = null;
		Buffer reader = null;
		byte[] data = null;
		// 创建默认的httpClient实例.
		CloseableHttpClient httpclient = HttpClients.createDefault();
		// 创建httppost
		HttpPost httppost = new HttpPost(URL);
		httppost.addHeader("Content-type", "application/json; charset=utf-8");
		httppost.setHeader("Accept", "application/json");
		try {
			StringEntity s = new StringEntity(json, Charset.forName("UTF-8"));
			s.setContentEncoding("UTF-8");
			httppost.setEntity(s);
			CloseableHttpResponse response = httpclient.execute(httppost);
			try {
				// 获取相应实体
				HttpEntity entity = response.getEntity();
				List<Cookie> cookies = cookieStore.getCookies();
				if (cookies.isEmpty()) {
					System.out.println("None");
				} else {
					for (int i = 0; i < cookies.size(); i++) {
						System.out.println("- " + cookies.get(i).toString());
					}
				}
				return data;
			} finally {
				response.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 关闭连接,释放资源
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return data;
	}
	/**  将流 保存为数据数组
	 * @param inStream
	 * @return
	 * @throws Exception
	 */
	public static byte[] readInputStream(InputStream inStream) throws Exception {
		ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		// 创建一个Buffer字符串
		byte[] buffer = new byte[1024];
		// 每次读取的字符串长度，如果为-1，代表全部读取完毕
		int len = 0;
		// 使用一个输入流从buffer里把数据读取出来
		while ((len = inStream.read(buffer)) != -1) {
			// 用输出流往buffer里写入数据，中间参数代表从哪个位置开始读，len代表读取的长度
			outStream.write(buffer, 0, len);
		}
		// 关闭输入流
		inStream.close();
		// 把outStream里的数据写入内存
		return outStream.toByteArray();
	}

	/**
	 * 向指定 URL 发送POST方法的请求
	 */
	public static String sendPost(String url, String param) throws UnsupportedEncodingException, IOException {
		log.info(url+"------"+param);
		return sendPost(url, param, null);
	}

	public static String sendPost(String url, String param, Map<String, String> header)
			throws UnsupportedEncodingException, IOException {
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		URL realUrl = new URL(url);
		try {
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// 设置超时时间
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(15000);
			// 设置通用的请求属性
			if (header != null) {
				for (Entry<String, String> entry : header.entrySet()) {
					conn.setRequestProperty(entry.getKey(), entry.getValue());
				}
			}
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf8"));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			if (out != null) {
				out.close();
			}
			if (in != null) {
				in.close();
			}
		} catch (Exception e) {
			throw new Exception("请求超时!");
		} finally {
			if (out != null) {
				out.close();
			}
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}

			}
			return result;

		}
	}
}
