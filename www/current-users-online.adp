<master>
<property name="title">Current users online</property>
<property name="context">@context@</property>

<p>Here you can see all users online, who are not in your buddy list yet sorted by the prefix of their last name!</p>

<p>
<multiple name="prefix_links">
<if @prefix_links.prefix@ not eq @prefix@>
<a href="current-users-online?prefix=@prefix_links.prefix@">@prefix_links.prefix@</a>&nbsp;|&nbsp;
</if>
<else>
@prefix_links.prefix@&nbsp;|&nbsp;
</else>
</multiple>
</p>


  <if @any_is_online_p@ eq 1>
  <table width='700' border='0' bgcolor='#666666' cellpadding='1' cellspacing='0'>
   <tr>
    <td>
      <table width='700' border='0' bgcolor='#FFFFFF'>
        <tr bgcolor='#999999'> 
          <td colspan='8'><b><font color='#FFFFFF'>Other Community Users Online</font></b></td>
        </tr>
        <multiple name=other_status>
         <tr>
          <td width='20%'>@other_status.first_names@ @other_status.last_name@</td>
          <td width='20%'><a href='buddy-add?friend_id=@other_status.any_user_id@&return_url=index'>Add to friends</a></td>
          <!-- <group column="any_user_id"> -->
          <td width='10%'><div align='center'><a href='message?screen=@other_status.create_jid@&screen_id=@other_status.any_screen_id@'>
          <img src='image/@other_status.service@_@other_status.status@.gif' width='18' height='25'></a>
          </div>
          </td>
         <!-- </group>-->
          <td width='10%'><div align='center'><a href='@other_status.chat@'>Chat</a></div></td></tr>
        <!--  <td width='10%'><div align='center'><a href='notify?friends_user_id=@other_status.any_user_id@'>Notify</a></div></td></tr> -->
        </multiple>
      </table>
    </td>
   </tr>
  </table>
  </if>
  <else>
  <p>There are no users with the prefix @prefix@, who are online now and not in your list!</p>
  </else>