<?

/* The Common Database Interface - MySQL Implementation */
/* Dev'd by Un-Thesis on September 3rd, 2001 */
/* v2 - modified on April 3, 2002 @ 8:17AM CST */

class MySQLInterface {
	var $db;

	function connect($database_host,$database_login,$database_pass,$database_name) {
		$this->db = @mysql_connect($database_host,$database_login,$database_pass);
		mysql_select_db($database_name,$this->db);
		return $this->db;

	}

	function pconnect($database_host,$database_login,$database_pass,$database_name) {
		$this->db = @mysql_pconnect($database_host,$database_login,$database_pass);
		mysql_select_db($database_name,$this->db);
		return $this->db;
	}
	
	function query() {
		$arglist = func_get_args();
		$num_args = func_num_args();
		if ($num_args == 1) {
			return mysql_query($arglist[0],$this->db);
		} elseif ($num_args == 2) {
			return mysql_query($arglist[0],$arglist[1]);
		} else {
			return FALSE;
		}
	}
	
	function fetch_array($qResult) {
		return mysql_fetch_array($qResult);
	}

	function fetch_row($qResult) {
		return mysql_fetch_row($qResult);
	}

	function error() {
		return mysql_error();
	}

	function num_rows($qResult) {
		return mysql_num_rows($qResult);
	}

	function close() {
		$arglist = func_get_args();
		$num_args = func_num_args();
		if ($num_args == 0) {
			return mysql_close($this->db);
		} elseif ($num_args == 1) {
			return mysql_query($arglist[0]);
		} else {
			return FALSE;
		}
	}
	
	function get_last_id($result,$db) {
		return mysql_insert_id($db);
	}

	function test() {
		print "test...\n";
	}
}

?>