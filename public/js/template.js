$(document).ready(function() {
    var getUri = "http://"+window.location.host;
    console.log(getUri);
    $('select').material_select();

    $('#area_select_search').change(function(e){
        e.preventDefault();
        var id = $(this).val();
        $.get(getUri + "/ajaxNucleo", {'id' : id}).done(function( data ){
            var d = JSON.parse(data);
            console.log(d);
            $("#nucleo_select_search").html('');
            for(var i in d) {
                $("#nucleo_select_search").append("<option value='"+d[i].codigo+"'>"+d[i].name+"</option>");
            }
        });
    });

    $('.stepper').activateStepper();
});
