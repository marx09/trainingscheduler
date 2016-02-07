$(document).on('ready page:load', function(){

  $(document).bind('ajaxError', 'form#new_training, form[id^="edit_training_"], form.load-template-data, form#new_training_prototype', function(event, jqxhr, settings, exception){

    // note: jqxhr.responseJSON undefined, parsing responseText instead
    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );

  });
  
/**Training excercises management**/ 

  $('#load_template_modal').on('show.bs.modal', function (event) {
    
    var modal = $(this);
    
    $.get( "/templates/load/all" , function(data) {
        
        var options = "";
        
        $(data).each(function() {
            options += '<option value="'+this.id+'">'+this.name+'</option>';
        });
        var select = modal.find('.modal-body select#template');
        
        select.html(options);
        
      })
      .done(function() {
        // nothing yet - close modal and refresh page?
      })
      .fail(function() {
        // output errors
      })
      .always(function() {
        // nothing to do yet
      });
  });
  
  $('#training_grid #add-slot-btn').click(function() {
      var slot = $('#block-prototypes .slot').clone(true)
      $('#last-slot').before($(slot));
      $(slot).find('.group-settings').before($('#block-prototypes .serie').clone(true));
  });
  
  $('form.training-data').submit(function(event) {

      //remove previous errors
      $('#training_grid .slot .form-group.has-error').each(function() {
          $('.help-block').remove();
          $(this).removeClass('has-error');
      });
      
      
      var data = {
          slots: []
      };
      var slots = $('#training_grid .slot');
      
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
        $('.training-data input#data_string').val(JSON.stringify(data));
      } else {
        event.preventDefault();
        return false;  
      }
      
  });
  
  function removeExcercise() {
      $(this).closest('.serie').remove();
  }
    
  $('#training_grid .add-excercise').click(function() {
      var excercise = $('#block-prototypes .serie').clone(true);
      $(this).closest('.group-settings').before($(excercise));
  });
  
  $('#training_grid .remove-excercise').click(function() {
    console.log('Ahoj');
      $(this).closest('.serie').remove();
  });
  
  $('#training_grid .remove-slot').click(function() {
      $(this).closest('.slot').remove();
  });
  
  $('#training_grid select.excercise').change(function() {
      if($(this).val() != 'default') {
          $(this).closest('.form-group').removeClass('has-error').find('.help-block').remove();
      };
  });

/**Users management**/  
  
  $('#manage_users_modal').on('show.bs.modal', function (event) {
    
    var modal = $(this)
    var button = $(event.relatedTarget);
    var id = button.data('trainingId'); 
    
    $.get( "/trainings/"+id+"/users" , function(data) {
        
        var block = modal.find('.modal-body #users_grid');
        
        block.html(data);
        
        block.find('.current_users .user .add-btn').hide();
        block.find('.available_users .user .remove-btn').hide();
        
        block.find('.user .add-btn').click(function() {
          var item = $(this).closest('.user');
          item.find('.remove-btn').show();
          item.find('.add-btn').hide();
          block.find('.current_users>.content').prepend(item);
        });
        
        block.find('.user .remove-btn').click(function() {
          var item = $(this).closest('.user');
          item.find('.remove-btn').hide();
          item.find('.add-btn').show();
          block.find('.available_users>.content').prepend(item);
        });
        
      })
      .done(function() {
        // nothing yet - close modal and refresh page?
      })
      .fail(function() {
        // output errors
      })
      .always(function() {
        // nothing to do yet
      });
  });
  
  $('form.training-users-data').submit(function(event) {
      var data = {
          users: []
      };
      var users = $('#users_grid .current_users>.content .user');
      
      //collecting values
      users.each(function() {
        data.users.push({
            id: $(this).data('userId')
        });
      });
      $('.training-users-data input#data_string').val(JSON.stringify(data));
      //console.log($('.training-users-data input#data_string').val());
      //event.preventDefault();
      //return false;
      
  });
  
/**Results management**/

  $('#user_result_modal').on('show.bs.modal', function (event) {
    
    var modal = $(this)
    var button = $(event.relatedTarget);
    var title_name = button.data('userName');
    var title_excercise = button.data('excercise');
    
    modal.find('.modal-header .modal-title .excercise').text(title_excercise);
    modal.find('.modal-header .modal-title .user-name').text(title_name);
    
    modal.find('.training-users-result-data #user_id').val(button.data('user'));
    modal.find('.training-users-result-data #serie_id').val(button.data('serie'));
    modal.find('.training-users-result-data #result_id').val(button.data('id'));
    
    modal.find('.training-users-result-data #reps').val(button.data('reps'));
    modal.find('.training-users-result-data #time').val(button.data('time'));
    modal.find('.training-users-result-data #weight').val(button.data('weight'));
    
  });  
  
  $('#user_training_result_modal').on('show.bs.modal', function (event) {
    
    var modal = $(this)
    var button = $(event.relatedTarget);
    
    modal.find('.modal-header .modal-title .user-name').text(button.data('userName'));
    
    modal.find('.training-users-training-result-data #user_id').val(button.data('user'));
    modal.find('.training-users-training-result-data #training_id').val(button.data('training'));
    modal.find('.training-users-training-result-data #result_id').val(button.data('id'));
    
    modal.find('.training-users-training-result-data #calories').val(button.data('calories'));
    modal.find('.training-users-training-result-data #time').val(button.data('time'));
    modal.find('.training-users-training-result-data #rate').val(button.data('rate'));
    
  });  

});
