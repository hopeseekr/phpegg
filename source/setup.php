#!/usr/local/bin/php -q
<?php
// cool setup script - not done (gryph's job)

// todo: check if this works on bsd, sun, win?, irix etc. 

print("Welcome to php_egg version VERSION easy setup\n");

// OS CHECK
$ok=0;
if (PHP_OS=="Linux") {
    $ok=1;
}
if ($ok==0) {
    print("Sorry, this is only tested on Linux...\n");
    exit;
}

// PHP VERSION CHECK
if (!eregi("^4.",phpversion())) {
    print("\nSorry, you need php4 to run php-egg\n");
    exit;
} else {
    print("PHP version... OK - ".phpversion()."\n");
}

// OPEN /dev/stdin
$fp=fopen("/dev/stdin","r+");
if ($fp=="") {
    print("Error: could not open /dev/stdin\n");
    exit;
}

print("DATABASE SETUP:\n");

print("Host (localhost): ");
$database_host=trim(fgets($fp,1024));
if ($database_host=="") {
    $database_host="localhost";
}
while (strlen($database_login)==0 || ord($database_login[0])==10) {
    print("Login: ");
    $database_login=trim(fgets($fp,1024));
}
while (strlen($database_pass)==0 || ord($database_pass[0])==10) {
    print("Password: ");
    $database_pass=trim(fgets($fp,1024));
}
while (strlen($database_name)==0 || ord($database_name[0])==10) {
    print("Database name: ");
    $database_name=trim(fgets($fp,1024));
}
// Check mysql connection
$db=@mysql_connect($database_host,$database_login,$database_pass);
if ($db=="") {
    print("Error: MySQL connection failed\n");
    exit;
}
print("Mysql connection... OK\n");

$sql="select version()";
$result=mysql_query($sql,$db);
$myrow=mysql_fetch_array($result);
if (!eregi("^3.23.",$myrow[0])) {
    print("\nSorry, you need mysql version 3.23 to run php-egg\n");
    exit;
} else {
    print("MySQL version... OK - ".$myrow[0]."\n");
}

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
// GOT THIS FAR - gryph

// drop some tabels

$exec="$mysql_location -u $database_login -h $database_host -p$database_pass $database_name < ../php_egg.sql";

exec($exec);

exit;
print("IRC SETUP:\n");
while (strlen($irc_nick)==0 || ord($irc_nick[0])==10) {
    print("Nick: ");
    $irc_nick=fgets($fp,1024);
}
while (strlen($irc_alt_nick)==0 || ord($irc_alt_nick[0])==10) {
    print("Alt nick: ");
    $irc_alt_nick=fgets($fp,1024);
    if ($irc_alt_nick==$irc_nick) {
	print("Error: you need to write a nick diffrent from nick\n");
	$irc_alt_nick="";
    }
}
while (strlen($irc_identd)==0 || ord($irc_identd[0])==10) {
    print("Ident: ");
    $irc_identd=fgets($fp,1024);
}
while (strlen($irc_real_name)==0 || ord($irc_real_name[0])==10) {
    print("Real name: ");
    $irc_real_name=fgets($fp,1024);
}
// server

print("BOT SETUP:\n");
// admin
// magic word
// quit msg

print("ADVANCED SETUP:\n");
// debug

?>
