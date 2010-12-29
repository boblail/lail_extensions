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
    this.__records = records || [];
  },
  
  
  
  all: function() {
    return this.__records;
  },
  
  first: function() {
    return this.__records[0];
  },
  
  find: function(id) {
    // be sure to use the method defined in Lail.ArrayExtensions
    return this.__records.__find(function(record) {return (record.id == id)});
  },
  
  collect: function(attribute) {
    // be sure to use the method defined in Lail.ArrayExtensions
    return this.__records.__collect(function(record) {return record[attribute];});
  },
  
  
  
  update: function(records) {
    if(!(records instanceof Array)) {records = [records];}
    for(var i=0, ii=records.length; i<ii; i++) {this.__updateRecord(records[i]);}
    this.__observer.fire('afterUpdate');
  },
  
  __updateRecord: function(newRecord) {
    if(newRecord) {
      var record = this.find(newRecord.id);
      if(record) {
        for(var newAttribute in newRecord) {
          record[newAttribute] = newRecord[newAttribute];
        }
        this.__observer.fire('update', [record]);
      } else if(newRecord.id) {
        this.__createRecord(newRecord);
      }
    }
  },
  
  
  
  create: function(records) {
    if(!(records instanceof Array)) {records = [records];}
    for(var i=0, ii=records.length; i<ii; i++) {this.__createRecord(records[i]);}
    this.__observer.fire('afterCreate');
  },
  
  __createRecord: function(newRecord) {
    if(newRecord) {
      this.__records.push(newRecord);
      this.__observer.fire('create', [newRecord]);
    }
  },
  
  
  
  destroy: function(ids) {
    if(!(ids instanceof Array)) {ids = [ids];}
    for(var i=0, ii=ids.length; i<ii; i++) {this.__destroyRecord(ids[i]);}
    this.__observer.fire('afterDestroy');
  },
  
  __destroyRecord: function(id) {
    if(id) {
      for(var i=0, ii=this.__records.length; i<ii; i++) {
        var record = this.__records[i];
        if(record.id == id) {
          this.__observer.fire('destroy', record);
          this.__records.splice(i, 1);
          return;
        }
      }
    }
  }
});
