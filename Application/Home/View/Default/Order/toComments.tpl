<extend name="Base/common" />

{// css样式区 }
<block name="link">
	<link rel="stylesheet" type="text/css" href="__PLUGIN__/webuploader/webuploader.css">
	<link rel="stylesheet" type="text/css" href="__STYLE__/usercenter.css" />
	<link rel="stylesheet" type="text/css" href="__STYLE__/estimate.css" />
    <style type="text/css">
        *{font-size: 1.3rem;}
    </style>
</block>

<block name="jscript">
	<script type="text/javascript" src="__PLUGIN__/webuploader/webuploader.js"></script>
    <script type="text/javascript" src="__JS__/estimate.js"></script>
</block>

<block name="main">
	<!-- 头部 -->
	<header class="header-menu dis-box">
    	<a href="javascript:history.go(-1);"><i class="iconfont">&#xe636;</i></a>
        <h3>{$columnTitle}</h3>
        <a href="__ROOT__"><i class="iconfont">&#xe621;</i></a>
    </header>
	
	<!-- 主题内容 -->
	<form class="main">
		<input type="hidden" name="order_id" value="{$orderInfo['id']}" />
		<input type="hidden" name="pro_id" value="{$orderInfo['pro_id']}" />
		<input type="hidden" name="type" value="" />
		<input type="hidden" name="picture" value="" />
		<div class="estimate">
			<dl>
			    <dt><img src="__ROOT__/{$orderInfo['picture']}" alt=""></dt>
			    <dd class="txt">总体评价</dd>
			    <dd class="estimateChoose">
			        <ul>
			            <li data-id="3"><i class="iconfont">&#xe642;</i>好评</li>
			            <li data-id="2"><i class="iconfont">&#xe641;</i>中评</li>
			            <li data-id="1"><i class="iconfont">&#xe640;</i>差评</li>
			        </ul>
			    </dd>
			</dl>
			<textarea name="content" class="textInput" placeholder="亲，我们的宝贝您满意吗，服务怎么样，物流快吗？（写够15个字才是好同志）"></textarea>
			
			<!-- 图片上传 -->
			<div class="uploadPhoto">
			    <div class="uploadBtn" id="filePicker">
			    	<div class="btn">
			    		<div class="icon"><i class="iconfont">&#xe629;</i></div>
			    	</div>
			    </div>
		    	<div id="fileList" class="uploader-list">
					<!-- <div class="getData">
			    		<i class="iconfont">&#xe669;</i>
				    	<div class="pic"><img src="__ROOT__/{$orderInfo['picture']}" /></div>
				    	<span>
				    		<label>标题</label>
				    		<em class="right iconfont">&#xe612;</em>
				    	</span>
				    </div>
			    	<div class="getData">
			    		<i class="iconfont">&#xe669;</i>
				    	<div class="pic"><img src="__ROOT__/{$orderInfo['picture']}" /></div>
				    	<span>
				    		<label>标题标题标题标题标题标题标题</label>
				    		<em class="error iconfont">&#xe669;</em>
				    	</span>
				    </div>
			    	<div class="getData">
			    		<i class="iconfont">&#xe669;</i>
				    	<div class="pic"><img src="__ROOT__/{$orderInfo['picture']}" /></div>
				    </div>
			    	<div class="getData last">
			    		<i class="iconfont">&#xe669;</i>
				    	<div class="pic"><img src="__ROOT__/{$orderInfo['picture']}" /></div>
				    </div> -->
				</div>
			    <p class="tips">亲，最多上传4张照片哦～</p>
			</div>
		</div>
		<input class="submit" type="submit" value="提交评价">
		<script type="text/javascript">
			var fileMaxSize = 1048576;
			// 创建图片上传实例
			var uploader = WebUploader.create({
			    // 选完文件后，是否自动上传。
			    auto: true,
			    // swf文件路径
			    swf: jsObj['root'] + '/webuploader/Uploader.swf',
			    // 文件接收服务端。
			    server: '{:U("CommodityComment/picUpload")}',
			    // 选择文件的按钮。可选。
			    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
			    pick: '#filePicker',
			    fileNumLimit: 4,
			    fileSingleSizeLimit: fileMaxSize,
			    // 只允许选择图片文件。
			    accept: {
			        title: 'Images',
			        extensions: 'gif,jpg,jpeg,bmp,png',
			        mimeTypes: 'image/*'
			    }
			});

			uploader.on( 'beforeFileQueued', function( file ) {
				if ( file.size > fileMaxSize ) {
					d_messages('图片大小不能超过1M。'+file.id);
				}
			});
			// 当有文件添加进来的时候
			uploader.on( 'fileQueued', function( file ) {
				var $li = $(
						'<div id="' + file.id + '" class="getData">' +
						'	<i class="iconfont">&#xe669;</i>' +
						'	<div class="pic"><img></div>' +
						'	<span><label>' + file.name + '</label></span>' +
						'</div>'
				);
			    var $img = $li.find('img');

			    // $list为容器jQuery实例
			    var $list = $("#fileList");
			    $list.append( $li );

			    // 创建缩略图
			    // 如果为非图片文件，可以不用调用此方法。
			    // thumbnailWidth x thumbnailHeight 为 100 x 100
			    var thumbnailWidth = 100;
			    var thumbnailHeight = 100;
			    uploader.makeThumb( file, function( error, src ) {
			        if ( error ) {
			            $img.replaceWith('<span>不能预览</span>');
			            return;
			        }

			        $img.attr( 'src', src );
			    }, thumbnailWidth, thumbnailHeight );
			});
			// 文件上传过程中创建进度条实时显示。
			uploader.on( 'uploadProgress', function( file, percentage ) {
			    var $li = $( '#'+file.id );
			    var $percent = $li.find('.progress span');
			    // 避免重复创建
			    if ( !$percent.length ) {
			        $percent = $('<p class="progress"><span></span></p>').appendTo( $li ).find('span');
			    }
			    $percent.css( 'width', percentage * 100 + '%' );
			});

			// 文件上传成功，给item添加成功class, 用样式标记上传成功。
			uploader.on( 'uploadSuccess', function( file, response ) {
			    //$( '#'+file.id ).addClass('upload-state-done');
			    $( '#'+file.id+' > span' ).append('<em class="right iconfont">&#xe612;</em>');
			    // 处理服务端返回的数据
			    if ( response['status'] ) {
			    	var input = $( 'input[name="picture"]' );
			    	var nowVal = input.val();
			    	if ( nowVal == "" ) {
			    		input.val( response['savepath'] );
			    	} else {
			    		input.val( nowVal + '|' + response['savepath'] );
			    	}
			    } else {
			    	d_messages( '图片：' + file.name + '上传失败!' );
			    }
			});
			
			// 文件上传失败，显示上传出错。
			uploader.on( 'uploadError', function( file ) {
			    var $li = $( '#'+file.id ),
			        $error = $li.find('div.error');

			    // 避免重复创建
			    if ( !$error.length ) {
			        $error = $('<div class="error"></div>').appendTo( $li );
			    }
			    
			    $error.text('上传失败');
			    
			    $( '#'+file.id+' > span' ).append('<em class="right iconfont">&#xe669;</em>');
			    $( '#'+file.id+' > label' ).html( '上传失败' );
			});

			// 完成上传完了，成功或者失败，先删除进度条。
			uploader.on( 'uploadComplete', function( file ) {
			    $( '#'+file.id ).find('.progress').remove();
			});
			
			$( '.uploader-list' ).on( 'click', '.getData i', function() {
				var index = $( this ).parent().index();
				var id = $( this ).parent().attr('id');
				removeUploader( id, index );
			} );
			
			function removeUploader( id, index ) {
				for (var i = 0; i < uploader.getFiles().length; i++) {
					if ( uploader.getFiles()[i].id == id ) {
			            uploader.removeFile(uploader.getFiles()[i],true);
			            var $li = $('#' + uploader.getFiles()[i].id);
			            $li.off().remove();
			            // 替换input值
			            var input = $( 'input[name="picture"]' );
				    	var nowVal = input.val();
				    	if ( nowVal != '' ) {
				    		var inputArray = nowVal.split( '|' );
				    		inputArray.splice( index, 1 );
				    		nowVal = inputArray.join( '|' );
				    		input.val( nowVal );
				    	}
					}
		        }
			}
		</script>
	</form>
	
	
	
</block>