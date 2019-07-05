package com.minmeng.web.action;

import java.util.List;

import com.j2mvc.framework.i18n.I18n;
import com.j2mvc.framework.mapping.ActionPath;
import com.j2mvc.framework.mapping.ActionUri;
import com.j2mvc.framework.util.DataValidations;
import com.j2mvc.util.Error;
import com.j2mvc.util.Pagination;
import com.j2mvc.util.StringUtils;
import com.j2mvc.util.Success;
import com.j2mvc.util.Utils;
import com.j2mvc.util.Validations;

import com.minmeng.entity.common.Board;
import com.minmeng.entity.ui.Page;
import com.minmeng.service.common.BoardService;

/**
 * @Description 内容
 * @Company 贵州沃尔达科技有限公司
 * @Author 杨大江
 * @Version 1.0.1 
 * @Date 2014-12-21 创建
 * @Date 2014-12-26 变更
 */
@ActionPath(path="/board/")
public class BoardAction  extends BaseAction {
	
	BoardService boardService = new BoardService();
	Page page;

	/**
	 * 留言列表
	 * @param page
	 * @param pageSize
	 * @param k 关键词
	 * @param st 开始时间
	 * @param et 结束时间
	 * @return
	 */
	@ActionUri(uri="([/])?")
	public String index(Integer p){
		page = pageService.getByName(Page.NAME_INDEX);
		if(page != null){
			// 页面信息
			put("page",page);
			put("title","留言 - " + SITENAME);
			p = p!=null?p:1;
			Integer ps = Integer.valueOf(I18n.i18n.get("DEFAULT_PAGESIZE"));
			// 查询出总数
			Integer total = boardService.total("","Y","","");
			// 创建分页对象
			Pagination pagination  = new Pagination(total,ps, p,"p");
			// 查询分页数据
			Integer start = pagination.getStartIndex();
			List<Board> list = boardService.query("","Y", "","", start, ps);
			put("list",list);
			put("nodata", !(list != null && list.size() > 0) ? "未找到留言。" : "");
			put("pagination", pagination);
			put("paginationHtml", pagination.getHtml(request.getRequestURI(), 20));
		}
		return jsp("board.jsp");
	}
	
	@ActionUri(uri="write")
	public String write(){
		page = pageService.getByName(Page.NAME_INDEX);
		if(page != null){
			// 页面信息
			put("page",page);
			put("title","留言 - " + SITENAME);
		}
		return jsp("board-write.jsp");
	}
	
	@ActionUri(uri="save([/])?",description="保存用户")
	public void save(String id,String address,
			String title,String mobile,String content,String name,
			String fax){
		if(content.length()< 10){
			printJson(new Error("内容不能为空，且不能少于10个字！"));
			return;
		}

		if(checkTitle(title) 
				&& checkMobile(id, mobile)){
			Board board = new Board();
			board.setAddress(address);
			board.setContent(content);
			board.setFax(fax);
			board.setMobile(mobile);
			board.setName(name);
			board.setTitle(title);
			board.setId(Utils.createId());
			List<Error> errors = DataValidations.dataTooLong(board);
			if(errors!=null && errors.size()>0){
				printJson(new Error( "数据长度超过限制.",errors));
				return;
			}
			if(boardService.save(board)!=null){
				printJson(new Success( "留言成功提交，我们会尽快处理，感谢您的支持！"));
			}else {
				printJson(new Error( "服务器繁忙，请稍后重试，或联系我们."));
			}
		}
	}

	@ActionUri(uri="checkTitle([/])?",description="检查标题")
	public boolean checkTitle(String title) {
		if(title == null || "".equals(title)){
			printJson(new Error("标题不能为空！"));
			return false;
		}else if(title.length() < 6){
			printJson(new Error("标题不能少于6个字！"));
			return false;
		}else{
			printJson(new Success("标题可用"));
			return true;
		}
	}

	@ActionUri(uri="checkMobile([/])?",description="检查手机号")
	public boolean checkMobile(String id,String mobile) {
		if(StringUtils.isEmpty(mobile)){
			printJson(new Error("手机号不能为空！"));
			return false;
		}else if(!Validations.isMobilephone(mobile)){
			printJson(new Error("手机号格式不正确！"));
			return false;
		}else {
			printJson(new Success("手机号可用"));
			return true;
		}
	}
	
}
