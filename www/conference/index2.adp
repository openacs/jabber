<master>
<property name ="title">Jabber</property>
<property name="context">@context@</property>
<p><B>Bold entrys indicate Rooms, Rooms are indexed by Upper Letters . If there is some one in the Room you can <I>enter</I> the Room.
If there is no one in the Room you can <I> Restart it</I></B></P>
<p>Plain Entrys are indexed by numbers, they describe topics that where discussed in the above <B>Room</B>  , you can <I>Read</I> the discussions. <BR> Every Topic may have one ore more <B>Room Entrys</B>  diplayed just beneath them , those <B>Rooms</B> where created to to discuss a sub Topic of the above displayed major Topic    </P>
<if @is_room_table@  eq true>
 <OL type=A>
    
     <multiple name="rooms_table">
      <LI><B>@rooms_table.room_name@ 
        <if @rooms_table.active@  eq true>
            <a href="@rooms_table.active_value@">Enter</a>
        </if> 
        <if @rooms_table.active@  eq false>
           <a href="room-create.tcl?room_id=@rooms_table.room_id@&roomname=@rooms_table.room_name@&roomsubject=Restarted_at_@time@&threadname=Room_@rooms_table.room_name@_Restarted_at_@time@&threadsubject=Room_@rooms_table.room_name@_Restarted_at_@time@&party_id=@rooms_table.party_id@">Restart</a> 
        </if>
           
     </B>@rooms_table.thread_table@</LI> <HR/>
   
     </multiple>
    </OL> 
</if>
<if @is_room_table@  eq false>
 You don't have access to any rooms Yet
</if> 