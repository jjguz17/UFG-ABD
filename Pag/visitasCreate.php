<link href="../sweetalert/sweetalert2.css" rel="stylesheet" />

 
<div class="box-header">
   <a class="btn btn-danger btn-sm btn-lg" onclick="RegresarVisitasIndex()">
   <i class="fa fa-plus-square"></i> &nbsp; Regresar
   </a>
   <a class="btn btn-primary btn-sm btn-lg" onclick="InsertarVisita()">
   <i class="fa fa-plus-square"></i> &nbsp; Guardar
   </a>

</div>
<?php
   require ("../conf/db.conf.php");
   require ("../servicio/conexion.class.php");
   require ("../modelo/combos.class.php");
   require ("../modelo/entradas.class.php");
   
   $obj_entradas =  new entradas();
   $obj_entradas->conectar();
   
   ?>
<div class="box-body">
      <div class="row">
          <div class="col-md-6">
             <!-- 

             <div class="row">
                <div class="col-md-12">
                   <div class="form-group">
                      <select class="form-control select2" id="cbCombo" style="width: 100%;">
                         <option value="-1">Seleccione tipo de entrada</option>
                         >
                         <?php
                            echo $obj_entradas->ddl_entradas();
                            ?>
                      </select>
                   </div>
                </div>
             </div>
             -->

             <div class="row">
                <div class="col-md-12">
                   <div class="form-group">
                      <label>Nombre de visita</label>
                      <input class="form-control" id="txtNombreVisita" maxlength="350" type="text" placeholder="Nombre de visita">
                   </div>
                </div>
             </div>
             <div class="row">
                <div class="col-md-12">
                   <div class="form-group">
                      <label>Compañía</label>
                      <input class="form-control" id="txtCompaniaVisita" maxlength="350" type="text" placeholder="¿De dónde nos visita?">
                   </div>
                </div>
             </div>
             <div class="row">
                <div class="col-md-12">
                   <div class="form-group">
                      <label>Motivo de visita</label>
                      <textarea class="form-control rounded-0" id="txtMotivo" rows="3"></textarea>
                   </div>
                </div>
             </div>

            <div class="row">
                <div class="col-md-12">
                   <div class="form-group">
                      <label>Empleado a visitar</label>
                      <br><br>
                      <select name="SearchEmpleadoInput" class="js-example-basic-single" id="SearchEmpleadoInput" >
                        <option selected="" disabled="">Seleciona el empleado</option>
                        <?php
                        $empleadosArray = $obj_entradas->getEmployees(); //Se toma de entradas.class.php
                        foreach($empleadosArray as $row) {
                        echo '<option value="'.$row["id_empleado"].'">'.$row["nombres_empleado"].'</option>';
                        }
                        ?>

                      </select>

                      


                   </div>
                </div>
             </div>

             <div class="row">
                <div class="col-md-12">
                   <div class="form-group">
                      <label>Documento de identidad</label>
                      <input class="form-control" id="txtdocid" maxlength="350" type="text" placeholder="DUI, licencia o pasaporte">
                   </div>
                </div>
             </div>

             <div class="row">
                <div class="col-md-12">
                   <div class="form-group">
                      <label>¿Necesitará escolta?</label><br>
                      <label>Sí:</label>

                      <input type="checkbox" id="chkEscolta" onchange="ShowSearchEscolta()">
                      <br>
                      
                      <select name="SearchEscoltaInput" class="form-control input-md js-example-basic-single" id="SearchEscoltaInput">
                        

                        <option selected="" disabled="">Seleciona el escolta</option>
                        <?php
                        $empleadosArray = $obj_entradas->getEmployees(); //Se toma de entradas.class.php
                        foreach($empleadosArray as $row) {
                        echo '<option value="'.$row["id_empleado"].'">'.$row["nombres_empleado"].'</option>';
                        }
                        ?>

                      </select>


                   </div>
                </div>
             </div>

          </div>  
      <div class="col-md-6">               
        <div class="col-md-12">
           <div class="form-group">
              <img src="..." class="img-fluid" id="imgen" style="width:500px; height:350px" alt="/Sistema/imagenes/">
           </div>
        </div>   
      </div> 
  </div>   
</div>
<script src="../sweetalert/sweetalert2.js"></script>

  
<script>
    
$(document).ready(function(){
    $("#imgen").hide();
    
    //debugger;
    $("#SearchEmpleadoInput").select2();
    $("#SearchEscoltaInput").select2();
    $("#SearchEscoltaInput").next(".select2-container").hide(); //Se oculta por defecto 
    //$(".js-example-basic-single").select2(); 
});


//Si se cambia el checkbox de escolta se muestra o se esconde el SELECT para empleados
$("#chkEscolta").change(function(){
  if (this.checked) {
        $("#SearchEscoltaInput").next(".select2-container").show();
  }else{
    $("#SearchEscoltaInput").next(".select2-container").hide();
  }  
});


$("#cbCombo").change(function(){

   var phdId = $("#cbCombo").val();
   $("#txtNombre").val('');
   $("#txtdescripcion").val('');
   $("#txtprecio").val('');
      

        //debugger;
        $.ajax({
        type: "POST",
        cache: false,
        url: '../controlador/combos.ctrl.php',

        data:{
        phdId:phdId,

        },
        success: function (data) {
            console.log(data);
        if (data ) {
          
        var res = data.split("*");
        $("#txtNombre").val(res[1]);
        $("#txtdescripcion").val(res[2]);
        $("#txtprecio").val(res[3]);
            let urls =  "/Sistema/imagenes/" + res[4];
            console.log(location.hostname + "/Sistema/imagenes/" + res[4]);
        $("#imgen").attr("src", urls);
        $("#imgen").show();         
        } else {

        }
        },
        error: function (jqXHR, textStatus, errorThrown) {

        },
        });



});
    

    
    
   function InsertarVisita(){
   
   //debugger;
    var ptipo_operacion= 1;
    var txtNombreVisita = $('#txtNombreVisita').val();
    var txtCompaniaVisita = $('#txtCompaniaVisita').val();
    var txtMotivo = $('#txtMotivo').val();
    var SearchEmpleadoInput = $('#SearchEmpleadoInput').val();
    var txtdocid = $('#txtdocid').val();
    var SearchEscoltaInput = $('#SearchEscoltaInput').val();
   
               /*Realizando validacion de datos*/
               if (ValidarDatos() == true)
               {
                  
                   //debugger;
                   swal({
                       title: "Proceso de Creacion",
                       text: "¿Desea crear el registro?",
                       type: 'warning',
                       showCancelButton: true,
                       confirmButtonColor: '#3085d6',
                       cancelButtonColor: '#d33',
                       confirmButtonText: 'Aceptar',
                       cancelButtonText: 'Cancelar',
                       confirmButtonClass: 'btn btn-primary',
                       cancelButtonClass: 'btn btn-danger',
                       buttonsStyling: false
   
                   }).then(function () {
                       $.ajax({
                           type: "POST",
                           cache: false,
                           url: '../controlador/comandas.ctrl.php',
                        
                           data:{
                           tipo_operacion:ptipo_operacion,
                           txtNombreVisita:txtNombreVisita,
                           txtCompaniaVisita:txtCompaniaVisita,
                           txtMotivo:txtMotivo, 
                           SearchEmpleadoInput:SearchEmpleadoInput,
                           txtdocid:txtdocid,
                           SearchEscoltaInput:SearchEscoltaInput
                       },
                           success: function (data) {
                              console.log(data);
                               if (data ) {
                                   swal({
                                       title: "Exito",
                                       text: data.responseText,
                                       type: "success"
                                   }).then(function () {
                                      $('#mitablaDatos').load('visitasIndexTable.php');
                                   });
                               } else {
                                   Sweetalert2("Fail", data.responseText, "error");
                               }
                           },
                           error: function (jqXHR, textStatus, errorThrown) {
                               Sweetalert2("Comunicarse con IT", "se genero el siguiente error: " + errorThrown, "error");
                           },
                       });
                   }, function (dismiss) {
                       if (dismiss === 'cancel') {
   
                       }
                   })
               }
   }
   
   function ValidarDatos() {
               debugger;
       return true;
               /*if (=) {
                 Sweetalert2("Por favor digite area");
                   return false;
               } else {
                   return true;
               }*/
           }
  

  function ShowSearchEscolta(){

    var checkEscolta = document.getElementById("chkEscolta");
    var SearchEscoltaInput = document.getElementById("SearchEscoltaInput");

    if(chkEscolta.checked == true){
      //SarchEscoltaInput.setAttribute("type","text");
      SearchEscoltaInput.style.display = 'none';
    } else{
      //SearchEscoltaInput.setAttribute("type","hidden");
      SearchEscoltaInput.style.display = 'inline';
    }

  }






</script>