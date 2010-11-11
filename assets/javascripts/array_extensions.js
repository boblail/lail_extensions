
Array.prototype.__in_groups_of = function(n) {
  var length = this.length,
      group_size = Math.ceil(length / n),
      groups = [];
  for(var i=0; i<n; i++) {
    groups.push(this.slice((i*group_size), ((i+1)*group_size)) || []);
  }
  return groups;
}
if(!Array.prototype.in_groups_of) Array.prototype.in_groups_of = Array.prototype.__in_groups_of;



Array.prototype.__includes = function(item) {
  for(var i=0, ii=this.length; i<ii; i++) {
    if(this[i] == item) {
      return true;
    }
  }
  return false;
}
if(!Array.prototype.includes) Array.prototype.includes = Array.prototype.__includes;
if(!Array.prototype.include) Array.prototype.include = Array.prototype.__includes;
if(!Array.prototype.contains) Array.prototype.contains = Array.prototype.__includes;
if(!Array.prototype.contain) Array.prototype.contain = Array.prototype.__includes;



Array.prototype.__each = function(fn) {
  for(var i=0, ii=this.length; i<ii; i++) {
    fn(this[i]);
  }
}
if(!Array.prototype.find) Array.prototype.each = Array.prototype.__each;



Array.prototype.__find = function(fn) {
  for(var i=0, ii=this.length; i<ii; i++) {
    if(fn(this[i])) {
      return this[i];
    }
  }
  return null;
}
if(!Array.prototype.find) Array.prototype.find = Array.prototype.__find;
if(!Array.prototype.detect) Array.prototype.detect = Array.prototype.__find;



Array.prototype.__select = function(fn) {
  var selected = [];
  for(var i=0, ii=this.length; i<ii; i++) {
    if(fn(this[i])) {
      selected.push(this[i]);
    }
  }
  return selected;
}
if(!Array.prototype.select) Array.prototype.select = Array.prototype.__select;
if(!Array.prototype.findAll) Array.prototype.findAll = Array.prototype.__select;
