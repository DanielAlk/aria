var Works = {};

Works.index = function() {
  var status_translated = {draft: 'Borrador', active: 'Activa', paused: 'Pausada', trash: 'Borrada'};
  var label_class = {draft: 'info', active: 'success', paused: 'danger', trash: 'danger'};
  var updateToggle = function(e, work) {
  	var is_active = work.status == 'active';
  	var $toggler = $('#work_' + work.id + ' .work-active-toggler');
  	$toggler.data('hash', { work: { status: is_active ? 'paused' : 'active' }});
  	$toggler.find('.fa').removeClass('fa-play fa-pause').addClass(is_active ? 'fa-pause' : 'fa-play');
  	$toggler.tooltip('destroy');
  	$toggler.attr('title', is_active ? 'Pausar' : 'Activar');
  	$toggler.tooltip();
  	$('#work_status_' + work.id)
  	.text(status_translated[work.status])
  	.removeClass('label-info label-success label-danger')
  	.addClass('label-' + label_class[work.status]);
  };
  var updateSpecialToggle = function(e, work) {
  	var is_new = work.special == 'is_new';
  	var is_offer = work.special == 'is_offer';
  	var $display = $('#work_' + work.id);
  	var $togglerNew = $display.find('.work-new-toggler');
  	var $togglerOffer = $display.find('.work-offer-toggler');
  	$togglerNew.data('hash', { work: { special: is_new ? 'is_regular' : 'is_new' }});
  	$togglerNew.find('.fa').removeClass('fa-flag fa-flag-o').addClass(is_new ? 'fa-flag' : 'fa-flag-o');
  	$togglerNew.tooltip('destroy');
  	$togglerNew.attr('title', is_new ? 'Quitar nuevo' : 'Marcar como nuevo');
  	$togglerNew.tooltip();
  	$togglerOffer.data('hash', { work: { special: is_offer ? 'is_regular' : 'is_offer' }});
  	$togglerOffer.find('.fa').removeClass('fa-star fa-star-o').addClass(is_offer ? 'fa-star' : 'fa-star-o');
  	$togglerOffer.tooltip('destroy');
  	$togglerOffer.attr('title', is_offer ? 'Quitar oferta' : 'Marcar como oferta');
  	$togglerOffer.tooltip();
  };
	var updatedMany = function(e, response) {
	  for (var key in response) {
	  	updateToggle(e, response[key]);
	  	updateSpecialToggle(e, response[key]);
	  };
	  Alerts.success('Se cambiaron con exito las obras seleccionadas');
	};
	var filterable_submit = function(e) {
	  $(this).closest('form').submit();
	};
	$('[data-util=updateMany]').on('updated.util.updateMany', updatedMany);
	$('.work-active-toggler').on('updated.util.update', updateToggle);
	$('.work-new-toggler, .work-offer-toggler').on('updated.util.update', updateSpecialToggle);
	$('#filterable-works select').change(filterable_submit);
	Utils.checkboxes();
	Utils.updateMany();
	Utils.deleteManyForm();
	Utils.selectpicker();
};

Works.show = function() {
	$('#tabs-container>nav>li>a').click(function(e) {
	  e.preventDefault();
	  $(this).tab('show');
	});
	$('#work_active_toggler').on('updated.util.update', function(e, response) {
	  var $this = $(this);
	  var is_active = response.status == 'active';
	  $this.data('hash', { work: { status: is_active ? 'paused' : 'active' }});
	  $this.find('.fa').removeClass('fa-play fa-pause').addClass(is_active ? 'fa-pause' : 'fa-play');
	  $this.tooltip('destroy');
	  $this.attr('title', is_active ? 'Pausar' : 'Activar');
	  $this.tooltip();
	  $('#work_page_link')[(is_active ? 'remove' : 'add') + 'Class']('hidden');
	  $('#work_active_toggler_update')
	  .text(is_active ? 'Activa' : 'Pausada')
	  .removeClass('label-success label-danger label-info')
	  .addClass(is_active ? 'label-success' : 'label-danger');
	});
};

Works.form = function() {
	$('form#new_work').validate();
	$('form[id^="edit_work"]').validate();
	Utils.selectpicker();
	Utils.autonumeric();
	Utils.addOptionToSelect();
	$('#tinymce_tabs a').click(function(e) {
	  e.preventDefault()
	  $(this).tab('show')
	});
	//destroy data sheet file
	(function($container, $input, $trigger) {
		var trigger = function(e) {
			e.preventDefault();
			var $fileInput = $('#work_data_sheet_file');
			$input.val(true);
			$container.fadeOut();
			$fileInput.replaceWith($fileInput.val('').clone());
		};
		var fileSelected = function(e) {
			$input.val(false);
			$container.fadeIn();
		};
		$trigger.click(trigger);
		$(document).on('change', '#work_data_sheet_file', fileSelected);
	})($('.destroy-data-sheet-file-container'), $('#work_destroy_data_sheet_file'), $('.destroy-data-sheet-file-trigger'));
};