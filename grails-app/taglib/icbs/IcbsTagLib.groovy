package icbs

import java.text.Format
import java.text.SimpleDateFormat
class IcbsTagLib {
  static namespace = "g"
    
  def customDatePicker = {attrs, body -> 
    def date = attrs.get('value');
    if(date!=null && date!=""){
        Format formatter = new SimpleDateFormat("MM/dd/yyyy")
        String s = formatter.format(date);
        attrs['value'] = s
    }
    out << '<div class="input-group date">'
    out << g.textField(attrs)
    out << '<div class="input-group-addon"><span class="fa fa-calendar"></span></div>'
    out << '</div>'
  }
  def inlineSearch = {attrs,body->
    out<<"<!-- The Modal for inline search-->"
    out<<'    <div class="modal" width="300px"id="searchModal">'
    out<<'        <div class="modal-dialog">'
    out<<'            <div class="modal-content">'
    out<<'                 <div class="modal-header">'
    out<<'                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>'
    out<<'                    <h4 class="modal-title">Search</h4>'
    out<<'                </div>'
    out<<'                <div class="modal-body">'
    out<<'                    <div id="searchDiv">'
    out<<'                    </div>'
    out<<'                </div>'
    out<<'                <div class="modal-footer">'
    out<<'                    <a href="#" data-dismiss="modal" class="btn">Close</a>'
    out<<'                    <a href="#" class="btn btn-primary"onclick="">Save changes</a>'
    out<<'                </div>'
    out<<'            </div>'
    out<<'        </div>'
    out<<'    </div>'
        
        
    out<< '<script type="text/javascript">'
    out<<'function openSearch(){'
    out<<'        jQuery.ajax({type:\'POST\', '
    out<<'        url:\'/icbs/search/search\','
    out<<'      success:function(data,textStatus){'
    out<<'             jQuery(\'#searchDiv\').html(data);'
    out<<'            jQuery(\'#searchModal\').modal(\'show\');'
    out<<'        },'
    out<<'        error:function(XMLHttpRequest,textStatus,errorThrown){'
    out<<'            alert(errorThrown);'
    out<<'        }'
    out<<'       });return false;'
    out<<'    }'
    out<< '</script>'
        
  }
}
