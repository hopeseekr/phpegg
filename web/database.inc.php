<?php
/* 
  $database tells PHP-Egg what database you will be using it with.
  The ONLY option right now: MySQL
*/
$database="MySQL";
$database_host="localhost";
$database_login="root";
$database_pass="";
$database_name="eggdrop";

/* Loads the db_ctrl interface */
include('db_ctrl.php');
switch($database) {
	case "MySQL":
		$db_ctrl = new MySQLInterface;
		$dbshort = "mysql";
		break;
}

// edit host, login, pass here
$db=@$db_ctrl->connect($database_host,$database_login,$database_pass,$database_name);

if ($db=="") {
    print("Error: $database connection failed<br>\n");
    exit;
}

// edit your database name here
//sql_select_db("egg_final",$db);

if (($foo=$db_ctrl->error())!="") {
    print("$foo<br>\n");
    exit;
}

?>