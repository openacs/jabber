<master>
<property name ="title">Jabber</property>
<property name="context">conference</property>

<p>
The  Room '@room_name@' is Active, at the moment the Topic '@current_subject@' is disscused.<br><b> If you change the Topic, everything submitted to this Room will be appended to the discussion on Topic '@subject@'.<b>
</p>

<b>Room: @room_name@ <br> Current Topic: @current_subject@ <br> <I> New Topic: @subject@ </I></b>

<p>
<table>
<tr><th>Users in this Room</th></tr>
<multiple name=members > 
<tr><td><font color=@members.color@>@members.nick@</font></td></tr>
</multiple>
</table>
</p> 

<p>
Are you sure you want to 
<a href="append-chat-2.tcl?room_name=@room_name@&subject=@subject@&thread_id=@thread_id@&room_id=@room_id@&display_status=@display_status@&party_id=@party_id@">change </a> the Topic to @subject@ ? 
</p>

<p>
or you rather 
<a href="recorded-chat.tcl?name=@room_name@&thread_id=@thread_id@&party_id=@party_id@&subject=@subject@&display_status=@display_status@&room_id=@room_id@">return </a>, and don't change anything ?
</p>