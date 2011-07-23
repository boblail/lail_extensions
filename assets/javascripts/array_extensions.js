
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
if(!Array.prototype.each) Array.prototype.each = Array.prototype.__each;



Array.prototype.__collect = function(fn) {
  var array = [];
  for(var i=0, ii=this.length; i<ii; i++) {
    array.push(fn(this[i]));
  }
  return array;
}
if(!Array.prototype.collect) Array.prototype.collect = Array.prototype.__collect;
if(!Array.prototype.map) Array.prototype.map = Array.prototype.__collect;



Array.__each = function(array, fn) {
  for(var i=0, ii=array.length; i<ii; i++) {
    fn(array[i]);
  }
}
if(!Array.each) Array.each = Array.__each;



Array.prototype.__find = function(fn) {
  for(var i=0, ii=this.length; i<ii; i++) {
    var e = this[i];
    if(fn(e)) {
      return e;
    }
  }
  return null;
}
if(!Array.prototype.find) Array.prototype.find = Array.prototype.__find;
if(!Array.prototype.detect) Array.prototype.detect = Array.prototype.__find;



Array.prototype.__remove = function(removeMe) {
  if((typeof f) == 'function') {
    this.__remove(removeMe);
  } else {
    for(var i=0, ii=this.length; i<ii; i++) {
      if(this[i]==removeMe) {
        this.splice(i, 1);
        ii--;
        i--;
      }
    }
  }
}
if(!Array.prototype.remove) Array.prototype.remove = Array.prototype.__remove;



Array.prototype.__removeWith = function(fn) {
  for(var i=0, ii=this.length; i<ii; i++) {
    if(fn(this[i])) {
      this.splice(i, 1);
      ii--;
      i--;
    }
  }
}
if(!Array.prototype.removeWith) Array.prototype.removeWith = Array.prototype.__removeWith;
if(!Array.prototype.removeIf) Array.prototype.removeIf = Array.prototype.__removeWith;



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
