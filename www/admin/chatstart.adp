<master>
<property name=title>Start Chat</property>


<h1>Start Chat:</h1><hr>

<if @success@ eq -1>
	<h2>Jabber Client Offline!</h2>
</if>
<if @success@ eq 0>
	<h2>Chat started between: @user1@ and @user2@!</h2>
</if>

<br>
<br>
<hr>
<h4>Back to <a href='index'>admin-page</a></h4>






