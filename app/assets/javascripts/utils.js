var Utils = {};

Utils.collapseCaret = function() {
	var findFa = function(element) {
		return $('[data-toggle="collapse"][href="#'+$(element).attr('id')+'"] .fa');
	};
	$(document).on('show.bs.collapse', '.collapse', function(e) {
		e.stopPropagation();
		findFa(this).addClass('fa-flip-vertical');
	});
	$(document).on('hide.bs.collapse', '.collapse', function(e) {
		e.stopPropagation();
		findFa(this).removeClass('fa-flip-vertical');
	});
};

Utils.delete = function() {
	var triggerClick = function(e) {
		e.preventDefault();
		var $trigger = $(this);
		var options = $trigger.data();
		var $remove = !!options.remove && $trigger.closest(options.remove);
		var $parent = !!options.remove && $remove.parent();
		$.ajax({ url: $trigger.attr('href'), method: 'delete', dataType: 'json' })
		.done(function(response) {
			if (!!options.remove) $remove.fadeOut(function() {
				$remove.remove();
				$(document).trigger('removed.util.delete', [ $parent.length ? $parent.get(0) : null ]);
			});
		});
	};
	$(document).on('click', '[data-util=delete]', triggerClick);
};

Utils.templates = function() {
	var inputsFromData = function(data) {
		if (!data) return null;
		var $obj = $();
		for (var key in data) {
			var val = data[key];
			var $hidden = $('<input>', { type: 'hidden', name: key, value: val });
			$obj = $obj.add($hidden);
		};
		return $obj;
	};
	var triggerClick = function(e) {
		e.preventDefault();
		var $trigger = $(this);
		var options = $trigger.data();
		var $clone = $(options.template).clone().removeAttr('id');
		var $target = $(options.target);
		if (!!options.inputs) {
			var $inputs = inputsFromData(options.inputs);
			var $form = $clone.find('form');
			$form.append($inputs);
		};
		$clone.appendTo($target);
		$trigger.trigger('inserted.util.templates', [$trigger.get(0), $clone.get(0), $target.get(0)]);
	};
	$(document).on('click', '[data-util=template]', triggerClick);
};

Utils.handleAjaxErrors = function() {
	$(document).ajaxError(function(event, xhr, settings, thrownError) {
		Alerts.danger('Ocurrió un error de conexión debido a: <small>' + thrownError.toString() + '</small>');
		console.log(arguments);
	});
};

Utils.onload = function() {
	Utils.handleAjaxErrors();
	Utils.collapseCaret();
	Utils.templates();
	Utils.delete();
};

$(Utils.onload);