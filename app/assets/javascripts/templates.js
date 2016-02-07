function bind_events_to_grid(selector) {
    
  $(selector+' .add-excercise').click(function() {
      var excercise = $('#block-prototypes .serie').clone(true);
      $(this).closest('.group-settings').before($(excercise));
  });
  
  $(selector+' .remove-excercise').click(function() {
      $(this).closest('.serie').remove();
  });
  
  $(selector+' .remove-slot').click(function() {
      $(this).closest('.slot').remove();
  });
  
  $(selector+' select.excercise').change(function() {
      if($(this).val() != 'default') {
          $(this).closest('.form-group').removeClass('has-error').find('.help-block').remove();
      };
  });

}

$(document).on('ready page:load', function(){

  $(document).bind('ajaxError', 'form#new_template, form[id^="edit_template_"]', function(event, jqxhr, settings, exception){

    // note: jqxhr.responseJSON undefined, parsing responseText instead
    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

  });

/**Template excercises management**/ 
  
  $('#template_grid #add-slot-btn').click(function() {
      var slot = $('#block-prototypes .slot').clone(true)
      $('#last-slot').before($(slot));
      $(slot).find('.group-settings').before($('#block-prototypes .serie').clone(true));
  });
  
  function removeExcercise() {
      $(this).closest('.serie').remove();
  }
  
  bind_events_to_grid('#template_grid');
 
  $('form.template-data').submit(function(event) {

      //remove previous errors
      $('#template_grid .slot .form-group.has-error').each(function() {
          $('.help-block').remove();
          $(this).removeClass('has-error');
      });
      
      
      var data = {
          slots: []
      };
      var slots = $('#template_grid .slot');
      
      //validation & collecting values
      
      var hasErrors = false;
      slots.each(function(index) {
            
          var series = $(this).find('.serie');
          if(series.length) {
              seriesData = [];
              //validate series
              series.each(function(index) {
                  var excercise = $(this).find('select.excercise');
                  var series = $(this).find('input.series');
                  var note = $(this).find('input.note');
                  if(excercise.val() != 'default') {
                      seriesData.push({
                          id: $(this).data('serieId'),
                          order: index,
                          excercise: excercise.val(),
                          series: series.val(),
                          note: note.val()
                        });
                  } else {
                      //handle error on select
                      hasErrors = true;
                      excercise.closest('.form-group').addClass('has-error');
                      excercise.after("<span class='help-block'>Choose excercise</span>");
                  }
              });
              data.slots.push({
                  id: $(this).data('slotId'),
                  note: $(this).find('input.slot-note').val(),
                  order: index,
                  series: seriesData
              });
          } else {
              //remove slot if empty
              $(this).remove();
          }
      });
      if(!hasErrors) {
        $('.template-data input#data_string').val(JSON.stringify(data));
      } else {
        event.preventDefault();
        return false;  
      }
      
  });
});
