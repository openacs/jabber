
<master>

<property name="title">Edit Contact Information</property>
<property name="context">Confirm</property>

<h1>Please confirm your changes</h1>

<form action="edit-external-contact-2.tcl" method="post">
<p>First Name : @friend_first_name@</p>
<p>Last Name : @friend_last_name@</p>
<input name="friend_first_name" type="hidden" size="40" value="@friend_first_name@" >
<input name="friend_last_name" type="hidden" size="40" value="@friend_last_name@" >
<input name="friend_last_name_old" type="hidden" size="40" value="@friend_last_name_old@" >
<input name="friend_first_name_old" type="hidden" size="40" value="@friend_first_name_old@" >
<multiple name=new_im_contacts >

<p>
@new_im_contacts.pretty_name@ : @new_im_contacts.im_screen_name@
</p>

<input name="im_screen_name.@new_im_contacts.service@" type="hidden" size="40"  value="@new_im_contacts.im_screen_name@" >
<input name="im_screen_name_old.@new_im_contacts.service@" type="hidden" size="40"  value="@new_im_contacts.im_screen_name_old@" >
<input name="services.@new_im_contacts.service@" type="hidden" size="40"  value="@new_im_contacts.service@" >


</multiple>
<input type="submit" name="sub1" value="Confirm">
<hr>

<a href="index.tcl">Back to index page</a>
