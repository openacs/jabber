<master>
<property name="title">Register user to the Jabber Server</property>

<h1>Register user to the Jabber Server</h1>

<p>Here you can search for Users, who are not registered to the Jabber Server yet, so you can register them now!</p>
 
<table>
<tr><td align=left>
<p>Search for <b>Users</b> who's First or Last Name starts with: </p>
<formtemplate id="search"></formtemplate>
</td>
</table>

<a name='result'></a>

<if @multi@ eq users>
<p>You can add this @multi@ to the Jabber Server</p>
<UL>
<multiple name=partys>
 <LI><a href="user-register-2.tcl?user_id=@partys.party_id@&user_prefix=@user_prefix@">@partys.name@</a></LI>
</multiple>
</UL>
</if>


<br>
<br>
<br>
<p>Back to <a href="index">admin-page</a></p>
