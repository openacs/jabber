<master>
<property name=title>Send Message</property>

<h1>Send Message:</h1>
<hr>

<if @register_check_p@ eq 1>
  <if @success@ eq -1> 
	<h2>Jabber Client Offline!</h2>
  </if>
  <if @success@ eq 0>
	<h2>Following message has been sent to '@receive_user@':</h2> 
        <br>
   	<h3>'@message@'</h3>
  </if>
</if>
<else>
	<h3>You are not registered</h3>
</else>

<br>
<br>
<hr>
<h4>Back to <a href='index'>admin-page</a>.</h4>
