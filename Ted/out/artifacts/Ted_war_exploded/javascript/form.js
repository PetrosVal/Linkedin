function emailAvailability() {
    var Email = jQuery("#email").val();

    jQuery.ajax({
        url : "EmailAvailability",
        method: "GET",
        type : "JSON",
        data : "&email="+Email,// query parameters 1st
        success : function(response){
            $('#ajaxGetUserServletResponse').text(response);

        }
    });
}