// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//


if (typeof jQuery !== 'undefined') {
  (function ($) {
    $('#spinner').ajaxStart(function () {
      $(this).fadeIn();
    }).ajaxStop(function () {
      $(this).fadeOut();
    });
  })(jQuery);
}

$(document).on("click", "#menu-btn", function (e) {
  if ($(this).hasClass("active")) {
    hideMenu();
  } else {
    showMenu();
  }
  e.preventDefault();
  return false;
});

$(document).on("keyup click", function (e) {
  if (e.keyCode == 27 || e.type == 'click') {
    hideMenu();
  }
});

$(document).on("click", "#menu", function (e) {
  e.stopPropagation();
});

function showMenu() {
  $("#menu-btn").addClass("active");
  $("#menu").slideDown('fast');
}

function hideMenu() {
  $("#menu-btn").removeClass("active");
  $("#menu").slideUp('fast');
}

function setupStickyActions() {
  var length = $('#main-actions').height() - $('#sidebar').height() + $('#main-actions').offset().top;
  $(window).scroll(function () {
    var scroll = $(this).scrollTop();
    var height = $('#sidebar').height() + 'px';

    if (scroll < $('#main-actions').offset().top) {
      $('#sidebar').css({
        'position': 'absolute',
        'top': '0'
      });
    } else if (scroll > length) {

      $('#sidebar').css({
        'position': 'absolute',
        'bottom': '0',
        'top': 'auto'
      });
    } else {
      $('#sidebar').css({
        'position': 'fixed',
        'top': '0',
        'height': height
      });
    }
  });
}

function setupTabContainer() {
  $(".nav-tab-container").each(function () {
    $(this).after("<div class=\"nav-tab-scrollers\"><span class=\"fa fa-chevron-left scroller scroll-left hidden\"></span><span class=\"fa fa-chevron-right scroller scroll-right hidden\"></span></div>");
    obj = $(this);
    setTimeout(function () {
      showInitialTabScrollers(obj);
      obj.find(".active").find("a").click();
    }, 500);
  });
}

function showInitialTabScrollers(tabcontainer) {
  tabwidth = 0;
  containerwidth = tabcontainer.innerWidth();
  tabcontainer.find("li").each(function (i, elem) {
    tabwidth += $(elem).outerWidth(true);
  });
  if (tabwidth > containerwidth) {
    tabcontainer.next(".nav-tab-scrollers").find(".scroll-right").removeClass("hidden");
  }
}

$(document).on("click", ".scroll-left", function () {
  tabs = $(this).parents(".nav-tab-scrollers").prev(".nav-tab-container");
  containerwidth = tabs.innerWidth();
  scrollposition = tabs.scrollLeft();
  tabwidth = 0;
  tabstop = 0;
  tabs.find("li").each(function (i, elem) {
    width = $(elem).outerWidth(true);
    tabwidth += width;
    if (scrollposition - containerwidth > tabstop) {
      tabstop += width;
    }
  });
  if (scrollposition > containerwidth) {
    tabs.animate({scrollLeft: tabstop}, 500);
    $(this).next(".scroll-right").removeClass("hidden");
  } else if (scrollposition > 0) {
    tabs.animate({scrollLeft: 0}, 500);
    $(this).next(".scroll-right").removeClass("hidden");
    $(this).addClass("hidden");
  }
});

$(document).on("click", ".scroll-right", function () {
  tabs = $(this).parents(".nav-tab-scrollers").prev(".nav-tab-container");
  containerwidth = tabs.innerWidth();
  scrollposition = tabs.scrollLeft();
  tabwidth = 0;
  tabstop = 0;
  tabs.find("li").each(function (i, elem) {
    width = $(elem).outerWidth(true);
    tabwidth += width;
    if (scrollposition + containerwidth > tabstop + width) {
      tabstop += width;
    }
  });
  if (tabwidth > tabstop) {
    tabs.animate({scrollLeft: tabstop}, 500);
    $(this).prev(".scroll-left").removeClass("hidden");
  }
  if (tabstop + containerwidth > tabwidth) {
    $(this).addClass("hidden");
  }
});

$(document).on("click", "[data-toggle='tab']", function () {
  tabcontainer = $(this).parents(".nav-tab-container");
  containeroffset = tabcontainer.offset().left;
  containeredge = containeroffset + tabcontainer.innerWidth();
  tabedge = $(this).offset().left + $(this).outerWidth(true);
  if (tabedge > containeredge) {
    tabstop = 0;
    li = $(this).parents("li").first();
    tabcontainer.find("li").each(function (i, elem) {
      width = $(elem).outerWidth(true);
      if ($(elem).is(li)) {
        return false;
      } else {
        tabstop += width;
      }
    });
    tabcontainer.next('.nav-tab-scrollers').find('.scroll-right').click();
  }
});

function getByName(name) {
  return $("[name='" + name + "']");
}

$.fn.getValue = function () {
  field_object = $(this).first();
  if (field_object.is(":radio") || field_object.is(":checkbox")) {
    field_object = getByName(field_object.attr("name")).filter(":checked");
  }
  return field_object.val() || '';
};

$.fn.hideField = function (initial) {
  if (initial) {
    $(this).hide();
  } else {
    $(this).slideUp('fast');
  }
};

$.fn.showField = function (initial) {
  if (initial) {
    $(this).show();
  } else {
    $(this).slideDown('fast');
  }
};

function processShowItems() {
  show_items = $("[data-show-when]");

  show_items.each(function () {
    observed_items = $(this).data("show-when").replace(/\s+/g, '').split(",");
    watched_value = [];
    watched_value_not = [];
    if ($(this).data("show-when-value") != undefined) {
      try {
        watched_value = eval(String($(this).data("show-when-value")));
      } catch (err) {
        console.log("Malformed show-when-value");
      }
    } else if ($(this).data("show-when-value-not") != undefined) {
      try {
        watched_value_not = eval(String($(this).data("show-when-value-not"))) || [];
      } catch (err) {
        console.log("Malformed show-when-value-not");
      }
    }
    target = $(this);
    container = target.parents(".form-group").first();

    $.each(observed_items, function (i, v) {
      observed = $("[name='" + v + "']");
      if (target.parents(".multi-field-item").length > 0) {
        observed = target.parents(".multi-field-item").first().find("[name='" + v + "']");
      }
      checkWatchedValues(observed, target, watched_value, watched_value_not, container);

      observeItems(observed, target, watched_value, watched_value_not, container);
    });
  });
}

function observeItems(observed, target, watched_value, watched_value_not, container) {
  observed.on('change', {observed: observed, target: target, watched_value: watched_value, watched_value_not: watched_value_not, container: container}, function (event) {
    checkWatchedValues(event.data.observed, event.data.target, event.data.watched_value, event.data.watched_value_not, event.data.container);
  });
}

function checkWatchedValues(observed, target, watched_value, watched_value_not, container) {
  if (watched_value && watched_value.length > 0) {
    if ($.inArray(String(observed.getValue()).replace(/\s+/g, ''), watched_value) > -1) {
      container.showField();
    } else {
      container.hideField();
    }
  } else if (watched_value_not && watched_value_not.length > 0) {
    if ($.inArray(String(observed.getValue()).replace(/\s+/g, ''), watched_value_not) > -1) {
      container.hideField();
    } else {
      container.showField();
    }
  }
}

$(document).off('click', '.multi-field-btn-add').on('click', '.multi-field-btn-add', function (e) {
  root = $(this).parents(".multi-field").first();
  template = root.find(".multi-field-template");
  maxlength = 3;
  currentlength = root.find('.multi-field-item:not(.multi-field-template):not(:hidden)').length + 1;
  try {
    maxlength = parseInt(template.data("multi-field-max"));
  } catch (err) {
  }
  new_item = template.clone().removeClass("multi-field-template").css("display", "none");
  timestamp = new Date().getTime();
  new_item.find("input, textarea, button").each(function () {
    $(this).attr("id", $(this).attr("id") + "_" + timestamp);
  });
  new_item.find("label").each(function () {
    $(this).attr("for", $(this).attr("for") + "_" + timestamp);
  });
  new_item.insertBefore(template).slideDown('fast', function () {
    if (currentlength >= maxlength) {
      root.find('.multi-field-btn-add').hide();
    }
  });
  root.find('.multi-field-btn-delete').show();
  processShowItems();

  // added for datepickers
  datepickerInitializer();

  e.preventDefault();
  return false;
});

$(document).off('click', '.multi-field-btn-delete').on('click', '.multi-field-btn-delete', function (e) {
  root = $(this).parents(".multi-field").first();
  template = root.find(".multi-field-template");
  maxlength = 3;
  try {
    maxlength = parseInt(template.data("multi-field-max"));
  } catch (err) {
  }
  $(this).parents(".multi-field-item").first().slideUp('fast', function () {
    if (String($(this).data("multi-field-existing")) == "true") {
      $(this).find("[data-field-type='delete']").val("true");
    } else {
      $(this).remove();
    }
    if (root.find('.multi-field-item:not(.multi-field-template):not(:hidden)').length < maxlength) {
      root.find('.multi-field-btn-add').show();
    }
    if (root.find('.multi-field-item:not(.multi-field-template):not(:hidden)').length < 1) {
      root.find('.multi-field-btn-add').click();
    }
  });
  processShowItems();
  e.preventDefault();
  return false;
});

function processMultiFieldItems() {
  $("[data-multi-field-preload='true']").each(function () {
    try {
      root = $(this).parents(".multi-field").first();
      root.find('.multi-field-btn-add').click();
    } catch (err) {
    }
  });
}

function setupValidators() {
  $(document).on("submit", "form", function () {

  });

  $(".required").each(function () {
    if ($(this).data('observed-required') != 'true') {
      $(this).data('observed-required', 'true').parents(".form-group").append("<div class=\"required-mark\"><span class=\"fa fa-star\"> REQUIRED</span></div>");
      field = getByName($(this).attr("name"));
      if (field.getValue() != '') {
        field.parents(".form-group").find('.required-mark').hide();
      }
      field.on('input change blur', function (event) {
        if ($(this).getValue() == '') {
          $(this).addClass("error").parents(".form-group").find('.required-mark').fadeIn('fast');
        } else {
          $(this).removeClass("error").parents(".form-group").find('.required-mark').fadeOut('fast');
        }
      });
    }
  });

  numericalValidators = [".integer", ".decimal", ".rate"];
  characterValidators = [".alpha", ".alphanumeric", ".email", ".phone", ".date"];
  signValidators = [".positive", ".negative"];
  formatValidators = numericalValidators.concat(characterValidators).concat(signValidators);
  validators = formatValidators.concat(["[data-length-max]"]);

  $(validators.join()).each(function () {
    $(this).on('input', function (event) {
      ensureMaxLengthAndFormat(event);
    });
  });

  function ensureMaxLengthAndFormat(event) {
    elem = $(event.target);
    pos = elem[0].selectionStart;
    value = elem.val();
    length = value.length;
    maxlength = parseInt(elem.data("length-max"));
    remaining = maxlength - length;
    eventType = event.type;
    data = "";
    if (eventType == "paste") {
      data = (event.originalEvent || event).clipboardData.getData('text/plain').substring(0, remaining);
    } else {
      data = event.which || event.charCode;
      console.log(data);
    }
    if (length >= maxlength) {
      if (eventType == "paste") {
        event.preventDefault();
        return false;
      } else if (!event.metaKey && !event.ctrlKey && !event.altKey && !event.shiftKey) {
        console.log("prevented");
        event.preventDefault();
        return false;
      }
    } else if (eventType == "paste") {
      new_value = value.substring(0, pos) + data + value.substring(pos, length);
      pos = pos + data.length;
      elem.val(new_value);
      elem[0].selectionStart = pos;
      elem[0].selectionEnd = pos;
      event.preventDefault();
      return false;
    } else {

    }
  }
}

function showSpinner() {
  $("#spinner").fadeIn('fast');
  $('html, body').css({
    'overflow': 'hidden',
    'height': '100%'
  });
}

function hideSpinner(){
  $("#spinner").fadeOut('fast');
  $('html, body').css({
    'overflow': 'auto',
    'height': 'auto'
  });
}
/*Hello Joe-e I just refactored this, thanks.-Kelvin*/
function datepickerInitializer(){
    $('.input-group.date').datepicker({
        format: "mm/dd/yyyy",
        todayBtn: "linked",
        multidate: false,
        autoclose: true,
        todayHighlight: true
  });
}
// Global handlers for AJAX events
$(document).on("ajaxSend", showSpinner).on("ajaxStop", function () {
  hideSpinner();
}).on("ajaxError", function (event, jqxhr, settings, exception) {
  hideSpinner();
});

$(document).ready(function () {
  setupTabContainer();
  if ($('#main-actions').length) {
    setupStickyActions();
  }
  $('#menu-filter').treeListFilter('#menu-content', 200);
  processShowItems();
  processMultiFieldItems();
  setupValidators();
  $("select").select2({allowClear: true});
  datepickerInitializer();
});
//prevent modals from exiting when clicking outside
//krYap function
$(function() {
    $.fn.modal.Constructor.DEFAULTS.backdrop = 'static';
});