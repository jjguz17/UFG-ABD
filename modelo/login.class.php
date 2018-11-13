<?php
   final class login extends conexion
   {
 
   
   
    function validar($usu,$cla)
        {
           $salida_inicial     =   (string)  '';
           $salida_final       =   (string)  '';
         
           $sentencia_select   =   $this->obj_con->prepare("SELECT Idusuario, nombre, usuario, clave  FROM usuarios where usuario = ? and clave  = ?");   
         $sentencia_select->bindParam(1,$usu);	
          $sentencia_select->bindParam(2,$cla);

           $sentencia_select->execute();
           $conteo_registros   =   $sentencia_select->rowCount();
           
         if($conteo_registros > 0):
            return 1;
        else:
            return 0;
        endif;
       }
       
       
       
   }
   
   ?>