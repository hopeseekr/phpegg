<?php

// edit host, login, pass here
$db=@mysql_connect("localhost","root","");

if ($db=="") {
    print("Error: database connection failed<br>\n");
    exit;
}

// edit your database name here
//mysql_select_db("eggdrop_cvs",$db);
mysql_select_db("eggdrop",$db);

if (($foo=mysql_error())!="") {
    print("$foo<br>\n");
    exit;
}

?>
