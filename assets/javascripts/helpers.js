var Lail; if(!Lail) Lail={};



Lail.debug = function(message) {
  if(window.console) {
    window.console.log(message);
  }
};



Lail.number_to_currency = function(money) {
  if(money == null) { // null or undefined?
    return '';
  }
  money = +money; // convert strings and nulls to numbers
  if(!money.toFixed) { // not a number?
    return '';
  }
  if(money < 0) {
    return '($' + (-money).toFixed(2).commafy() + ')';
  } else {
    return '$' + money.toFixed(2).commafy();
  }
};



Lail.number_to_percentage = function(number) {
  var percent = (number * 100).toFixed(1);
  return percent + '%';
};



Lail.concatQueryString = function(url, query) {
  return url + ((url.indexOf('?')>=0) ? '&' : '?') + query;
};



Lail.allow_only_numbers = function(options) {
  options = options || {};
  var allowed = {};
  for(var i=0; i<8; i++) { allowed[i] = []; }
  
  // Alt only              modifiers=1 (001)
  // Ctrl only             modifiers=2 (010)
  // Ctrl+Alt              modifiers=3 (011)
  // Shift only            modifiers=4 (100)
  // Shift+Alt             modifiers=5 (101)
  // Shift+Ctrl            modifiers=6 (110)
  // Shift+Alt+Ctrl        modifiers=7 (111)
  // None of these keys    modifiers=0 (000)
  
  function allow() {
    var args = Array.prototype.slice.call(arguments),
        code = args.shift(),
        modifiers = (args.length == 0 ? [0,1,2,3,4,5,6,7] : args);
    modifiers.__each(function(modifier) {
      allowed[modifier].push(code);
    });
  }
  
  allow(8);   // Allow backspace
  allow(46);  // Allow delete
  allow(37); allow(38); allow(39); allow(40); // Allow arrow keys
  allow(9);   // Allow tab
  allow(13);  // Allow enter
  for(var i=48; i<=57; i++) { allow(i, [0]); }  // Allow numbers
  for(var i=96; i<=105; i++) { allow(i, [0]); } // Allow numbers on the 10-key
  
  if(options.allowDecimalPoint) {
    allow(110, [0]);
    allow(190, [0]); // On the 10-key
  }
  if(options.allowDashes) {
    allow(189, [0]);
  }
  if(options.allowSpaces) {
    allow(32);
  }
  if(options.allowParentheses) {
    allow(57, [4]); // '(' is Shift+9
    allow(48, [4]); // ')' is Shift+0
  }
  
  return Lail.__restrictInputToKeys(allowed);
};



Lail.__restrictInputToKeys = function(allowed) {
  function eventHandler(e) {
    var modifiers = Lail.__getModifiers(e);
    !isAllowed(e.which, modifiers) && e.preventDefault();
  }
  function isAllowed(code, modifiers) {
    return allowed[modifiers].includes(code);
  }
  return eventHandler;
};



Lail.__getModifiers = function(keysPressed) {
  var modifiers = 0;
  keysPressed.altKey && (modifiers += 1);
  keysPressed.ctrlKey && (modifiers += 2);
  keysPressed.shiftKey && (modifiers += 4);
  return modifiers;
};



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
};



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



Lail.getDataSpread = function(values, min, max) {
  values.__each(function(value) {
    value = +value;
    (!App.exists(min) || min > value) && (min = value);
    (!App.exists(max) || max < value) && (max = value);
  });
  return [min, max];
};



Lail.scaleSpread = function(minMax, scaleBy) {
  var spread = minMax[1] - minMax[0],
      scaled = spread * scaleBy,
      halfDiff = (scaled - spread) / 2;
  return [(minMax[0] - halfDiff), (minMax[1] + halfDiff)];
};



Lail.getCoordinateTransformer = function(axisMinMax, paperMinMax) {
  var axisMin = axisMinMax[0],
      axisSpread = axisMinMax[1] - axisMin,
      paperMin = paperMinMax[0],
      paperSpread = paperMinMax[1] - paperMin,
      m = paperSpread / (axisSpread == 0 ? 1 : axisSpread),
      b = paperMin - (axisMin * m);
  return function(x) { return (m * x) + b; }
};



Lail.exists = function(n) {
  return (typeof n != "undefined" && n !== null);
};



Lail.simulateHoverStyle = function(element) {
  element.observe('mouseover', function() {
    element.addClassName('hovered');
  });
  element.observe('mouseout', function() {
    element.removeClassName('hovered');
  });
};
