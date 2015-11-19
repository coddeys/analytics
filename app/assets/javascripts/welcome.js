$(function() {
  $('#searchbox').keyup(function(e) {
    $.getJSON("questions", { q: this.value  }, function( data ) {
    });
  });
});

