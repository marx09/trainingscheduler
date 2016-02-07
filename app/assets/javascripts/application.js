// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree
//= require moment
//= require bootstrap-datetimepicker
//= require moment/cs
//= require chartkick

function flashes_redraw(content) {
  $('#flashes-holder>.wrapper').html(content);
};

(function($) {

  $.fn.modal_success = function(){
    // close modal
    this.modal('hide');

    // clear form input elements
    // todo/note: handle textarea, select, etc
    this.find('form input[type="text"]').val('');
    this.find('form textarea').text('');
    this.find('form select').val('');

    // clear error state
    this.clear_previous_errors();
  };

  $.fn.render_form_errors = function(errors){

    $form = this;
    this.clear_previous_errors();
    model = this.data('model');
    
    // show error messages in input form-group help-block
    $.each(errors, function(field, messages){
      $input = $('input[name="' + model + '[' + field + ']"], select[name="' + model + '[' + field + ']"], select[name="' + field + '"]');
      $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
    });

  };

  $.fn.clear_previous_errors = function(){
    $('.form-group.has-error', this).each(function(){
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    });
  }

}(jQuery));
