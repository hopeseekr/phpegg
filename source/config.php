<?php

// changes start here

$magic_word="HELLO!";

$admin_email="user@localhost";

// mysql database information 
$database_host="localhost";
$database_login="root";
$database_pass="";
$database_name="phpegg";

/* egg bot name */
$irc_nick="php_bot";
$irc_alt_nick="php_bot2";

/* itent */
$irc_identd="phpa";

/* real name */
$irc_real_name="phpegg beta 1";

// quit message
$quit_message="php_egg beta 1.2 by kill-9";

// If you would like to run a server that is not part of the server groups now.
// set $server_group="local"
// uncomment the folowing two lines and set them to the server and port that you wish the bot to connect to.

//$irc_servers[0]="127.0.0.1";
//$irc_server_ports[0]="6667";

$server_group="Random EU Undernet server";
//$server_group="local";

// If you are having any problems with getting php egg to connect to irc and dont know why 
// you can uncomment the debug line below and see what it is that the bot is trying to do and mabie figure out why
// she isnt connecting to irc. 
$debug=0;

?>