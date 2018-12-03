
<div class="box-header">
    <a class="btn btn-primary btn-sm btn-lg" onclick="CargarNuevaVisita()">
        <i class="fa fa-plus-square"></i> &nbsp; Agregar visita
    </a>
</div>

<?php
    require ("../conf/db.conf.php");
    require ("../servicio/conexion.class.php");
    require ("../modelo/comandas.class.php");
    
    global $obj_comanda;
    $obj_comanda  =  new comanda();
    $obj_comanda->conectar();
?>
            <div class="box-header">
              <h3 class="box-title">Visitas creadas</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                <th>Nº</th>
                <th>Visitante</th>
                <th>Compañía</th>
                <th>Visita a</th>
                <th>Escolta</th>
                <th>Ingreso</th>
                <th>Estado</th>
                <th>Opciones</th>
                </tr>
                </thead>
                <tbody>
                   <?php
                  echo $obj_comanda->listar_comanda();
                  ?>

                </tbody>
                <tfoot>
                <tr>
                   <th>Nº</th>
                  <th>Descripcion</th>
                    <th>Total</th>
                     <th>Registrada</th>
                  <th>Estado</th>
                 
                  <th>Opciones</th>
                
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


 






 