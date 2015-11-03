function update_sum() {
    var a = $("#add-a").val();
      var b = $("#add-b").val();
        $.ajax({                                  
              url: "/api/sum/" + a + "/" + b,
                  success: function(data) {               
                          $("#add-result").text(data.result);   
                              },
                                  error: function() {
                                          $("#add-result").text("(fail)");
                                              }
                                                });
}

["#add-a", "#add-b"].forEach(function(item) {
    $(item).on("keyup", function(event) {
          update_sum();
            });
});
