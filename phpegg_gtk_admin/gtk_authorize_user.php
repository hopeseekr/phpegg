<?
/* 
	Copyright (c) 2001 Un-Thesis (Ted R. Smith)
	http://sourceforge.net/projects/phpegg
*/
function authorize_user($widget,$txt_login,$txt_password,$win_login) {
	$login = $txt_login->get_text();
	$password=$txt_password->get_text();
	
	if ($login_id=validate_user($login,$password)) {
		include_once("common.inc.php");
		include("database.inc.php");
		$user_id=decrypt_login($db,$login_id);
		$win_login->hide();
		unset($win_login);
		create_win_menu();
	} else {
		$query = &new GtkDialog();
		$query->set_title("Access Denied!");
		$label = &new GtkLabel("Access denied...\nTry re-entering your username and password!");
		$vbox = $query->vbox;
		$vbox->pack_start($label, TRUE, TRUE, 0);
		$label->show();
		$okbutton = &new GtkButton('OK');
		$okbutton->connect_object('clicked', array($query, 'destroy'));
		$action_area = $query->action_area;
		$action_area->pack_start($okbutton, TRUE, TRUE, 0);
		$okbutton->show();
		$query->show_all();
	}
}

function validate_user($login,$password) {
	include("database.inc.php");
	
    $sql="select * from user where user='$login' and mysql_password=password('$password')";
    
    $result=@mysql_query($sql,$db);
    if (mysql_num_rows($result)==0) {
		$user=$myrow["user"];
		$pass=$myrow["mysql_password"];
		
		if (!$pass) {
		    include_once("bf_lib.php");
		    $pass=bf_encrypt_pass($password);
	    		
		    $sql="select * from user where user='$login' and password='$pass'";
		
		    $result=@mysql_query($sql,$db);	
		    if (mysql_num_rows($result)!=0) {	
				$sql_update="update user set mysql_password=password('$password') where user='$login'";
				$result_update=@mysql_query($sql_update,$db);
				
				$login_time=time();
				
				$result=@mysql_query($sql,$db);	
				$sql="insert into web_login (user,login_time) values ('$login','$login_time')";
				$result=@mysql_query($sql,$db);	
				$result_login=@mysql_query($sql,$db);	
				if ($result_login) {
					$login_id=mysql_insert_id($db);
					$login_id=crypt_login($db,$login_id,$login_time);
		    
					return $login_id;
				}
			}
		}
    } else {
		$login_time=time();
		include_once("common.inc.php");
	
		$sql="delete from web_login where user='$login'";
		$result=@mysql_query($sql,$db);
		$sql="insert into web_login (user,login_time) values ('$login','$login_time')";
			
		$result_login=@mysql_query($sql,$db);	
		if ($result_login) {
		    $login_id=mysql_insert_id($db);
			
		    $login_id=crypt_login($db,$login_id,$login_time);
				
			return $login_id;
		}
    }
}
?>
