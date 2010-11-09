
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
  for(var i=0, ii=length; i<ii; i++) {
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

