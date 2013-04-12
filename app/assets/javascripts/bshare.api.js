$(function() {
  var template = $('#response-template').html();

  $('.api-link').click(function() {
    (function ($this) {
      var request_url = $this.attr('href');
      $.get('/bshare_api/send_http_request', {'rquest_url': request_url}, function(response) {
        $this.next('.api-response').remove();
        $this.after(Mustache.to_html(template, {'request_url': request_url, 'response': response}));
      });
    })($(this));
    return false;
  });

  $('.active-api-btn').click(function() {
    $(this).parent().next("ul").find("a.api-link").trigger('click');
  });

});