<master>
<property name=title>Jabber-Register</property>

<H1>Jabber Register: </H1><hr>


<if @insert_check_p@ eq 0> 
	<h2>Database Error Occurred<br></h2>
	<p> Insert failed : @errormsg@</p> 
</if>
<if @insert_check_p@ eq 1>
	<h2>New JabberID created: @jscreen@\@jabber_server</h2></h3>
</if>
<if @insert_check_p@ eq 2>
	<h2>JabberID exists or user is already signed in for Jabber! Please choose another username or user_id!</h2>
</if>

<if @insert_check_p@ eq 3>
	<h2>We had a problem processing your data! The Jabber Client could not register you!</h2>
</if>

<br>
<br>
<hr>
<h4>Back to <a href='index'>index</a>.</h4>









