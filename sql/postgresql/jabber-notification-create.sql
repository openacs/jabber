
--
-- package/jabber/sql/oracle/jabber-notification-create.sql
-- @author Bjoern Kiesbye
-- @email bkiesbye@sussdorff-roy.com
--




-- This function calls register the jabber package with the service-contracts as implementation 
-- for the DeliveryMethod interface of the  notification package.


-- implemeting the notification::imessage::send_or_mail function.


create function inline_1() returns integer as '
declare
   impl_id      integer;
   foo           integer;
begin
   
   impl_id := acs_sc_impl__new (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_or_email'',
              ''jabber''
          );
   

   foo := acs_sc_impl_alias__new (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_or_email'',
              ''Send'',
              ''notification::imessage::send_or_email'',
              ''TCL''
          );

   foo := acs_sc_impl_alias__new (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_or_email'',
              ''ScanReplies'',
              ''notification::imessage::scan_replies'',
              ''TCL''
          );



PERFORM   acs_sc_binding__new (
             ''NotificationDeliveryMethod'',
             ''notification_imessage_or_email''
          );                             

   foo:= notification_delivery_method__new(
       NULL,
       impl_id,
       ''imessage_or_email'',
       ''Instant Message or Email'',
       now(),
       null,
       null,
       null
   );

   return(0);   
        
end;
' language 'plpgsql';
 


create function inline_1() returns integer as '
declare
   impl_id      integer;
   foo           integer;
begin
   
   impl_id := acs_sc_impl__new (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_and_email'',
              ''jabber''
          );
   

   foo := acs_sc_impl_alias__new (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_and_email'',
              ''Send'',
              ''notification::imessage::send_and_email'',
              ''TCL''
          );

   foo := acs_sc_impl_alias__new (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_or_email'',
              ''ScanReplies'',
              ''notification::imessage::scan_replies'',
              ''TCL''
          );



   perform acs_sc_binding__new (
               ''NotificationDeliveryMethod'',
               ''notification_imessage_and_email''
          );                             


   foo:= notification_delivery_method__new(
       NULL,
       impl_id,
       ''imessage_and_email'',
       ''Instant Message and Email'',
       now(),
       null,
       null,
       null
   );

   return(0);   
        
end;
' language 'plpgsql';

select inline_1();
drop function inline_1();
        

-- @jabber-notification-forum-create.sql

