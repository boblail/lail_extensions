/*

      ModalPopup

*/

var ModalPopup = (function() {
  var open_net = null;
  var open_popup = null;
  var on_accept = null;
  var on_cancel = null;
  var remove_popup_on_close = false;
  var close_popup_on_esc = true;
  var disabled = false;
  var body;
  var observer = new Observer();
  
  document.observe('dom:loaded',function() {
    body = $(document.body);
    body.observe('keyup', function(event) {
      if(close_popup_on_esc && !disabled && (event.keyCode == Event.KEY_ESC)) {
        ModalPopup.cancel();
        Event.stop(event);
      }
    });
  });
  // 
  // var _on_keyup = function(event) {
  //   if(event.keyCode == Event.KEY_ESC) {
  //     ModalPopup.cancel();
  //     Event.stop(event);
  //   }
  // };
  
  var _on_resize = function(div) {
    var de = document.documentElement;
    var w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
    var h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;

    var width = div.getWidth();
    var margin_left = ((w - width) / 2) + 'px';
    var height = div.getHeight();
    var margin_top = ((h - height) / 2) + 'px';
    
    //debugger;
    //alert(w+', '+h);
    //alert(width+','+height);
    //alert(margin_left+','+margin_top);
    div.setStyle({marginLeft:margin_left, marginTop:margin_top});
  };
  
  var _create_frame = function() {
    var popup_frame = $(document.createElement('div'));
    popup_frame.className = 'modal-frame';
    popup_frame.id = 'modal_frame';
    
    //var top = $(document.createElement('div')).addClassName('t');
    //var bot = $(document.createElement('div')).addClassName('b');
    popup_frame.appendChild($(document.createElement('div')).addClassName('tl'));
    popup_frame.appendChild($(document.createElement('div')).addClassName('tf'));
    popup_frame.appendChild($(document.createElement('div')).addClassName('tr'));
    popup_frame.appendChild($(document.createElement('div')).addClassName('rf'));
    popup_frame.appendChild($(document.createElement('div')).addClassName('br'));
    popup_frame.appendChild($(document.createElement('div')).addClassName('bf'));
    popup_frame.appendChild($(document.createElement('div')).addClassName('bl'));
    popup_frame.appendChild($(document.createElement('div')).addClassName('lf'));
    
    //popup_frame.appendChild(top);
    //popup_frame.appendChild(bot);
    
    return popup_frame;
  };
  
  var _create_body = function(popup_frame) {
    var popup_body = $(document.createElement('div'));
    popup_body.className = 'modal-body';
    popup_body.id = 'modal_body';
    popup_frame.appendChild(popup_body);
    return popup_body;
  };
  
  var _prepare_contents = function(div) {
    // todo: might want to add loaded trigger here too

    // resize
    div.stopObserving('resize',_on_resize);
    div.observe('resize',_on_resize);
    _on_resize(div);
  };
  
  var _get_or_create_popup = function() {
    if(!open_popup) {
      var popup_frame = _create_frame();
      var popup_body = _create_body(popup_frame);
      _show_popup(popup_frame, {});
    }
    return open_popup;
  };
  
  var _show_loading = function() {
    if(!open_net) {
      // create the disabling net
      open_net = $(document.createElement('div'));
      open_net.id = 'modal_net';

      // write the net to document
      if(!body) body = ($$('body')||[null])[0];
      body.appendChild(open_net);
    }
  };
  
  var _hide_loading = function() {
    if(open_net) {
      open_net.remove();
      open_net = null;
    }
  };

  var _show_popup = function(div, options) {
  
    // close any existing popup
    ModalPopup.cancel();

    // store callbacks
    on_accept = options.onAccept;
    on_cancel = options.onCancel;
    close_popup_on_esc = options.closeOnEscape;
    disabled = false;

    // create the disabling net
    open_net = $(document.createElement('div'));
    open_net.id = 'modal_net';

    // write the net to document
    if(!body) body = ($$('body')||[null])[0];
    body.appendChild(open_net);
    
    // show the popup
    if(div) {
      open_popup = div;
      
      // In IE7, nodes which have not been added to the document do not have
      // null parentNodes, but parentNodes of the type DOCUMENT_FRAGMENT_NODE (11)
      remove_popup_on_close = !open_popup.parentNode || (open_popup.parentNode != 1)
      if(remove_popup_on_close) {
        body.appendChild(open_popup);
        observer.fire('loaded');
      }
      else
        open_popup.show();
        
      //
      observer.fire('show');
      
      _prepare_contents(div);
    }

    // // just once, please
    // body.stopObserving('keyup',_on_keyup);
    // if(options.closeOnEscape != false)
    //   body.observe('keyup',_on_keyup);
  };
  
  function extender() {
    document.body.observe('click', function(event) {
      var a = event.findElement('a');
      if(a) {
        if(a.hasClassName('popup')) {
          Event.stop(event);
          ModalPopup.show({url:a.href});
        } else if(a.hasClassName('replace')) {
          Event.stop(event);
          ModalPopup.replace({url:a.href});
        }
      }
    });
  }  

  return {
    observe: function(name, func) { observer.observe(name, func); },
    unobserve: function(name, func) { observer.unobserve(name, func); },
    show: function(options) {
      options = options || {};
      var params = options.parameters || {};
      var method = options.method || 'get';
      params.for_popup = true;
      // alert(options);

      /*
      // process arguments
      var message=null, options={};
      if(arguments.length==1) {
        message = arguments.length[0];
        if(typeof(message)=="object") {
          options=message, message=null;
        } else if(typeof(message)!="string") {
          message=null;
        }
      } else if(arguments.length>1) {
        message=arguments[0], options=(arguments[1]||{});
      }
      */
      
      // TODO: include loading feature...
      // TODO: do it with events like rails.js (Rails3)?
      if(options.url) { // show url
        //alert('...');
        new Ajax.Request(options.url, {
          evalScripts:true,
          evalJS:true,
          method:method,
          parameters:params,
          /*
          onLoading:function() {
            _show_loading();
          },
          */
          onComplete:function(response) {
            //debugger;
            //_hide_loading();
            //alert(response.status);
            /*
            var s = '';
            var headers = response.getAllHeaders();
            for(var i=0; i<headers.length; i++) {
              s  = s + headers[i].toString() + '\n';
            }
            */
            //alert(response.getHeader('Content-Type'));
            if(response.getHeader('Content-Type').include('text/html')) {
              ModalPopup.replace_with(response.responseText);
            } else {
              //alert(response.getHeader('Content-Type'));
              //alert(response.responseText);
              //response.request.evalResponse();
              //eval(response.responseText);
            }
            // <SCRIPT> blocks are evaluated _after_ this event is called.
          },
          onFailure:function(response) {
            alert('exception');
          },
          method:'get'});
      }
      else if(options.id) { // show element by id
        _show_popup($(options.id), options);
      }
      else if(options.message) { // show message
        var popup_frame = _create_frame();
        var popup_body = _create_body(popup_frame);
        popup_body.insert(options.message);
        _show_popup(popup_body, options);
      }
      else { // show disabled screen
        _show_popup(null, options);
      }
    },
    replace_with: function(content) {
      App.debug('1');
      var popup = _get_or_create_popup();
      App.debug('2');
      var popup_body = popup.down('.modal-body');
      App.debug('3');
      if(popup_body) {
        App.debug('4');
        // Prototype: if (!options.evalScripts) responseText = responseText.stripScripts();
        popup_body.update(content);
        _prepare_contents(popup);
        popup.show();
        observer.fire('loaded');
      }
    },
    replace: function(options) {
      if(open_popup) {
        options = options || {};
        if(options.url) { // show url
          new Ajax.Request(options.url, {
            evalScripts:true,
            evalJS:true,
            parameters:{for_popup:true},
            onComplete:function(response, json) {
              ModalPopup.replace_with(response.responseText);
            },
            method:'get'});
        }
        else if(options.message) { // show message
          ModalPopup.replace_with(options.message);
          // popup_body.replace(options.message);
        }
      }
    },
    accept: function() {
      if(open_popup && on_accept)
        on_accept(open_popup);
      else
        ModalPopup.close();
    },
    cancel: function() {
      if(open_popup && on_cancel)
        on_cancel(open_popup);
      else
        ModalPopup.close();
    },
    close: function() {
      if(open_popup) {
        if(remove_popup_on_close)
          open_popup.remove();
        else
          open_popup.hide();
        open_popup = null;
      }
      if(open_net) {
        open_net.remove();
        open_net = null;
      }
      if(body)
        body.stopObserving('keyup',_on_keyup);
    },
    disable: function() {
      disabled = true;
      if(open_popup) {
        open_popup.select('form').each(Form.disable);
        observer.fire('disabled');
      }
    },
    enable: function() {
      disabled = false;
      if(open_popup) {
        open_popup.select('form').each(Form.enable);
        observer.fire('enabled');
      }
    },
    
    // For compatibility
    show_blank: function() {
      show();
    },
    show_message: function(message, close_on_esc) {
      show(message, {closeOnEscape:close_on_esc});
    },
    show_url: function(url, accept_callback, cancel_callback) {
      show({url:url, onAccept:accept_callback, onCancel:cancel_callback});
    },

    extend_links: function() {
      if(document.body) {
        extender();
      } else {
        document.observe('dom:loaded', extender);
      }
    }
      
  };
})();