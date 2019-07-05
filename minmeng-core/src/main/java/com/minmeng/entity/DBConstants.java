package com.minmeng.entity;

/**
 * 数据库常量
 * 
 * @Company 贵州万嘉
 * @Author 杨大江
 * @Version 1.0.1
 * @Date 2017-9-28
 */
public interface DBConstants {

	interface Table {
		/** 公共系统表 */
		interface Common {
			String CAT = "cats";
			/** 附件表(公共库) */
			String ATTACH = "attaches";
			String ADMIN = "sys_admins";
			String AD = "ads";
			String FRIEND_URL = "friend_urls";
			String GLOBAL_SETTING = "global_settings";
			String BOARD = "boards";
			String KEYWORD = "keywords";
			String SLIDE_LINK = "slide_links";
		}


		/** 内容管理系统表 */
		interface CMS {
			/** 文章内容(主库) */
			String CONTENT_INFO = "content_infos";
			/** 文章内容附件(主库) */
			String CONTENT_ATTACH = "content_attaches";
			/** 专题（板块） */
			String FORUM = "forums";
			String FORUM_CONTENT = "forum_contents";
			String FETCH_RECORD = "fetch_records";
		}

		/** UI表 */
		interface UI {
			/** 导航(UI)*/
			String NAV ="navs";
			/** 页面 */
			String PAGE = "pages";
			String VIEW = "views";
			String VIEW_ITEM = "view_items";
			String PAGE_VIEW = "page_views";
		}

		/** UI表 */
		interface Sys {
			/** 数据库备份 */
			String SQL_DUMP = "sql_dumps";
		}
	}

}
