var MP = {};

MP.init = function(publicKey) {
	Mercadopago.setPublishableKey(publicKey);
	Mercadopago.getIdentificationTypes();
	MP.getPaymentMethod();
	MP.captureSubmit();
	$('#docType option').livequery(function(e){
		var $option = $(this);
		var $select = $option.parent();
		if ($option.val() == $select.data('selected')) $select.val($option.val());
	});
};

MP.captureSubmit = function() {
	var doSubmit = false;
	function doPay(event){
		event.preventDefault();
		if(!doSubmit){
			var $form = document.querySelector('#pay');
			Mercadopago.createToken($form, sdkResponseHandler);
			return false;
		}
	};
	function sdkResponseHandler(status, response) {
		if (status != 200 && status != 201) {
			$('label.mp-error').remove();
			response.cause.forEach(function(cause) {
				var error = MP.cardTokenErrors[cause.code];
				var $element = $(error.selector)
				if ($element.length) {
					if ($element.closest('.address-creator').css('display') == 'none') {
						$('.address-selector').fadeOut();
						$('.address-creator').fadeIn();
					};
					$element.after($('<label>', { class: 'mp-error', text: error.message })).focus();
				} else alert('Revisá los datos.');
			});
		}else if ($('form#pay').valid()) {
			var form = document.querySelector('#pay');
			var card = document.createElement('input');
			card.setAttribute('name',"payment[token]");
			card.setAttribute('type',"hidden");
			card.setAttribute('value',response.id);
			form.appendChild(card);
			doSubmit=true;
			Pages.loader("Procesando el págo...");
			form.submit();
		}
	};
	$('#pay').submit(doPay);
};

MP.getPaymentMethod = function() {
	function getBin() {
		var ccNumber = document.querySelector('input[data-checkout="cardNumber"]');
		if (!!ccNumber) return ccNumber.value.replace(/[ .-]/g, '').slice(0, 6);
		else return $('#cardId').find('option:selected').attr('first_six_digits');
	};

	function guessingPaymentMethod(event) {
		var bin = getBin();
		if (event.type == "keyup") {
			if (bin.length >= 6) {
				Mercadopago.getPaymentMethod({
					"bin": bin
				}, setPaymentMethodInfo);
			}
		} else {
			setTimeout(function() {
				if (!!bin && bin.length >= 6) {
					Mercadopago.getPaymentMethod({
						"bin": bin
					}, setPaymentMethodInfo);
				}
			}, 100);
		}
	};

	function setPaymentMethodInfo(status, response) {
		if (!response) return console.log(status);
		if (status == 200) {
			// do somethings ex: show logo of the payment method
			var form = document.querySelector('#pay');

			if (document.querySelector("input#paymentMethodId") == null) {
				var paymentMethod = document.createElement('input');
				paymentMethod.setAttribute('name', "payment[payment_method_id]");
				paymentMethod.setAttribute('id', "paymentMethodId");
				paymentMethod.setAttribute('type', "hidden");
				paymentMethod.setAttribute('value', response[0].id);

				form.appendChild(paymentMethod);
			} else {
				document.querySelector("input#paymentMethodId").value = response[0].id;
			}
		}
	};

	if ($('#cardId').length) {
		$('#cardId').on('change', guessingPaymentMethod);
		guessingPaymentMethod({});
	} else {
		$('input[data-checkout="cardNumber"]').on('keyup', guessingPaymentMethod);
		$('input[data-checkout="cardNumber"]').on('change', guessingPaymentMethod);
		$('input[data-checkout="cardNumber"]').on('focusout', guessingPaymentMethod);
	};
};



MP.cardTokenErrors = {
	'205': {
		selector: '[data-checkout="cardNumber"]',
		description: 'parameter cardNumber can not be null/empty',
		message: 'Ingresa el número de tu tarjeta.'
	},
	'208': {
		selector: '[data-checkout="cardExpirationMonth"]',
		description: 'parameter cardExpirationMonth can not be null/empty',
		message: 'Elige un mes.'
	},
	'209': {
		selector: '[data-checkout="cardExpirationYear"]',
		description: 'parameter cardExpirationYear can not be null/empty',
		message: 'Elige un año.'
	},
	'212': {
		selector: '[data-checkout="docType"]',
		description: 'parameter docType can not be null/empty',
		message: 'Ingresa tu documento.'
	},
	'213': {
		selector: '[data-checkout=""]',
		description: 'The parameter cardholder.document.subtype can not be null or empty',
		message: 'Ingresa tu documento.'
	},
	'214': {
		selector: '[data-checkout="docNumber"]',
		description: 'parameter docNumber can not be null/empty',
		message: 'Ingresa tu documento.'
	},
	'220': {
		selector: '[data-checkout="cardIssuerId"]',
		description: 'parameter cardIssuerId can not be null/empty',
		message: 'Ingresa tu banco emisor.'
	},
	'221': {
		selector: '[data-checkout="cardholderName"]',
		description: 'parameter cardholderName can not be null/empty',
		message: 'Ingresa el nombre y apellido.'
	},
	'224': {
		selector: '[data-checkout="securityCode"]',
		description: 'parameter securityCode can not be null/empty',
		message: 'Ingresa el código de seguridad.'
	},
	'E301': {
		selector: '[data-checkout="cardNumber"]',
		description: 'invalid parameter cardNumber',
		message: 'Hay algo mal en ese número. Vuelve a ingresarlo.'
	},
	'E302': {
		selector: '[data-checkout="securityCode"]',
		description: 'invalid parameter securityCode',
		message: 'Revisa el código de seguridad.'
	},
	'316': {
		selector: '[data-checkout="cardholderName"]',
		description: 'invalid parameter cardholderName',
		message: 'Ingresa un nombre válido.'
	},
	'322': {
		selector: '[data-checkout="docType"]',
		description: 'invalid parameter docType',
		message: 'Revisa tu documento.'
	},
	'323': {
		selector: '[data-checkout=""]',
		description: 'Invalid parameter cardholder.document.subtype',
		message: 'Revisa tu documento.'
	},
	'324': {
		selector: '[data-checkout="docNumber"]',
		description: 'invalid parameter docNumber',
		message: 'Revisa tu documento.'
	},
	'325': {
		selector: '[data-checkout="cardExpirationMonth"]',
		description: 'invalid parameter cardExpirationMonth',
		message: 'Revisa la fecha.'
	},
	'326': {
		selector: '[data-checkout="cardExpirationYear"]',
		description: 'invalid parameter cardExpirationYear',
		message: 'Revisa la fecha.'
	}
};