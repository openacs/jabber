<master>
<property name=title>Login</property>

<h1><hr>Login: </h1>

<if @success@ eq -1>
	<h2>Jabber Client could not login! See Error Log for details!</h2>
</if>
<else> 
        <h2>Jabber Client logged in!
        <if @success_presence@ eq -1>  
        	Setting Presence failed! See Error Log for details!</h2>
	</if>        
	<else> 
		Presence set to 'Online'!</h2>
        </else>    
</else>

<br>
<br>
<hr>
<h4>Back to <a href='index'>admin-page</a>.</h4>




