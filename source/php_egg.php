#!/usr/local/bin/php -q
<?php

include("version.php");

// start up
print("\nStarting PHP-Egg version ".VERSION."\n");
print("web: http://sourceforge.net/projects/phpegg/\n");

if (file_exists("config.auto.php")) {
    include("config.auto.php");
} else {
    include("config.php");
}
if ($magic_word=="") {
    print("\nError: you need to write your magic_word in config.php\n");
    exit;
}
if ($database_name=="") {
    print("\nError: you need to write the name of your php_egg database in config.php\n");
    exit;
}
if ($irc_identd=="") {
    print("\nError: you need to write a irc_identd in config.php\n");
    exit;
}
print("Configuration loaded...\n");

include('db_ctrl.php');
switch($database) {
	case "MySQL":
		$db_ctrl = new MySQLInterface;
		$dbshort = "mysql";
		break;
	case "PostgreSQL":
		$db_ctrl = new PostgreSQLInterface;
		$dbshort = "pg";
		break;
}
print ("Database Control loaded...\n");

include_once("bf_lib.php");
include("server_functions.inc");
include("login_check.inc");
include("seen.inc");
include_once("autoruncommands.inc");	
include("common.inc");

// gryph: hmm, what is this function doing here?
function check_for_colon($str) {
    if (substr($str,0,1)==":") {
	$str=substr($str,1,strlen($str));
    }
    return $str;
}

// make database connection
$db = $db_ctrl->pconnect($database_host,$database_login,$database_pass,$database_name);

if ($db=="") {
    print("\nError: $database connection failed\n");
    exit;
}

if (($foo=$db_ctrl->error())!="") {
    print("\nError: $foo\n");
    exit;
}
print("$database connection established...\n");

// check php and mysql versions
if (!eregi("^4.",phpversion())) {
    print("\nSorry, you need php4 to run php-egg\n");
    exit;
}

if ($database == "MySQL") {
	$sql="select version()";
	$result=$db_ctrl->query($sql,$db);
	$myrow=$db_ctrl->fetch_array($result);
	if (!eregi("^3.23.",$myrow[0])) {
	    print("\nSorry, you need mysql version 3.23 to run php-egg\n");
	    exit;
	}
}
print "$sql\nHey there!\n\n";
$sql="select * from user2";

$result=$db_ctrl->query($sql,$db);
if ($db_ctrl->num_rows($result)!=0) {
    if ($debug==1) {
	echo "Unsetting magic word users deteched \n";
   
	}
    unset($magic_word);
} else {
    if ($debug==1) {
	echo "found no users leaving magic word \n";
    }
}	

$chan_total=0;

// delete old dcc_connections
$sql="delete from dcc_connections";
@$db_ctrl->query($sql,$db);

// fixes problem if bot crashes before database is updated

$sql="update channels set in_chan='0'";
$result=@$db_ctrl->query($sql,$db);


$sql="update chan_users set reason='bot died' where reason is null";
$result=@$db_ctrl->query($sql,$db);

$sql="delete from bans";
$result=@$db_ctrl->query($sql,$db);


// reading servers
if ($server_group!="local") {
    $sql_servers="select server_name, port from server_groups sg, servers s where upper(server_group)=('$server_group') and sg.server_groups_id=s.server_group_id";
    $result_servers=@$db_ctrl->query($sql_servers,$db);
    while ($myrow=@$db_ctrl->fetch_array($result_servers)) {
	$irc_servers[]=$myrow["server_name"];
	$irc_server_ports[]=$myrow["port"];
    }
}

if ($debug==1) {
    echo "num of servers loaded ".count($irc_servers)."\n";
}

// loading modules


/* Module control
   
   Basic structure of loading individual modules dev'd by Kill-9
   Modular class system dev'd by Un-Thesis 

   Single module:
       $mod_ctrl->load_specific("modname");
   All modules:
	   $mod_ctrl->load_all(); 
*/

/* unloading modules -- Dev'd by Un-Thesis
	   $mod_ctrl->unload_specific("modname");
       $mod_ctrl->unload_all();
*/

/* reloading modules -- Dev'd by Un-Thesis
       $mod_ctrl->reload_specific("modname");
	   $mod_ctrl->reload_all();
*/
include("mod_ctrl.php");

$mod_ctrl = new module_control;
$mod_ctrl->set_debug();
$mod_ctrl->load_all();


global $db_ctrl,$dcc_connections,$uptime;

$dcc_connections="";
$uptime=time();

include("connect.inc");

irc_connect();
?>
