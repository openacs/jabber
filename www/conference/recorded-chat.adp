<master>
<property name ="title">Jabber</property>
<property name="context"></property>





<h3>Recorded Chat from<br> Room: @name@<br>Subject: @subject@</h3><br> 
<p><a href="append-chat?room_name=@name@&subject=@subject@&thread_id=@thread_id@&room_id=@room_id@&display_status=@display_status@&party_id=@party_id@">Pic up Topic</a>  <br>(Here you can restart the discussion on this Topic. All new submissions will be appended to the end of this document. )</p>


<table>
<formtemplate id="room_create"></formtemplate>
</table>
Here you can create a new Room to discuss a sub Topic of the current Topic. The new Room will be displayed next to the current Topic.
<p></p>
<Table >
<tr><th>Nick</th><th align=left>Message</th><th>Date</th></tr>
<multiple name=msg>
<tr>
<if @msg.link@  eq true>
<td>
<%set dummy [lindex [lindex  $msg_list $msg_list_count] 3]
  incr msg_list_count    
%><%=$dummy%></td>
<!--
<td>@msg.link_url@</td>
-->
</if>
<else>
<td>@msg.nick@</td>
</else>


<td>@msg.text@</td><td>@msg.date@</td></tr>
</multiple>
</table>
