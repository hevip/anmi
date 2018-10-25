<extend name="Base/common" />

{// css样式区 }
<block name="link">
</block>

<block name="jscript">
</block>

<block name="main">
	<include file="Public/top" /> 
    <div class="main">
    	<div class="app_bg" id="col1">
        	<div class="app_logo">
            	<img src="__IMAGES__/app_logo.png" />
            </div>
            <div class="app_txt">
            	<h2>多享 Mall</h2>
                <p>专业的互联网产品服务选购平台</p>
            </div>
            <div class="app_btn">
            	<a href="__ROOT__" id="link" class="link1">
                    <div class="app_btn_txt">
                    	<img src="__IMAGES__/download150.png" />
                    	<h3>免费下载客户端</h3> 
                    </div>
                </a>
            </div>
            <div class="app_btn_txt01">
					免费下载APP客户端<br />自动识别手机系统安装
			</div>
        </div>
    </div>
	<div class="floating">
        <div class="w1">
            <div class="w1float"><img src="__IMAGES__/down_float.png" width="60%" /></div>
        </div>
    </div>
    
<script>
total = document.documentElement.clientHeight;
colHeight = total-50-document.getElementById("col1").offsetTop;
document.getElementById("col1").style.height=colHeight+"px";
</script>  

<script>
$('body').bind('touchmove',function(event){event.preventDefault;
//code
});
var platform = identifyUA();
var link;
switch(platform){
	case 'ios':
	link = 'http://www.pgyer.com/aEJs';
	break;
	case 'android':
	link = 'http://m.malldx.com/app/Android/DuoXiangMall.apk';
	$('html').bind('click',function(){
		window.location.href=link;
	});
	break;
	default:
	link = '/';
}
var userAgent = navigator.userAgent.toLowerCase();
var wx = userAgent.indexOf('micromessenger');
if (wx != -1) {
    $('#link').click(function(event) {
        event.preventDefault();
        $('.floating').show();
    });
}
try{
    WeixinApi.ready(function(){
        
        $('#link').click(function(event) {
                event.preventDefault();
                
                $('.floating').show();
            });
    })
}
catch(err){}

$('#link').attr('href', link);
function identifyUA() {
    var userAgent = navigator.userAgent.toLowerCase();
    var platform ='';
    if(userAgent == null || userAgent == ''){
        platform = 'web' ; 
    }else{
        if(userAgent.indexOf("android") != -1 ){ 
            platform = 'android';
        }else if(userAgent.indexOf("ios") != -1 || userAgent.indexOf("iphone") != -1){ 
            platform = 'ios';
        }else if(userAgent.indexOf("ipad") != -1) {
            platform = 'ios';
        }else if(userAgent.indexOf("windows phone") != -1 ){ 
            platform = 'windowsphone';
        }else{
            platform = 'web';
        }
    }
    return platform;
}
</script>
</block>