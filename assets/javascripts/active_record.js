Lail.ActiveRecord = function(name) {
  // !todo: insert John Resig's code
  
  var self = this;
  var observer = new Observer,
      records = [];
  
  
  
  this.load = function(_records) {
    records = _records;
  };
  
  
  
  this.update = function() {
    Array.each(arguments, updateRecord);
    observer.fire('afterUpdate');
  };
  
  function updateRecord(newRecord) {
    for(var i=0; i<records.length; i++) {
      if(records[i].id == newRecord.id) {
        for(var newAttribute in newRecord) {
          records[i][newAttribute] = newRecord[newAttribute];
        }
        observer.fire('update', [newRecord]);
        return;
      }
    }
  }
  
  
  
  this.create = function() {
    Array.each(arguments, createAccount);
    observer.fire('afterCreate');
  };
  
  function createRecord(newRecord) {
    records.push(newRecord);
    observer.fire('create', [newRecord]);
  }
  
  
  
  this.destroy = function() {
    Array.each(arguments, destroyRecord);
    observer.fire('afterDestroy');
  };
  
  function destroyRecord(id) {
    records.remove(function(record) {
      if(record.id == id) {
        observer.fire('destroy', record);
        return true;
      }
      return false;
    });
  }
  
  
  
  this.all = function() {
    return records;
  }
  
  
  
  this.name = function() {
    return name;
  }
  
  
  
  this.observe = function(name, callback) {
    if(name == 'afterSave') {
      observer.observe('afterCreate', callback);
      observer.observe('afterUpdate', callback);
      observer.observe('afterDestroy', callback);
    } else {
      observer.observe(name, callback);
    }
  }
  
}