<master>
<property name=title>Logout</property>


<h1>Logout:</h1><hr>

<if @success@ eq -1> 
	<h2>Jabber Client could not logout properly! No Connection found!</h2>
</if>
<else> 
        <h2>Jabber Client logged out!</h2>
</else>    


<br>
<br>
<hr>
<h4>Back to <a href='index'>admin-page</a>.</h4>


