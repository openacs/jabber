
<master>

<property name="title">Edit Contact Information</property>
<property name="context"></property>

<h1>Please confirm your Entrys!</h1>
Or backup your Browser to coreckt your Entrys!
 
<p>
First Name: @first_names@
</p>
<p>
Last Name: @last_name@
</p>

<form action="add-external-contact-2.tcl" method="post">
<input type="hidden" name="first_names" value="@first_names@">
<input type="hidden" name="last_name" value="@last_name@">

<multiple name=new_im_contacts >

<if @new_im_contacts.display@ eq true >
<p>
@new_im_contacts.pretty_name@ : @new_im_contacts.im_screen_name@
</p>
</if>
<input name="screen_name.@new_im_contacts.service@" type="hidden"  value="@new_im_contacts.im_screen_name@" >
</multiple>
<input type="submit" name="sub1" value="Confirm">
</form>
<hr>

<a href="index.tcl">Back to index page</a>

