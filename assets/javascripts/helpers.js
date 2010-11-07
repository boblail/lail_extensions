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
