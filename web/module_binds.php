<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");
include("database.inc.php");

if ($new=="create")
	{
	
	
	
	$sql="insert into module_binds ( bind  )  values ( '$bind')";
				
		
	if ($sql)
		{	
		$result=mysql_query($sql,$db);
		if (!$result)
			{
			$msg.= "Mysql error: ".mysql_error($db)."<br>";
			}
		else
			{
			$msg.="module_binds inserted<br>";
			
			}
		}
	}
if ($update=="update")	
	{

	
			
			
	$sql="update module_binds set bind = '$bind'  where module_binds_id = $module_binds_id ";
		
	
	
	if ($sql)
		{	
		$result=mysql_query($sql,$db);
		if (!$result)
			{
			$msg.="Mysql error: ".mysql_error($db)."<br>";
			}
		else
			{
			$msg.="{$title} updated<br>";
			
			}
		}
	}
if (($delete=="delete") && $module_binds_id)	
	{
	
	$sql="delete from module_binds where module_binds_id = $module_binds_id";
	$result=mysql_query($sql,$db);
	if (!$result)
		{
		$msg.= "Mysql error: ".mysql_error($db)."<br>";
		}
	else
		{
		$msg.="module_binds deleted<br>";
		
		}
	unset($module_binds_id);
	}
	
	
	
include("table.inc.php");
//  create new news 

if (!$module_binds_id)
	{
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(300, "green","create module_binds");
	echo $str;
	
	


	echo "<form action=module_binds.php method=post  >";
	echo "<table width=100%>";
	
	





echo " bind <br> 
			<input type=text name=bind><br> "; 
                         




	echo "<tr><td><input type=hidden name=login_id values=$login_id><input type=submit name=new value=create>
	<input type=reset name=reset value=reset></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;

	}
else
	{
	// update existing news.
	$sql="select * from module_binds where module_binds_id=$module_binds_id ";
	$result=@mysql_query($sql,$db);
	$myrow=@mysql_fetch_array($result);
$bind=$myrow["bind"]; 
$module_binds_id=$myrow["module_binds_id"]; 
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(400, "green","Update module_binds");
	echo $str;
	echo "<form  action=module_binds.php method=post  >";
	echo "<table width=100%>";
	
echo " bind <br> 
			<input type=text name=bind value='$bind'><br> "; 
                         	echo "<input type=hidden name=login_id values=$login_id>
	<input type=hidden name=module_binds_id value=$module_binds_id>
	<input type=submit name=update value=update>
	<input type=reset name=reset value=new onclick=\"javascript:document.location.href='module_binds.php?login_id=$login_id'\"></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;
	
	
	}	






echo "
</td><td VALIGN=top>";  

// show curent news in the system 

$str=create_table_top(300, "green","module_binds");
echo $str;
echo "<form acton=module_binds.php method=post>";
echo "<table width=100%>";

$sql="select * from module_binds order by module_binds_id desc";
$result=@mysql_query($sql,$db);
while ($myrow=mysql_fetch_array($result))
	{

$bind=$myrow["bind"]; 
$module_binds_id=$myrow["module_binds_id"]; 
	
	
	echo "<tr><td><input type=radio name=module_binds_id value=$module_binds_id></td><td><a href=module_binds.php?module_binds_id=$module_binds_id&login_id=$login_id>$bind</a></td></tr>";
	
	
	}

echo "<tr><td><input type=hidden name=login_id values=$login_id><input type=submit name=delete value=delete></td></tr>";
echo "</table>";
echo "</form>";
$str=create_table_bottom();
echo $str;


	
if ($msg)
	{
	echo "<br><br><br>";
	
	$str=create_table_top(300, "red", "System Message");
	echo $str;
	echo $msg;
	$str=create_table_bottom();
	echo $str;
	
	
	
	
	
	}	
echo "</td></tr>";







echo "
</table>";




?>
</body>
</html>