<?php

function lastspoke_log($sender_ident,$sender_nick,$sender_host,$chan)
	{
	
	global $db_ctrl,$db;
	  	$now=date("YmdHis",time());
	    	//$sender_nick=addslashes($sender_nick);
	    	$sql="update chan_users set last_spoke='$now' , ident='$sender_ident' , host_mask='$sender_host' where nick='$sender_nick' and upper(chan_name)=upper('$chan') and reason is null";
	    	$result=@$db_ctrl->query($sql,$db);
	
	
	
	
	
	
	
	
	
	
	}

function notice_lastspoke($irc_connect,$sender_nick,$chan,$seen_nick)
	{
	global $db_ctrl,$db;
	$sql="select unix_timestamp(last_spoke) as last_spoke , chan_name from chan_users where nick='$seen_nick' and reason is null order by last_spoke desc limit 1";
	echo $sql."\n";
	$result=@$db_ctrl->query($sql,$db);
	if ($db_ctrl->num_rows($result)!=0)
		{
	
		$myrow=$db_ctrl->fetch_array($result);
		$lastspoke=$myrow["last_spoke"];
		$chan_name=$myrow["chan_name"];
		$now=date("l F j S, Y, H:i ",$lastspoke);
		if ($lastspoke!=0)
			{
		fputs($irc_connect, ":$my_nick PRIVMSG $chan :$seen_nick last spoke in $chan_name $now  \n");
			}
		else
			{
			fputs($irc_connect, ":$my_nick PRIVMSG $chan :$seen_nick  hasnt spoken since i have been here. \n");
			
			}	
		}
	else
		{
		
		fputs($irc_connect, ":$my_nick PRIVMSG $chan :$seen_nick isnt curntly in any of the channels i montor  \n");
		
		
		}	
	
	}



function update_seen_data($irc_connect,$chan_user,$chan,$mode)
	{
	global $db_ctrl,$db;
	
	
		// insert user
		
		$sql_insert="insert into chan_users (chan_name,nick,mode) values ('$chan','$chan_user','$mode')";
		$result_insert=$db_ctrl->query($sql_insert,$db);
		if (!$result_insert)
			{
			print "update seen data error inserting $sql_insert \n";					print $db_ctrl->error($db);
			
			}
	
	
	
	}

function notice_seen($irc_connect,$sender_nick,$chan,$seen_nick)
	{
	
	global $db_ctrl,$db;
	
	$seen_nick=addslashes($seen_nick);
	if (strtoupper($sender_nick)==strtoupper($seen_nick))
		{
		$msg="arnt you here now? ";
		
		
		}
	else 
		{	
		$sql= "select reason,chan_name,ident,host_mask,  sec_to_time(unix_timestamp(now()) - unix_timestamp(date)) as date from chan_users where upper(nick)=upper('$seen_nick') order by date desc";
		
		
		$result=$db_ctrl->query($sql,$db);
		$i=0;
		while ($myrow=$db_ctrl->fetch_array($result))
			{
			$date[$i]=$myrow["date"];
			$reason[$i]=$myrow["reason"];
			$chan_name[$i]=$myrow["chan_name"];
			$host_mask[$i]=$myrow["host_mask"];
			$ident[$i]=$myrow["ident"];
			$i++;
			}
		
		if ($db_ctrl->num_rows($result)>1)
			{
			for ($i=0;$i<count($chan_name);$i++)
				{
				
				if (!$reason[$i] && ($chan_name[$i]==$chan))
					{
					$msg="$seen_nick is here \n";
					
					}
				}
			if (!$msg)
				{
				
				for ($i=0;$i<count($chan_name);$i++)
					{
					
					if (!$reason[$i])
						{
						$in_chans[]=$chan_name[$i];
						
						}
					}
				if ($in_chans && is_array($in_chans))
					{
					
					$msg="$seen_nick is in ".implode(",",$in_chans)."\n";
					
					}
				//else
				//	{
					
				//	$msg="$seen_nick is in $in_chan \n";
					
				//	}	
				}
			if (!$msg)
				{
				$date_array=explode(":",$date[0]);
				
				if ($date_array[0]>24)
					{
					
					$days=number_format($date_array[0]/24,0);
					$hours= (24*$days) -$date_array[0];
					$minutes=$date_array[1];
					$date_display=" $days days $hours hours and $minutes minutes ago";
					}
				else if ($date_array[0]!="00")
					{
					
					$date_display=number_format($date_array[0],0)." hours and ".number_format($date_array[1],0)." minutes ago";
					
					}	
				else
					{
					if ($date_array[1]!="00")
						{
						$date_display=number_format($date_array[1],0)." minutes ago";
						}
					else
						{
						$date_display=" Less then a minute ago";
						
						}	
					
					}	
				
				$msg="I found ".$db_ctrl->num_rows($result)." matches to your query. Here is the most recent: $seen_nick  ($ident[0]@$host_mask[0]) was last seen quitting from $chan_name[0] $date_display stating ($reason[0])";
				
				}		
				
					
			}
		else if ($db_ctrl->num_rows($result)==0)
			{
			
			$msg ="I dont know $seen_nick ";
			}	
		else
			{
			
			if ($reason[0])
				{
				$date_array=explode(":",$date[0]);
				if ($date_array[0]>24)
					{
						
					$days=number_fromat($date_array[0]/24,0);
					$hours= (24*$days) -$date_array[0];
					$minutes=$date_array[1];
					$date_display=" $days days $hours hours and $minutes minutes ago";
					}
				else
					{
					if ($date_array[0]!="00")
						{	
					$date_display="$date_array[0] hours and $date_array[1] minutes ago";
						}
					else
						{
						if ($date_array[1]!="00")
						{
						$date_display=number_format($date_array[1],0)." minutes ago";
						}
					else
						{
						$date_display=" Less then a minute ago";
						
						}
						}	
					}
				
				$msg="I found 1 match to your query. Here it is: $seen_nick  ($ident[0]@$host_mask[0]) was last seen quitting from $chan_name[0] $date_display stating ($reason[0])";
				}
			else
				{
				/*BUG HERE NOT KECTCHING THE IS HERE */
				if (strtoupper($chan_name[0])==trim(strtoupper($chan)))
					{
					$msg="$seen_nick is right here ";
					}
				else
					{	
					$msg="$seen_nick is in $chan_name[0] $chan";
					}
				}	
			
			}	
		}
	fputs($irc_connect, "NOTICE $sender_nick :$msg \n");
			
	
			
	}	
	
function update_seen_data_quit($irc_connect,$who,$quit_message)
	{
	global $db_ctrl,$db;
	if (trim($quit_message)=="")
		{
		
		$quit_message="QUIT IRC";
		}
	$sender_info=clean_nick($who);
	$sender_nick=$sender_info[0];
	$sender_ident=$sender_info[1];
	$sender_host=$sender_info[2];
	
	
	
	$sql="update chan_users set reason='$quit_message' , ident='$sender_ident' , host_mask='$sender_host' where  nick='$sender_nick' ";
	
	
	$result=$db_ctrl->query($sql,$db);
	if (!$result)
		{
		
		print "Error updating reason \n $sql \n";
		
		}
	//print "$sender_nick quit irc stating $quit_message \n";
	
	}
function update_seen_data_part($irc_connect,$who,$chan)
	{
	global $db_ctrl,$db;
	$sender_info=clean_nick($who);
	$sender_nick=$sender_info[0];
	$sender_ident=$sender_info[1];
	$sender_host=$sender_info[2];
	
	
	
	
	$sql="update chan_users set reason='Left $chan' , ident='$sender_ident' , host_mask='$sender_host' where  nick='$sender_nick' and chan_name='$chan'";
	
	$result=$db_ctrl->query($sql,$db);
	if (!$result)
		{
		
		print "Error updating reason \n $sql \n";
		
		}
	//print "$sender_nick left $chan_left stating $quit_message \n";
	
	}
function update_seen_data_join($irc_connect,$who,$chan,$mode="u")
	{
	global $db_ctrl,$db;
	$sender_info=clean_nick($who);
	$sender_nick=$sender_info[0];
	$sender_ident=$sender_info[1];
	$sender_host=$sender_info[2];
	
	
	
	$sql_insert="insert into chan_users (nick,chan_name, ident,host_mask,mode) values ('$sender_nick','$chan','$sender_ident','$sender_host','$mode')";
		$result_insert=$db_ctrl->query($sql_insert,$db);
		
	//echo "user joined chan check this ".$sql_insert."\n";	
	
	}
	
	
?>
