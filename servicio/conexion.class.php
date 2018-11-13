<?php
abstract class conexion 
{
    private static $gestor;
    private static $servidor;
    private static $usuario;
    private static $password;
    private static $db;
    private static $port;
    public $obj_con;
    
    function __construct()
    {
        //propiedades de la clase Conexion
        self::$gestor           =   GESTOR_DB;
        self::$servidor         =   SERVIDOR_BD;
        self::$usuario          =   USUARIO_BD;
        self::$password         =   PASS_BD;
        self::$db               =   DB_BD;
        self::$port             =   PORT_DB; 
    }
    
    function conectar()
    {
        try 
    {
            $this->obj_con      =   new PDO(self::$gestor.':host='.self::$servidor.';dbname='.self::$db.';port='.self::$port, self::$usuario, self::$password);
            return true;
        }
        catch(PDOException $e)
    {
        return false;
    }
        
    }    
    
    function desconectar()
    {
        $this->obj_con = null;
    }
 
      
    function __destruct() 
    {
        //unset($this);
        $this->obj_con = null;
    }

}
?>
