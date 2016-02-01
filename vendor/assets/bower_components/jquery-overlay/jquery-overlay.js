/* ========================================================================
 * jquery-overlay-v0.0.1 : Monday, 28.04.2014, 06:32:36
 * a Plugin for jQuery
 * Copyright 2014 Web-evolutions
 * ========================================================================
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 * 
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * ======================================================================== */

;(function($, window, document, undefined){

    var pluginName = 'overlay',
        dataPlugin = 'plugin_' + pluginName,
        defaults = {
            cls: 'overlay-layer',
            style: 'display:none;',
            build: true,
            content: 'STAGE',
            template: function(data){
                return '<div class="overlay-stage">' + data + '</div>';
            },
            timein: 500,
            timeout: 500,
            close: true,
            id: false,
    },

    session = 1,
    dataId = 'data-overlay-id',
    dataTarget = 'data-overlay-target',
    dataType = 'data-overlay-type',
    store = {},

    prepare = function(overlayId, selector, options){
        if(store[overlayId].build === true){
            var object = selector.find('[' + dataType + '="layer"][' + dataTarget + '="' + overlayId + '"]');
            if(!object.length){
                var tpl = options.template(store[overlayId].content);
                selector.append('<div ' + dataType + '="layer" ' + dataTarget + '="' + overlayId + '" class="'+ store[overlayId].cls +'" style="' + store[overlayId].style + '">' + tpl + '</div>');
                selector.trigger('overlay.prepare');
            }
        } 
    },

    setContent = function(overlayId, selector, set, options){
        var object = $('[' + dataType + '="layer"][' + dataTarget + '="' + overlayId + '"]');
        if(object.length){
            if(typeof set === 'function'){
                set(overlayId, object, selector);
            }else{
                var tpl = store[overlayId].template(store[overlayId].content);
                object.html(tpl);           
            }             
        }
        return object;
    },

    getId = function(data){
        var result = {};
        if(typeof data === 'object'){
            if(typeof data.overlayTarget !== 'undefined'){
                result[data.overlayTarget] = data.overlayTarget;
            }else if(typeof data.overlayId !== 'undefined'){
                result[data.overlayId] = data.overlayId;
            }else{
                result = data;
            }
        }else{
            result[data] = data;
        }
        return result;
    },

    getData = function(data, options){
        var id = '';
        if(typeof data['overlayId'] !== 'undefined' || typeof data['overlayTarget'] !== 'undefined'){
            if(typeof data['overlayId'] !== 'undefined'){
                id = data['overlayId']; 
            }else if(typeof data['overlayTarget'] !== 'undefined'){  
                id = data['overlayTarget'];
            }
            $.each(store[id], function(key, value){
                var name = 'overlay' + key.charAt(0).toUpperCase() + key.slice(1);
                if(typeof data[name] !== 'undefined'){
                    store[id][key] = data[name];    
                } 
            });              
        }
    },

    toggleState = function(data, type, selector, opts){
        getData(data, opts);
        $.each(getId(data), function(key, overlayId){
            if(overlayId in store){
                var object = $('[' + dataType + '="layer"][' + dataTarget + '="' + overlayId + '"]');
                if(opts.content !== store[overlayId].content){
                    setContent(overlayId, selector, store[overlayId].content, opts);                                        
                }                
                if(type === 'hide'){
                    object.fadeOut(store[overlayId].timeout);    
                }
                if(type === 'show'){
                    object.fadeIn(store[overlayId].timein);    
                }                
                selector.trigger('overlay.' + type);
            }
        });  
    },

    overlayTrigger = function(fn, data, type, onEvent){
        $('[' + data + '="' + type + '"]').on(onEvent, function(){
            var object = $(this);
            if(type !== 'layer'){
                object.overlay(fn, object.data()); 
            }else{
                closeOnClick = object.overlay('settings', object.data(), 'get', 'close');                
                if(closeOnClick === true){
                    object.overlay(fn, object.data());                    
                }      
            }              
        });
    }, 

    Plugin = function(element){
        this.options = $.extend({}, defaults);
        this.selector = $(element);
        this.element = element;
    };

    Plugin.prototype = {
        init: function(options){
            $.extend(this.options, options);
            var self = this,
                x = 0,
                overlayId = '',
                value = 'undefined';
            this.selector.trigger('overlay.init');      
            this.selector.each(function(event){
                if(self.options.id === false){
                    overlayId = session + '-' + x;
                }else{
                    overlayId = self.options.id;
                }
                value = self.selector.attr(dataId);
                if(typeof value === 'undefined'){
                    self.selector.attr(dataId, overlayId);   
                }else{
                    overlayId = value;   
                }                 
                if(!(overlayId in store)){
                    store[overlayId] = {
                        cls: self.options.cls,
                        style: self.options.style,
                        build: self.options.build,
                        content: self.options.content,
                        timein: self.options.timein,
                        timeout: self.options.timeout,
                        close: self.options.close,
                        template: self.options.template,                        
                    };
                    prepare(overlayId, self.selector, self.options);  
                }
                x++;
            });
            session++;
        },

        hide: function(data){
            toggleState(data, 'hide', this.selector, this.options);  
        },

        show: function(data){
            toggleState(data, 'show', this.selector, this.options); 
        },

        content: function(data, set){
            var self = this;
            $.each(getId(data), function(key, overlayId){
                if((overlayId in store)){
                    setContent(overlayId, self.selector, set, self.options);
                    self.selector.trigger('overlay.content');
                }
            });
        },

        settings: function(data, type, option, value){
            var self = this,
                result = '';
            $.each(getId(data), function(key, overlayId){
                if((overlayId in store)){
                    if(type === 'get' && typeof option !== 'undefined'){
                        result = store[overlayId][option];     
                    }
                    if(type === 'set' && typeof option !== 'undefined' && typeof value !== 'undefined'){
                        store[overlayId][option] = value;        
                    }
                    self.selector.trigger('overlay.' + type);
                }
            });
            return result;
        },

        destroy: function(){
            this.element.data(dataPlugin, null);
        },

    }

    $.fn[pluginName] = function(arg){
        var args, 
            instance;
        if (!( this.data(dataPlugin) instanceof Plugin)){
            this.data(dataPlugin, new Plugin(this));
        }
        instance = this.data(dataPlugin);
        if(instance !== null){
            instance.element = this;
            if (typeof arg === 'undefined' || typeof arg === 'object'){

                if(typeof instance['init'] === 'function'){
                    instance.init(arg);
                }
            }else if(typeof arg === 'string' && typeof instance[arg] === 'function'){
                args = Array.prototype.slice.call(arguments, 1);
                return instance[arg].apply(instance, args);
            }else{
                $.error('Method ' + arg + ' does not exist on jQuery.' + pluginName);
            }            
        }
    };

    // DATA-API 
    $('[' + dataId + ']').each(function(){
        var obj = $(this),
            id = obj.attr(dataId);
        if(!(id in store)){
            obj.overlay(obj.data());                
        }
    });  
    $(window).on('load', function(){
        overlayTrigger('show', dataType, 'show', 'click');
        overlayTrigger('hide', dataType, 'hide', 'click');
        overlayTrigger('hide', dataType, 'layer', 'click');
    });      

}(jQuery, window, document));