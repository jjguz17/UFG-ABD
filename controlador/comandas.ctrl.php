<?php

    require ("../conf/db.conf.php");
    require ("../servicio/conexion.class.php");
    require ("../modelo/comandas.class.php");
    
    $obj_comandas = new comanda();
 
    if($obj_comandas->conectar()):
       $operacion =  (integer) $_REQUEST['tipo_operacion'];

        $txtNombre = (string) trim($_REQUEST['txtNombre']);

        $txtdescripcion = (string) trim($_REQUEST['txtdescripcion']);

       $txtprecio = (string) trim($_REQUEST['txtprecio']);

        $cbCombo = (string) trim($_REQUEST['cbCombo']);



        $array_info = array($cbCombo,$txtdescripcion,$txtprecio);
        
        if($operacion == 1)://INSERTAR
            $bandera = $obj_comandas->new_comandas($array_info);
        elseif($operacion == 2)://MODIFICAR
            $bandera = $obj_comandas->despachar_comandas($_REQUEST['IdComanda']);
        elseif($operacion == 3)://ELIMINAR
            $bandera = $obj_comandas->cambiarestado_comandas($_REQUEST['IdComanda'],$_REQUEST['Estado']);
        elseif($operacion == 4)://ELIMINAR
            $bandera = $obj_comandas->delete_sucursalcomandas($_REQUEST['hdIdcomandas']);
        elseif($operacion == 5)://ELIMINAR
           // $bandera = $obj_comandas->insert_sucursalcomandas($_REQUEST['hdIdcomandas'],$_REQUEST['hdIdsucursal']);
             $bandera = $obj_comandas->insert_sucursalcomandas($_REQUEST['hdIdcomandas'],$_REQUEST['hdIdsucursal']);
        endif;
        
        if($bandera == 1 && $operacion == 1):
          //  header('Location: ../?vista=listar_emp&opc=1&bandera=1');
        elseif($bandera == 1 && $operacion == 2):
            //header('Location: ../?vista=listar_emp&opc=2&bandera=1');
        elseif($bandera == 1 && $operacion == 3):
            //header('Location: ../?vista=listar_emp&opc=3&bandera=1');
        else:
           // header('Location: ../?vista=listar_emp&opc=4');
        endif;
        
    else:
       
    endif;

?>