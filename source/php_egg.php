#!/usr/local/bin/php -q
<?php
//  __   .__.__  .__			 ________ 
// |  | _|__|  | |  |		    /   __   \
// |  |/ /  |  | |  |	 ______ \____	 /
// |	<|  |  |_|  |__ /_____/    /    /
// |__|_ \__|____/____/		      /____/  
//	  \/								
// PHP-EGG v1 by kill-9 
// All others by Un-Thesis :o

/* Take the first step :-) */
$version = '3.0';

ini_set("html_errors", "0");

if ($debug >= 1) {
	print("\nStarting PHP-Egg version $version\n");
	print("web: http://sourceforge.net/projects/phpegg/\n");
}

$stderr = fopen("php://stderr", "w");

/* Load configuration file */
if (file_exists("config.inc")) {
	require_once("config.inc");
} else {
	fputs($stderr, "Fatal: No config.inc. Run setup.php now!\n");
	exit;
}

/* Check for prerequisites */
	if (!eregi("^4.",phpversion())) {
	    fputs($stderr, "Fatal: Sorry, you need php4 to run php-egg\n");
		exit;
	}

/* Corrects -- IMHO buggy -- flush() behavior of PHP 4.2+ */
	ob_end_flush();

/* Check the current configuration */
	if ($magic_word == "") {
		fputs($stderr, "Fatal: You must set \$magic_word in config.inc!\n");
		exit;
	}

	if ($database_name == "") {
		fputs($stderr, "Fatal: You must set the name of your PHP-Egg database in config.inc; rerun setup.php!\n");
		exit;
	}

	if ($irc_identd == "") {
	    fputs($stderr, "Fatal: You must set \$irc_identd in config.in; rerun setup.php!\n");
		exit;
	}
	if ($debug >= 2) {
		print("Configuration loaded...\n");
	}

/* Load and initialize my Common Database Interface */
	switch($database) {
		case "MySQL":
			require_once("cdi/mysql.inc");
			$db_ctrl = new MySQLInterface;
		break;
		case "PostgreSQL":
			if (!eregi("^4.2",phpversion())) {
				require_once("cdi/pgsql.inc");
			} else {
				require_once("cdi/pgsqlv2.inc");
			}
			$db_ctrl = new PostgreSQLInterface;
		break;
	}
	if ($debug >= 2) {
		print ("Database Control loaded...\n");
	}

/* Load essential libraries -- Needs to be re-implemented!! */
	require_once("login_check.inc");

/* Make the main database connection and check for errors */
	$db = $db_ctrl->pconnect($database_host,$database_login,$database_pass,$database_name);

	if ($db == "") {
	    fputs($stderr, "Fatal: $database connection failed! Make sure the database is running and accessible; rerun setup.php if necessary.\n");
	    exit;
	}

	if ($database == "MySQL") {
		$sql="select version()";
		$result=$db_ctrl->query($sql);
		$myrow=$db_ctrl->fetch_array($result);
		//if (!eregi("^3.23.",$myrow[0])) {
		//    fputs($stderr, "Fatal: MySQL must be version 3.23 or above to run php-egg!!\n");
		//    exit;
		//}
	}

	if (($foo = $db_ctrl->error()) != "") {
	    fputs($stderr, "Warning! Database Error occurred: $foo\n");
	}
	if ($debug >= 1) {
		print("$database connection established...\n");
	}

/*	
	Seeing if the owner has registered w/ bot yet, 
	if so, unsetting magic word 
*/
	$sql="select * from user";

	$result=$db_ctrl->query($sql,$db);
	if ($db_ctrl->num_rows($result) != 0) {
		if ($debug >= 2) {
			echo "Unsetting magic word users deteched \n";
		}
	    unset($magic_word);
	} else {
	    if ($debug >= 2) {
			echo "found no users leaving magic word \n";
		}
	}	

/* Clean up the database
/* Fixes problems if bot crashes before database is updated */
	/* Clean up the DCC table */
		$sql="delete from dcc_connections";
		@$db_ctrl->query($sql,$db);

	/* Clean up channel-related tables */
		$sql="update channels set in_chan='0'";
		$result=@$db_ctrl->query($sql,$db);

		$sql="update chan_users set reason='bot died' where reason is null";
		$result=@$db_ctrl->query($sql,$db);

		$sql="delete from bans";
		$result=@$db_ctrl->query($sql,$db);

/* Load IRC servers info */
	if ($server_group != "local") {
		$sql_servers="select server_name, port from server_groups sg, servers s where upper(server_group)=('$server_group') and sg.server_groups_id=s.server_group_id";
	    $result_servers=@$db_ctrl->query($sql_servers,$db);
	    while ($myrow=@$db_ctrl->fetch_array($result_servers)) {
			$irc_servers[]=$myrow["server_name"];
			$irc_server_ports[]=$myrow["port"];
	    }
	}
	if ($debug >= 1) {
	    echo "IRC Servers' Connection Info loaded: " . count($irc_servers) . "\n";
	}

/* Load and initialize my Module Control Interface */
	include("mod_ctrl.inc");
	$mod_ctrl = new module_control;
	if ($debug >= 1) {
		$mod_ctrl->set_debug($debug);
	}
	$mod_ctrl->load_all();

/* Initialize global variables */
	global $db_ctrl,$dcc_connections,$uptime;

	$dcc_connections="";
	$uptime=time();

/* Connec to IRC :-)) */
	include("connect.inc");
	irc_connect();
?>
