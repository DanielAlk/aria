var Pages = {};

Pages.loader = function(text) {
	var $loader = $('<div>', { class: 'gral-loader', id: 'gral_loader' });
	$loader
	.hide()
	.append($('<span>', { text: text }))
	.append('<i class="fa fa-spinner fa-spin fa-5x fa-fw"></i>')
	.appendTo('body')
	.fadeIn();
};

Pages.home = function() {
	$('section .owl-carousel').owlCarousel({
		loop:false,
		items:1,
		slideBy:1,
		margin:0,
		nav: true,
		dots: false,
		responsive:{
			0:{items:1},
			650:{items:2},
			800:{items:3},
			1025:{items:4},
			1251:{items:5}
		}
	});
	$('.slider-bottom .owl-carousel').owlCarousel({
		loop:true,
		items:1,
		margin:0,
		nav:true,
		dots:true,
		responsive:{
			0:{ items:1}
		}
	});
};

Pages.products = function() {
	$('.products-page-filters select').change(function(e) {
	  $(this).closest('form').submit();
	});
	$('section .owl-carousel').owlCarousel({
		loop:false,
		items:1,
		slideBy:1,
		margin:0,
		nav: true,
		dots: false,
		responsive:{
			0:{items:1},
			650:{items:2},
			800:{items:3},
			1025:{items:4},
			1251:{items:5}
		}
	});
};

Pages.product = function(product) {
	AriaProductInit();
	$('#star_' + product.score).click();
	$('.rating input').click(function(e) {
	  e.preventDefault();
	});
	$('#galeria-thumbs.owl-carousel').owlCarousel({
	  loop:false,
	  items:3,
	  margin:0,
	  nav:true,
	  dots:false,
	  responsive:{
	      0:{ items:3}
	  }
	});	
	$('section.relacionados .owl-carousel').owlCarousel({
	  loop:false,
	  items:1,
	  slideBy:1,
	  margin:0,
	  nav: true,
	  dots: false,
	  responsive:{
	    0:{items:1},
	    650:{items:2},
	    800:{items:3},
	    1025:{items:4},
	    1251:{items:5}
	  }
	});
};

Pages.works = function() {
	$('.works-page-filters select').change(function(e) {
	  $(this).closest('form').submit();
	});
	$('section .owl-carousel').owlCarousel({
		loop:false,
		items:1,
		slideBy:1,
		margin:0,
		nav: true,
		dots: false,
		responsive:{
			0:{items:1},
			650:{items:2},
			800:{items:3},
			1025:{items:4},
			1251:{items:5}
		}
	});
};

Pages.work = function() {
	AriaProductInit();
	$('#galeria-thumbs.owl-carousel').owlCarousel({
	  loop:false,
	  items:3,
	  margin:0,
	  nav:true,
	  dots:false,
	  responsive:{
	      0:{ items:3}
	  }
	});	
	$('section.relacionados .owl-carousel').owlCarousel({
	  loop:false,
	  items:1,
	  slideBy:1,
	  margin:0,
	  nav: true,
	  dots: false,
	  responsive:{
	    0:{items:1},
	    650:{items:2},
	    800:{items:3},
	    1025:{items:4},
	    1251:{items:5}
	  }
	});
};

Pages.carousel = function() {
	$('.slider.owl-carousel').owlCarousel({
	  loop:true,
	  items:1,
	  margin:0,
	  nav:true,
	  dots:true,
	  autoplay:true,
	  autoplayTimeout:5000,
	  responsive:{
	      0:{ items:1}
	  }
	});
};