<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");

if ($new=="create")
	{
	
	
	
	$sql="insert into modules ( module_binds_id,module_name,module_desc,module_file_name  )  values ( $module_binds_id,'$module_name','$module_desc','$module_file_name')";
				
		
	if ($sql)
		{	
		$result=$db_ctrl->query($sql,$db);
		if (!$result)
			{
			$msg.= "Mysql error: ".$db_ctrl->error($db)."<br>";
			}
		else
			{
			$msg.="modules inserted<br>";
			
			}
		}
	}
if ($update=="update")	
	{

	
			
	$sql="update modules set module_binds_id =  $module_binds_id,module_name = '$module_name',module_desc = '$module_desc',module_file_name = '$module_file_name'  where modules_id = $modules_id ";
		
	
	
	if ($sql)
		{	
		$result=$db_ctrl->query($sql,$db);
		if (!$result)
			{
			$msg.="Mysql error: ".$db_ctrl->error($db)."<br>";
			}
		else
			{
			$msg.="{$title} updated<br>";
			
			}
		}
	}
if (($delete=="delete") && $modules_id)	
	{
	
	$sql="delete from modules where modules_id = $modules_id";
	$result=$db_ctrl->query($sql,$db);
	if (!$result)
		{
		$msg.= "Mysql error: ".$db_ctrl->error($db)."<br>";
		}
	else
		{
		$msg.="modules deleted<br>";
		
		}
	unset($modules_id);
	}
	
	
	
include("table.inc.php");
//  create new news 

if (!$modules_id)
	{
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(300, "green","create modules");
	echo $str;
	
	


	echo "<form action=modules.php method=post  >";
	echo "<table width=100%>";
	
	





$select_module_binds_id="select * from module_binds";  

			$result_select=@$db_ctrl->query($select_module_binds_id,$db);
			echo "<select name=module_binds_id >  ";
			while ($myrow=$db_ctrl->fetch_array($result_select))
				{
				$module_binds_id=$myrow[0];
				$temp=$myrow[1];
				echo "<option value=$module_binds_id>$temp</option>   ";

				}
			echo "</select>";
				echo " module_name <br> 
			<input type=text name=module_name><br> "; 
                         echo " module_desc <br> 
			<input type=text name=module_desc><br> "; 
                         echo " module_file_name <br> 
			<input type=text name=module_file_name><br> "; 
                         




	echo "<tr><td><input type=hidden name=login_id value=$login_id><input type=submit name=new value=create>
	<input type=reset name=reset value=reset></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;

	}
else
	{
	// update existing news.
	$sql="select * from modules where modules_id=$modules_id ";
	$result=@$db_ctrl->query($sql,$db);
	$myrow=@$db_ctrl->fetch_array($result);
$module_binds_id=$myrow["module_binds_id"]; 
$module_name=$myrow["module_name"]; 
$module_desc=$myrow["module_desc"]; 
$module_file_name=$myrow["module_file_name"]; 
$modules_id=$myrow["modules_id"]; 
	echo "
	<table width=100%>
	<tr><td VALIGN=top>";
	
	$str=create_table_top(400, "green","Update modules");
	echo $str;
	echo "<form  action=modules.php method=post  >";
	echo "<table width=100%>";
	
$select_module_binds_id="select * from module_binds";  

			$result_select=@$db_ctrl->query($select_module_binds_id,$db);
			echo "<select name=module_binds_id >  ";
			while ($myrow2=$db_ctrl->fetch_array($result_select))
				{
				$new_module_binds_id=$myrow2[0];
				$temp=$myrow2[1];
				
				if ($new_module_binds_id==$module_binds_id)
					{
					$checked=" selected ";

					}
				else
					{
					unset($checked);

					}

				echo "<option value=$new_module_binds_id $checked > $temp</option>   ";

				}
			echo "</select>";
				echo " module_name <br> 
			<input type=text name=module_name value='$module_name'><br> "; 
                         echo " module_desc <br> 
			<input type=text name=module_desc value='$module_desc'><br> "; 
                         echo " module_file_name <br> 
			<input type=text name=module_file_name value='$module_file_name'><br> "; 
                         	echo "<input type=hidden name=login_id value=$login_id>
	<input type=hidden name=modules_id value=$modules_id>
	<input type=submit name=update value=update>
	<input type=reset name=reset value=new onclick=\"javascript:document.location.href='modules.php?login_id=$login_id'\"></td></tr>";
	
	
	
	
	
	
	echo "</table>";
	echo "</form>";
	$str=create_table_bottom();
	echo $str;
	
	
	}	






echo "
</td><td VALIGN=top>";  

// show curent news in the system 

$str=create_table_top(300, "green","modules");
echo $str;
echo "<form acton=modules.php method=post>";
echo "<table width=100%>";

$sql="select module_name, modules_id , bind  from modules m , module_binds b where m.module_binds_id=b.module_binds_id";
$result=@$db_ctrl->query($sql,$db);
while ($myrow=$db_ctrl->fetch_array($result))
	{

$module_binds_id=$myrow["module_binds_id"]; 
$bind=$myrow["bind"];
$module_name=$myrow["module_name"]; 
$module_desc=$myrow["module_desc"]; 
$module_file_name=$myrow["module_file_name"]; 
$modules_id=$myrow["modules_id"]; 
	
	
	echo "<tr><td><input type=radio name=modules_id value=$modules_id></td><td><a href=modules.php?modules_id=$modules_id&login_id=$login_id>$module_name - $bind</a></td></tr>";
	
	
	}

echo "<tr><td><input type=hidden name=login_id value=$login_id><input type=submit name=delete value=delete></td></tr>";
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