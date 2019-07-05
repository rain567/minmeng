/**
 * 实现js+java异步上传
 * 
 */

/*! 在最顶层页面添加样式文件 */

(function($) {;

	// 上传容器
	var _doc;
	try{
	    _doc = window.document;  // 跨域|无权限
		_doc.getElementsByTagName; // chrome 浏览器本地安全限制
	}catch(e){
	    _doc = window.document;
	};
	/*!
	 * 是否IE6浏览器
	 */
	var _ie6 = window.ActiveXObject && !window.XMLHttpRequest,
	/*!
	 * _path 获取组件核心文件fixupload.js所在的绝对路径
	 * _args 获取fixupload.js文件后的url参数组，如：fixupload.js?skin=default中的?后面的内容
	 */ 
	_path = (function(script, i, me )
			{
	    var l = script.length;
		
		for( ; i < l; i++ )
		{
			me = !!_doc.querySelector ?
			    script[i].src : script[i].getAttribute('src',4);
			
			if( me.substr(me.lastIndexOf('/')).indexOf('fixupload.js') !== -1 )
			    break;
		}
		
		me = me.split('?'); _args = me[1];
		var path = me[0].substr( 0, me[0].lastIndexOf('/') + 1 );
		path = path.substring(path.indexOf('//')+2,path.length);
		path = path.substring(path.indexOf('/'),path.length);
		return path;
	})(_doc.getElementsByTagName('script'),0),
	_args,_getArgs = function( name )
	{
	    if( _args )
		{
		    var p = _args.split('&'), i = 0, l = p.length, a;
			for( ; i < l; i++ )
			{
			    a = p[i].split('=');
				if( name === a[0] ) return a[1];
			}
		}
		return null;
	},
	/*! 取皮肤样式名，默认为 default */
	_skin = _getArgs('skin') || 'default';

	/*! 在最顶层页面添加样式文件 */
	(function(style){
		if(!style)
		{
		    var head = _doc.getElementsByTagName('head')[0],
			    link = _doc.createElement('link');
				
			link.href = _path + 'skins/' + _skin + '/style.css';
		    link.rel = 'stylesheet';
			link.id = 'fixuploadLink';
			head.insertBefore(link, head.firstChild);
		}
	})(_doc.getElementById('fixuploadLink')),
	/*!
	 * 动态加载指定样式文件
	 */
	_initCss = /*! 在最顶层页面添加样式文件 */
		(function(skin){
			var style = _doc.getElementById('fixuploadLink_'+skin);
			if(!style)
			{
			    var head = _doc.getElementsByTagName('head')[0],
				    link = _doc.createElement('link');
					
				link.href = _path + 'skins/' + skin + '/style.css';
			    link.rel = 'stylesheet';
				link.id = 'fixuploadLink_'+skin;
				head.insertBefore(link, head.firstChild);
			}
		}),
	
	/*!
	 * 提交URL
	 * 
	 */
	_uploadUrl = (function(){
		return _path + 'jsp/upload.jsp';
	})(),
	/*!
	 * 文件后缀图标URL
	 * 
	 */
	_extIconUrl = (function(){
		return _path + 'jsp/exticon.jsp';
	})(),
	/*!
	 * 进度URL
	 * 
	 */
	_progressUrl = (function(){
		return _path + 'jsp/progress.jsp';
	})(),
	 /*!
	  * 获取文件大小单位
	  */
	 _size = (function(size){
		 if(!/\d+/.test(size) || size <= 0){
			 return '';
		 }
	 	var unit = "B";
	 	if (size > 1000) {
	 		size = size > 1000 ? size / 1024 : size;
	 		unit = "KB";
	 	}
	 	if (size > 1000) {
	 		size = size > 1000 ? size / 1024 : size;
	 		unit = "MB";
	 	}
	 	if (size > 1000) {
	 		size = size > 1000 ? size / 1024 : size;
	 		unit = "GB";
	 	}
	 	if (size > 1000) {
	 		size = size > 1000 ? size / 1024 : size;
	 		unit = "TB";
	 	}
	 	return size.toFixed(2) + unit;
	 }),
	 /*!
	  * 默认图片 
	  */ 
	 _imgUrl = (function(){
		 return _path+"skins/min/images/default.jpg";
	 })(),
	 _isExists = (function(file){
		 var xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		 xmlhttp.open("GET",file,false);
		 xmlhttp.send();
		 alert('xmlhttp.readyState>'+xmlhttp.status);
		 if(xmlhttp.readyState==4){ 
			 alert('xmlhttp.status>'+xmlhttp.status);
			 if(xmlhttp.status==200)
				 return true; //url存在 
			 else if(xmlhttp.status==404)
				 return false;//url不存在 
			 else 
				 return false;//其他状态 
		 } 
	 });

	function getRealWidth(_target,width){
		width -= getNumeric(_target.css('border-left-width'));
		width -= getNumeric(_target.css('border-right-width'));
		width -= getNumeric(_target.css('margin-left'));
		width -= getNumeric(_target.css('margin-right'));
		width -= getNumeric(_target.css('padding-left'));
		width -= getNumeric(_target.css('padding-right'));
		return width;
	}

	 // 进度条纵向居中
	 function vAlign(target,obj,mode) {
		// 父层高度
		var h = target.find('div:first').height();
		// 进度条高度
		var fh = obj.height();
		// 计算按钮top
		var top = (h - fh)/2;
		if(mode){
			if(mode == 'top'){
				top = 10;
			}
			if(mode == 'bottom'){
				top = h - fh - 10; 
			}
		}
		obj.css({"top":top+"px"});
	 }
	 
	
	/*!
	 * 上传表单数组
	 */
	var _uploadDoms ={
		file: // 默认
			'<div class="fixupload">'+
			  	'<form enctype="multipart/form-data" method="post" class="fixupload-form">'+
			  		'<input type="hidden" name="progressUrl">'+
			  		'<div><input type="file" name="file"></div>'+
			  		'<div><button class="click" type="button"></button></div>'+
			  	'</form>'+
			  	'<div class="icon"><img width=32 height=32 border=0/></div>' +
			  	'<div class="progressContainer">' +
			  	'<div class="state"></div>'+
			  	'<div class="progressBar">'+
			  		'<div class="progress"></div>'+
			  	'</div>'+
			  	'</div>'+
			  	'<div style="clear:both"></div>'+
			  	'<a class="del" title="删除">\xd7</a>'+
			'</div>',
		image:// 图片
			'<div class="fixupload">'+
				'<div class="uploadImage">'+
					'<img alt="default"/>'+
				'</div>'+
			  	'<form enctype="multipart/form-data" method="post" class="fixupload-form">'+
			  		'<input type="hidden" name="progressUrl">'+
			  		'<div class="absoluteFile">'+
			  			'<button class="click" type="button">上传图片</button>'+
			  			'<input type="file" name="file" value="">'+
			  		'</div>'+
			  	'</form>'+
			  	'<div class="progressBox">'+
				  	'<div class="progressBar">'+
				  		'<div class="progress"></div>'+
				  	'</div>'+
				  	'<div class="state">0%</div>'+
			  	'</div>'+
			  	'<a class="del">\xd7</a>'+
			 '</div>',
		multiFile: // 多选文件进度
			 '<div class="fixupload">'+
				'<div class="icon"><img width=32 height=32 border=0/></div>' +
				'<div class="progressContainer">' +
				'<div class="state"></div>'+
				'<div class="progressBar">'+
					'<div class="progress"></div>'+
				'</div>'+
				'</div>'+
				'<a class="del" title="删除">\xd7</a>'+
				'<div style="clear:both"></div>'+
			'</div>',
		multiImage:// 多选图片进度
			'<div class="fixupload">'+
				'<div class="uploadImage">'+
					'<img alt="default" src=""/>'+
				'</div>'+
				'<div class="progressBox">'+
				  	'<div class="progressBar">'+
				  		'<div class="progress"></div>'+
				  	'</div>'+
				  	'<div class="state">0%</div>'+
				'</div>'+
				'<a class="del">\xd7</a>'+
			'</div>'
	};  


	 $.fn.fixupload = function(options) {

		// 容器
		var DOM = $(this),IDOM=null;

		// 上传单元数组
		var _uploads = new Array(),swfupload=null,
		 	_wait = new Array(),// 等待中
		 	_inter = new Array(), // 计时器
			_skins = new Array(), // 保存样式
			_types = new Array();// 保存上传类型
		
		// 属性
		var defaults = {
			button:'',				// 点击按钮，在选自动创建时必须设置
			defaultImg:_path+'skins/min/images/default.jpg',
			buttonText:'上传文件',	// 上传按钮文本
			buttonSuccessText:'更换文件',	// 成功按钮文本
			buttonVAlign:'middle',			// 上传图片按钮偏移
			buttonImage:'',			// 上传按钮图片，保存在images目录下
			skin: "default",			// 样式：default，默认，min：小样式
			type : "file", 			// 上传类型,分为file,image,media,flash,
			ext:null,				// 限制文件扩展名
			maxSize:1*1024*1024,		// 限制文件大小，默认为1M
			autoCreate:false,		// 自动创建，如果为false,则预先创建指定num的上传单元，为true自动创建，需要页面添加按钮触发。
			path: _path,        		// JS路径
			urlInput : "urls", 		// 上传文件的返回Input名称
			saveUrl : "", 			// 上传文件的访问路径
			savePath : "", 			// 上传文件的保存路径
			iconPath : "", 			// 上传文件的图标路径
			max : "1", 				// 上传总数，可以设置，如果未设置，则默认为1个
			urls : [], 				// 已上传的文件URL数组
			width : 'auto',	 		// 上传单元高度
			height : 'auto', 		// 上传单元宽度
			uploadUrl : "",			// 提交上传URL
			progressUrl : "",		// 获取进度条URL
			exticonUrl : "",			// 获取文件图标URL
			progress:function(data){},		// 进度回调
			success:function(data){},		// 成功回调
			error:function(e){},			// 错误回调
			fileTypesDesc : '',				// 文件类型说明
			fileUploadLimit : '',			// 上传数量限制
			fileSizeLimit : '',				// 上传大小限制
			params : [{
			}],								// 传递参数
			progressbars:[],
			reset:function(){},				// 重置或重启
			finished:function(){}			// 加载结束
		};
		// 方法
		var methods = {				
			/*!
			 * 初始化
			 * 根据上传总数创建上传单元
			 * 
			 */
			init:function(){
				if(config.autoCreate){					
					// 上传ID
					var _uploadId = new Date().getTime()+"_"+(Math.floor(Math.random()*999+1));
					// 提交URL
					var uploadUrl = (config.uploadUrl?config.uploadUrl:_uploadUrl)
									+'?uploadId='+_uploadId
									+'&dir='+config.type
									+ (config.savePath!=''?'&savePath='+config.savePath:'')
									+ (config.saveUrl!=''?'&saveUrl='+config.saveUrl:'')
									+ (config.iconPath!=''?'&iconPath='+config.iconPath:'&iconPath='+_path+'skins/icons/ext/')
									+ (config.ext?'&ext='+config.ext:"")
									+ (config.maxSize?'&maxSize='+config.maxSize:"");
					if($.isArray(config.params)){
						$.grep(config.params,function(param){
							uploadUrl += "&"+param.key+"="+param.value;
						});
					}
					swfupload = new SWFUpload({
						debug 					: false,
						upload_url 				: uploadUrl,
						flash_url 				: _path + 'images/swfupload.swf',
						button_text_top_padding	:'1px',
						button_image_url			:_path + 'images/'+(config.buttonImage!=''?config.buttonImage:'upload.png'),
						button_placeholder 		: config.button[0],
						button_width			: 70,
						button_height			: 26,
						button_cursor 			: SWFUpload.CURSOR.HAND,
						file_types 				: config.ext!='all'?config.ext:'',
						file_types_description 	: config.fileTypesDesc,
						file_upload_limit 		: config.fileUploadLimit,
						file_size_limit 			: config.fileSizeLimit,
						file_queued_handler 		: function(file) {
							config.reset();
							this.startUpload();
						},
						file_queue_error_handler : function(file, errorCode, message) {
							var errorName = '';
							switch (errorCode) {
								case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
									errorName = '上传数量超过限制';
									break;
								case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
									errorName = '上传大小超过限制';
									break;
								case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
									errorName = '文件为空';
									break;
								case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
									errorName = '错误的文件类型';
									break;
								default:
									errorName = '未知错误';
									break;
							} 
							config.error(errorName);
						},
						upload_start_handler : function(file) {
							config.createProgressbar(file);
						},
						upload_progress_handler : function(file, bytesLoaded, bytesTotal) {							
							config.updateProgress(file,bytesLoaded,bytesTotal);
						},
						upload_error_handler : function(file, errorCode, message) {
							if (file && file.filestatus == SWFUpload.FILE_STATUS.ERROR) {
								config.error('上传错误.');
							}else{
								config.error(message);
							}
						},
						upload_success_handler : function(file, serverData) {
							config.successUpload(file,serverData);
						}
					});
				    if(config.type == "image"){
						if(config.urls && config.urls.length > 0){
							for(var i= 0;i<config.urls.length;i++){
								var url = $.trim(config.urls[i]);
								if(url != ''){
										config.loadCreate('load_'+i,url);
								}
							} 
						}
				    }else if(config.type == "file" &&
				    		typeof config.fileData == 'function'){
				    	config.fileData(function(source){
				    		if($.isArray(source)){
				    			$.grep(source,function(data,i){
									config.loadCreate('load_'+i,data.url,data);
				    			});
				    		}
				    	});
				    }

				}else{
					// 初始化数组
					config.clear(); 	// 清空上划区域
					config.initIframe(function(){
						_uploads = [],
					 	_wait = [],// 等待中
					 	_inter = [], // 计时器
						_skins = [], // 保存样式
						_types = []; // 保存上传类型

						var max = /\d+/.test(config.max)?parseInt(config.max):1;
						for(var i=0;i<max;i++){
							config.createUpload(i);
						}
					});
				}
				config.finished();
				return this;
			},
			/*!
			 * 创建顶层Iframe
			 */
			initIframe:function(response){
				var iframe = DOM.find('iframe');
				if(iframe.size() == 0){
					// 创建iframe
					var iframeId = new Date().getTime()+'';
//					var _iframe=_doc.createElement("iframe");
//					_iframe.setAttribute("id",iframeId);
//					_iframe.setAttribute("src",_path + 'html/'+config.skin + '.html');
//					_iframe.setAttribute("name",iframeId);
//					_iframe.setAttribute("frameborder","0");
//					_iframe.setAttribute('scrolling','no');
//					_iframe.setAttribute('width',DOM.width());
					var _iframe= $('<iframe frameborder=0 border=0></iframe>');
					_iframe.get(0).setAttribute("id",iframeId);
					_iframe.get(0).setAttribute("src",_path + 'html/'+config.skin + '.html');
					_iframe.get(0).setAttribute("name",iframeId);
					_iframe.get(0).setAttribute("frameborder","0");
					_iframe.get(0).setAttribute('scrolling','no');
					_iframe.get(0).setAttribute('border','no');
					_iframe.get(0).setAttribute('width',DOM.width());
					// 追到上传区域DOM
					iframe = $(_iframe);
					DOM.append(iframe);
					// 延时更新内容
					setTimeout(function(){
						var body =  iframe.contents().find('body');
						body.html('<div class="fixupload-container"></div>');
						response();	
					},240); 
				}else{
					response();	
				}
			},
			/*
			 * 调整Iframe尺寸
			 */
			resizeIframe:function(){
				var _iframe = DOM.find('iframe');
				if(_iframe.size()>0){
					// 获取iframe内部尺寸
					//var iWidth = IDOM.width() + (_ie6 ? 0 : parseInt(IDOM.css('marginLeft')));
					var iHeight = IDOM.height()+20;
					// 适应iframe尺寸
					//_iframe.width(iWidth);
					_iframe.height(iHeight);
				}
			},
			/*!
			 * 获取URL数组
			 */
			getUrls: function(){
				var inputs = IDOM!=null?IDOM.find('input.fixupload-input-urls'):DOM.find('input.fixupload-input-urls');
				var urls = [];
				for(var i=0;i<inputs.size();i++){
					urls[i] = $(inputs[i]).val();
					//urls += (urls == ""?"": ",")+ ($(inputs[i]).val() !="" ?$(inputs[i]).val():"");
				}
				return urls;
			},
			/*!
			 * 创建上传单元
			 */
			createUpload : function(index) {
				var _iframe = DOM.find('iframe');
				IDOM = _iframe.contents().find('.fixupload-container');
				var $uploadContainer,$dom = null;
				// 上传单元容器
				var _uploadContainer = ('<div></div>');
				// 上传ID
				var _uploadId = new Date().getTime()+"_"+(Math.floor(Math.random()*999+1));
				// 提交URL
				var uploadUrl = (config.uploadUrl?config.uploadUrl:_uploadUrl)
								+'?uploadId='+_uploadId
								+'&dir='+config.type
								+ (config.savePath!=''?'&savePath='+config.savePath:'')
								+ (config.saveUrl!=''?'&saveUrl='+config.saveUrl:'')
								+ (config.iconPath!=''?'&iconPath='+config.iconPath:'&iconPath='+_path+'skins/icons/ext/')
								+ (config.ext?'&ext='+config.ext:"")
								+ (config.maxSize?'&maxSize='+config.maxSize:"");
				// 进度URL
				var progressUrl = (config.progressUrl?config.progressUrl:_progressUrl)+'?uploadId='+_uploadId;
				// 样式
				_skins[index] = config.skin;
				// 动态添加样式
				_initCss(config.skin);
				// 类型 
				_types[index] = config.type;

				// 上传表单内容
				if(config.type == "file"){
					// 文件
					$dom = $(_uploadDoms.file);
				}else if(config.type == "image"){
					// 图片
					$dom = $(_uploadDoms.image);
				}
				// 宽度
				if($.isNumeric(config.width)){
					$dom.width(config.width);
				}
				// 高度
				if($.isNumeric(config.height))
					$dom.height(config.height);			
				$dom.addClass('fixupload-'+config.skin);
				// 提交Iframe	
			  	var $iframe = $('<iframe class="uploadIframe" name="'+_uploadId+'" id="'+_uploadId+'"></iframe>');		

			  	$dom.append($iframe);
				$dom.find('form').attr('target',_uploadId);	// form提交目标
				$dom.find('form').attr('action',uploadUrl);// form提交URL
				$dom.find('input[name="progressUrl"]').val(progressUrl);	// 进度条路径
				// 创建INPUT保存URL
				var $input = $('<input type="hidden" name="'+config.urlInput+'" class="fixupload-input-urls"/>');
				// 如果传入的urls数组不为空
				$dom.find('.click').text(config.buttonText);
				if($dom.find('.uploadImage'))
					$dom.find('.uploadImage img').attr('src',config.defaultImg);
				if(config.urls){
					if(config.urls[index]){
						$input.val(config.urls[index]);
						if($dom.find('.uploadImage')){
							// 默认图片
							$dom.find('.uploadImage img').attr('src',config.urls[index]);
							$dom.find('.click').text(config.buttonSuccessText);
						}
					}
				}
				$dom.append($input);
				$uploadContainer = $(_uploadContainer);		// 容器
				$uploadContainer.addClass('fixupload-'+config.skin+"-outer");
				$uploadContainer.append($dom);
				$uploadContainer.attr('id',_uploadId);

				// 延时更新内容
				setTimeout(function(){
					IDOM.append($uploadContainer);
					// 添加到上传数组
					_uploads[index] = $uploadContainer;
					// 上传准备
					config.uploadReady(index);
					config.resizeIframe();
				},120); 
				return index;
			},
			createProgressbar:function(file){
				// 上传单元容器				
				var _uploadContainer = $('<div class="fixupload-'+config.skin+'-outer"></div>');
				_uploadContainer.css({
					'position':'relative',
					'float':'left'
				});
				DOM.append(_uploadContainer);
				// 动态添加样式
				_initCss(config.skin);
				// 上传表单内容
				if(config.type == "file"){
					// 文件
					_dom = $(_uploadDoms.multiFile);
				}else if(config.type == "image"){
					// 图片
					_dom = $(_uploadDoms.multiImage);
				}
				// 宽度
				if($.isNumeric(config.width)){
					_dom.width(config.width);
				}
				// 高度
				if($.isNumeric(config.height))
					_dom.height(config.height);			
				_dom.addClass('fixupload-'+config.skin);
				// 提交Iframe	
				var _input = $('<input type="hidden" name="'+config.urlInput+'" class="fixupload-input-urls"/>');
				_dom.append(_input);
				_uploadContainer.addClass('fixupload-'+config.skin+"-outer");
				_uploadContainer.append(_dom);
				_uploadContainer.attr('id',file.id);
				_uploadContainer.find('.del').click(function(){
					// 删除上传队列					
					swfupload.cancelUpload(file.id);
					config.remove(_uploadContainer);
					config.reset();
				});
				if(config.type == "file"){
					// 文件
					this.createFileProgress(file,_uploadContainer);
				}else if(config.type == "image"){
					// 图片
					this.createImgProgress(_uploadContainer,_dom);
				}
			},
			createFileProgress:function(file,_uploadContainer){
				_uploadContainer.find(".state").html(
						'<span class="filename">'+file.name+ ' &nbsp;</span>' + 
						'<span color="size">等待上传...</span>');
				var _icon = _uploadContainer.find('.icon');				
				if(_icon.size()>0){
					_icon.hide();
					config.setIcon(file.name,function(url){
						_icon.find('img').attr('src',url);	
						_icon.show();
						_uploadContainer.find('.progressContainer').width(_uploadContainer.width() - _icon.outerWidth() - 8);
						config.resizeState(_uploadContainer.find(".state"));
					});
				}
			},
			createImgProgress:function(_uploadContainer,_dom){
				_uploadContainer.css({
					'position':'relative'
				});
				var progressBox = _uploadContainer.find('.progressBox');
				var state = _uploadContainer.find('.state');
				progressBox.css({
					 'position':'absolute',
					 'width':$.isNumeric(config.width)?config.width+'px':'100%',
					 'z-index':998,
					 'bottom':0,
					 'left':0
				});
				state.css({
					 'position':'absolute',
					 'z-index':999,
					 'color':'#fff',
					 'padding-left':'2px',
					 'bottom':'0px'
				});
				state.html('<span color="size">准备...</span>');
				var imgNode =  _uploadContainer.find('.uploadImage img');
				// 宽度
				if($.isNumeric(config.width)){
					imgNode.width(config.width);
				}
				// 高度
				if($.isNumeric(config.height))
					imgNode.height(config.height);		
			},
			updateProgress:function(file, bytesLoaded, bytesTotal){
				if(config.type == "file"){
					// 文件
					this.updateFileProgress(file, bytesLoaded, bytesTotal);
				}else if(config.type == "image"){
					// 图片
					this.updateImgProgress(file, bytesLoaded, bytesTotal);
				}
			},
			updateFileProgress:function(file, bytesLoaded, bytesTotal){
				var percent = Math.round(bytesLoaded * 100 / bytesTotal);
				DOM.find('#'+file.id).find('.progress').css({'width':percent + "%"});//.animate({width : percent + "%"}, "fast");
				DOM.find('#'+file.id).find(".state").html(
						'<span class="filename">'+file.name+ ' &nbsp;</span>'
						+ '<span class="size">'+(percent == 0?'就绪...': _size(bytesLoaded) + "/"+_size(bytesTotal) )+ " &nbsp;</span>"
						+ '<span class="percent">'+percent + "%&nbsp;</span>");
				config.resizeState(DOM.find('#'+file.id).find(".state"));
			},
			updateImgProgress:function(file, bytesLoaded, bytesTotal){
				var percent = Math.round(bytesLoaded * 100 / bytesTotal);
				var progress = DOM.find('#'+file.id).find('.progress');
				var state = DOM.find('#'+file.id).find('.state');
				progress.css({'width':percent + "%"});//.animate({width : percent + "%"}, "fast");
				state.html('<span class="size">'+(percent == 0?'就绪...':
												_size(bytesLoaded) + "/"+_size(bytesTotal) )+ "</span>");
			},
			successUpload:function(file,serverData){
				if(serverData && serverData.replace(/[\r\n\s]/g, "")!=''){
					var data = $.parseJSON(serverData);
					if(data.info){
						if(config.type == "file"){
							// 文件
							this.successFileUpload(file,data);
						}else if(config.type == "image"){
							// 图片
							this.successImgUpload(file,data);
						}
					}else if(data.error){
						config.remove(DOM.find('#'+file.id),'上传文件“'+file.name+'”错误，信息：'+data.error.message);
					}
				}
			},
			successFileUpload:function(file,data){
				DOM.find('#'+file.id).find('.fixupload-input-urls').val(data.info.url);
				DOM.find('#'+file.id).find('.progress').animate({width : data.info.percent + "%"}, "fast");
				DOM.find('#'+file.id).find(".state").html(
						'<span class="filename">'+data.info.filename+ ' &nbsp;</span>'
						+ '<span class="size">'+ _size(data.info.bytesRead) + " &nbsp;</span>"
						+ '<span class="percent">完成.&nbsp;</span>');
				if(config.success){
					config.success(config.getUrls());
				}
				config.resizeState(DOM.find('#'+file.id).find(".state"));
			},
			successImgUpload:function(file,data){
				var progress = DOM.find('#'+file.id).find('.progress');
				var state = DOM.find('#'+file.id).find(".state");
				DOM.find('#'+file.id).find('.fixupload-input-urls').val(data.info.url);
				progress.show();
				progress.animate({width : data.info.percent + "%"}, "fast");
				state.html('<span class="percent">完成.</span>');
				var imgNode =  DOM.find('#'+file.id).find('.uploadImage img');
				imgNode.attr('src',data.info.url);
				if(config.success){
					config.success(config.getUrls());
				}
				config.resizeState(DOM.find('#'+file.id).find(".state"));
			},
			loadCreate:function(id,url,data){
				// 上传单元容器				
				var _uploadContainer = $('<div class="fixupload-'+config.skin+'-outer"></div>');
				_uploadContainer.css({
					'position':'relative',
					'float':'left'
				});
				DOM.append(_uploadContainer);
				// 动态添加样式
				_initCss(config.skin);
				// 上传表单内容
				if(config.type == "file"){
					// 文件
					_dom = $(_uploadDoms.multiFile);
				}else if(config.type == "image"){
					// 图片
					_dom = $(_uploadDoms.multiImage);
				}
				// 宽度
				if($.isNumeric(config.width)){
					_dom.width(config.width);
				}
				// 高度
				if($.isNumeric(config.height))
					_dom.height(config.height);			
				_dom.addClass('fixupload-'+config.skin);
				// 提交Iframe	
				var _input = $('<input type="hidden" name="'+config.urlInput+'" class="fixupload-input-urls"/>');
				_dom.append(_input);
				_uploadContainer.addClass('fixupload-'+config.skin+"-outer");
				_uploadContainer.append(_dom);
				_uploadContainer.attr('id',id);
				_uploadContainer.find('.del').click(function(){
					// 删除上传队列				
					config.remove(_uploadContainer);
					config.reset();
				});
				if(config.type == "file"){
					// 文件
					var _icon = _uploadContainer.find('.icon');				
					if(_icon.size()>0){
						_icon.hide();
						config.setIcon(data.info.filename,function(url){
							_icon.find('img').attr('src',url);	
							_icon.show();
							_uploadContainer.find('.progressContainer').width(_uploadContainer.width() - _icon.outerWidth() - 8);
							config.resizeState(_uploadContainer.find(".state"));
						});
					}
					config.loadFileUpload(id,data);
				}else if(config.type == "image"){
					// 图片
					var imgNode =  _uploadContainer.find('.uploadImage img');
					// 宽度
					if($.isNumeric(config.width)){
						imgNode.width(config.width);
					}
					// 高度
					if($.isNumeric(config.height))
						imgNode.height(config.height);		
					
					config.loadImgUpload(id,url,imgNode);
				}
			},
			loadFileUpload:function(id,data){
				DOM.find('#'+id).find('.fixupload-input-urls').val(data.info.url);
				DOM.find('#'+id).find('.progress').animate({width : data.info.percent + "%"}, "fast");
				DOM.find('#'+id).find(".state").html(
						'<span class="filename">'+data.info.filename+ ' &nbsp;</span>'
						+ '<span class="size">'+ _size(data.info.bytesRead) + " &nbsp;</span>"
						+ '<span class="percent">完成.&nbsp;</span>');
				if(config.success){
					config.success(config.getUrls());
				}
				config.resizeState(DOM.find('#'+id).find(".state"));
			},
			loadImgUpload:function(id,url,imgNode){
				var progress = DOM.find('#'+id).find('.progress');
				var state = DOM.find('#'+id).find(".state");
				DOM.find('#'+id).find('.fixupload-input-urls').val(url);
				progress.hide();
				state.hide();
				imgNode.attr('src',url);
				if(config.success){
					config.success(config.getUrls());
				}
			},
			/*!
			 * 清空上传区域
			 */
			clear:function(){
				DOM.html("");
			},
			/**
			 * 设置文件图标
			 */
			setIcon:function(filename,response){
				var url = (config.exticonUrl!=''?config.exticonUrl:_extIconUrl)+'?iconPath=' + 
							(config.iconPath!=''?+config.iconPath:_path+'skins/icons/ext/') + 
							'&filename='+filename;
				$.get(url, function(result){
					response(result);
				});
			},
			resizeState:function(_state){
				var _container = _state.parent();
				var _del = _container.parent().find('.del');
				var _filename = _state.find('.filename');
				var _size = _state.find('.size');
				var _percent = _state.find('.percent');
				var width = _container.innerWidth() - (_del.size()>0?_del.outerWidth():0) - (_size.size()>0?_size.outerWidth():0) - (_percent.size()>0?_percent.outerWidth():0);
//				alert(_container.innerWidth() + ' ' + (_del.size()>0?_del.outerWidth():0) + ' ' + 
//						(_size.size()>0?_size.outerWidth():0) + ' ' + 
//						(_percent.size()>0?_percent.outerWidth():0))
				_filename.width(width);
			},
			/*!
			 * 移出指定iframe
			 */
			remove:function(obj,err){
				if($.isNumeric(obj)){
					_uploads[obj].remove();// 删除HTML
				}else{
					obj.remove();
				};
				if(config.success){
					 config.success(config.getUrls());
				}
				if(config.error && err){
					 config.error(err);
				}
				config.resizeIframe();
			},
			
			 /*!
			  * 单个上传
			  */
			uploadReady:function(index){
				 var $upload = _uploads[index];
				 _wait[index] = true,// 等待中
				 _inter[index] = null;// 计时器
				 var progressUrl = $upload.find('input[name="progressUrl"]').val();
				 var uploadForm = $upload.find("form.fixupload-form");
				 var clickNode = $upload.find('.click');
				 var iconNode =  $upload.find(".icon");
				 var progressNode =  $upload.find(".progress");
				 var stateNode =  $upload.find(".state");
				 var imgNode =  $upload.find('.uploadImage img');
				 var urlInput = $upload.find('.fixupload-input-urls');
				 
				 // min节点
				 var progressBox =  $upload.find('.progressBox');	 // 进度BOX
				 var absoluteFile =  $upload.find('.absoluteFile');	 // 上传文件BOX
				 var file =  $upload.find('input[type="file"]');	 // 上传文件按钮
				 var delBtn =  $upload.find('.del');	 			 // 删除按钮
				 // 隐藏文件按钮，目前暂时不用
				 file.hide();
				 $upload.find('.progressContainer').width($upload.width() - iconNode.outerWidth()  - 8);
				 if(delBtn)
					 delBtn.hide();
				 clickNode.click(function(){
					 file.click();
				 });
				 // 删除
				 if(delBtn){
					 delBtn.click(function(){
						 config.remove(index);
					 });
				 }
				 // 文件输入框值改变，提交上传
				 file.change(function() {
					 stateNode.removeClass('error');
					 stateNode.html('准备上传...');
					 uploadForm.submit();
					 return true;
				 });

				 /*!
				  * 准备
				  * form提交
				  */ 
				 uploadForm.submit(function() {
					 
					 submit();
				 });
				 // 类型为图片上传，样式为小样式
				 if(_types[index] == "image" && _skins[index] == "min"){
					 vAlign($upload,absoluteFile,config.buttonVAlign);
				 }
				 // 提交上传
				 var submit = function() {
					 if(absoluteFile)
						 absoluteFile.hide();
					 if(progressBox)
						 progressBox.show();
					 _uploads[index].show();
					 // 普通文件上传
					 if(_skins[index] == "default" && _types[index] == "file"){
						 clickNode.attr("disabled", true);
						 clickNode.addClass('disabled');
						 progressNode.hide();
						 stateNode.html("准备上传.");
					 }else  if(_types[index] == "image" && _skins[index] == "min"){
						 // 小样式图片上传
						 progressNode.hide();
						 stateNode.html("准备...");
						 vAlign($upload,progressBox,config.buttonVAlign);
					 }
					 config.resizeIframe(); // 刷新IFRAME尺寸
					 _wait[index] = false; // 准备中
					 _inter[index] = setInterval(starting, 1000);
					 
				 };
				 /*!
				  * 上传指定序号的文件中...
				  */
				 function starting() {
						// 如果上传已经完成
						if (_wait[index]) {
							clearInterval(_inter[index]);
							return;
						}
						$.ajax({
							type : "get",
							dataType : "json",
					        async:false, 
							url : progressUrl+"&timestamp="+(new Date().getTime()),
							beforeSend : function() {
							},
							success : function(data) {
								progressNode.show();
								if(_skins[index] == "default" && _types[index] == "file"){
									uploadDefaultFile(data);
								}
								else  if(_types[index] == "image" && _skins[index] == "min" )
									uploadMinImage(data);
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) {
							}
						});
					};
					/*!
					 * default文件上传
					 */
					function uploadDefaultFile(data){
						if(data){
							if (data.error) {
								// 上传错误
								_wait[index] = true;
								clickNode.attr("disabled",false);
								clickNode.removeClass('disabled');
								stateNode.addClass('error');
								stateNode.html(data.error.message);
								urlInput.val('');
								if(config.error){
									config.error(data.error.message);
								}
							} else if (data.info) {
								// 有文件信息
								progressNode.animate({width : data.info.percent + "%"}, "fast");
								progressNode.show();
								if(iconNode.size()>0 && data.info.icon){
									iconNode.find('img').attr('src',data.info.icon);	
									$upload.find('.progressContainer').width($upload.width() - iconNode.outerWidth()- 8);
								}
								stateNode.html(
										'<span class="filename">'+data.info.filename+ ' &nbsp;</span>'+
										+ '<span class="size">'+_size(data.info.bytesRead) + "/"+ _size(data.info.totalSize) +  " &nbsp;</span>"
										+ '<span class="percent">'+data.info.percent + "%&nbsp;</span>");
								if (data.info.percent == 100) {
									_wait[index] = true;
									clickNode.attr("disabled", false);
									clickNode.removeClass('disabled');
									clickNode.text(config.buttonSuccessText);
									urlInput.val(data.info.url);
									if(config.success){
										config.success(config.getUrls());
									}
									stateNode.html('<span class="filename">'+data.info.filename+ ' &nbsp;</span>'
											+ '<span class="size">'+_size(data.info.bytesRead) +  " &nbsp;</span>"
											+ '<span class="percent">'+data.info.percent + "%&nbsp;</span>");
									//progressNode.hide();
								}
							}
						}
					}

					/*!
					 * 小样式图片上传
					 */
					function uploadMinImage(data){
						if (data.error) {
							// 上传错误
							_wait[index] = true;
							if(absoluteFile){
								absoluteFile.show();
							}
							progressBox.hide();
							urlInput.val('');
							if(config.error){
								config.error(data.error.message);
							}
						} else if (data.info) {
							// 输出进度
							progressNode.animate({width : data.info.percent + "%"}, "fast");
							stateNode.html(data.info.percent + "%");
							if (data.info.percent == 100) {
								_wait[index] = true;
								if(absoluteFile){
									absoluteFile.show();
									absoluteFile.find('.click').text(config.buttonSuccessText);
								}
								progressBox.hide();
								urlInput.val(data.info.url);
								imgNode.attr('src',data.info.url);
								if(config.success){
									config.success(config.getUrls());
								}
							}
						}
					}
			 }
		};

		var config = $.extend(methods, defaults, options);

//		config.init();
//		return config;
		
		return DOM.each(function() {
			config.init();
			return config;
		});
	 };
	
})(jQuery);