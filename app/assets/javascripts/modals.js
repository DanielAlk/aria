var Modals = {};

Modals.init = function() {
	$(document).on('shown.bs.modal', '.modal', function(e) {
		$(this).find('form input:not([type=hidden])').first().focus();
	});
	$(document).on('hidden.bs.modal', '.modal', function(e) {
		var $form = $(this).find('form');
		if ($form.length) $form.get(0).reset();
	});
	$(document).on('click', '[data-util=modal]', Modals.customFunction);
};

Modals.contextForm = function(modalId, prefix) {
	var $modal = $('#' + modalId);
	var $form = $modal.find('form');
	var onShow = function(e) {
		var $btn = $(e.relatedTarget);
		var data = $btn.data();
		for (var name in data) {
			if (name == 'toggle' || name == 'target') continue;
			var $input = $form.find('input[name="'+prefix+'\['+name+'\]"]');
			if (!$input.length) continue;
			$input.val(data[name]);
		};
	};
	$modal.on('show.bs.modal', onShow);
	$form.validate();
};

Modals.customFunction = function(e) {
	e.preventDefault();
	var $trigger = $(this);
	var $target = $($trigger.attr('href'));
	var closeModal = function(e) {
		e.preventDefault();
		$(this).off('click', closeModal);
		$('body').removeAttr('style');
		$target.fadeOut(function() {
			$target.removeClass('in').trigger('hidden.bs.modal');
		});
	};
	$target.fadeIn(function() {
		$target.addClass('in').trigger('shown.bs.modal');
		$target.find('.close').click(closeModal);
	});
	$('body').css('overflow', 'hidden');
};

$(Modals.init);