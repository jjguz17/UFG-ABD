
<div class="box-header">
    <a class="btn btn-primary btn-sm btn-lg" onclick="CargarNuevoAcceso()">
        <i class="fa fa-plus-square"></i> &nbsp; Agregar entrada
    </a>
</div>

<?php

    require("../conf/db.conf.php");
    require("../servicio/conexion.class.php");
    require ("../modelo/comandas.class.php");
    
    $obj_comanda  =  new comanda();
    $obj_comanda->conectar();
?>
            <div class="box-header">
              <h3 class="box-title">Accesos creados</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>Nº</th>
                  <th>Tipo de acceso</th>
                  <th>Supervisor</th>
                  <th>Cargo de empleado</th>
                  <th>Depto empleado</th>
                  <th>Fecha hora entrega</th>
                  <th>Fecha hora devolucion</th>
                  <th>Estado</th>
                  <th>Opciones</th>
                </tr>
                </thead>
                <tbody>
                   <?php
                  echo $obj_comanda->listar_accesos();
                  ?>

                </tbody>
                <tfoot>
                <tr>
                
                </tr>
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
<!-- ./wrapper -->

<script>
  $(function () {
    $('#example1').DataTable()
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false
    })
  })
</script>
