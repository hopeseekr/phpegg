<?php


function create_table_top($width, $color, $table_name="<br>")
	{
	
	$str="

<center>

<table width=$width border=0 cellspacing=0 bgcolor=$color >  
 <tr>
  <td>
   <font color=ffffff>$table_name</font>

     <table border=0 cellspacing=0 bgcolor=#ffffff width=100%>
      <tr>
       <td width=30% valign=middle>
       ";
       
       return $str;
       
       }
       
function create_table_bottom()
	{
		
		$str= "
	       </td> 
	      </tr>
	     </table>
	   
	    </td>
	   </tr>
	  </table>
	  </center>
	  ";
	  return $str;
  	}
  
 ?> 