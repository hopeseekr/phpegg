<?php


function on_part_msg($irc_connect,$who,$chan) {
    global $db_ctrl,$db;

    $sender_info=clean_nick($who);
    $sender_nick=$sender_info[0];
    $sender_ident=$sender_info[1];
    $sender_host=$sender_info[2];
    
    $host_mask=$sender_ident."@".$sender_host;	
	
    // prevents chan v and o users from receieving the on part msg 
    $sql="select user.user from user_host uh, user ,user_chan uc where '$host_mask' like replace(replace(mask,'*!',''),'*','%') and uh.user=user.user and uc.user=user.user and ((user.o='1' or user.f='1' or user.v='1') or (uc.chan='$chan' and (uc.o='1' or uc.v='1' or uc.f='1'))) limit 1";

    $result=@$db_ctrl->query($sql,$db);
    if ($db_ctrl->num_rows($result)==0) {
	$sql="select msg from channels c, part_msg jm where upper(c.chan_name)=upper('$chan') and on_join='1' and c.chan_name=jm.chan_name order by part_msg_id asc";
	$result=@$db_ctrl->query($sql,$db);
	while($myrow=@$db_ctrl->fetch_array($result)) {
	    $msg=$myrow["msg"];
	    $sender_info=clean_nick($who);
	    $sender_nick=$sender_info[0];
	
	    sleep(1);
	    fputs($irc_connect, "NOTICE $sender_nick :$msg\n");
	    $sent=1;
	}
	if ($sent==1) {
	    //echo "ON part in $chan sent to $sender_nick \n";
	}
    }
}

function on_join_msg($irc_connect,$who,$chan) {
    global $db_ctrl,$db;

    $sender_info=clean_nick($who);
    $sender_nick=$sender_info[0];
    $sender_ident=$sender_info[1];
    $sender_host=$sender_info[2];	
	
    $host_mask=$sender_ident."@".$sender_host;	
    // prevents chan v and o users from receieving the on join msg 
    $sql="select user.user from user_host uh, user ,user_chan uc where '$host_mask' like replace(replace(mask,'*!',''),'*','%') and uh.user=user.user and uc.user=user.user and ((user.o='1' or user.f='1' or user.v='1') or (uc.chan='$chan' and (uc.o='1' or uc.v='1' or uc.f='1'))) limit 1";
 
    $result=@$db_ctrl->query($sql,$db);
    if ($db_ctrl->num_rows($result)==0) {	
	$sql="select msg from channels c, join_msg jm where upper(c.chan_name)=upper('$chan') and on_join='1' and c.chan_name=jm.chan_name order by join_msg_id asc";
	$result=@$db_ctrl->query($sql,$db);
	while($myrow=@$db_ctrl->fetch_array($result)) {
	    $msg=$myrow["msg"];
	    $sender_info=clean_nick($who);
	    $sender_nick=$sender_info[0];
	    sleep(1);
	
	    fputs($irc_connect, "NOTICE $sender_nick :$msg\n");
	    $sent=1;
	}
	if ($sent==1) {
	    //echo "ON JOIN in $chan sent to $sender_nick \n";
	}
    }
}

function user_part_chan($irc_connect,$who,$chan) {
    //  When a user leaves a chan update the chan_user data with the time they left
    // the channel
	
    update_seen_data_part($irc_connect,$who,$chan);
	
    $sender_info=clean_nick($who);
    $sender_nick=$sender_info[0];
    $sender_ident=$sender_info[1];
    $sender_host=$sender_info[2];
	
    //print "$sender_nick ($sender_ident@$sender_host) left $chan \n";
}

function  quit_chan($irc_connect,$who,$reason) {
    // user quits update all records for that user on the chan_user table stating his
    // reason for leaveing and when he left
    update_seen_data_quit($irc_connect,$who,$reason);
	
    $sender_info=clean_nick($who);
    $sender_nick=$sender_info[0];
    $sender_ident=$sender_info[1];
    $sender_host=$sender_info[2];
    //print "$sender_nick ($sender_ident@$sender_host) quit irc \n stating $reason \n";
}
			
function user_join_chan($irc_connect,$who,$chan) {
    // update the chan_user data stating when he joined if he is there remove a reason
    // for leaveing and update the seen counter how many tiems he has been here
	
    $who=trim($who);
    $chan=trim($chan);
    update_seen_data_join($irc_connect,$who,$chan,"u");
    $sender_info=clean_nick($who);
    $sender_nick=$sender_info[0];
    $sender_ident=$sender_info[1];
    $sender_host=$sender_info[2];
    //print "$sender_nick ($sender_ident@$sender_host) Joined $chan \n";
}				
	
function nick_change($irc_connect,$who,$who_to) {	
    // if its not been seen before then add it to the chan_user table
    // update the user stating the time and reason changing nick to new_nick

    global $db_ctrl,$db,$my_nick;
	
    $sender_info=clean_nick($who);
    $sender_nick=$sender_info[0];
    $sender_ident=$sender_info[1];
    $sender_host=$sender_info[2];
    /* if ($sender_nick==$my_nick) {
	$GLOBALS["my_nick"]=$who_to;
	$my_nick=$who_to;
    } */

    $new_who=$who_to."!".$sender_ident."@".$sender_host;
	
    $sql="select * from chan_users  where upper(nick)=upper('$sender_nick') and reason is null";
	
    $result=$db_ctrl->query($sql,$db);
    while($myrow=$db_ctrl->fetch_array($result)) {
	$cu_id=$myrow["cu_id"];
	$mode=$myrow["mode"];
	$chan_name=$myrow["chan_name"];
					
	update_seen_data_join($irc_connect,$new_who,$chan_name,$mode);
    }
    $sql_update="update chan_users set ident='$sender_ident',host_mask='$sender_host', reason='changed nick to $who_to' where reason is null and upper(nick)=upper('$sender_nick')";

    $result_update=$db_ctrl->query($sql_update,$db);	
    if (!$sql_update) {
	//echo "Error in server_msg change_nick sql_update ".$db_ctrl->error($result_update)."\n";
    }
    //print "$sender_nick ($sender_ident@$sender_host) is now $who_to \n";
}
	
function bot_join_topic($irc_connect,$who,$chan,$topic) {
    // if chan not in the chan table then add it
    // if it is then update the topic
    global $db_ctrl,$db;
	
    $topic=addslashes(trim($topic));
    $sql="update channels set topic='$topic' where upper(chan_name)=upper('$chan')";
	
    $result=$db_ctrl->query($sql,$db);
	
    $sql="update chan_users set reason='Bot left' where upper(chan_name)=upper('$chan') and reason is null;";
    $result=$db_ctrl->query($sql,$db);
	
    //print "Bot joined $chan topic is $topic \n";
}	

function bot_join_topic_setby($irc_connect, $chan,$topic_set_by,$topic_set) {
    // update the topic set by info and when in the chan table.
	
    global $db_ctrl,$db;
    $topic_set_by=addslashes($topic_set_by);
    $sql="update channels set topic_set_by='$topic_set_by', topic_set_date='$topic_set' where upper(chan_name)=upper('$chan')";
    $result=$db_ctrl->query($sql,$db);
	
    //print "Bot joined $chan topic set by $topic_set_by $topic_set\n";
	
}

function bot_join_names($irc_connect,$chan,$names) {
    global $db_ctrl,$irc_nick;
    // check all the names in the table to see who is here and who isnt and new people
    // update left on the others that arnt there.
    $names=trim($names);
    $chan_users=explode(" ",$names);
						
    for ($n=0;$n<count($chan_users);$n++) {
	// to prevent the duplicate join entry for the bot its self. use bot name
	if (strtoupper($chan_users[$i])!="PHP_EGG") {  // gryph: hmm, hardcoded?
	    $hold=substr($chan_users[$n],0,1);
	    if ($hold=="@") {
		$user=substr($chan_users[$n],1,strlen($chan_users[$n]));
		$user=trim($user);
		$chan=trim($chan);
		$user=addslashes($user);
		update_seen_data($irc_connect,$user,$chan,"o");
	    } else if ($hold=="+") {
		$user=trim($user);
		$chan=trim($chan);
				
		$user=substr($chan_users[$n],1,strlen($chan_users[$n]));
		$user=addslashes($user);
		update_seen_data($irc_connect,$user,$chan,"v");
	    } else {	
		$chan=trim($chan);
		$user=trim($chan_users[$n]);
		$user=addslashes($user);
		update_seen_data($irc_connect,$user,$chan,"u");
	    }
	}
    }
    //print "bot joined $chan curent names are \n $names \n";
}	
	
function change_user_mode($irc_connect,$who,$chan,$mode) {
    global $db_ctrl,$db;	
	
    //print "$who Mode Now $mode \n";
	
    $plus_minus=substr($mode,0,1);
    $mode=substr($mode,1,1);
    $mode=trim($mode);
    if ($plus_minus=="+") {
	if (($mode=="v") || ($mode=="o")) {
	    $sql="update chan_users set mode='$mode' where upper(nick)=upper('$who') and upper(chan_name)=upper('$chan')";
	    $result=$db_ctrl->query($sql,$db);
	}
    } else {
	if ($mode=="o") {
	    $sql="update chan_users set mode='u'  where upper(nick)=upper('$who') and upper(chan_name)=upper('$chan')";
			
	    $result=$db_ctrl->query($sql,$db);
	} else if ($mode=="v") {
	    $sql="update chan_users set mode='u'  where upper(nick)=upper('$who') and upper(chan_name)=upper('$chan')";
			
	    $result=$db_ctrl->query($sql,$db);
	}
    }
    // update the chan_user table for that user name. to show the new level
	
}	
?>