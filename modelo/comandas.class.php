<?php
final class comanda extends conexion
{
private $Idcomanda;

    
 function new_comandas($array_datos)
    {
        $Estado = 'A';
       $date = date('Y-m-d H:i:s');
        $sentencia_insert = $this->obj_con->prepare("INSERT INTO comandas(IdCombo,descripcion,total,estado,fechaRegistro) VALUES (?,?,?,?,?)");
        $sentencia_insert->bindParam(1,$array_datos[0]);		
        $sentencia_insert->bindParam(2,$array_datos[1]);
        $sentencia_insert->bindParam(3,$array_datos[2]);
        $sentencia_insert->bindParam(4,$Estado);
      $sentencia_insert->bindParam(5,$date);
    
     
      
        $sentencia_insert->execute();
        $conteo_registros = $sentencia_insert->rowCount();
        
        if($conteo_registros > 0):
            return 1;
        else:
            return 0;
        endif;
    }
    
    
     function despachar_comandas($Id)
    {
         
        $Estado = 'D';
       $date = date('Y-m-d H:i:s');
        $sentencia_insert = $this->obj_con->prepare("UPDATE comandas SET estado = ?, fechaDespacho= CURRENT_TIMESTAMP  WHERE Idcomanda = ?");		
          $sentencia_insert->bindParam(1,$Estado);	
          $sentencia_insert->bindParam(2,$Id);

        $sentencia_insert->execute();
        $conteo_registros = $sentencia_insert->rowCount();
        
        if($conteo_registros > 0):
            return 1;
        else:
            return ;
        endif;
    }
    
      function cambiarestado_comandas($Id,$Estado)
    {
         if($Estado == 1){
             $Nuevo = 'I';
         }
          else{
              $Nuevo = 'A';
         }
      
       $date = date('Y-m-d H:i:s');
        $sentencia_insert = $this->obj_con->prepare("UPDATE comandas SET estado = ? WHERE Idcomanda = ?");		
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

    $sentencia_select =	$this->obj_con->prepare("SELECT IdComanda,descripcion,total,fechaRegistro,estado  FROM comandas where estado <> 'D'");
   	
    $sentencia_select->execute();
    $conteo_registros = $sentencia_select->rowCount();

    if($conteo_registros> 0):
        foreach ($sentencia_select as $row):
            $contador++;

            $ValorTem = $row["estado"] ;
            if($row["estado"] == "A")
            {
                $varible2= '<span class="label label-success">Activo</span>';
                $varEstado = 1;
            }
            else
            {
                $varible2= '<span class="label label-danger">Inactivo</span>';
                $varEstado = 0;
            }

            $varible = '"'.$row['descripcion'].'"';
            $link_modificar = "<a href='#' class='btn btn-sm btn btn-danger fa fa-edit btn-sm' onclick='modificar(".$row['IdComanda'].",".$varible.",".$varEstado.")'></a>";
            $link_eliminar = '<a href="#" class="btn btn-sm btn btn-danger fa  fa-trash btn-sm" onclick="Eliminar('.$row['IdComanda'].')""></a>';


            $salida_inicial     =   '<tr>'
                                    . '<td>'.$row["IdComanda"].'</td>'
                                    . '<td>'.$row["descripcion"].'</td>'
                                    . '<td>'.$row["total"].'</td>'
                                    . '<td>'.$row["fechaRegistro"].'</td>'
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
}




?>

