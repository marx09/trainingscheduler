$(document).on('ready page:load', function(){

  $(document).bind('ajaxError', 'form#new_group, form[id^="edit_group_"]', function(event, jqxhr, settings, exception){

    // note: jqxhr.responseJSON undefined, parsing responseText instead
    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

  });

});
