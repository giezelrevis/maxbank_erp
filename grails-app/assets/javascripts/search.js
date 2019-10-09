/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* global icbs */

ns("icbs.Utilities");
icbs.Utilities.Search = function(url,searchDiv) {
    var self = this;
    var rootUrl = url;
    console.log('url?? '+url);
    var searchFormId ='#searchForm';
    var sDiv = searchDiv||'#inlineSearchDiv';
    console.log(sDiv);
    var searchCallback = function(data,params){
        $(sDiv).html(data);
    };
    

    
    this.searchMe = function(link){
        var retUrl;
        if(link!=null){
            retUrl = link;
            console.log("returl 1 "+retUrl);
           // alert(1);
        }else{
            retUrl = rootUrl;
           // alert(2);
           console.log("returl 2 "+retUrl);
        }
        icbs.Dependencies.Ajax.run({url:retUrl,params:$(sDiv).find(searchFormId).serialize(),callback:searchCallback});
    };
    
    var setupGridAjax = function() {
        $(sDiv).find(".pagination a, th.sortable a").on('click', function(event) {
            event.preventDefault();
            var tempUrl = $(this).attr('href');
            var url = rootUrl + tempUrl.substring(tempUrl.indexOf('?'));
            //search with other constraints desc asc sorting filtering etc
            self.searchMe(url);
        });
    };
    
    this.setupGridAjax = function() {
        $(sDiv).find(".pagination a, th.sortable a").on('click', function(event) {
            event.preventDefault();
            var tempUrl = $(this).attr('href');
            var url = rootUrl + tempUrl.substring(tempUrl.indexOf('?'));
            //search with other constraints desc asc sorting filtering etc
            self.searchMe(url);
        });
    };
    
    
    icbs.Dependencies.Ajax.addLoadEvent(function(){
        setupGridAjax();      
        $(sDiv).find(searchFormId).on('submit', function(e){
            e.preventDefault();
        });
        
        
    });
    setupGridAjax();   
};