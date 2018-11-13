<?php

    require ("../conf/db.conf.php");
    require ("../servicio/conexion.class.php");
    require ("../modelo/login.class.php");
    
    $obj_login = new login();
 
    if($obj_login->conectar()):
      
           $bandera = $obj_login->validar($_REQUEST['txtusuario'],$_REQUEST['txtclave']);
 //$bandera = $obj_login->validar('Cliente','demo');


            print($bandera);
        
        
    else:
       
    endif;

?>