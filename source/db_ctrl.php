<?

/* Dev'd by Un-Thesis on September 3rd, 2001 */
class PostgreSQLInterface {
	var $db;
	
	function connect($database_host,$database_login,$database_pass,$database_name) {
		$this->db = pg_connect("host=$database_host dbname=$database_name user=$database_login 
	password=$database_pass") or die("Unable to connect to SQL server!");
		return $this->db;
	}

	function pconnect($database_host,$database_login,$database_pass,$database_name) {
		$this->db = pg_pconnect("host=$database_host dbname=$database_name user=$database_login 
	password=$database_pass") or die("Unable to connect to SQL server!");
		return $this->db;
	}

	function get_last_id($result,$db) {
		return pg_getlastoid($result);
	}

	function query() {
		$arglist = func_get_args();
		$num_args = func_num_args();
		if ($num_args == 1) {
			return pg_exec($this->db,$arglist[0]);
		} elseif ($num_args == 2) {
			return pg_exec($arglist[1],$arglist[0]);
		} else {
			return FALSE;
		}
	}

	function fetch_array($qResult) {
		static $a;
		$results = @pg_fetch_array($qResult,$a);
		$a++;
		return $results;
	}

	function fetch_row($qResult) {
		static $a;
		$results = @pg_fetch_row($qResult,$a);
		$a++;
		return $results;
	}

	function error() {
	$arglist = func_get_args();
		$num_args = func_num_args();
		if ($num_args == 0) {
			return pg_errormessage($this->db);
		} elseif ($num_args == 1) {
			return pg_errormessage($arglist[0]);
		} else {
			return FALSE;
		}
	}

	function num_rows($qResult) {
		return pg_numrows($qResult);
	}

	function close() {
		if ($num_args == 0) {
			return pg_close($this->db);
		} elseif ($num_args == 1) {
			return pg_close($arglist[0]);
		} else {
			return FALSE;
		}
	}
}

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
		print "hey\n";
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