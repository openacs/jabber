<master>
<property name=title>JABBER ADMIN PAGE</property>
          

<p align = center><h1>JABBER ADMIN PAGE</h1></p>
<hr>
            
<p><a href="conference">Conference Groups Administration</a></p>
<p><a href="../jabber-login?return_url=@url@">Start the JabberApplet</A></p>
             
  
<hr>
          <table>
            <tr><td width=30%><h2>Client Control:</h2>  
                    <table>
                    <tr><td height=25><b>Connection State:</b></td>
                    <if @state@ eq 0>
                        <td><font color=red> OFFLINE</font></td>
                    </if>
                    <else>
                        <td><font color=green> ONLINE</font></td>
                    </else>
                    </tr>
                    <tr><td height=56></td><td></td></tr> 
                    <tr><td><formtemplate id="login"></formtemplate>
                        </td>
                        <td><formtemplate id="logout"></formtemplate>
                        </td>
                    </tr>
                    </table> 
                 </td>
		 <td width=30%><h2>Add New IM-Service:</h2>
		    <table>
		    <formtemplate id="service-add"></formtemplate>
		    </table>
	     </tr>
             <tr><td><h4> Show <a href="online-users">online users</a></h4>
                 <br>
                 <h4>Show <a href="jabber-users">registered users</a><br><a href="user-register">Search and register</a> non registered users</h4></td>
		 <td><h4><a href="service-view">Services view/deactivate</a></h4></td>
            </tr> 
           </table>   
<hr>          
            <h4><a href="view-users?action=add">Add Buddy to User's roster</a></h4> 
            <h4><a href="view-users?action=remove">Remove Buddy from User's roster</a></h4>                  
<hr>
          <table width=50%>
            <tr><td><h4>Send message:</h4>  
                    <table>
		    <formtemplate id="message"></formtemplate>
                    </table>
		 <td></td>
		 <td></td>
		 <td></td>
                 <td valign="top"><h4>Start Chat:</h4>
                    <table>
		    <formtemplate id="chat"></formtemplate>
                    </table>
                 </td>
             </tr>
           </table>   










