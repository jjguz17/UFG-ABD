<?php

    require ("../conf/db.conf.php");
    require ("../servicio/conexion.class.php");
    require ("../modelo/comandas.class.php");
    
    $obj_comandas = new comanda();
 
    if($obj_comandas->conectar()):

        $operacion = (integer) $_REQUEST['tipo_operacion'];

        if($operacion == 1)://INSERTAR
                 ######################## VISITAS ###############################
            $txtNombreVisita =  (string) trim($_REQUEST['txtNombreVisita']);
            $txtCompaniaVisita = (string) trim($_REQUEST['txtCompaniaVisita']);
            $SearchEmpleadoInput = (integer) $_REQUEST['SearchEmpleadoInput'];
            $txtdocid = (string) trim($_REQUEST['txtdocid']);
            $txtMotivo = (string) trim($_REQUEST['txtMotivo']);
            $SearchEscoltaInput = $_REQUEST['SearchEscoltaInput'];
            ($SearchEscoltaInput=="")?$SearchEscoltaInput = $SearchEmpleadoInput:$SearchEscoltaInput = (integer) $_REQUEST['SearchEscoltaInput'];

        $array_info = array($txtNombreVisita,$txtCompaniaVisita,$SearchEmpleadoInput,$txtdocid,$txtMotivo,$SearchEscoltaInput);

            $bandera = $obj_comandas->new_comandas($array_info);


        elseif($operacion == 2)://DEPACHAR
            $bandera = $obj_comandas->despachar_comandas($_REQUEST['IdComanda']);

        elseif($operacion == 3)://cAMBIAR ESTADO VISITA
            $bandera = $obj_comandas->cambiarestado_comandas($_REQUEST['IdComanda'],$_REQUEST['Estado']);

        elseif($operacion == 4)://INSERTAR ACCESO

             ######################## ACCESOS ###############################
            $SearchEmpleadoInput = (integer) $_REQUEST['SearchEmpleadoInput'];
            $SearchAccesoInput = (integer) $_REQUEST['SearchAccesoInput'];
            $txtAutorizacion = (string) ("../Documentos/Autorizaciones/"+ $_REQUEST['txtAutorizacion']);
            $array_acceso = array($SearchAccesoInput,$SearchEmpleadoInput,  $txtAutorizacion);

            $bandera = $obj_comandas->new_acceso($array_acceso);

        elseif($operacion == 5)://CAMBIAR ESTADO ACCESO

             $bandera = $obj_comandas->cambiarestado_acceso($_REQUEST['IdComanda'],$_REQUEST['Estado']);
        elseif($operacion == 6):
             $bandera = $obj_comandas->despachar_acceso($_REQUEST['IdComanda']);
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