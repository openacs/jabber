<master>
<property name="title">Register user</property>

<if @connstate@ eq -1>
<h1> Sorry, the IM Service is not avaiable now, please try again later. </h1>
<br>
<br>
<br>
<p>Back to <a href="index">admin-page</a></p>
</if>
<else>
<h1>Register user</h1>
   <table>
     <tr>
      <td>
      <if @reg_error@ eq exists>
       <font color='red'>The screen name you typed in is already in use!</font>
      </if>
      <if @reg_error@ eq nothing>
       <font color='red'>Please fill in the form to register user with Jabber!</font>
      </if> 
      </td>
     </tr>
     <tr>
     <td><formtemplate id="user-register"></formtemplate>
     </td>
     </tr>
    </table>
<br>
<br>
<br>
<p>Back to <a href="user-register?user_prefix=@user_prefix@">search list</a>
<br>
Back to <a href="index">admin-page</a></p>
</else>