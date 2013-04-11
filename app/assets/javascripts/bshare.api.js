$(function() {
  var template = $('#response-template').html();

  $('.api-link').click(function() {
    $this = $(this);
    var request_url = $this.attr('href');
    $.get(request_url, function(response) {
      $this.after(Mustache.to_html(template, {'request_url': request_url, 'response': response}));
    });
    return false;
  });

});