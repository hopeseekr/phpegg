<?php

// changes start here

$magic_word="HELLO!";

$admin_email="user@localhost";

// mysql database information 
/* 
  $database tells PHP-Egg what database you will be using it with.
  The ONLY option right now: MySQL
*/
$database="MySQL";
$database_host="localhost";
$database_login="root";
$database_pass="";
$database_name="egg_final";

/* egg bot name */
$irc_nick="phpbot";
$irc_alt_nick="php_bot2";

/* itent */
$irc_identd="phpa";

/* real name */
$irc_real_name="phpegg beta 1";

// quit message
$quit_message="php_egg beta 2 by kill-9 and Un-Thesis";

// If you would like to run a server that is not part of the server groups now.
 //set $server_group="local"
// uncomment the folowing two lines and set them to the server and port that you wish the bot to connect to.

$irc_servers[0]="10.100.200.6";
$irc_server_ports[0]="6667";

//$server_group="Random EU Undernet server";
$server_group="local";

/* This starts up the database 
   WARNING: If your $database variable does not have something that matches the case statements 
   below, your script WILL NOT work.
*/
include('db_ctrl.php');
switch($database) {
	case "MySQL":
		$db_ctrl = new MySQLInterface;
		$dbshort = "mysql";
		break;
}


// If you are having any problems with getting php egg to connect to irc and dont know why 
// you can uncomment the debug line below and see what it is that the bot is trying to do and mabie figure out why
// she isnt connecting to irc. 
$debug=0;

?>