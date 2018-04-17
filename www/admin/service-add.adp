<master>
<property name=title>Add New Service</property>


<h2>Add New Service</h2>

<if @insert_check_p@ eq 1>

 <p> Insert was successful, new service is now available! </p>

</if>
<else>

 <p> Insert failed. Service exists already, maybe it is deactivated, please check following the link
     on the admin page!
 </p>

</else>

<hr>
<p> Back to <a href="index">admin-page</a> </p>
