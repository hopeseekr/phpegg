<html>
<head>
<title>PHP-Egg</title>
</head>
<body bgcolor="ffffff">
<?php

include("table.inc.php");
if (!$login && !$password) {
    print("<form action=\"$PHP_SELF\" method=\"post\">\n");
    $str=create_table_top(300, "green","PHP-Egg Login");

    print("$str\n".
    "Login<br>\n".
    "<input type=\"text\" name=\"login\"><br>\n".
    "Password<br>\n".
    "<input type=\"password\" name=\"password\"><br>\n".
    "<input type=\"submit\" name=\"login_button\" value=\"Login\">\n");
	
    $str=create_table_bottom();

    print("$str\n".
    "</form>\n");
    
} else {
    include("database.inc.php");
	
    $sql="select * from user where user='$login' and mysql_password=password('$password')";
    
    $result=$db_ctrl->query($sql,$db);
    if ($db_ctrl->num_rows($result)==0) {
		
		$user=$myrow["user"];
		$pass=$myrow["mysql_password"];
		if (!$pass) {
			include_once("bf_lib.php");
			$pass=bf_encrypt_pass($password);
			$sql="select * from user where user='$login' and password='$pass'";
		
			$result=@$db_ctrl->query($sql,$db);	
			if ($db_ctrl->num_rows($result)!=0) {	
				$sql_update="update user set mysql_password=password('$password') where user='$login'";
				$result_update=@$db_ctrl->query($sql_update,$db);
				
				$login_time=time();
				include_once("common.inc.php");
				
				$result=@$db_ctrl->query($sql,$db);	
				$sql="insert into web_login (user,login_time) values ('$login','$login_time')";
				$result=@$db_ctrl->query($sql,$db);	
				$result_login=@$db_ctrl->query($sql,$db);	
				if ($result_login) {
					$login_id=$db_ctrl->get_last_id($result,$db);
					$login_id=crypt_login($db,$login_id,$login_time);
					print "LOGIN=$login_id";
				}
				
			}
		}
		include("menu.inc.php");
    } else {
		$login_time=time();
		include_once("common.inc.php");
	
		$sql="delete from web_login where user='$login'";
		$result=@$db_ctrl->query($sql,$db);
		$sql="insert into web_login (user,login_time) values ('$login','$login_time')";

		$result_login=@$db_ctrl->query($sql,$db);	
		if ($result_login) {
			$login_id=$db_ctrl->get_last_id($result_login,$db);
			
			$login_id=crypt_login($db,$login_id,$login_time);

			include("menu.inc.php");
		}
    }
}	

?>

</body>
</html>