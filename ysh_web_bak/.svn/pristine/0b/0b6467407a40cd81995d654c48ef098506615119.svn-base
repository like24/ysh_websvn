package com.yoga.controller.v2;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.RoundingMode;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.web.servlet.ModelAndView;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.yoga.dao.System_user;
import com.yoga.dao.Weixin_blog_content;
import com.yoga.dao.Weixin_blog_teacher_course; 
import com.yoga.dao.Weixin_blog_user; 
import com.yoga.dao.Weixin_blog_user_msg;
import com.yoga.service.SystemIFace;
import com.yoga.service.WeixinBlogLiveIFace;
import com.yoga.service.WeixinBlogManagerIFace;
import com.yoga.service.WeixinManagerIFace;
import com.yoga.service.WeixinOrderIFace;
import com.yoga.service.WeixinOtherIFace;
import com.yoga.service.impl.SystemIFaceImpl;
import com.yoga.service.impl.WeixinBlogLiveIFaceImpl;
import com.yoga.service.impl.WeixinBlogManagerIFaceImpl;
import com.yoga.service.impl.WeixinManagerIFaceImpl;
import com.yoga.service.impl.WeixinOrderIFaceImpl;
import com.yoga.service.impl.WeixinOtherIFaceImpl;
import com.yoga.service.impl.saler.WeixinSalerIFaceImpl;
import com.yoga.service.impl.v2.WeixinV2IndexHomeIFaceImpl;
import com.yoga.service.saler.WeixinSalerIFace;
import com.yoga.service.v2.WeixinV2IndexHomeIFace;
import com.yoga.utils.Config;
import com.yoga.utils.HttpClientUtil;
import com.yoga.utils.ObjectSerializer;
import com.yoga.weixin.WeixinUtil;
import com.yoga.weixin.template.TemplateData;
import com.yoga.weixin.template.WxTemplate;

import net.sf.json.JSONObject;
import rewin.ubsi.Client;

/**
 * 
 * @author harry
 *
 */
public class R {
 
	
	protected static String getDecimalNumber( int m ,String bl ){
		if( bl.equals("10") ){ return String.valueOf(m); }
		if( bl.equals("0")){ return "0"; }
		DecimalFormat df = (DecimalFormat)NumberFormat.getInstance();  
		df.setMaximumFractionDigits(2);  
		df.setRoundingMode(RoundingMode.HALF_UP); 
		return df.format(m * ( Double.parseDouble("0."+bl))).replaceAll(",", "");
	}


	/**
	 * 是否是表情格式！
	 * @param s
	 * @return
	 */
	boolean requiresMb4(String s) {
		int len = s.length();
		return len != s.codePointCount(0, len);
	}

	/**
	 * 提示信息
	 */
	protected final String ERROR_TMSG="非法操作，限制性关键词输入:";

	public final String DOMAIN = Config.getString("domain");
	public final String CDNDOMAIN = Config.getString("cdndomain");

	/** 后台页面条数  */
	public static final int pageSize = 10 ;

	/** 密匙   */
	public static final String cKey = "1234567890aaadd1";

	/** 系统SESSION  */
	public static final String USER_SESSSION_KEY = "system_user";

	/** 微信SESSION */
	public static final String WEIXIN_SESSSION_KEY = "weixin_user";

	/** 主库 */
	protected static final String DATABASE_MASTER = "master";

	/** 从库  */
	protected static final String DATABASE_SLAVE  = "slave";

	/** 文章Cache名称  */
	public static final String ARTICLE = "ARTICLE";

	/** 用户  */
	public static final String USER    = "USER";

	/** SDF  */
	protected static final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/** FILE EXT  */
	public static String generateRandomFileName(String fileExt) {
		return UUID.randomUUID().toString() + "." + fileExt;
	}


	private String inj_str = Config.getString("INJ_STR");


	/**
	 * 转移半角的分号和逗号
	 * @param str
	 * @return
	 */
	public String tranInjStr( String str ){
		if( str == null )
			return "";
		str = str.replaceAll("'", "‘");
		str = str.replaceAll(",", "，"); 
		return str;
	}


	/**
	 * 检查语句是否被SQL注入 
	 * @param content
	 * @return
	 */
	protected Object[] isSQLInj( String content ){
		if( content == null || content.length() == 0 )
			return new Object[]{false,""};
		String [] injList = inj_str.split("\\|");
		for( String inj : injList ){
			if( content.toLowerCase().indexOf( inj ) > -1 )
				return new Object[]{true,inj };
		} 
		return new Object[]{false,""};
	}



	// sdf
	protected final java.text.SimpleDateFormat sdf_date = new java.text.SimpleDateFormat("yyyy-MM-dd");

	/** 状态码  */
	public final int STATUS_ERROR = -1;

	/**
	 * 获得当前系统时间
	 * @return
	 */
	public static String getTime(){
		return sdf.format( new Date() );
	}



	/**
	 * 获得当前系统时间
	 * @return
	 */
	protected String getDate(){
		return sdf_date.format( new Date() );
	}



	/**
	 * 去除null
	 * @param str
	 * @return
	 */
	protected String trim( String str ){
		if( str == null || str.trim().toLowerCase().equals("null"))
			return "";
		return tranInjStr(str);
	}



	/**
	 * 去除null
	 * @param str
	 * @return
	 */
	protected String trim( String str, String defalut ){
		if( str == null || str.trim().toLowerCase().equals("null"))
			return "";
		return defalut;
	}




	/**
	 * 是否是空
	 * @param str
	 * @return
	 */
	public boolean isEmpty( String str ){
		if( str == null || str.equals("") )
			return true;
		return false;
	}


	public final static double EARTH_RADIUS = 6378137;


	/**
	 * 获取距离
	 * @param lat1  位置1纬度
	 * @param lng1  位置1经度
	 * @param lat2  位置2纬度
	 * @param lng2  位置2经度
	 * @return
	 */
	public static double getDistance(double lat1, double lng1, double lat2, double lng2){
		double radLat1 = Math.toRadians(lat1);
		double radLat2 = Math.toRadians(lat2);
		double a = radLat1 - radLat2;
		double b = Math.toRadians(lng1) - Math.toRadians(lng2);
		double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a/2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b/2), 2)));
		return  Math.round(s * EARTH_RADIUS * 10000) / 10000;
	}



	/**
	 * 将字节转换为十六进制字符串
	 * @param mByte
	 * @return
	 */
	protected final String byteToHexStr(byte mByte) {
		char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		char[] tempArr = new char[2];
		tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
		tempArr[1] = Digit[mByte & 0X0F];
		String s = new String(tempArr);
		return s;
	}


	protected String create_nonce_str() {
		return UUID.randomUUID().toString().replace("-", "");
	}

	protected String create_timestamp() {
		return Long.toString(System.currentTimeMillis() / 1000);
	}



	/**
	 * 将字节数组转换为十六进制字符串
	 * @param byteArray
	 * @return
	 */
	protected String byteToStr(byte[] byteArray) {
		String strDigest = "";
		for (int i = 0; i < byteArray.length; i++) {
			strDigest += byteToHexStr(byteArray[i]);
		}
		return strDigest;
	}



	public String getIpAddr(HttpServletRequest request) {      
		String ip = request.getHeader("x-forwarded-for");      
		if(ip ==null || ip.length() ==0 || "unknown".equalsIgnoreCase(ip)) {      
			ip = request.getHeader("Proxy-Client-IP");      
		}      
		if(ip ==null || ip.length() ==0 || "unknown".equalsIgnoreCase(ip)) {      
			ip = request.getHeader("WL-Proxy-Client-IP");      
		}      
		if(ip ==null || ip.length() ==0 || "unknown".equalsIgnoreCase(ip)) {      
			ip = request.getRemoteAddr();      
		}      
		return ip;      
	}  

	public String getUUID(){
		return UUID.randomUUID().toString().replaceAll("-", "").substring(4,9);
	}

	/**
	 * get Login user info
	 * @Title: getLoginUserInfo   
	 * @param session 
	 * @return User_info  
	 * @throws
	 */
	@Deprecated
	public System_user getLoginUserInfo(HttpSession session){
		if(session == null){
			return null;
		}
		Object object = session.getAttribute(USER_SESSSION_KEY ); 
		if(object == null){
			return null;
		}
		return (System_user)object;
	}


	protected static final SystemIFace  service = new SystemIFaceImpl();

	protected static final WeixinBlogManagerIFace  weixin = new WeixinBlogManagerIFaceImpl();

	protected static final WeixinManagerIFace  manager = new WeixinManagerIFaceImpl();

	protected static final WeixinOrderIFace  order = new WeixinOrderIFaceImpl();

	protected static final WeixinOtherIFace  other = new WeixinOtherIFaceImpl();

	protected static final WeixinSalerIFace  saler = new WeixinSalerIFaceImpl();
	
	// 
	protected static final WeixinV2IndexHomeIFace v2Index = new WeixinV2IndexHomeIFaceImpl();
     
	// 直播业务
	protected static final WeixinBlogLiveIFace live = new WeixinBlogLiveIFaceImpl();
	
	// http接口
	protected static HttpClientUtil  httpClient = new HttpClientUtil();

	/**
	 * 
	 * @param msg
	 */
	public static void insertMsg( Weixin_blog_user_msg msg ) {
		weixin.addOrUpdateUserMsg( msg );
	}





	/**  
	 * 下载远程文件并保存到本地  
	 * @param remoteFilePath 远程文件路径   
	 * @param localFilePath 本地文件路径  
	 */
	public static void downloadFile(String remoteFilePath, String localFilePath){
		URL urlfile = null;
		HttpURLConnection    httpUrl = null;
		BufferedInputStream  bis     = null;
		BufferedOutputStream bos     = null;
		File f = new File( localFilePath );
		try {
			urlfile = new URL(remoteFilePath);
			httpUrl = (HttpURLConnection)urlfile.openConnection();
			httpUrl.setReadTimeout(20000);
			httpUrl.connect();
			bis = new BufferedInputStream(httpUrl.getInputStream());
			bos = new BufferedOutputStream(new FileOutputStream(f));
			int len = 20480;
			byte[] b = new byte[len];
			while ((len = bis.read(b)) != -1) {
				bos.write(b, 0, len);
			}
			bos.flush();
			bis.close();
			httpUrl.disconnect();
		} catch (Exception e)  {
			e.printStackTrace();
		}  finally  {
			try {
				bis.close();
				bos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}


	public static String getCdnPath( String images ) {
		if( images == null || images.length() == 0 )
			return "";
		return images.substring( images.lastIndexOf("/")+1 , images.length());
	}


	protected Weixin_blog_user getWeixinSession(HttpServletRequest request,HttpSession session){
		Weixin_blog_user user = (Weixin_blog_user) session.getAttribute( WEIXIN_SESSSION_KEY);
		if( user != null ){
			return user;
		}
		Cookie[] cookies = request.getCookies();
		String   wxid    = null;
		if( cookies != null ){
			for( Cookie cook : cookies ){
				if( cook.getName().equals("wxid") ){
					wxid = cook.getValue();
				}
			}
		} 
		if( wxid != null && !wxid.equals("") ){
			Client  client = null;
			try {
				client = Client.newInstance( Client.TCP );
				Object[] res = client.sendRequest(SERVER_NAME, "getSession", new Object[]{ wxid });
				if( res != null && (Boolean)res[0] ){
					byte[] userseaa = (byte[]) res[1];
					user = (Weixin_blog_user) serializer.deserialize( userseaa );
				}
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		return user;
	}


    
	/**
	 * 
	 * @param request
	 * @param session
	 */
	public void removeSession(HttpSession session){
		 session.removeAttribute( WEIXIN_SESSSION_KEY );
	}


	/**
	 * 还原标签
	 * @param html
	 * @return
	 */
	public static String transHtml( String html ) {
		if( html  == null )
			return "";
		//		html.replaceAll(" +", "");
		return html.replaceAll(" ","&nbsp;").replaceAll("\n", "<br>").replaceAll("\r", "<br>");
	}



	/**
	 * 转义可能会在页面上存在问题的符号
	 * @param str
	 * @return
	 */
	public static String replaceBlank(String str) {
		if( str == null )
			return "";
		str = str.replace("\"","^");
		str = str.replace("'", "^");
		String dest = "";
		if (str!=null) {
			Pattern p = Pattern.compile("\\s*|\t|\r|\n");
			Matcher m = p.matcher(str);
			dest = m.replaceAll("");
		}
		return dest;
	}



	/** 
	 * 显示时间，如果与当前时间差别小于一天，则自动用**秒(分，小时)前，如果大于一天则用format规定的格式显示 
	 * @param ctime  时间 
	 * @param format 格式 格式描述:例如:yyyy-MM-dd yyyy-MM-dd HH:mm:ss 
	 * @return 
	 */  
	public static String showTime(String ctime) {  
		String r = "";  
		if(ctime==null)return r;  
		long nowtimelong = System.currentTimeMillis();  
		long ctimelong = 0;
		try {
			ctimelong = sdf.parse(ctime).getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}  
		long result = Math.abs(nowtimelong - ctimelong);  
		if(result < 60000){// 一分钟内  
			long seconds = result / 1000;  
			if(seconds == 0){  
				r = "刚刚";  
			}else{  
				r = seconds + "秒前";  
			}  
		}else if (result >= 60000 && result < 3600000){// 一小时内  
			long seconds = result / 60000;  
			r = seconds + "分钟前";  
		}else if (result >= 3600000 && result < 86400000){// 一天内  
			long seconds = result / 3600000;  
			r = seconds + "小时前";  
		}else if (result >= 86400000 && result < 1702967296){// 三十天内  
			long seconds = result / 86400000;  
			r = seconds + "天前";  
		}else{ 
			r = ctime.split(" ")[0].substring(5)  ;
		}  
		return r;  
	}  




	/**
	 * 签名URL 
	 * @param map
	 * @param url
	 */
	protected void jsapiSignatureURL( HashMap<String,Object> map, String url, Object ticket ){
		if( ticket == null || ticket.equals("")){
			return;
		}
		String nonce_str = create_nonce_str();
		String timestamp = create_timestamp();
		String string1;
		String signature = "";
		string1 = "jsapi_ticket=" + ticket +"&noncestr=" + nonce_str +"&timestamp=" + timestamp +"&url=" + url;
		try { 
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			byte[] digest = md.digest(string1.toString().getBytes());
			signature = byteToStr( digest ).toLowerCase();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();                                                                                                                                                                                                                                                                               
		}  
		map.put("url", url);
		map.put("jsapi_ticket", ticket);
		map.put("nonceStr",  nonce_str);
		map.put("appid",     Config.getString("weixin.appid") );
		map.put("timestamp", timestamp);
		map.put("signature", signature);
	}





	/**
	 * 获取支付所需签名
	 * @param ticket
	 * @param timeStamp
	 * @param card_id
	 * @param code
	 * @return
	 * @throws Exception
	 */
	public static String getPayCustomSign(Map<String, String> bizObj,String key)  {
		String bizString = null;
		String sign = null;
		try {
			bizString = FormatBizQueryParaMap(bizObj, false);
			sign = sign(bizString, key);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sign;
	}



	/**
	 * FormatBizQueryParaMap
	 * @param paraMap
	 * @param urlencode
	 * @return
	 * @throws Exception
	 */
	public static String FormatBizQueryParaMap(
			Map<String, String> paraMap,
			boolean urlencode ) throws Exception {
		String buff = "";
		try {
			List<Map.Entry<String, String>> infoIds = new ArrayList<Map.Entry<String, String>>( paraMap.entrySet());
			Collections.sort(infoIds, new Comparator<Map.Entry<String, String>>() {
				public int compare(Map.Entry<String, String> o1,
						Map.Entry<String, String> o2) {
					return (o1.getKey()).toString().compareTo( o2.getKey());
				}
			});
			for (int i = 0; i < infoIds.size(); i++) {
				Map.Entry<String, String> item = infoIds.get(i);
				if (item.getKey() != "") {
					String key = item.getKey();
					String val = item.getValue();
					if (urlencode) {
						val = URLEncoder.encode(val, "utf-8");
					}
					buff += key + "=" + val + "&";
				}
			}
			if (buff.isEmpty() == false) {
				buff = buff.substring(0, buff.length() - 1);
			}
		} catch (Exception e) {
			throw new Exception(e.getMessage());
		}
		return buff;
	}


	/**
	 * MD5
	 * @param s
	 * @return
	 */
	public final static String MD5(String s) {
		char hexDigits[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};       
		try {
			byte[] btInput = s.getBytes();
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			mdInst.update(btInput);
			byte[] md = mdInst.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}


	/**
	 * 
	 * @param str
	 * @return
	 */
	public static boolean IsNumeric(String str) {
		if (str.matches("\\d *")) {
			return true;
		} else {
			return false;
		}
	}





	public  String orderNum(){
		String chars = "0123456789";
		String order = System.currentTimeMillis()+"";
		String res = "";
		for (int i = 0; i < 19; i++) {
			Random rd = new Random();
			res += chars.charAt(rd.nextInt(chars.length() - 1));
		}
		order+=res;
		return order;
	}



	public static JSONObject xml2JSON(InputStream is) {  
		JSONObject obj = new JSONObject();  
		try {  
			SAXReader sb = new SAXReader();  
			Document doc = sb.read(is);
			Element root = doc.getRootElement();  
			obj.put(root.getName(), iterateElement(root));  
			return obj;  
		} catch (Exception e) {  
			return null;  
		}  
	}  






	/**
	 * Sign
	 * @param content
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static String sign(String content, String key) throws Exception{
		String signStr = "";
		signStr = content + "&key=" + key;
		return MD5(signStr).toUpperCase();
	}



	/**
	 * 
	 * @param arr
	 * @return
	 */
	public static String ArrayToXml(Map<String, String> arr) {
		String xml = "<xml>";
		Iterator<Entry<String, String>> iter = arr.entrySet().iterator();
		while (iter.hasNext()) {
			Entry<String, String> entry = iter.next();
			String key = entry.getKey();
			String val = entry.getValue();
			if (IsNumeric(val)) {
				xml += "<" + key + ">" + val + "</" + key + ">";
			} else
				xml += "<" + key + "><![CDATA[" + val + "]]></" + key + ">";
		}
		xml += "</xml>";
		return xml;
	}



	/** 
	 * 一个迭代方法 
	 * @param element   : org.jdom.Element 
	 * @return java.util.Map 实例 
	 */  
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static Map  iterateElement(Element element) {  
		List jiedian = element.elements() ;
		Element et = null;  
		Map obj = new HashMap();  
		List list = null;  
		for (int i = 0; i < jiedian.size(); i++) {  
			list = new LinkedList();  
			et = (Element) jiedian.get(i);  
			if (et.getTextTrim().equals("")) {  
				if (et.elements().size() == 0)  
					continue;  
				if (obj.containsKey(et.getName())) {  
					list = (List) obj.get(et.getName());  
				}  
				list.add(iterateElement(et));  
				obj.put(et.getName(), list);  
			} else {  
				if (obj.containsKey(et.getName())) {  
					list = (List) obj.get(et.getName());  
				}  
				list.add(et.getTextTrim());  
				obj.put(et.getName(), list);  
			}  
		}  
		return obj;  
	} 

	/**
	 * 自动压缩图片
	 * @param imgsrc
	 * @param imgdist
	 * @param widthdist
	 * @param heightdist
	 */
	public static void reduceImg(String imgsrc, String imgdist, int widthdist, int heightdist) {        
		try {        
			File srcfile = new File(imgsrc);        
			if ( !srcfile.exists() ) {        
				return;        
			}        
			Image src = javax.imageio.ImageIO.read(srcfile);        
			BufferedImage tag= new BufferedImage((int) widthdist, (int) heightdist,   BufferedImage.TYPE_INT_RGB);        
			tag.getGraphics().drawImage(src.getScaledInstance(widthdist, heightdist,  Image.SCALE_SMOOTH), 0, 0,  null);        
			FileOutputStream out = new FileOutputStream(imgdist);        
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);        
			encoder.encode(tag);        
			out.close();        
		} catch (IOException ex) {        
			ex.printStackTrace();        
		}        
	}   


	protected static final ObjectSerializer serializer = new ObjectSerializer();

	protected static final String SERVER_NAME = "com.yoga.listener.WeixinSessionServer";


	/**
	 * 微信注册用户
	 * @param code
	 * @param user
	 * @param session
	 */
	public String regeditWeixinUser( 
			String           code,  
			Weixin_blog_user user, 
			HttpServletResponse response,
			HttpSession session
			){
		JSONObject result = null;
		if( code != null && code.length() > 0  ) {
			result = JSONObject.fromObject( httpClient.doGet( 
					"https://api.weixin.qq.com/sns/oauth2/access_token?appid="
							+Config.getString("weixin.appid")
							+"&secret="+Config.getString("weixin.appsecret")
							+"&code="+code+"&grant_type=authorization_code"
					));
			if( result ==null || !result.containsKey("openid") ){
				return null;
			}
			String access_token = null;
			String openid = result.getString("openid");
			if( result != null && result.containsKey("access_token") ) { 
				access_token = result.getString("access_token");
				user = weixin.getWeixinUserByWid( openid );
				if( user != null ){
					session.setAttribute(  WEIXIN_SESSSION_KEY , user);
					setUserSession(user,response);
					weixin.updateAccessTime( user.getId() );
				}
				if( user == null ) {  // 没有注册过
					if( result != null && result.containsKey("openid") ) {
						JSONObject user_ = JSONObject.fromObject( 
								httpClient.doGet( 
										"https://api.weixin.qq.com/sns/userinfo?access_token="+access_token+"&openid="+result.getString("openid")
										) 
								);
						user = new Weixin_blog_user();
						user.setCreatetime( sdf.format( new Date()) );
						if(user_.containsKey("nickname")){
							user.setNickname( user_.getString("nickname") );
						}else{
							user.setNickname("");
						}
						user.setSex( Integer.valueOf( user_.getString("sex") ));
						user.setWxid(  openid );
						user.setFile_path( user_.getString("headimgurl") );
						user.setUnionid( user_.getString("unionid")+"@harry" );
						user.setLast_access_time( sdf.format( new Date()) );
						
						int id = weixin.addOrUpdateWeixinUser( user );
						if( id  == 0 ){
							id = weixin.addOrUpdateWeixinUser( user );
						}
						user.setId( id );
						setUserSession(user,response);	
						session.setAttribute(  WEIXIN_SESSSION_KEY , user);
					} 
				}
			}
			return user!= null ? user.getWxid() :null;
		}else
			return "";
	}



	public boolean checkUserHasNotice(Weixin_blog_user user){
		boolean result = false;
		if(user == null || user.getWxid() == null){
			return result;
		}
		String url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token="+weixin.getToken()[0] + "&openid="+user.getWxid()+"&lang=zh_CN";
		JSONObject json = JSONObject.fromObject(httpClient.doGet(url));
		if(json == null){
			return result;
		}
		result = json.getInt("subscribe") == 1;
		return result;
	}

	protected void setUserSession(Weixin_blog_user user,HttpServletResponse response ) {
		if( user == null ){
			return;
		}
		Client  client = null;
		try {
			client = Client.newInstance( Client.TCP );
			client.sendRequest(SERVER_NAME, "putSession", new Object[]{ user.getWxid(), serializer.serialize( user ) });
		} catch (Exception e) {
			e.printStackTrace();
		} 
		// 设置Cookie
		Cookie cookie = new Cookie("wxid", user.getWxid());
		cookie.setPath("/");
		cookie.setDomain(".keepyoga.com");  
		cookie.setMaxAge(Integer.MAX_VALUE);
		response.addCookie(cookie);    
	} 

	/**
	 * 给老师发送提问消息
	 * @param openId
	 * @return
	 */
	public int sendTeacherTemplate( String openId, Weixin_blog_content content, String nickname ,String p, String money){
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+weixin.getToken()[0];
		WxTemplate temp = new WxTemplate();
		temp.setUrl( DOMAIN +"/w/faq/d/ask.html?p="+p+"&r=0");
		temp.setTouser( openId );
		temp.setTopcolor("#000000");
		temp.setTemplate_id( Config.getString("weixin.askteacher.templateid"));

		Map<String,TemplateData> m = new HashMap<String,TemplateData>();
		TemplateData first = new TemplateData();
		first.setColor("#000000");
		TemplateData name = new TemplateData();  
		name.setColor("#000000");  
		if(content.getHasanswer() == 0 ){
			first.setValue( nickname+"很仰慕你，问了你一个问题，期待回答" );  			
			name.setValue( content.getTitle() );  
		}else{
			first.setValue( nickname+"向您追问，期待回答" );  						
			name.setValue( content.getSubcontent() );  
		}
		m.put("first", first);  
		m.put("keyword1", name);

		TemplateData wuliu = new TemplateData();  
		wuliu.setColor("#000000");  
		wuliu.setValue( content.getIsopen() == 1 ?"私密":"公开");  
		m.put("keyword2", wuliu);

		TemplateData orderNo = new TemplateData();  
		orderNo.setColor("#000000");  
		orderNo.setValue( getTime() );  
		m.put("keyword3", orderNo);

		TemplateData remark = new TemplateData();  
		remark.setColor("#000000");  
		remark.setValue( "回答可收入："+money+"元,速去回答！" );  
		m.put("remark", remark);
		temp.setData( m );
		String jsonString = JSONObject.fromObject(temp).toString();
		JSONObject jsonObject = null;
		try {
			jsonObject = WeixinUtil.httpRequest(url, "POST", jsonString);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if ( null != jsonObject ) {  
			if (0 != jsonObject.getInt("errcode")) {  
				return jsonObject.getInt("errcode");
			}  
		}
		return -1;
	}

	/**
	 * 发送购买课程的通知
	 * @param openId
	 * @return
	 */
	public int sendBuyCoureseTemplate( String openId, Weixin_blog_teacher_course course){
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+weixin.getToken()[0];
		WxTemplate temp = new WxTemplate();
		temp.setUrl( DOMAIN+"/w/faq/course.html?p="+course.getId());
		temp.setTouser( openId );
		temp.setTopcolor("#000000");
		temp.setTemplate_id( Config.getString("weixin.buycourse.templateid") );

		Map<String,TemplateData> m = new HashMap<String,TemplateData>();
		TemplateData first = new TemplateData();
		first.setColor("#000000");  
		first.setValue( "课程购买通知" );  
		m.put("first", first);  

		TemplateData keyword1 = new TemplateData();
		keyword1.setColor("#000000");  
		keyword1.setValue( System.currentTimeMillis()+"" );  
		m.put("keyword1", keyword1);  

		TemplateData keyword2 = new TemplateData();
		keyword2.setColor("#000000");  
		keyword2.setValue( course.getCname() );  
		m.put("keyword2", keyword2);  

		TemplateData keyword3 = new TemplateData();
		keyword3.setColor("#000000");  
		keyword3.setValue( course.getMoney()+"元");  
		m.put("keyword3", keyword3); 

		TemplateData keyword4 = new TemplateData();
		keyword4.setColor("#000000");  
		keyword4.setValue("4000186161");  
		m.put("keyword4", keyword4); 

		TemplateData keyword5 = new TemplateData();
		keyword5.setColor("#000000");  
		keyword5.setValue( getTime() );  
		m.put("keyword5", keyword5); 

		TemplateData remark = new TemplateData();  
		remark.setColor("#000000");  
		remark.setValue( "如有问题请致电4000186161或直接在微信留言，小瑜将第一时间为您服务！" );  
		m.put("Remark", remark);

		temp.setData( m );
		String jsonString = JSONObject.fromObject(temp).toString();
		JSONObject jsonObject = null;
		try {
			jsonObject = WeixinUtil.httpRequest(url, "POST", jsonString);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if ( null != jsonObject ) {  
			if (0 != jsonObject.getInt("errcode")) {  
				return jsonObject.getInt("errcode");
			}  
		}
		return -1;
	}


	protected ModelAndView goIndexHome(){
		return new ModelAndView( "redirect:/w/faq/index.html?p=0" );
	}
	 
	public static final int ACTIVITY_JG    = 24; //随心瑜经管课程活动11月
	public static final int ACTIVITY_SJ    = 21; //线下理疗集训营活动10月
	public static final int ACTIVITY_JSR   = 23; //瑜伽教师日活动
	public static final int ACTIVITY_INDIA = 25; //印度大会线上课程售卖
	public static final int ACTIVEIT_2017  = 27; //2017世界瑜伽大会
	public static final int ACTIVEIT_2017_SLIMMING  =31; //2017世界瑜伽大会
	public static final int ACTIVEIT_2017_YUNCHAN   =33; //孕产瑜伽节

	public static final String ACTIVITY_JG_NAME="随心瑜掌馆-实战经管集训营课程";//24活动名称
	public static final float  ACTIVITY_JG_MONEY=99f;//24活动价格

	public static final String ACTIVITY_INDIA_NAME="随心瑜掌馆-印度大会线上售卖课程";// 印度大会的活动名称
	public static final float  ACTIVITY_INDIA_MONEY=99f;//25活动价格
	
	public static final String ACTIVITY_SLIMMING_NAME = "瘦身集训营";
	public static final float  ACTIVITY_SLIMMING_MONEY=10f; //瘦身集训营活动价格

	public static final String ACTIVITY_MEETING_2017 = "2017世界瑜伽峰会";
	public static final String ACTIVITY_YUNCHAN_2017 = "孕产瑜伽";//

	public String getDistributorOnlyNumber(){
		String [] zm = new String[]{"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		String times = System.currentTimeMillis()+"";
		return zm[ Math.abs(new Random().nextInt(zm.length))]+times.substring(times.length()-4, times.length());
	}

	public static String getRandomRownumber(){
		return UUID.randomUUID().toString().replace("-", "").toUpperCase();
	}
}
