<?php
   final class combos extends conexion
   {
   private $Idcombo;
   
   
    function ddl_combos()
        {
           $salida_inicial     =   (string)  '';
           $salida_final       =   (string)  '';
         
           $sentencia_select   =   $this->obj_con->prepare("SELECT Idcombo, nombre FROM combos");    
           $sentencia_select->execute();
           $conteo_registros   =   $sentencia_select->rowCount();
           
           if($conteo_registros> 0):
               foreach ($sentencia_select as $row):
                   
                   $salida_inicial     =   '<option value="'.$row["Idcombo"].'">'.$row["nombre"].'</option>';
                   $salida_final       =   $salida_final.$salida_inicial;
               endforeach;
           else:
               $salida_final           =   '';
           endif;
           
           return $salida_final;
       }
       
         function combo_row($Id)
        {
           $salida_inicial     =   (string)  '';
           $salida_final       =   (string)  '';
         
           $sentencia_select   =   $this->obj_con->prepare("SELECT Idcombo, nombre, descripcion, precio,imagen,estado FROM combos WHERE Idcombo = ?");  
         $sentencia_select->bindParam(1,$Id); 
           $sentencia_select->execute();
           $conteo_registros   =   $sentencia_select->rowCount();
           
           if($conteo_registros> 0):
               foreach ($sentencia_select as $row):
                   
                   $salida_inicial     =   $row["Idcombo"].'*'.$row["nombre"].'*'.$row["descripcion"].'*'.$row["precio"].'*'.$row["imagen"];
                   $salida_final       =   $salida_final.$salida_inicial;
               endforeach;
           else:
               $salida_final           =   '';
           endif;
           
           return $salida_final;
       }
       
   }
   
   ?>