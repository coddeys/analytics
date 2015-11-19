$(function() {
  var textInput = document.getElementById('searchbox');
  var timeout = null;
  textInput.onkeyup = function (e) {
    clearTimeout(timeout);
    timeout = setTimeout(function () {
                $.getJSON("questions", { q: textInput.value  }, function( data ) {});
              }, 1000);
  };
});



