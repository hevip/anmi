<extend name="Base/common" />

<block name="link">
	<link href="__PLUGIN_H-ui__/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
	<link href="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</block>

<block name="jscript">
	<!-- ueditor编辑器开始 -->
	<script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/ueditor.config.js"></script>
	<script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/ueditor.all.min.js"> </script>
	<script type="text/javascript" src="__PLUGIN__/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
	<script>
		$(function(){
			var ue = UE.getEditor('editor');
		});
	</script>
	<!-- ueditor编辑器结束 -->
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/icheck/jquery.icheck.min.js"></script> 
	<script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> 
	<script type="text/javascript" src="__JS__/commodity.js"></script>
	<script type="text/javascript">
		$(function(){
			// radio插件
			$('.skin-minimal input').iCheck({
				checkboxClass: 'icheckbox-blue',
				radioClass: 'iradio-blue',
				increaseArea: '20%'
			});

		$('.pid-select').change(function(){
				var $this = $(this);
				var id = $this.val();
				if(id==30){
					$('.addInfo').css('display','block');
					$('.addInfo .col-1').html('抢购时间:');
				}else{
					$('.addInfo').css('display','none');
				}
				
			})
			// 单图上传
			plugins.singleImageUpload();
			
			// 表单验证
			plugins.Validform();

		});
	</script>
</block>

<block name="main">
	<div class="pd-20">
		<form action="__URL__/update" method="post" class="form form-horizontal" id="formValidform">
			<input type="hidden" name="id" value="{$dataInfo['id']}" />
			<div class="panel panel-default">
		    	<div class="panel-body">
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>商品标题：
						</label>
						<div class="formControls col-9">
							<input type="text" name="title" value="{$dataInfo['title']}" datatype="*" nullmsg="商品标题不能为空" placeholder="商品标题" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
				    <div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>上市时间：
						</label>
						<div class="formControls col-9">
							<if condition="$dataInfo['birth_time'] gt 0">
								<input type="text" name="birth_time" value="{$dataInfo['birth_time']|date='Y-m-d',###}" datatype="*" nullmsg="上市时间不能为空" placeholder="上市时间" class="input-text radius Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
							<else />
								<input type="text" name="birth_time" value="" datatype="*" nullmsg="上市时间不能为空" placeholder="上市时间" class="input-text radius Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
							</if>
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							网站标题：
						</label>
						<div class="formControls col-9">
							<input type="text" name="web_title" value="{$dataInfo['web_title']}" placeholder="网站标题" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							网站关键字：
						</label>
						<div class="formControls col-9">
							<input type="text" name="web_keywords" value="{$dataInfo['web_keywords']}" placeholder="网站关键字" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							网站描述：
						</label>
						<div class="formControls col-9">
							<input type="text" name="web_description" value="{$dataInfo['web_description']}" placeholder="网站描述" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">封面图：</label>
						<div class="formControls col-9">
							<if condition="$dataInfo['picture'] neq ''">
								<div class="singleImageShow">
									<img src="__ROOT__/{$dataInfo['picture']}" width="100" />
								</div>
							</if>
							<div class="uploader-thum-container">
								<div id="fileList" class="uploader-list"></div>
								<div id="filePicker">选择图片</div>
								<input type="hidden" name="picture" value="{$dataInfo['picture']}" id="singleImageUpload" datatype="*" nullmsg="请上传商品封面图" />
								<input type="button" id="btn-star" class="btn btn-default btn-uploadstar radius ml-10" value="开始上传" />
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							商品分类：
						</label>
						<div class="formControls col-9">
							<div class="classList" style="display:inline;">
								<if condition="$dataInfo['pid'] eq 0">
									<span class="select-box radius width-130">
								    	<select name="pid" class="select pid-select select-class" datatype="*" nullmsg="请选择商品分类">
							                <option value="">请选择1分类</option>
							                <volist name="classList" id="volist">
												<option value="{$volist['id']}">{$volist['title']}</option>
							                </volist>
							            </select>
									</span>
								<else />
					                <volist name="classList" id="onelist">
						    			<span class="select-box radius width-130">
									    	<select name="pid" class="select pid-select select-class" datatype="*" nullmsg="请选择商品分类">
								                <option value="">请选择2分类</option>
								                <volist name="onelist" id="volist">
													<option value="{$volist['id']}"{$volist['selected']}>{$volist['title']}</option>
								                </volist>
								            </select>
										</span>
									</volist>
								</if>
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl addInfo" style="display:none;">
						<label class="form-label col-1">
							
						</label>
						<div class="formControls col-9">
						<input type="text" name="end_time" value="" id="datemin" placeholder="结束日期" class="input-text radius Wdate width-200">
							 <input type="text" name="start_time" value="" id="datemin" placeholder="开始日期" class="input-text radius Wdate width-200">至
							 <script type="text/javascript" src="__PLUGIN_H-ui__/lib/webuploader/0.1.5/webuploader.min.js"></script> 
							 
						</div>
						<div class="col-2"> </div>
					</div>
					<!-- 商品所属start -->
					<div class="row cl">
						<label class="form-label col-1">
							商品所属：
						</label>
						<div class="formControls col-9 skin-minimal">
							<div class="radio-box">
								<if condition="$dataInfo['uid'] eq 0">
									<input type="radio" name="uid" value="0" checked="checked" id="uid-1" />
								<else />
									<input type="radio" name="uid" value="0" id="uid-1" />
								</if>
								<label for="uid-1">官方自营</label>
							</div>
							<div class="radio-box">
								<if condition="$dataInfo['uid'] gt 0">
									<input type="radio" name="uid" value="{$dataInfo['uid']}" checked="checked" id="uid-2" />
								<else />
									<input type="radio" name="uid" value="" id="uid-2" />
								</if>
								<label for="uid-2">第三方推荐</label>
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="TheGoods"><if condition="$dataInfo['uid'] gt 0">
							<div class="row cl">
								<label class="form-label col-1">
									<span class="c-red">*</span>幸运码：
								</label>
								<div class="formControls col-9">
									<input type="text" value="{$dataInfo['member_info']['referral_code']}" datatype="*" nullmsg="幸运码不能为空" placeholder="幸运码" class="input-text radius TheGoodsQuery" style="width:40%;border-color:#3bb4f2">
								</div>
								<div class="col-2"> </div>
							</div>
						</if></div>
					<if condition="$dataInfo['uid'] eq 0">
						<div class="row cl TheGoodsInfo" style="display:none;">
					<else />
						<div class="row cl TheGoodsInfo">
					</if>
						<label class="form-label col-1">开发人信息：</label>
						<div class="formControls col-9" style="position:relative;top:4px;color:red;">
							<if condition="$dataInfo['uid'] gt 0">
								用户名：{$dataInfo['member_info']['username']}&nbsp;&nbsp;&nbsp;&nbsp;真实名称：{$dataInfo['member_info']['nickname']}&nbsp;&nbsp;&nbsp;&nbsp;幸运码：{$dataInfo['member_info']['referral_code']}
							</if>
						</div>
					</div>
					<!-- 商品所属end -->
					
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>市场价：
						</label>
						<div class="formControls col-9">
							<input type="text" name="market_price" value="{$dataInfo['market_price']}" datatype="price" nullmsg="市场价不能为空" placeholder="市场价" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>会员价：
						</label>
						<div class="formControls col-9">
							<input type="text" name="member_price" value="{$dataInfo['member_price']}" datatype="price" nullmsg="会员价不能为空" placeholder="会员价" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>成本价：
						</label>
						<div class="formControls col-9">
							<input type="text" name="cost_price" value="{$dataInfo['cost_price']}" datatype="price" nullmsg="成本价不能为空" placeholder="成本价" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>运费：
						</label>
						<div class="formControls col-9">
							<input type="text" name="freight" value="{$dataInfo['freight']}" datatype="price" nullmsg="运费不能为空" placeholder="运费" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>库存：
						</label>
						<div class="formControls col-9">
							<input type="text" name="stock" value="{$dataInfo['stock']}" datatype="n" nullmsg="库存不能为空" placeholder="库存" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>是否上架：
						</label>
						<div class="formControls col-9 skin-minimal">
							<div class="radio-box">
								<if condition="$dataInfo['shelves'] eq 1">
									<input type="radio" name="shelves" value="1" checked="checked" id="shelves-1" datatype="*" nullmsg="请选择是否上架" />
								<else />
									<input type="radio" name="shelves" value="1" id="shelves-1" datatype="*" nullmsg="请选择是否上架" />
								</if>
								<label for="shelves-1">是</label>
							</div>
							<div class="radio-box">
								<if condition="$dataInfo['shelves'] eq 0">
									<input type="radio" name="shelves" value="0" checked="checked" id="shelves-2" />
								<else />
									<input type="radio" name="shelves" value="0" id="shelves-2" />
								</if>
								<label for="shelves-2">否</label>
							</div>
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							<span class="c-red">*</span>排序：
						</label>
						<div class="formControls col-9">
							<input type="text" name="sort" value="{$dataInfo['sort']}" datatype="n" nullmsg="排序值不能为空" placeholder="排序" class="input-text radius" />
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">商品简介：</label>
						<div class="formControls col-9">
							<textarea name="intro" dragonfly="true" onKeyUp="textarealength(this,100)" placeholder="几句描述商品的话...100个字符以内" class="textarea radius">{$dataInfo['intro']}</textarea>
							<p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
						</div>
						<div class="col-2"> </div>
					</div>
					<div class="row cl">
						<label class="form-label col-1">
							商品详情：
						</label>
						<div class="formControls col-9">
							<script id="editor" name="content" type="text/plain" style="width:100%;height:400px;">{$dataInfo['content']}</script>
						</div>
						<div class="col-2"> </div>
					</div>
				</div>
			</div>
			<div class="row cl">
				<div class="col-9 col-offset-9">
					<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</div>
</block>