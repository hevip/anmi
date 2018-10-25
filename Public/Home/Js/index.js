$( function() {
	var product_search = $( '.product_search' );
	var product_search_input = product_search.find( 'input' );
	product_search.find( 'span' ).click( function() {
		if ( product_search_input.val() != "" ) {
			location.href = jsObj['root'] + '/Product/clist/key/' + product_search_input.val();
		} else {
			product_search_input.focus();
		}
	} );
} );
