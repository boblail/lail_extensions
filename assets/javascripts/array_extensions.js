
Array.prototype.in_groups_of = function(n) {
  var length = this.length,
      group_size = Math.ceil(length / n),
      groups = [];
  for(var i=0; i<n; i++) {
    groups.push(this.slice((i*group_size), ((i+1)*group_size)) || []);
  }
  return groups;
}
