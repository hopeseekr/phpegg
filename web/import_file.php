<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");
include("table.inc.php");

if ($tclfile)
	{
	
	copy($tclfile,"tclfiles/userfile.user");
	
	include("import_user.php");
	
	
	
	}

echo "<form ENCTYPE=multipart/form-data action=import_file.php method=post>";
$str=create_table_top("500", "green", "TCL userfile import" );
	echo $str;
echo "<tr><td>import file<br>
<input type=file name=tclfile>
</td></td>";	
	
echo "<tr><td><input type=submit name=submit value=\"Import file\"><input type=hidden name=login_id value=$login_id>
</td></tr>";		
/*echo "<tr><td>WARNING IMPORTING A USER FILE WILL DELETE ALL OF THE USERS CURNTLY IN THE SYSTEM.</td></tr>";	
echo "<tr><td>NOTE: we will be fixing this in the next version.</td></tr>";	*/
$str=create_table_bottom();
  	echo $str;
	echo "</form>";
?>	

</body></html>