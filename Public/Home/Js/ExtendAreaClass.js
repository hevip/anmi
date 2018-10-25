;(function( $ ) {
	var settingsArea = $.extend( {
		'province' : $( '#province' ),
		'city' : $( '#city' ),
		'area' : $( '#area' ),
	});

    
	$.extend({
		cityInit : function( city ) {
			// 触发省
            settingsArea.province.change( function() {
				var father = $( this ).val();
				city = city ? city : "";
				$.ajax({
					url : jsObj['root'] + '/Address/getCity',
					type : "post",
					data : { father : father, city : city, rnd : Math.random() },
					async : true,
					beforeSend : function() {},
					success : function( data, textStatus ) {
                        settingsArea.city.find( "option" ).remove();
                        settingsArea.area.find( "option" ).remove();
                        settingsArea.city.append("<option value=\"\">市</option>");
                        settingsArea.area.append("<option value=\"\">县/区</option>");
                        settingsArea.city.append(data);
					}
				});
			} );
		},
		areaInit : function( area ) {
			// 触发市
            settingsArea.city.change( function() {
				var father = $( this ).val();
				area = area ? area : "";
				$.ajax({
                    url :jsObj['root'] + '/Address/getArea',
					type : "post",
					data : { father : father, area : area, rnd : Math.random() },
					async : true,
					beforeSend : function() {},
					success : function( data, textStatus ) {
                        settingsArea.area.find( "option" ).remove();
                        settingsArea.area.append("<option value=\"\">县/区</option>");
                        settingsArea.area.append(data);
					}
				});
			} );
		}
	});
})(jQuery);
