<html>
<body bgcolor=ffffff>
<?php
include("menu.inc.php");
include("table.inc.php");
include("database.inc.php");	
$user=rawurldecode($user);
if ($add)
	{
	
	echo "$user";
	if ($x)
		{
	
		$x="Y";
	
	
		}
		else
		{
	
		$x="N";
	
	
		}	
	if ($t)
	{
	
		$t="Y";
	
	
		}
		else
		{
	
		$t="N";
	
	
		}	
if ($j)
	{
	
		$j="Y";
	
	
		}
		else
		{
	
		$j="N";
	
	
		}	
if ($h)
	{
	
		$h="Y";
	
	
		}
		else
		{
	
		$h="N";
	
	
		}	
if ($b)
	{
	
	$b="Y";
	
	$sql_bot="insert into user_bot (user) values ('$user')";
	
	$result=@mysql_query($sql_bot,$db);	
	if ($password)
		{
		$tcl_password="'$password'";
		$mysql_password="'$password'";
		
		
		}
	else
		{
		
		$tcl_password="NULL";
		$mysql_password="NULL";
		
		}
	
	}
else
	{
	
	$b="N";
	if ($password)
		{
		include_once("bf_lib.php");
		$pass=bf_encrypt_pass($password);
	
		$tcl_password="'$pass'";
		$mysql_password="password('$password')";
	
		}
	else
		{
		
		$tcl_password="NULL";
		$mysql_password="NULL";
		
		}	
	
	}	
if ($p)
	{
	
	$p="Y";
	
		
		
		
	
	
	}
else
	{
	
	$p="N";
	
	
	
	
	}	
if ($f)
	{
	
	$f="Y";
	
	
	}
else
	{
	
	$f="N";
	
	
	}	
if ($n)
	{
	
	$n="Y";
	
	
	}
else
	{
	
	$n="N";
	
	
	}	
if ($m)
	{
	
	$m="Y";
	
	
	}
else
	{
	
	$m="N";
	
	
	}	
if ($o)
	{
	
	$o="Y";
	
	
	}
else
	{
	
	$o="N";
	
	
	}	
if ($v)
	{
	
	$v="Y";
	
	}
else
	{
	
	$v="Y";
	
	
	}	
$now=time();	
$sql="insert into user (user,v,o,m,n,f,p,b,h,j,t,x,created,password,mysql_password) values ( 	
	'$user','$v','$o','$m','$n','$f','$p','$b','$h','$j','$t','$x',$now,$tcl_password,$mysql_password)";
$result=@mysql_query($sql,$db);	
	
	if ($add_chan)
		{
		
		$v="add_v";
		$o="add_o";
		$m="add_m";
		$f="add_f";
		if ($$v)
			{
			
			$v="Y";
			
			}
		else
			{
			
			$v="N";
			}
		if ($$f)
			{
			
			$f="Y";
			
			}
		else
			{
			
			$f="N";
			}	
		if ($$o)
			{
			
			$o="Y";
			
			}
		else
			{
			
			$o="N";
			}
		if ($$m)
			{
			$m="Y";
			
			}
		else
			{
			
			$m="N";
			}
			
			
			
			$sql="insert user_chan (user,chan,v,f,o,m) values ('$user','$add_chan','$v','$f','$o','$m')";
			
		
		$result=@mysql_query($sql,$db);	
		
		
		
			}	
	if ($add_host)
		{
		$sql="insert into user_host (user,mask) values ('$user','$add_host')";
		
		$result=@mysql_query($sql,$db);	
		}		
			
			
	}


echo "<a href=import_file.php?login_id=$login_id>import tcl userfile </a>";
	echo "<form action=add_user.php method=post>";
	
	
	
	
	$str=create_table_top("500", "green", "EGG USER " );
	echo $str;
	echo "<tr><td colspan=12>
	User:<br>
	<input type=text name=user value='$user'>
	</td></tr>";
	
	
	
	echo "<tr><td colspan=12>
	Change Password:<br>
	<input type=password name=password size=30>
	</td></tr>";		
	
	
	echo "<td>Global Modes</td><td >
        v:<br>
        <input type=checkbox name=v value='Y' >
        </td><td >
        o:<br>
        <input type=checkbox name=o value='Y' >
        </td><td >
        m:<br>
        <input type=checkbox name=m value='Y' >
        </td><td >
        n:<br>
        <input type=checkbox name=n value='Y' >
        </td><td >
        f:<br>
        <input type=checkbox name=f value='Y' >
        </td><td >
        p:<br>
        <input type=checkbox name=p value='Y' >
        </td><td >
        b:<br>
        <input type=checkbox name=b value='Y' >
        </td><td >
        h:<br>
        <input type=checkbox name=h value='Y' >
        </td><td >
        j:<br>
        <input type=checkbox name=j value='Y' >
        </td><td >
        t:<br>
        <input type=checkbox name=t value='Y' >
        </td><td >
        x:<br>
        <input type=checkbox name=x value='Y' >
</td></tr>";
	
			

		
		

	echo "</tr>";
	
	echo "<tr><td colspan=12>Channels</td></tr>";
	
	
  echo "<tr><td colspan=12>Add a chan</td></tr>";	
  $sql="select * from channels order by chan_name";
  $result=@mysql_query($sql,$db);
  echo "<tr><td colspan=1><select name=add_chan ><option value=0>add chan </option>";	
  while ($myrow=mysql_fetch_array($result))
  	{
  	$chan=$myrow["chan_name"];
  	
  	if ($chan=="#".$add_chan)
  		{
  		$selected =" selected";
  		}
  	else
  		{
  		unset($selected);
  		
  		}	
  	echo "<option value=$chan $selected>$chan </option>";
  
  	}
  	echo "</select></td>";
  	
  echo "<td>v <br>
  <input type=checkbox name=add_v value=Y></td>
   ";	
    echo "<td>f <br>
  <input type=checkbox name=add_f value=Y></td>
   ";	
    echo "<td>o <br>
  <input type=checkbox name=add_o value=Y></td>
   ";	
    echo "<td colspan=8>m <br>
  <input type=checkbox name=add_m value=Y></td>
   ";	
  echo "</tr>";		
  echo "<tr><td colspan=12>Host Masks</td></tr>";
 
 echo "<tr><td colspan=12>Add a host: <br><input type=text name=add_host value='$add_host' size=60></td></tr>";
	
	
	
	 echo "<tr><td colspan=12><input type=hidden name=login_id value=$login_id><input type=submit name=add value='Add User'></td>
	 
	
	 </tr>";	
	
	$str=create_table_bottom();
  	echo $str;
	echo "</form>";
	
	
?>	

</body></html>