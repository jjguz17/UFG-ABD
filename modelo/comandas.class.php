<?php
final class comanda extends conexion
{
private $Idcomanda;

public function debug_to_console( $data ) {
    $output = $data;
    if ( is_array( $output ) )
        $output = implode( ',', $output);

    echo "<script>console.log( 'Debug Objects: " . $output . "' );</script>";
}
    
 function new_comandas($array_datos)
    {
        $Estado = '1'; // 1 activo , 0 inactivo
        $date = date('Y-m-d H:i:s');
        $sentencia_insert = $this->obj_con->prepare("INSERT INTO visitas(nombre_visita,compania_visita,id_empleado_visitado,doc_visita,motivo_visita,empleado_escolta,fechahora_ingreso,estado_visita) VALUES (?,?,?,?,?,?,?,?)");
        $sentencia_insert->bindParam(1,$array_datos[0]);		
        $sentencia_insert->bindParam(2,$array_datos[1]);
        $sentencia_insert->bindParam(3,$array_datos[2]);
        $sentencia_insert->bindParam(4,$array_datos[3]);
        $sentencia_insert->bindParam(5,$array_datos[4]);
        $sentencia_insert->bindParam(6,$array_datos[5]);
        $sentencia_insert->bindParam(7,$date);
        $sentencia_insert->bindParam(8,$Estado);

        $sentencia_insert->execute();
        $conteo_registros = $sentencia_insert->rowCount();
        
        if($conteo_registros > 0):
            return 1;
        else:
            $arregloError = $sentencia_insert->errorInfo();
            echo "<script>console.log( 'Debug Objects: " .$arregloError[2] . "' );</script>";
            return 0;
        endif;
    }
    
     function new_acceso($array_datos)
    {
        $Estado = '1'; // 1 activo , 0 inactivo
        $entregaDate = date('Y-m-d H:i:s');
        $date = new DateTime('+1 day');
        $fechadev = $date->format('Y-m-d H:i:s');

        $sentencia_insert = $this->obj_con->prepare("INSERT INTO accesos(id_tipo_acceso,fechahora_Entrega,id_empleado,ruta_aprobacion,fechahora_Devolucion,estado_acceso) VALUES (?,?,?,?,?,?)");
        $sentencia_insert->bindParam(1,$array_datos[0]);#Tipo acceso
        $sentencia_insert->bindParam(2,$entregaDate);          #fecha entrega
        $sentencia_insert->bindParam(3,$array_datos[1]);#Empleado
        $sentencia_insert->bindParam(4,$array_datos[2]);#ruta autorizacion 
        $sentencia_insert->bindParam(5,$fechadev);      #fecha Devolucion
        $sentencia_insert->bindParam(6,$Estado);        #estado acceso 1

        $sentencia_insert->execute();
        $conteo_registros = $sentencia_insert->rowCount();
        
        if($conteo_registros > 0):
            return 1;
        else:
            $arregloError = $sentencia_insert->errorInfo();
            echo "Error: " .$arregloError[2] . " \\n al agregar nuevo acceso";
            return 0;
        endif;
    }
     function despachar_comandas($Id)
    {
         
        $Estado = '2';
       $date = date('Y-m-d H:i:s');
        $sentencia_insert = $this->obj_con->prepare("UPDATE visitas SET estado_visita = ?, fechahora_egreso = ?  WHERE id_visita = ?");		
          $sentencia_insert->bindParam(1,$Estado);	
          $sentencia_insert->bindParam(2,$date);
          $sentencia_insert->bindParam(3,$Id);

        $sentencia_insert->execute();
        $conteo_registros = $sentencia_insert->rowCount();
        
        if($conteo_registros > 0):
            return 1;
        else:
            return 0 ;
        endif;
    }
    
      function cambiarestado_comandas($Id,$Estado)
    {
         if($Estado == 1){
             $Nuevo = "0";
         }
          else{
              $Nuevo = "1";
         }
      
       $date = date('Y-m-d H:i:s');
        $sentencia_insert = $this->obj_con->prepare("UPDATE visitas SET estado_visita = ? WHERE id_visita = ?");		
          $sentencia_insert->bindParam(1,$Nuevo);	
          $sentencia_insert->bindParam(2,$Id);

        $sentencia_insert->execute();
        $conteo_registros = $sentencia_insert->rowCount();
        
        if($conteo_registros > 0):
            return 1;
        else:
            return ;
        endif;
    }

function listar_comanda()
{
    $salida_inicial = (string) '';
    $salida_final = (string) '';
    $contador = (integer) 0;

    $sentencia_select =	$this->obj_con->prepare("SELECT * from v_dashboard_visitas");
   	
    $sentencia_select->execute();
    $conteo_registros = $sentencia_select->rowCount();

    if($conteo_registros> 0):
        foreach ($sentencia_select as $row):
            $contador++;

            //$ValorTem = $row["estado"] ;
            if($row["estado_visita"] == "1")
            {
                $varible2= '<span class="label label-success">Activo</span>';
                $varEstado = 1;
            }
            else
            {
                $varible2= '<span class="label label-danger">Inactivo</span>';
                $varEstado = 0;
            }

            $varible = '"'.$row['nombre_visita'].'"';
            $link_modificar = "<a href='#' class='btn btn-sm btn btn-danger fa fa-edit btn-sm' onclick='modificar(".$row['id_visita'].",".$varible.",".$varEstado.")'></a>";
            $link_eliminar = '<a href="#" class="btn btn-sm btn btn-danger fa  fa-trash btn-sm" onclick="Eliminar('.$row['id_visita'].')""></a>';


            $salida_inicial     =   '<tr>'
                                    . '<td>'.$row["id_visita"].'</td>'
                                    . '<td>'.$row["nombre_visita"].'</td>'
                                    . '<td>'.$row["compania_visita"].'</td>'
                                    . '<td>'.$row["visitando_a"].'</td>'
                                    . '<td>'.$row["escolta"].'</td>'
                                    . '<td>'.$row["fechahora_ingreso"].'</td>'
                                    . '<td>'.$varible2.'</td>'

                                    . '<td>'.$link_modificar.'&nbsp;'.$link_eliminar.'</td>'
                                    . '</tr>';
            $salida_final       =   $salida_final.$salida_inicial;
             $varible2 = "";
        endforeach;
    else:
        $salida_final           =   '<tr><td colspan="8" style="text-align:center"><b>NO HAY REGISTROS</b></td></tr>';
    endif;

    return $salida_final;
    }


    function listar_accesos()
{
    $salida_inicial = (string) '';
    $salida_final = (string) '';
    $contador = (integer) 0;

    $sentencia_select = $this->obj_con->prepare("SELECT * from v_dashboard_accesos");
    
    $sentencia_select->execute();
    $conteo_registros = $sentencia_select->rowCount();

    if($conteo_registros> 0):
        foreach ($sentencia_select as $row):
            $contador++;

            //$ValorTem = $row["estado"] ;
            if($row["estado_acceso"] == "1")
            {
                $varible2= '<span class="label label-success">Activo</span>';
                $varEstado = 1;
            }
            else
            {
                $varible2= '<span class="label label-danger">Inactivo</span>';
                $varEstado = 0;
            }

            $varible = '"'.$row['empleado'].'"';
            $link_modificar = "<a href='#' class='btn btn-sm btn btn-danger fa fa-edit btn-sm' onclick='modificarAcceso(".$row['id_acceso'].",".$varible.",".$varEstado.")'></a>";
            $link_eliminar = '<a href="#" class="btn btn-sm btn btn-danger fa  fa-trash btn-sm" onclick="EliminarAcceso('.$row['id_acceso'].')""></a>';


            $salida_inicial     =   '<tr>'
                                    . '<td>'.$row["id_acceso"].'</td>'
                                    . '<td>'.$row["tipo_acceso"].'</td>'
                                    . '<td>'.$row["empleado"].'</td>'
                                    . '<td>'.$row["jefe"].'</td>'
                                    . '<td>'.$row["nombre_departamento"].'</td>'
                                    . '<td>'.$row["FechaHora_Entrega"].'</td>'
                                    . '<td>'.$row["FechaHora_Devolucion"].'</td>'
                                    . '<td>'.$varible2.'</td>'

                                    . '<td>'.$link_modificar.'&nbsp;'.$link_eliminar.'</td>'
                                    . '</tr>';
            $salida_final       =   $salida_final.$salida_inicial;
             $varible2 = "";
        endforeach;
    else:
        $salida_final           =   '<tr><td colspan="8" style="text-align:center"><b>NO HAY REGISTROS</b></td></tr>';
    endif;

    return $salida_final;
    }

 function despachar_acceso($Id)
    {
         
        $Estado = '2';
       $date = date('Y-m-d H:i:s');
        $sentencia_insert = $this->obj_con->prepare("UPDATE accesos SET estado_acceso = ?, fechahora_egreso = ?  WHERE id_acceso = ?");     
          $sentencia_insert->bindParam(1,$Estado);  
          $sentencia_insert->bindParam(2,$date);
          $sentencia_insert->bindParam(3,$Id);

        $sentencia_insert->execute();
        $conteo_registros = $sentencia_insert->rowCount();
        
        if($conteo_registros > 0):
            return 1;
        else:
            return 0 ;
        endif;
    }
    
      function cambiarestado_acceso($Id,$Estado)
    {
         if($Estado == 1){
             $Nuevo = "0";
         }
          else{
              $Nuevo = "1";
         }
      
       $date = date('Y-m-d H:i:s');
        $sentencia_insert = $this->obj_con->prepare("UPDATE accesos SET estado_acceso = ? WHERE id_acceso = ?");        
          $sentencia_insert->bindParam(1,$Nuevo);   
          $sentencia_insert->bindParam(2,$Id);

        $sentencia_insert->execute();
        $conteo_registros = $sentencia_insert->rowCount();
        
        if($conteo_registros > 0):
            return 1;
        else:
            return ;
        endif;
    }




}?>

