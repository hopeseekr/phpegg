<?

/* The Common Database Interface - PostgreSQL v2 Implementation */
/* Dev'd by Un-Thesis on September 3rd, 2001 */
/* v1 - Modified on April 3, 2002 @ 8:17AM CST */

class PostgreSQLv2Interface {
	var $db;
	
	function connect($database_host,$database_login,$database_pass,$database_name) {
		$this->db = pg_connect("host=$database_host dbname=$database_name user=$database_login password=$database_pass") or die("Unable to connect to SQL server!");
		return $this->db;
	}

	function pconnect($database_host,$database_login,$database_pass,$database_name) {
		$this->db = pg_pconnect("host=$database_host dbname=$database_name user=$database_login password=$database_pass") or die("Unable to connect to SQL server!");
		return $this->db;
	}

	function get_last_id($result,$db) {
		return pg_last_oid($result);
	}

	function query() {
		$arglist = func_get_args();
		$num_args = func_num_args();
		if ($num_args == 1) {
			return pg_query($this->db,$arglist[0]);
		} elseif ($num_args == 2) {
			return pg_query($arglist[1],$arglist[0]);
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
			return pg_last_error($this->db);
		} elseif ($num_args == 1) {
			return pg_last_error($arglist[0]);
		} else {
			return FALSE;
		}
	}

	function num_rows($qResult) {
		return pg_num_rows($qResult);
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

?>