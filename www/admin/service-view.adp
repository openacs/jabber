<master>
<property name=title>Available IM-Services</property>


<h2>Available IM-Services and their activation status</h2>


<if @row_check_p@ eq 1>
<table>
   <tr> 
	<th>Pretty Name</th> 
	<th>Service Name (database name)</th> 
	<th>Status</th> 
	<th>Change Status</th> 
   </tr>
 <multiple name=get_services>
   <tr> 
	<td>@get_services.pretty_name@</td> 
	<td>@get_services.service@</td>
	<if @get_services.active_check_p@ eq t> 
	  <td>ENABLED</td>
	  <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="service-deactivate?service=@get_services.service@">disable</a></td>
	</if>
	<else>
	  <td>DISABLED</td>
	  <td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="service-activate?service=@get_services.service@">enable</a></td>
	</else>
   </tr>
 </multiple>
</if>
<else>

<p> Sorry, there are no IM-services available! Please add one! </p>

</else>
</table>

<hr>
<p>Back to <a href="index">admin-page</a> </p>