/* 
 *Kelvin Roger Ang Yap
 */
/* ICBS JAVASCRIPT Dependencies*/
ns("icbs.Dependencies");
icbs.Dependencies.Ajax = {
    run:function(params){
        var url = params.url;
        var data = params.params;
        var callback = params.callback;
        var callbackParams = params.callbackParams;
        var errorCallback = params.errorCallback;
        var errorCallbackParams = params.errorCallbackParams;
        //only post is allowed
        var type = 'POST';
        var dataType = params.dataType||'html';
        jQuery.ajax({
            type:type, 
            data:data,
            url:url,
            dataType:dataType,
            success:function(data,textStatus,jqXHR){
                if(typeof callback == 'function') {
                    callback(data,callbackParams);
                }
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){
                if(typeof errorCallback == 'function') {
                    errorCallback(data,errorCallbackParams);
                }
            },
        });     
    },
    addLoadEvent:function(func) {
        var oldonload = window.onload;
        if (typeof window.onload != 'function') {
            window.onload = func;
        } else {
            window.onload = function() {
                if (oldonload) {
                    oldonload();
                }
                func();
            }
        }
    }
};
ns("icbs.UI");
icbs.UI.Modal =function(params){
    var self = this;
    var url = params.url;
    var isRemote =url?true:false;
    var title = params.title;
    var id = params.id;
    this. id = params.id;
    var modalClass=params.modalClass||"modal-wide fade";
    var content = params.url||params.content||'default-content';
    var onShowCallback = params.onShowCallback;
    var onShowCallbackParams = params.onShowCallbackParams||{};
    var onCloseCallback = params.onCloseCallback;
    this.onCloseCallbackParams = params.onCloseCallbackParams||{};
    var buttonClass = params.buttonClass;
    var params = params.params;
    var create = function(){
        //if(!document.getElementById(id)){
            var modal = '<div id="'+id+'" class="modal '+modalClass+'">';
            modal +=     '<div class="modal-dialog">';
            modal +=         '<div class="modal-content">';
            modal +=             '<div class="modal-header">';
            modal +=                 '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>';
            modal +=                     '<h4 class="modal-title">'+title+'</h4>';
            modal +=             '</div>';
            modal +=             '<div class="modal-body">';
            modal +=             '</div>';
            modal +=             '<div class="modal-footer">';
            modal +=                 '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>';
            modal +=             '</div>';
            modal +=         '</div><!-- /.modal-content -->';
            modal +=      '</div><!-- /.modal-dialog -->';
            modal +='</div><!-- /.modal -->';
            jQuery('#modal-append-div').append(modal);
        //}
    };
    var setRemoteContentCallback=function(data,params){
        console.log('srcc '+data);
        jQuery('#'+id+' .modal-body').html(data);
        //datepickerInitializer();
    };
    var setContent = function(){
        if(isRemote){
            icbs.Dependencies.Ajax.run({url:url,callback:setRemoteContentCallback,params:params,callbackParams:onShowCallback});
        }else{
            jQuery('#'+id+' .modal-body').html(content);
            console.log('sc '+content);
        }
    };
    /*Params to pass to Modal*/
    this.show = function(params){
        onShowCallbackParams = params;
        console.log('showmodal');
        console.log("modal id:"+id);
        jQuery('#'+id).modal('show');
    };  
    /*Params to exit Modal*/
    this.close = function(){
        //jQuery('#'+id).modal('close');
    };
    this.addOnCloseCallbackParams = function(key,val){
        self.onCloseCallbackParams[key] = val;
        
        console.log(self.onCloseCallbackParams);
        console.log("pasok sa onclose");
        console.log(val);
        console.log(JSON.stringify(self.onCloseCallbackParams));
    };
    //Create Modal!
    $(document).ready(function(){
        create();//create modal
        if(buttonClass){
           $('.'+buttonClass).click(function(){
               self.show();
           });
        }
        
        $('#'+id).on('hidden.bs.modal', function () {
                console.log("Pasok sa create modal");
                console.log("Catch ID +" +id);
                var element = document.getElementById(self.id);
                console.log("get elemet:"+element);
                element.parentNode.removeChild(element);
                $('#'+self.id).html('');
                console.log(self.id);
                if(typeof onCloseCallback === 'function'){
                    console.log("onCloseCallback is a function");
                    if(self.onCloseCallbackParams){
                        console.log(self.onCloseCallbackParams);
                        onCloseCallback(self.onCloseCallbackParams);
                        console.log("Show:"+onCloseCallback);
                        self.onCloseCallbackParams = {};
                        console.log(self.onCloseCallbackParams);
                    }
                    //unbind previous modal events when hidden
                    $('#'+id).unbind();
                }     
            });
        $('#'+id).on('shown.bs.modal', function () {
                setContent(); //only set content when going to show   
                if(typeof onShowCallback === 'function'){
                    onShowCallback(onShowCallbackParams);
                }   
            });
    }); 
    //Add Load event para di magclash sa ibang onload events ng javascript
    icbs.Dependencies.Ajax.addLoadEvent(function(){
           
    });   
};

