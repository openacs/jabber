
--
-- package/jabber/sql/oracle/jabber-notification-create.sql
-- @author Bjoern Kiesbye
-- @email bkiesbye@sussdorff-roy.com
--




-- This function calls register the jabber package with the service-contracts as implementation 
-- for the DeliveryMethod interface of the  notification package.


-- implemeting the notification::imessage::send_or_mail function.
 
declare
   impl_id      integer;
   foo           integer;
begin
   
   impl_id := acs_sc_impl.new (
              'NotificationDeliveryMethod',
              'notification_imessage_or_email',
              'jabber'
          );
   

   foo := acs_sc_impl_alias.new (
              'NotificationDeliveryMethod',
              'notification_imessage_or_email',
              'Send',
              'notification::imessage::send_or_email',
              'TCL'
          );


   acs_sc_binding.new (
              contract_name => 'NotificationDeliveryMethod',
              impl_name => 'notification_imessage_or_email'
          );                             


   foo:= notification_delivery_method.new(
       short_name => 'imessage_or_email',
       sc_impl_id => impl_id,
       pretty_name => 'Instant Message or Email',
       creation_user => null,
       creation_ip => null
   );
   
        
end;
/
show errors

-- implemeting the notification::imessage::send_and_mail function.

declare
   impl_id      integer;
   foo           integer;
begin
   
   impl_id := acs_sc_impl.new (
              'NotificationDeliveryMethod',
              'notification_imessage_and_email',
              'jabber'
          );
   

   foo := acs_sc_impl_alias.new (
              'NotificationDeliveryMethod',
              'notification_imessage_and_email',
              'Send',
              'notification::imessage::send_and_email',
              'TCL'
          );


   acs_sc_binding.new (
              contract_name => 'NotificationDeliveryMethod',
              impl_name => 'notification_imessage_and_email'
          );                             


   foo:= notification_delivery_method.new(
       short_name => 'imessage_and_email',
       sc_impl_id => impl_id,
       pretty_name => 'Instant Message and Email',
       creation_user => null,
       creation_ip => null
   );
   
        
end;
/
show errors

@jabber-notification-forum-create.sql

