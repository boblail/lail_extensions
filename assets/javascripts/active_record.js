Lail.ActiveRecord = Klass.extend({
  
  
  
  init: function(_name) {
    this.name = _name;
    this.__records = [];
    this.__observer = new Observer();
  },
  
  
  
  observe: function(name, callback) {
    if(name == 'afterSave') {
      this.__observer.observe('afterCreate', callback);
      this.__observer.observe('afterUpdate', callback);
      this.__observer.observe('afterDestroy', callback);
    } else {
      this.__observer.observe(name, callback);
    }
  },
  
  
  
  load: function(records) {
    this.__records = records;
  },
  
  
  
  all: function() {
    return this.__records;
  },
  
  first: function() {
    return this.__records[0];
  },
  
  find: function(id) {
    return this.__records.find(function(record) {return (record.id == id)});
  },
  
  
  
  update: function() {
    Array.each(arguments, this.__updateRecord);
    observer.fire('afterUpdate');
  },
  
  __updateRecord: function(newRecord) {
    var record = this.find(newRecord.id);
    if(record) {
      for(var newAttribute in newRecord) {
        record[newAttribute] = newRecord[newAttribute];
      }
      this.__observer.fire('update', [record]);
    }
  },
  
  
  
  create: function() {
    Array.each(arguments, this.__createRecord);
    observer.fire('afterCreate');
  },
  
  __createRecord: function(newRecord) {
    this.__records.push(newRecord);
    observer.fire('create', [newRecord]);
  },
  
  
  
  destroy: function() {
    Array.each(arguments, this.__destroyRecord);
    observer.fire('afterDestroy');
  },
  
  __destroyRecord: function(id) {
    for(var i=0, ii=this.__records.length; i<ii; i++) {
      var record = this.__records[i];
      if(record.id == id) {
        observer.fire('destroy', record);
        this.__records.splice(i, 1);
        return;
      }
    }
    // __records.remove(function(record) {
    //   if(record.id == id) {
    //     observer.fire('destroy', record);
    //     return true;
    //   }
    //   return false;
    // });
  }
});
  
  
  // // !todo: insert John Resig's code
  // // !todo: refactor a la http://ejohn.org/blog/simple-javascript-inheritance/?
  // 
  // var self = this;
  // var observer = new Observer,
  //     records = [];
  // 
  // 
  // 
  // this.load = function(_records) {
  //   records = _records;
  // };
  // 
  // 
  // 
  // this.update = function() {
  //   Array.each(arguments, updateRecord);
  //   observer.fire('afterUpdate');
  // };
  // 
  // function updateRecord(newRecord) {
  //   for(var i=0; i<records.length; i++) {
  //     if(records[i].id == newRecord.id) {
  //       for(var newAttribute in newRecord) {
  //         records[i][newAttribute] = newRecord[newAttribute];
  //       }
  //       observer.fire('update', [newRecord]);
  //       return;
  //     }
  //   }
  // }
  // 
  // 
  // 
  // this.create = function() {
  //   Array.each(arguments, createAccount);
  //   observer.fire('afterCreate');
  // };
  // 
  // function createRecord(newRecord) {
  //   records.push(newRecord);
  //   observer.fire('create', [newRecord]);
  // }
  // 
  // 
  // 
  // this.destroy = function() {
  //   Array.each(arguments, destroyRecord);
  //   observer.fire('afterDestroy');
  // };
  // 
  // function destroyRecord(id) {
  //   records.remove(function(record) {
  //     if(record.id == id) {
  //       observer.fire('destroy', record);
  //       return true;
  //     }
  //     return false;
  //   });
  // }
  // 
  // 
  // 
  // this.all = function() {
  //   return records;
  // }
  // 
  // 
  // 
  // this.name = function() {
  //   return name;
  // }
  // 
  // 
  // 
  // this.observe = function(name, callback) {
  //   if(name == 'afterSave') {
  //     observer.observe('afterCreate', callback);
  //     observer.observe('afterUpdate', callback);
  //     observer.observe('afterDestroy', callback);
  //   } else {
  //     observer.observe(name, callback);
  //   }
  // }
  
// }