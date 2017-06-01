package com.yoga.controller.v2.api;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yoga.controller.v2.R; 
import com.yoga.dao.Weixin_blog_user_search; 
import com.yoga.utils.Pagination; 

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author king
 *
 */
@Controller
public class WeixinV2APIHomeController extends R {


	/**
	 * V2版本首页JSON
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/index.json")
	public @ResponseBody JSONObject v2IndexHome(
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse response
			) {
		JSONObject object = new JSONObject(); 
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		object.put("status",true);
		object.put("code", QCode.SUCCESS.getCode() );
		object.put("msg",  QCode.SUCCESS.getMsg());
		object.put("data", v2Index.getIndexHome() );
		return object;
	}



	/**
	 * 首页查看更多接口
	 * @param type    查看更多的内容
	 *        free    更多免费课程
	 *        pay     更多付费课程
	 *        zhibo	      更多直播
	 *        teacher 更多老师
	 *        	 更多专题
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/index/{type}/more.json")
	public @ResponseBody JSONObject v2IndexMore(
			@PathVariable("type")      String type,
			@RequestParam(value = "p", required = false, defaultValue = "1") int p,
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse response
			) {
		JSONObject object = new JSONObject(); 
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		object.put("status",true);
		object.put("code", QCode.SUCCESS.getCode());
		object.put("msg",  QCode.SUCCESS.getMsg());
		JSONArray  array  = new JSONArray();
		switch( type  ){
		case "free":
			Pagination page = weixin.getCourseList(" AND status=0 AND money=0 ORDER BY id DESC ", p, 20);
			if( page.getResults() != null && page.getResults().size() > 0 ){
				List<HashMap<String,Object>> clist = page.getResults();
				if( clist != null && clist.size() > 0 ){
					for( HashMap<String,Object> c: clist ){
						JSONObject cJSON = new JSONObject();
						cJSON.put("cid",      c.get("id"));
						cJSON.put("cname",    c.get("cname"));
						cJSON.put("icon",     c.get("icon"));
						cJSON.put("logo",     c.get("logo"));
						cJSON.put("longtime", c.get("longtime"));
						cJSON.put("remark",   c.get("remark"));
						cJSON.put("money",    c.get("money"));
						cJSON.put("ctype",    c.get("ctype"));
						if(c.get("toptime") != null){
							cJSON.put("toptime",    (c.get("toptime")+"").substring(5, 10));
						}
						array.add( cJSON );
					}
				}
			}
			object.put("totalcount", page.getTotalCount());
			object.put("pagenum",    page.getPageNum());
			object.put("data",       array );
			break;
		case "pay":
			Pagination pagep = weixin.getCourseList(" AND status=0 AND money > 0 AND istop=1 ORDER BY toptime DESC ", p, 20);
			if(pagep.getResults() != null && pagep.getResults().size() > 0){
				List<HashMap<String, Object>> plist = pagep.getResults();
				if(plist != null && plist.size() > 0){
					for(HashMap<String, Object> pay : plist){
						JSONObject pJSON = new JSONObject();
						pJSON.put("cid",      pay.get("id"));
						pJSON.put("cname",    pay.get("cname"));
						pJSON.put("icon",     pay.get("icon"));
						pJSON.put("logo",     pay.get("logo"));
						pJSON.put("longtime", pay.get("longtime"));
						pJSON.put("remark",   pay.get("remark"));
						pJSON.put("money",    pay.get("money"));
						pJSON.put("ctype",    pay.get("ctype"));
						if(pay.get("toptime") != null){
							pJSON.put("toptime",    (pay.get("toptime")+"").substring(5, 10));
						}
						array.add( pJSON );
					}
				}
			}
			object.put("totalcount", pagep.getTotalCount());
			object.put("pagenum",    pagep.getPageNum());
			object.put("data",       array );
			break;
		case "teacher":
			Pagination tlist = weixin.getWeixinUserList(" AND isteacher = 1 AND status= 0 AND hide=0 ORDER BY seqindex, createtime DESC ", p, 20);
			if( tlist.getResults() != null && tlist.getResults().size() > 0 ){
				List<HashMap<String,Object>> ttlist = tlist.getResults();
				if( ttlist != null && ttlist.size() > 0 ){
					for( HashMap<String,Object> t: ttlist ){
						JSONObject tJSON = new JSONObject();
						tJSON.put("id",         t.get("id")); 
						tJSON.put("name",       t.get("nickname")); 
						tJSON.put("icon",       t.get("file_path")); 
						tJSON.put("userpost",   t.get("userpost")); 
						tJSON.put("shortremark",t.get("shortremark")); 
						array.add(tJSON );
					}
				}
			}
			object.put("totalcount", tlist.getTotalCount());
			object.put("pagenum",    tlist.getPageNum());
			object.put("data",       array );
			break;
		case "special":
			Pagination spaga = weixin.activityList("", p, 20);
			List<HashMap<String,Object>> clslist = spaga.getResults();
			if(clslist != null && clslist.size() > 0){
				for(HashMap<String, Object> cls : clslist){
					JSONObject clsJSON = new JSONObject();
					clsJSON.put("id", cls.get("id"));
					clsJSON.put("name", cls.get("name"));
					clsJSON.put("logo", cls.get("logo"));
					clsJSON.put("url",  cls.get("url")); 
					array.add(clsJSON);
				}
			}
			object.put("totalcount", spaga.getTotalCount());
			object.put("pagenum",    spaga.getPageNum());
			object.put("data",       array );
			break;
		case "zhibo":
			Pagination zpaga =manager.getZhiboList(" ", p, 20);
			List<HashMap<String,Object>> zlist = zpaga.getResults();
			if(zlist != null && zlist.size() > 0){
				for(HashMap<String, Object> z : zlist){
					JSONObject zJSON = new JSONObject();
					zJSON.put("id", z.get("id"));
					zJSON.put("name", z.get("name"));
					zJSON.put("remark", z.get("remark"));
					zJSON.put("logo", z.get("logo"));
					zJSON.put("buycount", z.get("buycount"));
					zJSON.put("starttime", z.get("starttime"));
					zJSON.put("money", z.get("money"));
					zJSON.put("status", z.get("status"));
					array.add(zJSON);
				}
			}
			object.put("totalcount", zpaga.getTotalCount());
			object.put("pagenum",    zpaga.getPageNum());
			object.put("data",       array );
			break;
		default:break;
		}
		return object;
	}

	/**
	 * V2版本课程JSON
	 * @param sp	课程一级分类id
	 * @param nh	课程排序 0：最新 1：最热  默认：0
	 * @param sp2	课程二级分类id
	 * @param ct	课程类型 0：音频 1：视频 2：全部
	 * @param hm	课程价格 0：免费 1：收费 2：全部
	 * @param cons	适合人群 
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/course/{sp}/{nh}.json")
	public @ResponseBody JSONObject v2Course(
			@PathVariable("sp")      int sp,
			@PathVariable("nh")      int nh,
			@RequestParam(value = "sp2",  required = false, defaultValue = "0")  int sp2,
			@RequestParam(value = "ct",   required = false, defaultValue = "2")  int ct,
			@RequestParam(value = "hm",   required = false, defaultValue = "2")  int hm,
			@RequestParam(value = "cons", required = false, defaultValue = "")   String cons,
			@RequestParam(value = "p",    required = false, defaultValue = "1")  int p,
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse respons
			) {
		JSONObject object = new JSONObject();
		JSONArray  array  = new JSONArray();
		respons.setHeader("Access-Control-Allow-Origin",  "*");
		respons.setHeader("Access-Control-Allow-Methods", "POST");
		respons.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		String filter = "";
		Pagination cpage = null ; 
		if( sp == 0 ){
			filter += "" ;
		}else {
			filter += " AND specialid like '%" + sp + "%'";
			List<HashMap<String, Object>> speciallist = manager.getSpecialByParentid( sp );
			if(speciallist != null && speciallist.size() > 0){
				JSONArray  sparray  = new JSONArray();
				for(HashMap<String, Object> sps : speciallist){
					JSONObject spJSON = new JSONObject();
					spJSON.put("id",      sps.get("id"));
					spJSON.put("name",    sps.get("name"));
					spJSON.put("parentid",    sps.get("parentid"));
					spJSON.put("parentname",    sps.get("parentname"));
					sparray.add(spJSON);
				}
				object.put("speciallist", sparray);
			}
			if( sp2 > 0 ){
				filter += " AND specialid2 like '%"+sp2+"%'";
			}
		} 
		if( ct != 2){
			filter += " AND ctype = " + ct;
		}
		if( hm != 2){
			if(Integer.valueOf(hm) == 0 ){
				filter += " AND money = 0";
			}else if(Integer.valueOf(hm) == 1){
				filter += " AND money > 0";
			}
		}
		if(cons.length() > 0 && !cons.equals("") && !cons.equals("全部")){
			filter += " AND consumer like ('%"+cons+"%')";
		}

		if( nh ==  0 ){
			filter += " AND status=0  ORDER BY createtime DESC" ;
		}else if( nh == 1){
			filter += " AND status=0  ORDER BY followcount DESC,playcount DESC" ;
		} 

		cpage = weixin.getCourseList(filter, p, 20);
		if(cpage.getResults() != null && cpage.getResults().size() > 0){
			List<HashMap<String, Object>> clist = cpage.getResults();
			if(clist != null && clist.size() > 0){
				for(HashMap<String, Object> c : clist){
					JSONObject cJSON = new JSONObject();
					cJSON.put("cid",      c.get("id"));
					cJSON.put("cname",    c.get("cname"));
					cJSON.put("icon",     c.get("icon"));
					cJSON.put("logo",     c.get("logo"));
					cJSON.put("longtime", c.get("longtime"));
					cJSON.put("remark",   c.get("remark"));
					cJSON.put("money",    c.get("money"));
					cJSON.put("ctype",    c.get("ctype"));
					array.add(cJSON);
				}
			}
		}
		object.put("status",true);
		object.put("code", QCode.SUCCESS.getCode() );
		object.put("msg",  QCode.SUCCESS.getMsg());
		object.put("totalcount", cpage.getTotalCount());
		object.put("pagenum",    cpage.getPageNum());
		object.put("data", array );
		return object;
	}


	/**
	 * V2版本搜索首页JSON
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/search/index.json")
	public @ResponseBody JSONObject v2SearchHome(
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse response
			) {
		JSONObject object = new JSONObject(); 
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		object.put("status",true);
		object.put("code", QCode.SUCCESS.getCode() );
		object.put("msg",  QCode.SUCCESS.getMsg());
		object.put("data", weixin.getHotSearch() );
		return object;
	}

	/**
	 * 搜索
	 * @param session
	 * @param request
	 * @param response 
	 * @return
	 */
	@RequestMapping(value = "v2/search.json")
	public JSONObject blogSearch(
			@RequestParam(value = "c", required = true, defaultValue = "") String c,
			HttpServletRequest     request, 
			HttpSession            session, 
			HttpServletResponse    response
			){
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		JSONObject object = new JSONObject();
		object.put("content",     replaceBlank(c));
		Object [] isSQLInj = isSQLInj( c );
		int hasdata = 0 ;
		if( !(Boolean) isSQLInj[0] && c.length() > 0  ){
			Pagination teacherlist = weixin.getWeixinUserList(" AND hide=0  AND isteacher = 1 AND status = 0 AND nickname like '%"+ c +"%' ", 1, 100);
			if( teacherlist.getResults() != null && teacherlist.getResults().size() > 0) {
				List<HashMap<String, Object>> tlist = teacherlist.getResults();
				JSONObject tJSON = new JSONObject();
				JSONArray arry = new JSONArray();
				if(tlist != null && tlist.size() > 0){
					for(HashMap<String, Object> t : tlist){
						tJSON.put("id",         t.get("id")); 
						tJSON.put("name",       t.get("nickname")); 
						tJSON.put("icon",       t.get("file_path")); 
						tJSON.put("userpost",   t.get("userpost")); 
						tJSON.put("shortremark",t.get("shortremark")); 
						arry.add(tJSON );
					}
					object.put("teacherlist", arry);
				}
				hasdata += teacherlist.getResults().size();
			}
			Pagination courselist = weixin.getCourseList(" AND status = 0  AND cname like '%"+ c +"%' ORDER BY toptime DESC", 1, 100);
			if( courselist.getResults() != null && courselist.getResults().size() > 0){
				List<HashMap<String, Object>> clist = courselist.getResults();
				JSONObject cJSON = new JSONObject();
				JSONArray arry = new JSONArray();
				if(clist != null && clist.size() > 0){
					for(HashMap<String, Object> co : clist){
						cJSON.put("cid",      co.get("id"));
						cJSON.put("cname",    co.get("cname"));
						cJSON.put("icon",     co.get("icon"));
						cJSON.put("logo",     co.get("logo"));
						cJSON.put("longtime", co.get("longtime"));
						cJSON.put("remark",   co.get("remark"));
						cJSON.put("money",    co.get("money"));
						cJSON.put("ctype",    co.get("ctype"));
						arry.add(cJSON );
					}
					object.put("courselist", arry);
				}
				hasdata += courselist.getResults().size();
			}
			Pagination asklist = weixin.getWeixinContentList(0, " AND askid > 0 AND title like '%"+ c +"%'", 1, 100, false);
			if( asklist.getResults() != null && asklist.getResults().size() > 0) {
				List<HashMap<String, Object>> alist = asklist.getResults();
				JSONObject aJSON = new JSONObject();
				JSONArray arry = new JSONArray();
				if(alist != null && alist.size() > 0){
					for(HashMap<String, Object> a : alist){
						aJSON.put("aid",      a.get("id"));
						aJSON.put("content",    a.get("content"));
						aJSON.put("icon",     a.get("icon"));
						aJSON.put("askid", a.get("askid"));
						aJSON.put("askusername", a.get("askusername"));
						aJSON.put("askheader", a.get("askheader"));
						aJSON.put("askuserpost", a.get("askuserpost"));
						arry.add(aJSON );
					}
					object.put("asklist", arry);
				}
				hasdata += asklist.getResults().size();
			}
			String[] search = weixin.getSearch();
			boolean has = false ;
			for(int i = 0 ; i < search.length ; i++){
				if(c.equals(search[i])){
					has = true ;
				}
			}
			if(!has){
				Weixin_blog_user_search sear = new Weixin_blog_user_search();
				sear.setSname(c);
				sear.setNumber(1);
				weixin.addOrUpdateSearch(sear);
			}else{
				weixin.updateSearch(c);
			}
		}else{
			object.put("teacherlist", null);
			object.put("courselist",  null);
			object.put("asklist",     null);
		}
		object.put("hasdata",     hasdata );
		object.put("status",true);
		object.put("code", QCode.SUCCESS.getCode() );
		object.put("msg",  QCode.SUCCESS.getMsg());
		return object;
	}

 
}
