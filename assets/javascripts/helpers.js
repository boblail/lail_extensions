var Lail; if(!Lail) Lail={};

Lail.debug = function(message) {
  if(window.console) {
    window.console.log(message);
  }
}

Lail.number_to_currency = function(number) {
  var money = number.toFixed(2);
  if(money < 0) {
    return '($' + (-money).commafy() + ')';
  } else {
    return '$' + money.commafy();
  }
}

Lail.number_to_percentage = function(number) {
  var percent = (number * 100).toFixed(1);
  return percent + '%';
}

Lail.allow_only_numbers = function(options) {
  options = options || {};
  var exceptions = [46, 8]; // Allow backspace and delete
  if(options.allowDecimalPoint) {
    exceptions.push(110); // keyCode for '.'
    exceptions.push(190); // keyCode for '.' on the 10-key
  }
  function isException(event) {
    return exceptions.include(event.keyCode);
  }
  function isNumber(event) {
    var w = event.which;
    return (!event.shiftKey && ((w>=48 && w<=57) || (w>=96 && w<=105)));
  }
  return function(event) {
    if(!(isException(event) || isNumber(event))) {
      event.preventDefault();
    }
  }
}

// !nb: relies on prototype...
Lail.set_alternating_styles = function(selector) {
  var alt = false;
  $$(selector).each(function(item) {
    if(item.visible() && (item.style.visibility != 'hidden')) {
      alt ? item.addClassName('alt') : item.removeClassName('alt');
      alt = !alt;
    }
  })
};
