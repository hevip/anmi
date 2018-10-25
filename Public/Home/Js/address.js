$( function() {
	$( '#address_form' ).submit( function() {
		// 公司名称 
		var company = $( 'input[name="company"]' );
		if ( company.val() == "" ) {
			d_messages( company.attr( 'placeholder' ) );
			company.focus();
			return false;
		}
		// 联系人
		var nickname = $( 'input[name="nickname"]' );
		if ( nickname.val() == "" ) {
		d_messages( nickname.attr( 'placeholder' ),2 );
			nickname.focus();
			return false;
		}
		// 手机号码
		var tel = $( 'input[name="tel"]' );
		var telreg =  /^13[0-9]{9}|17[0-9]{9}|14[0-9]{9}|15[0-9]{9}|18[0-9]{9}$/;
		if ( tel.val() == "" ) {
			d_messages( tel.attr( 'placeholder' ) ,2);
			tel.focus();
			return false;
		} else if ( !telreg.test( tel.val() ) ) {
			d_messages( '手机号码格式有误',2 );
			tel.focus();
			return false;
		}
		// 联系电话
		var contact = $( 'input[name="contact"]' );
		if ( contact.val() == "" ) {
			d_messages( contact.attr( 'placeholder' ) ,2);
			contact.focus();
			return false;
		}
		// 省
		var province = $( 'select[name="province"]' );
		if ( province.val() == "" ) {
			d_messages( '请选择所属省份',2 );
			province.focus();
			return false;
		}
		// 市
		var city = $( 'input[name="areaId"]' );
		if ( city.val() == "" ) {
			d_messages( '请选择所在城市',2 );
			city.focus();
			return false;
		}
		// 县/区
		var area = $( 'select[name="area"]' );
		if ( area.val() == "" ) {
			d_messages( '请选择所在区域',2 );
			area.focus();
			return false;
		}
		// 详细地址
		var intro = $( 'input[name="intro"]' );
		if ( intro.val() == "" ) {
			d_messages( intro.attr( 'placeholder' ) ,2);
			intro.focus();
			return false;
		}
		var action = $("#address_form").attr("action");
		$.post(action,$('#address_form').serialize(),function(data){
			if(data.status == 1){
				d_messages( '操作成功' ,2);
				window.location.href = data.msg;
			}else{
				d_messages( data.msg ,2);
			}
		});
	} );
	$('.Province').click(function(){
		var $this = $(this);
		var id = $this.attr('data-id');
		$.post(jsObj['root'] + '/Address/getCity',{ father : id, rnd : Math.random() },function(data){
			$('.City').html(data);
		});
		
	});
	$('.delete').click(function(){
		$this = $(this);
		var id = $this.attr('data-id');
		if(confirm("确定要删除数据吗")){
			var $this = $(this);
			var id = $this.attr('data-id');
			$.get(jsObj['root'] + '/Address/delete',{ id: id, rnd : Math.random() },function(data){
				d_messages( data.msg ,2);
				if(data.status == 1){
					$this.parents('.flow-checkout-adr').remove();
				}
				
			});
	    }else{
	   }		
	});
	$('.seDefault').click(function(){
		$this = $(this);
		//if($this.hasClass('active'))return false;
		var id = $this.attr('data-id');
		var $this = $(this);
		var id = $this.attr('data-id');
		$.get(jsObj['root'] + '/Address/is_default',{ id: id, rnd : Math.random() },function(data){
			d_messages( data.msg ,2);
			if(data.status == 1){
				$this.addClass('active');
			}
			
		});		
	});
} );
