<master>
<property name ="title">Jabber</property>
<property name="context">Conference</property>
<h4><a href='help'>Help</a></h4>
<p>Visite Conferences of Group:</P>
<UL>
<multiple name=groups>
<LI><a href='main.tcl?group_id=@groups.group_id@'>@groups.group_name@</a></LI>
</multiple>
</UL>


<if @is_room_table@  eq true>
<H3>New  Topics since your last Visit!</H3> 
 <OL type=A> 
      
     <multiple name="rooms_table">
      <LI>@rooms_table.room_name@
        <if @rooms_table.active@  eq true>
            <a href="@rooms_table.active_value@">Enter</a>
        </if> 
        <if @rooms_table.active@  eq false>
            <a href="room-create.tcl?room_id=@rooms_table.room_id@&roomname=@rooms_table.room_name@&roomsubject=Restarted_at_@time@&threadname=Room_@rooms_table.room_name@_Restarted_at_@time@&threadsubject=Room_@rooms_table.room_name@_Restarted_at_@time@&party_id=@rooms_table.party_id@&restart=true&return_url=index.tcl">Restart</a> 
        </if>
           
      <td align=left valigen=top>@rooms_table.thread_table@</LI>
     </multiple>
 
</if>
<if @is_room_table@  eq false>
 You don't have access to any rooms Yet
</if> 