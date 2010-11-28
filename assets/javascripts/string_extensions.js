

String.prototype.commafy = function () {
  return this.replace(/(^|[^\w.])(\d{4,})/g, function($0, $1, $2) {
    return $1 + $2.replace(/\d(?=(?:\d\d\d)+(?!\d))/g, "$&,");
  });
}


// !nb: this isn't tested (and I haven't read the documentation!)
String.prototype.capitalize = function() {
  return this.replace(this[0], this[0].toUpperCase());
}
