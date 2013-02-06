
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



Array.prototype.__index_of = function(n) {
  for(var i=0, ii=this.length; i<ii; i++) {
    var e = this[i];
    if(e == n) { 
      return i;
    }
  }
  return -1;
}
if(!Array.prototype.indexOf) Array.prototype.indexOf = Array.prototype.__index_of;



Array.prototype.__group_by = function(fn) {
  var hash = {}, key, array;
  for(var i=0, ii=this.length; i<ii; i++) {
    key = fn(this[i]);
    array = hash[key] || [];
    array.push(this[i]);
    hash[key] = array;
  }
  return hash;
}
if(!Array.prototype.groupBy) Array.prototype.groupBy = Array.prototype.__group_by;



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



Array.prototype.__inject = function(memo, fn) {
  for(var i=0, ii=this.length; i<ii; i++) {
    memo = fn(memo, this[i]);
  }
  return memo;
}
if(!Array.prototype.inject) Array.prototype.inject = Array.prototype.__inject;
if(!Array.prototype.reduce) Array.prototype.reduce = Array.prototype.__inject;



Array.prototype.__eachWithObject = function(memo, fn) {
  for(var i=0, ii=this.length; i<ii; i++) {
    fn(memo, this[i]);
  }
  return memo;
}
if(!Array.prototype.eachWithObject) Array.prototype.eachWithObject = Array.prototype.__eachWithObject;



Array.prototype.__grep = function(regex) {
  return this.__select(function(e) {
    return e.toString().match(regex);
  });
}
if(!Array.prototype.grep) Array.prototype.grep = Array.prototype.__grep;



Array.prototype.__remove = function(removeMe) {
  for(var i=0, ii=this.length; i<ii; i++) {
    if(this[i]==removeMe) {
      this.splice(i, 1);
      ii--;
      i--;
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



Array.prototype.__count_of = function(fn) {
  var count = 0;
  for(var i=0, ii=this.length; i<ii; i++) {
    if(fn(this[i])) {
      count += 1;
    }
  }
  return count;
}
if(!Array.prototype.countOf) Array.prototype.countOf = Array.prototype.__count_of;



Array.prototype.__dup = function() {
  return this.slice(0);
}
if(!Array.prototype.dup) Array.prototype.dup = Array.prototype.__dup;



Array.prototype.__first = function() {
  return this[0];
}
if(!Array.prototype.first) Array.prototype.first = Array.prototype.__first;

Array.prototype.__last = function() {
  return this[this.length - 1];
}
if(!Array.prototype.last) Array.prototype.last = Array.prototype.__last;
