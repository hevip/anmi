<script type="text/javascript">
$( function() {
	var checkAll = $( ".checkAll" );
	// 全选
	checkAll.click( function() {
		var flag = $( this ).prop( 'checked' );
		var liObj = $( this ).parent().parent().parent();
		var liFindObj = liObj.find( 'ul li input[type="checkbox"]' );
		if ( flag ) {
			liFindObj.prop( 'checked', true );
		} else {
			liFindObj.prop( 'checked', false );
		}
	} );
	var checkSingle = $( '.checkSingle' );
	checkSingle.click( function() {
		var flag = $( this ).prop( 'checked' );
		var parentObj = $( this ).parent().parent().parent().parent();
		var allObj = parentObj.prev().find( 'input[type="checkbox"]' );
		var theUlObj = parentObj.find( 'li' );
		var theLen = theUlObj.length;
		if ( flag ) {
			var temp = 0;
			theUlObj.each( function( index ) {
				if ( $( this ).find( 'input[type="checkbox"]' ).prop( 'checked' ) ) {
					temp ++;
				}
			} );
			if ( temp == theLen ) {
				allObj.prop( 'checked', true );
			}
		} else {
			allObj.prop( 'checked', false );
		}
	} );
} );
</script>

<div class="pageContent">
	<form method="post" action="__URL__/auth_save" class="pageForm required-validate" onsubmit="return validateCallback(this, dialogAjaxDone)">
		<input type="hidden" name="id" value="{$id}" />
		<div class="pageFormContent" layoutH="68">
			<ul class="tree treeFolder collapse">
				<volist name="nodeList" id="volist">
                <li>
					<label class="label_auto">
						<input type="checkbox" name="auth[]" value="{$volist['name']}"{$volist['checked']} class="check_style checkAll" />
						{$volist['title']}
					</label>
					<if condition="$volist['child']|count gt 0">
						<ul class="tree treeFolder collapse" style="padding-left:20px;">
							<volist name="volist['child']" id="childList">
							<li>
								<label class="label_auto">
									<input type="checkbox" name="auth[]" value="{$volist['name']}/{$childList['name']}"{$childList['checked']} class="check_style checkSingle" />
									{$childList['title']}
								</label>
							</li>
							</volist>
	               		</ul>
					</if>               
                </li>
				</volist>
            </ul>
		</div>
		<div class="formBar">
			<ul>
                     <li>
                        <div class="buttonSave">
                            <div class="buttonSaveContent">
                                <button type="submit">
                            		<i class="iconfont">&#xe644;</i>保存
                                </button>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="buttonCancel">
                            <div class="buttonCancelContent">
                                <button type="button" class="close">
                                	<i class="iconfont">&#xe640;</i>取消
                                </button>
                            </div>
                        </div>
                    </li>
			</ul>
		</div>
	</form>
</div>