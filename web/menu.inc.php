<?php

include_once("common.inc.php");
include_once("database.inc.php");
$user_id=decrypt_login($db,$login_id);

if ($user_id==0)
	{
	echo "<html>
		<meta http-equiv=\"Refresh\" content=\"0; url=../index.php\"></head>
   
		<body bgcolor=ffffff>";
		echo "Access denied";
	echo "</body></html>";
	exit;
	}
/*else
	{
	
	$user_id=decrypt_login($db,$login_id);
	
	$now=time();
	
	$sql="Update web_login set login_time='$now' where web_login_id=$user_id";
	
	$result=@mysql_query($sql,$db);
	
	
	$login_id=crypt_login($db,$user_id,$now);
	
	
	
	
	}	*/
	
	
	
$user_id=decrypt_login($db,$login_id);



$manager=check_nm($db,$user_id);

if ($manager==1)
	{
echo "Bot owner or manager detected <br>";	
echo "<table width=100%>
<tr>";	
echo "<td><a href=server_groups.php?login_id=$login_id>PHPEgg-server_groups</a></td>";
echo "<td><a href=servers.php?login_id=$login_id>PHPEgg-servers</a></td>";
echo "<td><a href=module_binds.php?login_id=$login_id>PHPEgg-module_binds</a></td>";
echo "<td><a href=modules.php?login_id=$login_id>PHPEgg-modules</a></td>";
echo "<td><a href=channels.php?login_id=$login_id>PHPEgg-Channels</a></td>";
echo "<td><a href=chan_spy.php?login_id=$login_id>PHPEgg-Channels spy</a></td>";
echo "<td><a href=users.php?login_id=$login_id>PHPEgg-users</a></td>";
echo "<td><a href=add_user.php?login_id=$login_id>PHPEgg-Add users</a></td>";
	echo "
</tr>
</table>";
	}
else
	{
	
	$chan_mo=check_chan_mo($db,$user_id);
	echo "<table width=100%>
	<tr>";
	echo "<td><a href=channels.php?login_id=$login_id>PHPEgg-Channels</a></td>";
	echo "<td><a href=chan_spy.php?login_id=$login_id>PHPEgg-Channels spy</a></td>";
	echo "<td><a href=users.php?login_id=$login_id>PHPEgg-users</a></td>";
	echo "<td><a href=add_user.php?login_id=$login_id>PHPEgg-Add users</a></td>";
	
	echo "
</tr>
</table>";
	
	
	
	
	
	
	}	
echo "
</tr>
</table>
<img src=gfx/eggbotico.gif>
<br><br><br>
";
?>