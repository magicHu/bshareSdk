$(function() {
  $("#attrBtn").click(function() {
    console.log("age attr: " + $("#age").attr("value"));
    console.log("age property: " + $("#age").prop("value"));
  });
});