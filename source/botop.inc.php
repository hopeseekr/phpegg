

	


$sql="select distinct c.chan_name from channels c , chan_users cu  where active='Y' and in_chan='Y' and c.chan_name=cu.chan_name and cu.nick='php_egg' and reason is null and cu.mode='o'";
$result=@mysql_query($sql,$db);
echo "the first sql is".$sql."\n";
while($myrow=@mysql_fetch_array($result))
	{
	$chan_name=$myrow[0];
	
	$sql_users="select nick, ident, host_mask from chan_users cu , user where reason is null and cu.chan_name='$chan_name' and cu.mode!='o' and cu.nick=user.user and user.o='Y' and user.b='Y';
";

$result_users=@mysql_query($sql_users,$db);
	while($myrow=@mysql_fetch_array($result_users))
		{
		$nick=$myrow["nick"];
		$ident=$myrow["ident"];
		$host=$myrow["host_mask"];
		
		if ($ident && $host)
			{
			$host_mask=$ident."@".$host;
			
			$sql_ident="select user.user from user_host uh, user  where user.user='$nick' and '$host_mask' like replace(replace(mask,'*!',''),'*','%')  and uh.user=user.user  and user.o='Y' and user.b='Y' limit 1";
$result_ident=@mysql_query($sql_ident,$db);
echo $sql_ident."\n";
			if (mysql_num_rows($result_ident)!=0)
				{
	
			if ($debug==1)
				{
				echo php_egg MODE $chan_name +o $nick ";	
				}
	
				}
			
			
			
		}
		
	}
}

