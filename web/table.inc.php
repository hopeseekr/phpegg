<?php


function create_table_top($width, $color, $table_name="<br>") {
    $str="<center>\n".
    "<table width=\"$width\" border=\"0\" cellspacing=\"0\" bgcolor=\"$color\">\n".
    "<tr>\n".
    "<td>\n".
    "<font color=\"ffffff\">$table_name</font>\n".
    "<table border=\"0\" cellspacing=\"0\" bgcolor=\"#ffffff\" width=\"100%\">\n".
    "<tr>\n".
    "<td width=\"30%\" valign=\"middle\">\n";
    return $str;
}

function create_table_bottom() {		
    $str= "</td>\n".
    "</tr>\n".
    "</table>\n".
	   
    "</td>\n".
    "</tr>\n".
    "</table>\n".
    "</center>\n";
    
    return $str;
}
  
?>