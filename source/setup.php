#!/usr/local/bin/php -q
<?php

/* Take the first step :-) */
$version = '3.0';
print "Welcome to PHP-Egg v$version Easy Setup\n\n";
ob_end_flush();
// OS CHECK


// PHP VERSION CHECK
if (!eregi("^4.",phpversion())) {
	print("\nSorry, you need php4 to run php-egg\n");
	exit;
} else {
	print("PHP version... OK (".phpversion().")\n");
	ob_end_flush();
}

// OPEN /dev/stdin
$fp=fopen("php://stdin","r");
if ($fp=="") {
	print("Error: could not open php://stdin\n");
	exit;
}

print("DATABASE SETUP:\n");

while ((trim($database) != "MySQL") and (trim($database) != "PostgreSQL")) {
	print "Database (MySQL or PostgreSQL) [MySQL]: ";
	$database = trim(fgets($fp,1024));
	if ($database == "") {
		$database = "MySQL";
	}
}

print("Database host [localhost]: ");
$database_host=trim(fgets($fp,1024));
if ($database_host=="") {
	$database_host="localhost";
}

while (strlen(trim($database_login))==0) {
	print("Database login username: ");
	$database_login=trim(fgets($fp,1024));
}
while ((strlen(trim($database_pass))==0) and (trim($sure)!="yes")){
	print("Database login password: ");
	$database_pass=trim(fgets($fp,1024));
	if (strlen(trim($database_pass))==0) {
		print "Not having a password is unsafe.\n  Are you sure you do not want a password? (yes/no) ";
		$sure=fgets($fp,1024);
	}
}
while (strlen(trim($database_name))==0) {
	print("Database name: ");
	$database_name=trim(fgets($fp,1024));
}
// Check mysql connection
if ($database == "MySQL") {
	$db=@mysql_connect($database_host,$database_login,$database_pass);
	if ($db=="") {
		print("Error: MySQL connection failed\n");
		exit;
	}
	print("Mysql connection... OK\n");

	$sql="select version()";
	$result=mysql_query($sql,$db);
	$myrow=mysql_fetch_array($result);
	/*if ((!eregi("^3.23.",$myrow[0])) || (!eregi()) {
		print("\nSorry, you need mysql version 3.23 to run php-egg\n");
		exit;
	} else {*/
		print("MySQL version... OK (".$myrow[0].")\n");
	//}

	@mysql_select_db($database_name,$db);

	if (($foo=mysql_error())!="") {
		// Unknown database
		// if user==root, then try to create a new database
		if ($database_login=="root") {
			// try to create the database
			$sql="create database $database_name";
			$result=mysql_query($sql,$db);
			if ($result) {
				print("New database created...\n");
				@mysql_select_db($database_name,$db);
			} else {
				print("Error: could not create new database...\n");
				exit;
			}
		} else { // else just report the error
			print("Error: $foo\n");
			exit;
		}
	}

	// try to locate mysql
	// and insert sql dump into $database_name

	$found=1;
	$mysql_location="";
	exec("mysql -V",$output);
	for ($i=0;$i!=count($output);$i++) {
		if (strstr($output,"command not found")) {
			$found=0;
		}
	}
	if ($found==1) {
		$mysql_location="mysql";
	}
	if ($found==0) {
		if (file_exists("/usr/local/bin/mysql")) {
			$found=1;
			$mysql_location="/usr/local/bin/mysql";
		}
	}
	if ($found==0) {
		while (!file_exists($mysql_location)) {
			print("mysql location: ");
			$mysql_location=fgets($fp,1024);
		}
	}
	// check if I can find the mysql dump
	$sql_dump=fopen("../php_egg.mysql","r");
	if ($sql_dump=="") {
		print("Error: could not find sql dump...\n");
		exit;
	}

	// check for old installation
	$sql="select * from servers";
	$result=mysql_query($sql,$db);

	if ($result && mysql_num_rows($result)>0) {
		// got bot sql dump
		$yesno="a";
		while ($yesno!="" && $yesno!="no" && $yesno!="yes") {
			print("You got some tables in your database, do you want to overwrite them? (yes): ");
			$yesno=strtolower(trim(fgets($fp,1024)));
		}
		if ($yesno=="" || $yesno=="yes") {
			// drop old tabels
			print("Dropping old tables...");
			while ($buffer=fgets($sql_dump,1024)) {
				if (eregi("^CREATE TABLE",$buffer)) {
					$foo=explode(" ",$buffer);
					$sql="drop table $foo[2]";
					@mysql_query($sql,$db);
				}
			}
			print(" OK\n");
		}
	} else {
		$yesno="yes";
	}
	fclose($sql_dump);

	if ($yesno=="" || $yesno=="yes") {
		if ($database_pass != "") {
			$passphrase = " -p$database_pass";
		}
		// run sql dump
		print("Inserting sql dump...");
		$exec="$mysql_location -u $database_login -h $database_host$passphrase $database_name < ../php_egg.mysql";
		exec($exec,$output);
		for ($i=0;$i!=count($output);$i++) {
			if (strstr($output[$i],"ERROR")) {
				print(" ERROR\n");
				exit;
			}
		}
		print(" OK\n");
	}
} elseif ($database == "PostgreSQL") {
	print "Please note: Auto-setup support for PostgreSQL is extreme alpha right now.\nI'm merely hax0ring gryph's script here!\n\nSo, if this script doesn't do what it's supposed to, blame me; then manually\nedit your config.inc in the source dir and file a bug report on sourceforge.

You can consider yourself 'successful' if the screen fills with a bunch of stuff.
If you merely get to error messages, then you'll have to edit the config.php

	Thanks!
	Un-Thesis
		
Do you want to *attempt* to auto-set up the database? (yes/no) ";
	while ((trim($response)!="no") and (trim($response)!="yes")){
		$response=fgets($fp,1024);
	}
	if ($response == "yes") {
		print "executing -> su $database_login -c \"psql -c 'create database $database_name'\"\n";
		`su $database_login -c "psql -c 'create database $database_name'"`;
		print "executing -> su $database_login -c 'psql $database_name < ../php_egg.pgsql'\n";
		`su $database_login -c 'psql $database_name < ../php_egg.pgsql'`;
	} else {
		print "Try running these commands later:\nsu $database_login -c \"psql -c 'create database $database_name'\"\nsu $database_login -c 'psql $database_name < ../php_egg.pgsql'\n";
	}
}
/* We should have enough info at this point to load db_ctrl! woohoo! */
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
	print ("Database Control loaded...\n");

$db=$db_ctrl->connect($database_host,$database_login,$database_pass,$database_name);
if ($db=="") {
	print("Error: $database connection failed...get the database running and try again\n");
	exit;
}
print("$database connection... OK\n");

print("IRC SETUP:\n");
while (strlen($irc_nick)==0) {
	print("Nick: ");
	$irc_nick=trim(fgets($fp,1024));
}
while (strlen($irc_alt_nick)==0) {
	print("Alt nick: ");
	$irc_alt_nick=trim(fgets($fp,1024));
	if ($irc_alt_nick==$irc_nick) {
	print("Error: you need to write a nick diffrent from nick\n");
	$irc_alt_nick="";
	}
}
while (strlen($irc_identd)==0) {
	print("Ident: ");
	$irc_identd=trim(fgets($fp,1024));
}
while (strlen($irc_real_name)==0) {
	print("Real name: ");
	$irc_real_name=trim(fgets($fp,1024));
}

// server
$sql="select * from server_groups where server_groups_id<12";
$result=$db_ctrl->query($sql,$db);
if ($result && $db_ctrl->num_rows($result)>0) {
	// servers found
	while ($myrow=$db_ctrl->fetch_array($result)) {
	print("$myrow[server_groups_id]: $myrow[server_group]\n");
	}
	print("12: other\n");
	print("13: user defined\n");
	
	while (strlen(trim($server_group))==0 || $server_group<=0 || $server_group>13) {
	print("Server: ");
	$server_group=fgets($fp,1024);
	}
	if ($server_group==12) { // other
	// get total count
	$sql="select * from server_groups where server_groups_id";
	$result=$db_ctrl->query($sql,$db);
	$total_count=$db_ctrl->num_rows($result);
	$offset=12;
	$server_group="";
	while (strlen(trim($server_group))==0 && $offset>-1 || $server_group<=0 || $server_group>$total_count) {
		$sql="select * from server_groups order by server_groups_id limit $offset,20";
		$result=$db_ctrl->query($sql,$db);
		while ($myrow=$db_ctrl->fetch_array($result)) {
		print("$myrow[server_groups_id]: $myrow[server_group]\n");
		}
		
		print("Server (next): ");
		$server_group=fgets($fp,1024);
		if (strlen(trim($server_group))==0) {
		$offset=$offset+20;
		}
		if ($offset>$total_count) {
		$offset=0;
		}
		// set offset to -1 when selected a server_group
	}
	$sql="select server_group from server_groups where server_groups_id=\"$server_group\"";
	$result=$db_ctrl->query($sql,$db);
	if ($result && $db_ctrl->num_rows($result)>0) {
		$myrow=$db_ctrl->fetch_array($result);
		$server_group=$myrow[server_group];
	} else {
		print("Error: server not found\n");
		exit;
	}
	} elseif ($server_group==13) { // user defined 
	while (strlen($irc_servers[0])==0) {
		print("Host/IP: ");
		$irc_servers[0]=trim(fgets($fp,1024));
	}
	while (strlen($irc_server_ports[0])==0) {
		print("Port: ");
		$irc_server_ports[0]=trim(fgets($fp,1024));
		if ($irc_server_ports[0]<1) {
		$irc_server_ports[0]="";
		}
		if ($irc_server_ports[0]>pow(2,16)) {
		$irc_server_ports[0]="";
		}
	}
	$server_group="local";	
	} else { // 1-11
	$sql="select server_group from server_groups where server_groups_id=\"$server_group\"";
	$result=$db_ctrl->query($sql,$db);
	if ($result && $db_ctrl->num_rows($result)>0) {
		$myrow=$db_ctrl->fetch_array($result);
		$server_group=$myrow[server_group];
	} else {
		print("Error: server not found\n");
		exit;
	}
	}
	print("Selected server: $server_group\n");
} else {
	// no servers found
	print("Error: no servers found in database\n");
	exit;
}

print("BOT SETUP:\n");
// admin_email

	print("Admin email (asdf@asdf.net): ");
	$admin_email=trim(fgets($fp,1024));
	if (!eregi("^([[:alnum:]_%+=.-]+)@([[:alnum:]_.-]+)\.([a-z]{2,3}|[0-9]{1,3})$",$admin_email)) {
	$admin_email="";
}
// magic word
print("Magic word (HELLO!): ");
$magic_word=trim(fgets($fp,1024));
if (trim($magic_word)=="") {
	$magic_word="HELLO!";
}
// quit msg
while (strlen(trim($quit_message))==0) {
	print("Quit message: ");
	$quit_message=trim(fgets($fp,1024));
}
print("ADVANCED SETUP:\n");
// debug
$debug = 4;
while ($debug == 4) {
	print("Debug Level (0/None - 3/Full): ");
	$debug=trim(fgets($fp,1024));
}
fclose($fp);
print("Setup done... writing config.inc\n");

$fp=fopen("config.inc","w");
if ($fp=="") {
	print("Error: could not open config.inc\n");
	exit;
}
fputs($fp,"<?php\n");
// bot
fputs($fp,"\$magic_word=\"$magic_word\";\n");
fputs($fp,"\$admin_email=\"$admin_email\";\n");
// database
fputs($fp,"\$database=\"MySQL\";\n");
fputs($fp,"\$database_host=\"$database_host\";\n");
fputs($fp,"\$database_login=\"$database_login\";\n");
fputs($fp,"\$database_pass=\"$database_pass\";\n");
fputs($fp,"\$database_name=\"$database_name\";\n");
// irc
fputs($fp,"\$irc_nick=\"$irc_nick\";\n");
fputs($fp,"\$irc_alt_nick=\"$irc_alt_nick\";\n");
fputs($fp,"\$irc_identd=\"$irc_identd\";\n");
fputs($fp,"\$irc_real_name=\"$irc_real_name\";\n");
fputs($fp,"\$quit_message=\"$quit_message\";\n");
// servers
if ($server_group=="local") {
	fputs($fp,"\$server_group=\"$server_group\";\n");
	fputs($fp,"\$irc_servers[0]=\"".$irc_servers[0]."\";\n");
	fputs($fp,"\$irc_server_ports[0]=\"".$irc_server_ports[0]."\";\n");
} else {
	fputs($fp,"\$server_group=\"$server_group\";\n");
}
// debug
fputs($fp,"\$debug=\"$debug\";\n");
fputs($fp,"?>\n");
fclose($fp);

?>
