<?php
   final class searchEmployee extends conexion
   {
   	$key=$_GET['key'];
   	$array = array();
	$query=mysqli_query($obj_con, "SELECT id_empleado, nombres_empleado, apellidos_empleado FROM empleados where nombres_empleado LIKE '%{$key}%'");
	while($row=mysqli_fetch_assoc($query))
    {
      $array[] = $row['nombres_empleado'];
    }
    echo json_encode($array);
    mysqli_close($con);

   }


?>

