<?php
//  __   .__.__  .__			 ________ 
// |  | _|__|  | |  |		   /   __   \
// |  |/ /  |  | |  |	______ \____	/
// |	<|  |  |_|  |__ /_____/	/	/ 
// |__|_ \__|____/____/		   /____/  
//	  \/								
// PHP-EGG beta 1 by kill-9 

function get_connect() {
	global $my_irc_server, $my_nick, $irc_servers, $irc_server_ports, $irc_host, $irc_real_name, $irc_nick, $irc_alt_nick, $debug,$irc_identd;

	$trys=0;
	while (!$irc_connect) {	
		if ($trys>0) {
			sleep(20);
		}
		if (count($irc_servers)!=1) {	
			srand ((double) microtime() * 10000000);
		
			$rand_key = array_rand ($irc_servers, 2);
		} else {
			$rand_key[0] = 0;
		}	
		flush();
		$irc_server=$irc_servers[$rand_key[0]];
		if ($debug==1) {	
			echo "Connecting to: $irc_server\n";	
		}
		$irc_connect=fsockopen($irc_servers[$rand_key[0]],$irc_server_ports[$rand_key[0]],&$errno, &$errstr);
		$trys++;
	}
	
	$my_irc_server=$irc_servers[$rand_key[0]];
	$my_nick=$irc_nick;

	if ($debug==1) {
		print("USER $irc_identd 0 * :$irc_real_name\n");
	}
	fputs($irc_connect, "USER $irc_identd 0 * :$irc_real_name\n");
	
	if ($debug==1) {
		print "USER SENT\n";
	}	 
	 // now send NICK command, we might get backtalk on this one
	if ($debug==1) {
		print("NICK $irc_nick\n");
	}
	fputs($irc_connect, "NICK $irc_nick\n");
	if ($debug==1) { 
		print "NICK SENT\n";
	}
	return $irc_connect;
}

function irc_connect() {
	global $my_irc_server, $my_nick, $irc_servers,$irc_server_ports , $irc_host , $irc_real_name , $irc_nick , $irc_alt_nick,$db,$debug;
	
	$irc_connect=get_connect();
	if ($debug==1) {
		echo "connecting to irc...\n";
	}

	while (trim($reply[1])!="001") {
		$old_input_buffer=$input_buffer;
		$input_buffer = fgets($irc_connect, 1024);

		if ($old_input_buffer!=$input_buffer) {
			if ($debug==1) {
				print "$input_buffer";
			}
			if (strpos($input_buffer,"throttled")) {
				irc_connect();
				break;
			}
			if (strpos($input_buffer," 433 ")) {
				// if the nic is in use use alt nick.
				fputs($irc_connect, "NICK $irc_alt_nick\n");
				$my_nick=$irc_alt_nick;
			}
			if (strpos($input_buffer,"No ident response")) {
				if ($debug==1) {
					print $input_buffer."\n";
				}
				if ($ident_trys) {
					exit;
				}
				$ident_trys=1;
			}

			if (substr($input_buffer,0,5)=="ERROR"  ) {
				// adding error login
				$time=time();
				$error=addslashes($input_buffer);
				$sql="insert into server_error (time,error) values ($time,'$error')";
				$result=@mysql_query($sql,$db);
				set_time_limit(6000);
				fclose($irc_connect);
				$irc_connect=get_connect();
				if ($debug==1) {
					print "RECONNECTING \n";
				}
				sleep(5);
				irc_connect();
			}

			$input_buffer=str_replace(":","",$input_buffer);
			$reply=explode(" ",$input_buffer);
			if ($reply[0]=="PING") {
				if ($debug==1) {
					print("!PING?PONG\n");
				}
				fputs($irc_connect, "PONG $reply[1]\n");
			}		
			flush();
		}
	}
	if ($debug==1) {	
		print "Connected to $my_irc_server as $my_nick \n";	
	}

	//print "connecting to  $my_nick  +i \n";	
	//fputs($irc_connect, ":$irc_nick mode $irc_nick +i\n");
	//print "connecting to  $my_nick  -s \n";	
	//fputs($irc_connect, ":$irc_nick mode $irc_nick -s\n");
	//$input_buffer=str_replace(":","",$input_buffer);	
	//print "$input_buffer \n";
	// $input_buffer=str_replace(":","",$input_buffer);
	//print "$input_buffer \n";
	//print "heading for idle \n";		
	
	irc_idle($irc_connect);
	
	// if (!$irc_connect);
	if ($debug==1) {
		echo "Reconnecting...\n";
	}
	irc_connect();
}

function irc_idle($irc_connect) {
	global $my_irc_server, $my_nick,$db ,$irc_nick,$dcc_connections,$debug,$dcc_mdl;

 	set_socket_blocking($irc_connect,false);
  	$read_something=1;
	while ($irc_connect) {
		if ($read_something==0) {
	 		// nothing to do right now, sleep
			sleep(2);
		}
		$read_something=0;	

		// handles dcc connections
		$sql="select * from dcc_connections";
		$result=mysql_query($sql,$db);
	
		while ($myrow=mysql_fetch_array($result)) {
			$sock_info=socket_get_status($dcc_connections[$myrow[id]]);
	
			if ($sock_info[eof]) {
			// close and delete the dcc
				if ($debug==1) {
					print("dcc with $myrow[nick] closed...\n");
				}
				$sql="delete from dcc_connections where id=\"".$myrow[id]."\"";
				mysql_query($sql,$db);
			} 
			else 
			{
				set_socket_blocking($dcc_connections[$myrow[id]],false);
				unset($input_buffer);
				$input_buffer = fgets($dcc_connections[$myrow[id]], 1024);
	 		// running dcc modules now
				if ($input_buffer!="") 
				{  
					echo "'".$input_buffer."'\n";
					$message=trim($input_buffer);
					if ($myrow["login"] && ($myrow["password"]=="Y"))
					{
						if (substr($message,0,1)==".")
						{
			  				for($i=0;$i<count($dcc_mdl);$i++) 
				 			{
								echo "evaling dcc module \n";
								eval($dcc_mdl[$i]);
							}
						}
						else
						{
							// if it doesnt start with a . its not a command and goes out on the botnet.
				
							$said=trim($message);
							$id=$myrow["id"];
							$login=$myrow["login"];
							$front="[".$login."@".$my_nick."]";
							echo "$front $said \n";
							$sql="select * from dcc_connections";
							$result_partyline=@mysql_query($sql,$db);
							while($partyline=@mysql_fetch_array($result_partyline))
							{
								$partyline_id=$partyline["id"];
								fputs ($dcc_connections[$partyline_id],"$front $said\n" );
							}
						}	
		
					}
					else if (!$myrow["login"])
	 				{
						$login=trim($input_buffer);
						$sql="update dcc_connections set login='$login' , password='N' where id=".$myrow['id']." ";
			
						$result_up=@mysql_query($sql,$db);
			
						fputs ($dcc_connections[$myrow[id]],"Please enter your password. \n" );
					}			
					else if ($myrow["login"] && ($myrow["password"]=="N"))
					{
						$pass=trim($input_buffer);
						$access=check_mysql_login($myrow["hostmask"],$pass) ;
			
						if ($access)
						{
							$sql="update dcc_connections set login='$login' , password='Y' where id=".$myrow['id']." ";
							$result_up=@mysql_query($sql,$db);
							$ascii = fread(fopen("modules/ascii.mdl", "r"), filesize("modules/ascii.mdl")); 
							$buffer=explode("\n",$ascii);
							for ($a=0;$a<count($buffer);$a++)
							{
				 				fputs($dcc_connections[$myrow[id]],"$buffer[$a] \n");
				 			}
				
							fputs($dcc_connections[$myrow[id]],"Hey $login !  My name is $my_nick and I am running PHP-Egg  by Linda Pedersen (www.kill-9.dk/php_egg/) version 1.3b\n");
							$time=date("H:m",time());
							fputs($dcc_connections[$myrow[id]],"Local time is now $time\n");
					
							fputs($dcc_connections[$myrow[id]],"try .help to get help\n");
							fputs($dcc_connections[$myrow[id]],"	 .help all to get the full command list\n");
							fputs($dcc_connections[$myrow[id]],".help *somestring* to get the matching help texts\n");

							fputs($dcc_connections[$myrow[id]],"Have fun.\n");

							fputs($dcc_connections[$myrow[id]],"Commands start with '.' (like '.quit' or '.help')\n");
							fputs($dcc_connections[$myrow[id]],"Everything else goes out to the party line.\n");
						}
						else
						{
							fputs($dcc_connections[$myrow[id]],"Bad login or password closing connection \n");
							fclose($dcc_connections[$myrow[id]]);
				
							$sql="delete from dcc_connections where id=".$myrow['id']." ";
							$result_del=@mysql_query($sql,$db);
						}
					}		
					$read_something=1;	
				}
			}		
		}
			
		// handles the irc connection
		unset($input_buffer);
		$input_buffer = fgets($irc_connect, 1024);
		// adding error checking from the server.
		if (substr($input_buffer,0,5)=="ERROR")
		{
			$time=time();
			$error=addslashes($input_buffer);
			$sql="insert into server_error (time,error) values ($time,'$error')";
			$result=@mysql_query($sql,$db);
		}
		if ($input_buffer!="") {
			print("ircd read: $input_buffer");
			$read_something=1;

			$sock_info=socket_get_status($irc_connect);
			if($sock_info["eof"]) {
				fclose($irc_connect);
				if ($debug==1) {
					echo "got disconnect, reconecting.....\n";
				}
				// cleaning the tables on a reconnect.

				$sql="update channels set in_chan='N'";
				$result=@mysql_query($sql,$db);

				$sql="update chan_users set reason='bot reconnect' where reason is null";
				$result=@mysql_query($sql,$db);

				$sql="delete from bans";
				$result=@mysql_query($sql,$db);
			
				irc_connect(); // should force a reconnect
			}

			set_time_limit (8000);

			if (substr($input_buffer,0,1)==":") {
				// anyting but a server ping
				$len=strlen($my_nick)+1;
			
				$irc_buffer=substr($input_buffer,1,strlen($input_buffer));
				check_msg($irc_connect,$irc_buffer);
			} else {
				// server ping
	
				$input_buffer=str_replace(":","",$input_buffer);
				$reply=explode(" ",$input_buffer);
				if ($reply[0]=="PING") {
					if ($debug==1) {
						print "!PING?PONG \n";
					}
					fputs($irc_connect, "PONG $reply[1]\n");	
				}
				// running the auto run stuff
			}
			auto_run($irc_connect);
		} // end if ($input_buffer!="") {
	}
}
		
function check_msg($irc_connect,$input_buffer) {
	global $magic_word,$admin_email,$db, $ex_commands,$botmsgs,$reload_modules,$mode_mdl,$irc_nick,$my_nick,$debug,$help_mdl;

	global $nick_mdl, $topic_mdl, $part_mdl, $quit_mdl, $bot_join_topic,$bot_join_topic_set_by, $bot_join_names,$join_mdl,$help_mdl,$login_module,$show_mdl,$kick_mdl;

	if ($debug==1) {
		echo "$input_buffer";
	}
	if (strpos($input_buffer,":")) {
		$msg_array=explode(":",$input_buffer);
		$command_data=explode(" ",$msg_array[0]);
		$message=$msg_array[1];
	} else {
		$command_data=explode(" ",$input_buffer);
	}		
//	if ($debug==1) {
//		print "Command_data[0] $command_data[0] \n";
//		print "Command_data[1] $command_data[1] \n";
//		print "Command_data[2] $command_data[2] \n";
//		print "Command_data[3] $command_data[3] \n";
//		print "Command_data[4] $command_data[4] \n";
//		print "message $message \n";
//		print "message[0]  $message[0]";
//		print "$msg[0] \n";
//	}
	switch ($command_data[1]) {
	case "KICK":
		$who=trim($command_data[0]);
		$who=addslashes($who);
		$chan=trim($command_data[2]);
		$kicked_nick=trim($command_data[3]);
		$kick_reason=trim($command_data[4]);
			
		for($i=0;$i<count($kick_mdl);$i++) {
			eval($kick_mdl[$i]);
		}
	break;
	case "MODE":
		$who=$command_data[4];
		$who=addslashes($who);
		$chan=$command_data[2];
		$mode=$command_data[3];
		for($i=0;$i<count($mode_mdl);$i++) {
			eval($mode_mdl[$i]);
		}
					
	break;
	case "TOPIC":
		$chan=$command_data[2];
		$topic=$message;
		for($i=0;$i<count($topic_mdl);$i++) {
			eval($topic_mdl[$i]);
		}
	break;
	case "PRIVMSG":
		$who=$command_data[0];
			
		$sender_info=clean_nick($who);
		$sender_nick=$sender_info[0];
		$sender_ident=$sender_info[1];
		$sender_host=$sender_info[2];

		if (substr($command_data[2],0,1)=="#") {
			$chan=trim($command_data[2]);
			// deals with the last spoke info 	function lives in seen.inc
			lastspoke_log($sender_ident,$sender_nick,$sender_host,$chan);
	\		
			// done dealing with last spoke.

			// who sent it what chan they sent it to what they sent
			$hold=explode(" ",$message);
				
			if (strtoupper($hold[0])==strtoupper($my_nick)) {
				$op=op_check($chan,$sender_nick);
				if ($op!=1) {
					$voice=voice_check($chan,$sender_nick);
				}
				if (($op==1) || ($voice==1)) {
					// run help show
						
					for($i=0;$i<count($show_mdl);$i++) {
						eval($show_mdl[$i]);
					}
				}
			}	
					
			/* 
			   Basic architecture dev'd by Kill-9
			   Modular OOP structure dev'd by Un-Thesis
				   
			   Retrieve our good friend, $mod_ctrl here.  $mod_ctrl will then take care
			   of the messy business of executing the correct module.
			*/
			global $mod_ctrl;
			$token = substr($message,0,1);
			$message = trim($message);
				
			/* Don't waste CPU time by only sending a true message to $mod_ctrl */
			/*i now, should we call the eval($modname_mdl) here, or in $mod_ctrl? */
			if (strlen($message)>1) {
				eval($mod_ctrl->deliver_token($token, $message));
			}
		} else {
			// who sent it and what they sent
			$hold=strtoupper($message);	
				
			if (trim($message)==$magic_word) {
				$who=$command_data[0];
				
				$sender_info=clean_nick($who);
				$sender_nick=$sender_info[0];
				$sender_ident=$sender_info[1];
				$sender_host=$sender_info[2];
				
				$now=time();
				$sql="insert into user (user,n,m,o,v,f,p,created,last_on) values ('$sender_nick','Y','Y','Y','Y','Y','p','$now','$now')";
				$result_user=@mysql_query($sql,$db);
				if ($result_user) {
					$mask=make_ban($sender_ident,$sender_host);
					$sql="insert into user_host (user,mask) values ('$sender_nick','$mask')";
					$result_mask=@mysql_query($sql,$db);
					if ($result_mask) {
						fputs($irc_connect, "PRIVMSG $sender_nick :Hello master, What may i do to assist you?\n");
						fputs($irc_connect, "PRIVMSG $sender_nick :Please msg me PASSWORD <a pass> to set your password. \n");
					}
				}
				unset($GLOBALS["magic_word"]);	
			}
			$hold=explode(" ",$message);	
			
			if (trim($hold[0])=="PASSWORD")	{
				$hold[1]=trim($hold[1]);
					
				$who=$command_data[0];
				$sender_info=clean_nick($who);
			
				$sender_nick=$sender_info[0];
				$sender_ident=$sender_info[1];
				$sender_host=$sender_info[2];
				$host_mask=$sender_ident."@".$sender_host;
			
				$sql="select user.user from user_host uh, user where '$host_mask' like replace(replace(mask,'*','%'),'!','') and uh.user=user.user and user.user='$sender_nick'";
				$result=@mysql_query($sql,$db); 			
				if (mysql_num_rows($result)==1) {
					if (trim($hold[1])) {	
						$pass=bf_encrypt_pass($hold[1]);
						$sql="update user set password='$pass' , mysql_password=password('$hold[1]') where user='$sender_nick'";
						
						$result=@mysql_query($sql,$db); 	
						
						if ($result) {
							fputs($irc_connect, "PRIVMSG $sender_nick :New password set.\n");
						}
					}
				}
			}
			if (strtoupper($hold[0])=="OP") {
				$mode="o";
				eval($login_module);
			} else if (strtoupper($hold[0])=="VOICE") {
				$mode="v";
				eval($login_module);
			} else if (substr($message,0,1)=="!") {
				$msg_data=@explode(" ",$message);
				if (strtoupper($msg_data[0])=="!RELOAD") {
					$pass=trim($msg_data[1]);
					$host_mask=$sender_ident."@".$sender_host;
				   
					$login_access=check_mysql_login($host_mask,$pass);
					if ($login_access) {
						$access=check_global_access($login_access);	
						if ($access==1) {	
							eval($reload_modules);
						}
					}
				}
				for($i=0;$i<count($ex_commands);$i++) {
					eval($ex_commands[$i]);
				}
			} else if (substr($message,0,1)=="?") {
				if ($debug==1) {
					echo "help command detected..........  \n";
				}
				for($i=0;$i<count($help_mdl);$i++) {
					eval($help_mdl[$i]);
				}
			} else {
				eval($GLOBALS["msgcommands_mdl"]);
				for($i=0;$i<count($botmsgs);$i++) {
					eval($botmsgs[$i]);
				}
				//bot_msg($irc_connect,$command_data[0],$message);
			}	
		}
	break;
	case "NOTICE":
		// who sent it and what they sent
			
		// same as msg sent to the bot.
	break;
	case "PART":
		$chan=$command_data[2];
		$who=$command_data[0];
		$who=addslashes($who);
		for($i=0;$i<count($part_mdl);$i++) {
		eval($part_mdl[$i]);
		}
	break;
	case "QUIT":
		$reason=$message;
		$who=$command_data[0];
		$who=addslashes($who);
		for($i=0;$i<count($quit_mdl);$i++) {
		eval($quit_mdl[$i]);
		}
	break;
	case "JOIN":
		$chan=$message;
		$who=$command_data[0];
		$who=addslashes($who);
		for($i=0;$i<count($join_mdl);$i++) {
		eval($join_mdl[$i]);
		}
	break;
	case "NICK":
		$who=$command_data[0];
		   
		$who_to=$message;
		$who_to=addslashes($who_to);
		for($i=0;$i<count($nick_mdl);$i++) {
		eval($nick_mdl[$i]);
		}
	break;  
	case "311":
		// i think this is a talk back on a whois
		$nick_is=addslashes($command_data[3]);
		$ident_is=$command_data[4];
		$hostmask_is=$command_data[5];   
		$sql="update chan_users set ident='$ident_is' , host_mask='$hostmask_is' where reason is null and nick='$nick_is'";
		$result=@mysql_query($sql,$db);
			
		$sql="select nick from chan_users where reason is null and ident is null and host_mask is null  order by rand() limit 1";
		$result=@mysql_query($sql,$db);
			
		if (mysql_num_rows($result)==0) {
		//$GLOBALS["motd_end"]=1;
		}
		while($myrow=@mysql_fetch_array($result)) {
		$nick=addslashes($myrow["nick"]);
		$chan_name=$myrow["chan_name"];
		$now=date("YmdHis",time());
				
		$sql_check="select * from mode_data where action='WHOIS $nick'";
		$result_check=@mysql_query($sql_check,$db);
		if (mysql_num_rows($result_check)==0) {
			$sql_insert="insert into mode_data (chan_name,action,date_inserted,added_by) values ('$chan_name','WHOIS $nick','$now','system')";
			$result_insert=@mysql_query($sql_insert,$db);
			if ($result_insert) {
			echo "getting $nick \n";
			// found one
			}
		}
		}
	break;	  
	case 332:
		$chan=$command_data[3];
		$topic=$message;
		$who="";
		for($i=0;$i<count($bot_join_topic);$i++) {
			eval($bot_join_topic[$i]);
		}
		$sql="delete from bans where chan_name='$command_data[3]'";
		$result=@mysql_query($sql,$db);
		
		fputs($irc_connect,"MODE $chan +b \n");			
	break;
	case 333:
		$chan=$command_data[3];
		// trying to find out who is in the chan.
		//fputs($irc_connect,":$my_nick WHO $chan  \n");		
		$topic_set_by=$command_data[4];
		$topic_set=$command_data[5];

		for($i=0;$i<count($bot_join_topic_set_by);$i++) {
			eval($bot_join_topic_set_by[$i]);
		}
	break; 
	case 367:
		//print "ban list  \n";
			
		$sql="insert into bans (chan_name, ban_mask,set_by ,ban_date) values ('$command_data[3]','$command_data[4]','$command_data[5]',$command_data[6])";
		$result=mysql_query($sql,$db);
		break;  
	case 352:
		// ok this would be the who on everone in the chan curntly
		$chan=$command_data[3];
		$ident=$command_data[4];
		$host_mask=$command_data[5];
		$server=$command_data[6];
		$nick=addslashes($command_data[7]);
		$mode=substr($command_data[8],0,2);
		$real_name=$command_data[9];
			
		$mode=trim($mode);
		if (($mode=="H") || ($mode=="G")) {
		$mode="u";
		} else if (($mode=="H+") || ($mode=="G+")) {
		$mode="v";
		} else if (($mode=="H@") || ($mode=="G@")) {
		$mode="o";
		}		
		
		$sql="insert into chan_users (chan_name,nick,mode,ident,host_mask) values ('$chan' ,'$nick' ,'$mode' ,'$ident' ,'$host_mask')";
			
		$result=@mysql_query($sql,$db); 
		if ($debug==1) {
		echo "adding $nick $chan \n";
		 }
	break;		
	case 353:
		// trying to find out who is in the chan.
		$chan=$command_data[4];
		fputs($irc_connect,"WHO $chan\n");	
		/* $names=$message;
		for($i=0;$i<count($bot_join_names);$i++) {
		eval($bot_join_names[$i]);
		} */
	break;
	case 376:
		//echo "end of motd \n";
		 //echo $input_buffer."\n";
		 //$GLOBALS["motd_end"]=1;
		 	
	break;   
	/* default:
		print "in default this is bad \n";
		echo "$input_buffer \n";
	break; */		  
	}	
}	

/******************************************************/
/*  quotes a message to ctcp format				   */
/*   a ctcp command								  */


function irc_ctcp_quote($message) {
	// add middle-quoted characters
	$result = str_replace(chr(16), chr(16).chr(16), $message);
	// $result = str_replace("", chr(16)."r", $result);
	$result = str_replace("\n", chr(16)."n", $result);
	$result = str_replace(chr(0), chr(16)."0", $result);

	$result = str_replace("\\", "\\\\", $result);
	$result = str_replace(chr(1), "\\a", $result);

	// VERY, very basic handling of protocol - just add outer quotes
	$result = chr(1).$result.chr(1);
	
	return($result);
}

/******************************************************/
/*  check a message to see if the user is sending us */
/*   a ctcp command								  */

// gryph: is this function used????
function check_ctcp($irc_connect,$message,$sender_nick) {
	if (substr(trim($message),1,4)=="PING")
		{
				// some one pinged me lets ping them back
				
				fputs($irc_connect,"NOTICE $sender_nick :$message");
				}
	else if (substr(trim($message),1,7)=="VERSION")
				{
				
				$ctcp_version_quote=irc_ctcp_quote("VERSION php egg version 2");
				
				fputs($irc_connect,"NOTICE $sender_nick :$ctcp_version_quote \n");
				}
	else if (substr(trim($message),1,4)=="TIME")
				{
				$now = date("l m/d/Y H:i:s");
				
				$ctcp_time_quote=irc_ctcp_quote("TIME $now");
				
				fputs($irc_connect,"NOTICE $sender_nick :$ctcp_time_quote \n");
				}
	else if (substr(trim($message),1,6)=="FINGER")
				{
				
				
				$ctcp_finger_quote=irc_ctcp_quote("FINGER and finger you to.");
				
				fputs($irc_connect,"NOTICE $sender_nick :$ctcp_finger_quote \n");
				}									
	}		


function clean_nick($full_nick) {
	$start=0;
	
	$end=strpos($full_nick,"!");
	$size=$end-$start;
	$sender_info[0]=addslashes(substr($full_nick,$start,$size));
	
	$start=$end+1;
	$end=strpos($full_nick,"@",$start);
	$size=$end-$start;
	
	$sender_info[1]=substr($full_nick,$start,$size);
	
	$start=$end+1;
	$end=strlen($full_nick);
	$size=$end-$start;
	
	$sender_info[2]=substr($full_nick,$start,$size);
	
	return $sender_info;
}



?>
