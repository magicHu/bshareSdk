var Hello = function(element) {
	this.$element = $(element)
	this.$element.on('click', this.hello);
}

Hello.prototype = {
	hello : function() {
		alert("hello world , " + this.$element.attr("data-message"));
	}
}

$.fn.hello = function() {
	$(this).each(function() {
		var data = $(this).data('hello');
		if (!data) {
			$(this).data('hello', data = new Hello());
		}
	});

}