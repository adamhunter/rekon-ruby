jQuery(function($){
  
  $.fn.resolvePending = function() {
    this.each(function(index, pending){
      var func = $(pending).attr('data-function-name');
      window[func].call(pending);
    });
  };
  
  window.ping = function() {
    var node = $(this).attr('data-ping-node');
    var url  = '/nodes/' + node + '/ping';
    var elem = this;
    console.log(url);

    $.get('/nodes/' + node + '/ping', {}, function(data, status, xhr){
     if(status === 'success'){
       $(elem).attr('src', '/images/' + data + '.png').attr('alt', data);
     } else {
       $(elem).attr('src', '/images/delete.png');
     }
    });
  }
  
  $('.pending').resolvePending();

  $('#edit_key').live('keydown', function(e) { 
    var keyCode = e.keyCode || e.which; 

    if (keyCode == 9) { 
      var text, first, second, pos;
      e.preventDefault(); 
      text   = $(this).html();
      first  = text.slice(0, this.selectionStart);
      second = text.slice(this.selectionStart);
      pos    = first.length + 2;
      $(this).html(first + '  ' + second);
      $(this).focus();
      this.setSelectionRange(pos, pos);
    } 
  });
  
});