<?php

    require ("../conf/db.conf.php");
    require ("../servicio/conexion.class.php");
    require ("../modelo/combos.class.php");
    
    $obj_combos = new combos();
 
    if($obj_combos->conectar()):
      
            $bandera = $obj_combos->combo_row($_REQUEST['phdId']);

            print($bandera);
        
        
    else:
       
    endif;

?>