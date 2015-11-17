$(function() {
  $('#searchbox').keyup(function(e) {
    $.getJSON("questions", { q: this.value  }, function( data ) {
      var items = [];
      $.each(data, function(key, val) {
        items.push("<li id='" + key + "'>" + val + "</li>");
      });
      $("#analytics").empty();
      $("<ul>", {
        html: items.join("")
      }).appendTo("#analytics");
    });
  });
});

