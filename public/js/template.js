$.noConflict();

jQuery( document ).ready(function( $ ) {
    var getUri = "http://"+window.location.host;
    $('select').material_select();
    $('.collapsible').collapsible();

    $('#area_select_search').change(function(e){
        e.preventDefault();
        var id = $(this).val();
        $.get(getUri + "/ajaxNucleo", {'id' : id}).done(function( data ){
            var d = JSON.parse(data);
            console.log(d);
            $("#nucleo_select_search").html('');
            for(var i in d) {
                $("#nucleo_select_search").append("<option value='"+d[i].id+"'>"+d[i].name+"</option>");
            }
        });
    });

    $(".getNucleos").on("click", function(e){
        e.preventDefault();
        var this_ = $(this);
        $(".menu_home > li").removeClass('active');
        this_.parent().addClass('active');
        var id = this_.attr("data-id-nucleo");
        var ul = this_.next().next();
        ul.html('');
        $.get(getUri + "/ajaxNucleoTemplate", {'id' : id}).done(function( data ){
           /* var d = JSON.parse(data);
            console.log(d);
            for(var i in d) {
                ul.append("<li><a data-id-nucleo='"+d[i].id+"' href='/items/"+d[i].codigo_area+"/"+d[i].id+"'>"+d[i].name+" ("+d[i].length+")</a></li>");
            }*/
            ul.append(data);
            this_.parent().height(20+ul.height());
            $(".menu_home > li").each(function(e){
                console.log($(this).hasClass('active'));
                if($(this).hasClass('active')) {
                    ul.show();
                }else {
                    $(this).height($(this).height() - $(this).children('ul').height());
                    $(this).children('ul').hide();
                }
            });
        });
    });

   // $('.stepper').activateStepper();

    $(".archive").change(function () {

        if(window.File && window.FileReader && window.FileList && window.Blob){
            $('.tamano').val(parseInt(this.files[0].size/1024) + " kbytes");
            $("label[for=tamano]").addClass('active');
            ;
        }else{
            // IE
            var Fs = new ActiveXObject("Scripting.FileSystemObject");
            var ruta = document.upload.file.value;
            var archivo = Fs.getFile(ruta);
            var size = archivo.size;
            $('.tamano').val(parseInt(size/1024) + " kbytes");
            $("label[for=tamano]").addClass('active');
        }

    });
    jQuery.extend(jQuery.validator.messages, {
        required: "Este campo es obligatorio.",
        remote: "Por favor, rellena este campo.",
        email: "Por favor, escribe una dirección de correo válida",
        url: "Por favor, escribe una URL válida.",
        date: "Por favor, escribe una fecha válida.",
        dateISO: "Por favor, escribe una fecha (ISO) válida.",
        number: "Por favor, escribe un número entero válido.",
        digits: "Por favor, escribe sólo dígitos.",
        creditcard: "Por favor, escribe un número de tarjeta válido.",
        equalTo: "Por favor, escribe el mismo valor de nuevo.",
        accept: "Por favor, escribe un valor con una extensión aceptada.",
        maxlength: jQuery.validator.format("Por favor, no escribas más de {0} caracteres."),
        minlength: jQuery.validator.format("Por favor, no escribas menos de {0} caracteres."),
        rangelength: jQuery.validator.format("Por favor, escribe un valor entre {0} y {1} caracteres."),
        range: jQuery.validator.format("Por favor, escribe un valor entre {0} y {1}."),
        max: jQuery.validator.format("Por favor, escribe un valor menor o igual a {0}."),
        min: jQuery.validator.format("Por favor, escribe un valor mayor o igual a {0}.")
      });

});
