<master>
<property name="title">Remove registered user</property>


<h2>Remove registered user</h2>

<if @success@ eq 0>
 <p>We had problems processing your data, we could not remove the user from the the Jabber server. Database transaction was aborted!</p>
</if>

<if @delete_screens_check eq 0>
 <p>DML statement failed!</p>
</if>

<if @delete_jabber_information_check@ eq 0>
 <p>DML statement failed!</p>
</if>