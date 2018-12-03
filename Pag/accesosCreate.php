<link href="../sweetalert/sweetalert2.css" rel="stylesheet" />

 
<div class="box-header">
   <a class="btn btn-danger btn-sm btn-lg" onclick="RegresarIndex()">
   <i class="fa fa-plus-square"></i> &nbsp; Regresar
   </a>
   <a class="btn btn-primary btn-sm btn-lg" onclick="InsertarAcceso()">
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
                      <label>Empleado</label>
                      <br>
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
                      <label>Tipo de acceso</label>
                      <br><br>
                      <select name="SearchAccesoInput" class="js-example-basic-single" id="SearchAccesoInput" >
                        <option selected="" disabled="">Seleciona el tipo de acceso</option>
                        <?php
                        $tipoAccesoArray = $obj_entradas->getAccessType(); //Se toma de entradas.class.php
                        foreach($tipoAccesoArray as $row) {
                        echo '<option value="'.$row["id_tipo_acceso"].'">'.$row["nombre_tipo_acceso"].'</option>';
                        }
                        ?>

                      </select>

                   </div>
                </div>
             </div>



             <div class="row">
                <div class="col-md-12">
                   <div class="form-group">
                      <label>Archivo de Autorización</label>
                      <input class="form-control" id="txtAutorizacion" maxlength="350" type="text" placeholder="Archivo_Correo.eml">
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
    $("#SearchAccesoInput").select2();

});
    
    
   function InsertarAcceso(){
   
   //debugger;
    var ptipo_operacion= 4;
    var SearchEmpleadoInput = $('#SearchEmpleadoInput').val();
    var SearchAccesoInput = $('#SearchAccesoInput').val();
    var txtAutorizacion = $('#txtAutorizacion').val();
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
                           SearchEmpleadoInput:SearchEmpleadoInput,
                           SearchAccesoInput:SearchAccesoInput,
                           txtAutorizacion:txtAutorizacion
                       },
                           success: function (data) {
                              console.log(data);
                               if (data ) {
                                   swal({
                                       title: "Exito",
                                       text: data.responseText,
                                       type: "success"
                                   }).then(function () {
                                      $('#mitablaDatos').load('AccesosIndexTable.php');
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