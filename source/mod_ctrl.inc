<?
class module_control {
	var $debug;
	function set_debug() {
		$this->$debug = 1;
		return TRUE;
	}

	function load_all() {
		global $db_ctrl;
		/* clearstatcache() is the most important fucking function in this entire class!
           I lit. spent 4 hours trying to figure out how to change the filesize of an updated file.
		   This is the answer.
		*/
		clearstatcache();
		$sql="select distinct(module_name),module_file_name from modules;";
		$result=$db_ctrl->query($sql);
		while($myrow=$db_ctrl->fetch_array($result)) {
			eval('$GLOBALS["'.$myrow[module_name].'_mdl"] = fread(fopen("'.$myrow["module_file_name"].'","r"), filesize("'.$myrow["module_file_name"].'"));');
			
			if ($this->$debug == 1) {
				print "$myrow[module_name] was loaded...\n";
			}
			unset($myrow);
		}
		unset($sql);
		return TRUE;
	}

	function load_specific($name) {
		global $db_ctrl;
		clearstatcache();
		$sql="select * from modules where module_name='$name'";
		$result=$db_ctrl->query($sql);
		$myrow=$db_ctrl->fetch_array($result);
		print "Filesize = ".filesize($myrow[module_file_name])."\n";
		eval('$GLOBALS["'.$myrow[module_name].'_mdl"] = fread(fopen("'.$myrow["module_file_name"].'","r"), filesize("'.$myrow["module_file_name"].'"));');
		if ($this->$debug == 1) {
			print "$myrow[module_name] was loaded...\n";
		}
		unset($myrow);
		unset($sql);
		return TRUE;
	}

	function unload_all() {
		global $db_ctrl;
		$sql="select * from modules;";
		$result=$db_ctrl->query($sql);
		while($myrow=$db_ctrl->fetch_array($result)) {
			eval('unset($GLOBALS["'.$myrow[module_name].'_mdl"]);');
			if ($this->$debug == 1) {
				print "$myrow[module_name] was unloaded...\n";
			}
			unset($myrow);
		}
		unset($sql);
		return TRUE;
	}


	function unload_specific($name) {
		eval('$GLOBALS["'.$name.'_mdl"] = "";');
		if ($this->$debug == 1) {
			print "$name was unloaded...\n";
		}
		return TRUE;
	}

	function reload_all() {
		$this->unload_all();
		$this->load_all();
		return TRUE;
	}

	function reload_specific($name) {
		$this->unload_specific($name);
		$this->load_specific($name);
		return TRUE;
	}

	function deliver_token($token, $message) {
		global $db_ctrl;
		$sql="select * from module_binds where token='$token'";
		$result=$db_ctrl->query($sql);
		$myrow=$db_ctrl->fetch_array($result);
		$modname_q = $db_ctrl->query("select module_name from modules where module_binds_id='$myrow[module_binds_id]'");
		while($modname = $db_ctrl->fetch_row($modname_q)) {
			if ($this->$debug == 1) {
				print "using $modname[0]...$myrow[bind] detected...";
			}
			eval('$mod = $GLOBALS["$modname[0]_mdl"];');
		}
		if ($this->$debug == 1) {
			print "\n";
		}
		return $mod;
	}
}

?>