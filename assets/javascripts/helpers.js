var Lail; if(!Lail) Lail={};



Lail.debug = function(message) {
  if(window.console) {
    window.console.log(message);
  }
}



Lail.number_to_currency = function(money) {
  if(money < 0) {
    return '($' + (-money).toFixed(2).commafy() + ')';
  } else {
    return '$' + money.toFixed(2).commafy();
  }
}



Lail.number_to_percentage = function(number) {
  var percent = (number * 100).toFixed(1);
  return percent + '%';
}



Lail.concatQueryString = function(url, query) {
  return url + ((url.indexOf('?')>=0) ? '&' : '?') + query;
}



Lail.allow_only_numbers = function(options) {
  options = options || {};
  var exceptions = [46, 8]; // Allow backspace and delete
  if(options.allowDecimalPoint) {
    exceptions.push(110); // keyCode for '.'
    exceptions.push(190); // keyCode for '.' on the 10-key
  }
  function isException(event) {
    return exceptions.include(event.which);
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



Lail.simulateClick = function(element) {
  if(document.createEvent) {
    var oEvent = document.createEvent('HTMLEvents');
    oEvent.initEvent('click', true, true);
    element.dispatchEvent(oEvent);
  }
  else if(document.createEventObject) {
    var oEvent = document.createEventObject();
    element.fireEvent('onclick', oEvent);
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



Lail.simulateHoverStyle = function(element) {
  element.observe('mouseover', function() {
    element.addClassName('hovered');
  });
  element.observe('mouseout', function() {
    element.removeClassName('hovered');
  });
}