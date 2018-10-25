wx.config({
	debug : wxConfig.debug,
	appId : wxConfig.appId,
	timestamp: wxConfig.timestamp,
	nonceStr: wxConfig.nonceStr,
	signature: wxConfig.signature,
	jsApiList: wxConfig.jsApiList
});
shareData = {
	title: wxData.title, // 分享标题
    link: wxData.link, // 分享链接
    desc: wxData.desc, // 分享描述
    imgUrl: wxData.imgUrl, // 分享图标
    trigger: function (res) {
    	// 用户点击分享
    },
    success: function () { 
        // 用户确认分享后执行的回调函数
    },
    cancel: function () { 
        // 用户取消分享后执行的回调函数
    },
    fail: function (res) {
    }
};
wx.ready(function() {
	// 分享到朋友圈
	wx.onMenuShareTimeline( shareData );
	// 分享给朋友
	wx.onMenuShareAppMessage( shareData );
	// 分享到QQ
	wx.onMenuShareQQ( shareData );
	// 分享到QQ空间
	wx.onMenuShareQZone( shareData );
	// 分享到腾讯微博
	wx.onMenuShareWeibo( shareData );
}); 