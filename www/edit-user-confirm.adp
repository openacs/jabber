
<master>

<property name="title">Edit Contact Information</property>
<property name="context"></property>

<h1>Please confirm your changes</h1>

<form action="edit-user-2.tcl" method="post">
<multiple name=new_im_contacts >
<p>
@new_im_contacts.pretty_name@ : @new_im_contacts.im_screen_name@
</p>

<input name="screen_name.@new_im_contacts.service@" type="hidden" size="40" value="@new_im_contacts.im_screen_name@" >

</multiple>
<input type="submit" name="sub1" value="Confirm">
<hr>

<a href="index.tcl">Back to index page</a>

