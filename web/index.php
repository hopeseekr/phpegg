<html>
<body bgcolor=ffffff>
<?php

include("table.inc.php");
if (!$login && !$password && !$undernet_login_id)
	{
	echo "
	<html>
	<body bgcolor=ffffff>";
	echo "<form action=index.php method=post>";
	$str=create_table_top(300, "green","PHP-Egg Login");
	echo $str;

	echo "Login <br>";
	echo "<input type=text name=login><br>";
	echo "Password <br>";
	echo "<input type=password name=password><br>";
	echo "<input type=submit name=login_button value=Login>";
	
	
	
	$str=create_table_bottom();
	echo $str;
	echo "</form>";
	}
else
	{
	include("database.inc.php");
	
	$sql="select * from user where user='$login' and mysql_password=password('$password') ";
	
	$result=@mysql_query($sql,$db);
	if (mysql_num_rows($result)==0)
		{
		$user=$myrow["user"];
		$pass=$myrow["mysql_password"];
		
		if (!$pass)
			{
			include_once("bf_lib.php");
			$pass=bf_encrypt_pass($password);
			
			$sql="select * from user where user='$login' and  password='$pass'";
		
			$result=@mysql_query($sql,$db);	
			if (mysql_num_rows($result)!=0)
				{	
				$sql_update="update user set mysql_password=password('$password') where user='$login'";
				$result_update=@mysql_query($sql_update,$db);
				
				$login_time=time();
				include_once("common.inc.php");
				
				$result=@mysql_query($sql,$db);	
				$sql="insert into web_login (user,login_time) values ('$login','$login_time')";
				$result=@mysql_query($sql,$db);	
				$result_login=@mysql_query($sql,$db);	
				if ($result_login)
					{
					$login_id=mysql_insert_id($db);
			
					$login_id=crypt_login($db,$login_id,$login_time);
					
					include("menu.inc.php");
					
					}
				
					
				}
			
			}
			}
		else
			{
			$login_time=time();
			include_once("common.inc.php");
			$sql="delete from web_login where user='$login'";
			$result=@mysql_query($sql,$db);
			$sql="insert into web_login (user,login_time) values ('$login','$login_time')";
			
			$result_login=@mysql_query($sql,$db);	
			if ($result_login)
				{
				$login_id=mysql_insert_id($db);
			
				$login_id=crypt_login($db,$login_id,$login_time);
				
				include("menu.inc.php");
				}
			}	
		
		
		
			
	
	
	
	
	
	}	



?>

</body>
</html>