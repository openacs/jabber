<master>
<property name=title>Send Message</property>

<hr>
<p> To: @screen@<br>
    Your message: @message@
</p>

<if @user_check_p@ eq 1>
	<if @success@ eq -1> 
		<h2><p> The Instant Messaging System is not available.<br>
	       		The Message will be send as soon it becomes available!</p>
         	</h2>
	</if>
	<else>
     		<h2> Message has been sent and logged! </h2>
	</else>
</if>
<else> 
	<h3>We had problems to find out who you are. All messages are logged.</h3>
</else>


<br>
<br>
<hr>
<h4>Back to <a href=index>Index page</a>.</h4>



