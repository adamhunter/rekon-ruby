jQuery(function($){
  
  $.fn.resolvePending = function() {
    this.each(function(index, pending){
      var func = $(pending).attr('data-function-name');
      window[func].apply(pending);
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
  
});