#!/usr/local/bin/php -q
<?php

// start up
print("\nStarting PHP-Egg version 1.2b\n");
print("by: kill-9@skod.dk\n");
print("web: www.blah.com\n");

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

// make mysql connection
$db=@mysql_pconnect($database_host,$database_login,$database_pass);
if ($db=="") {
    print("\nError: mysql connection failed\n");
    exit;
}
mysql_select_db($database_name,$db);
if (($foo=mysql_error())!="") {
    print("\nError: $foo\n");
    exit;
}
print("MySQL connection established...\n");

// check php and mysql versions
if (!eregi("^4.",phpversion())) {
    print("\nSorry, you need php4 to run php-egg\n");
    exit;
}
$sql="select version()";
$result=mysql_query($sql,$db);
$myrow=mysql_fetch_array($result);
if (!eregi("^3.23.",$myrow[0])) {
    print("\nSorry, you need mysql version 3.23 to run php-egg\n");
    exit;
}

$sql="select * from user";
$result=@mysql_query($sql,$db);

if (mysql_num_rows($result)!=0) {
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
@mysql_query($sql,$db);

// fixes problem if bot crashes before database is updated

$sql="update channels set in_chan='N'";
$result=@mysql_query($sql,$db);


$sql="update chan_users set reason='bot died' where reason is null";
$result=@mysql_query($sql,$db);

$sql="delete from bans";
$result=@mysql_query($sql,$db);


// reading servers
if ($server_group!="local") {
    $sql_servers="select server_name, port from server_groups sg, servers s where upper(server_group)=('$server_group') and sg.server_groups_id=s.server_group_id";
    $result_servers=@mysql_query($sql_servers,$db);
    while ($myrow=@mysql_fetch_array($result_servers)) {
	$irc_servers[]=$myrow["server_name"];
	$irc_server_ports[]=$myrow["port"];
    }
}

if ($debug==1) {
    echo "num of servers loaded ".count($irc_servers)."\n";
}

// loading modules

$sql="select module_file_name from module_binds mb, modules m where bind='ONKICK' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $kick_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {	
    echo "num of kick modules loaded ".count($kick_mdl)."\n";
}

$sql="select module_file_name from module_binds mb, modules m where bind='SHOW' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $show_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of show modules loaded ".count($show_mdl)."\n";
}

$sql="select module_file_name from module_binds mb, modules m where bind='!_COMMAND' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $ex_commands[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}

if ($debug==1) {	
    echo "num of ! modules loaded ".count($ex_commands)."\n";
}
$sql="select module_file_name from module_binds mb, modules m where bind='BOTMSG' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $botmsgs[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of botmsg modules loaded ".count($botmsgs)."\n";
}

$sql="select module_file_name from module_binds mb, modules m where bind='MODE' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $mode_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of mode modules loaded ".count($mode_mdl)."\n";
}

$sql="select module_file_name from module_binds mb, modules m where bind='NICK' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $nick_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of nick modules loaded ".count($nick_mdl)."\n";
}
$sql="select module_file_name from module_binds mb, modules m where bind='TOPIC' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $topic_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of topic modules loaded ".count($topic_mdl)."\n";
}
$sql="select module_file_name from module_binds mb, modules m where bind='PART' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $part_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of part modules loaded ".count($part_mdl)."\n";
}

$sql="select module_file_name from module_binds mb, modules m where bind='JOIN' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $join_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of join modules loaded ".count($join_mdl)."\n";
}

$sql="select module_file_name from module_binds mb, modules m where bind='QUIT' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $quit_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of quit modules loaded ".count($quit_mdl)."\n";
}
$sql="select module_file_name from module_binds mb, modules m where bind='BOT_JOIN_TOPIC' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $bot_join_topic[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of bot_join_topic modules loaded ".count($bot_join_topic)."\n";
}
$sql="select module_file_name from module_binds mb, modules m where bind='BOT_JOIN_TOPIC_SETBY' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $bot_join_topic_set_by[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of bot_join_topic_set_by modules loaded ".count($bot_join_topic_set_by)."\n";
}
$sql="select module_file_name from module_binds mb, modules m where bind='BOT_JOIN_NAMES' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $bot_join_names[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of bot_join_names modules loaded ".count($bot_join_names)."\n";
}
$reload_modules = fread(fopen("modules/reload_mdl.mdl", "r"), filesize("modules/reload_mdl.mdl"));

$login_module = fread(fopen("modules/login.mdl", "r"), filesize("modules/login.mdl"));

$sql="select module_file_name from module_binds mb, modules m where bind='?_COMMAND' and mb.module_binds_id=m.module_binds_id";
$result=@mysql_query($sql,$db);
while($myrow=@mysql_fetch_array($result)) {
    $help_mdl[] = fread(fopen($myrow["module_file_name"], "r"), filesize($myrow["module_file_name"]));
}
if ($debug==1) {
    echo "num of help modules loaded ".count($help_mdl)."\n";
}

global $dcc_connections;
$dcc_connections="";

include("connect.inc");

irc_connect();
?>
