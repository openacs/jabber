--
-- package/jabber/sql/oracle/jabber-notification-forum-create.sql
-- @author Bjoern Kiesbye
-- @email bkiesbye@sussdorff-roy.com
--

-- This code registers the forum (package) with the
-- new NotificationMethodImplementations from the jabber package.
-- When the forum (package is re/installed after the jabber package)
-- the code from this from this file should run after the forum instalation.
-- This hack should be part of the forums package.
-- Comment: it should not be a hack like this anyway , the service contract is responsible
-- ,to let every App., that is interested in making use of the NotificationDeliveryMethod interface,
-- get access to all implementations of this interface. The Notification package is able to handle
-- more then one implementation of its interface (like it should by openacs definition)
-- but the service contract package doesn't seem to be able to properly populate multiple implementations
-- of the same interface (service contract). Even if it allows multiple implementations to exist

declare
v_type_id_message int;
v_delivery_method_id_and  notification_types_del_methods.delivery_method_id%TYPE;
v_type_id_thread notification_types_del_methods.type_id%TYPE;
v_delivery_method_id_or notification_types_del_methods.delivery_method_id%TYPE;
begin
        SELECT delivery_method_id INTO v_delivery_method_id_and FROM notification_delivery_methods WHERE short_name like('imessage_and_email');

        SELECT delivery_method_id INTO v_delivery_method_id_or FROM notification_delivery_methods WHERE short_name like('imessage_or_email');

        SELECT type_id INTO v_type_id_message FROM notification_types WHERE short_name like('forums_message_notif');

        SELECT type_id INTO v_type_id_thread FROM notification_types WHERE short_name like('forums_forum_notif');

        insert into notification_types_del_methods  (type_id, delivery_method_id)
        values ( v_type_id_thread ,v_delivery_method_id_and);

        insert into notification_types_del_methods  (type_id, delivery_method_id)
        values ( v_type_id_thread , v_delivery_method_id_or );

        insert into notification_types_del_methods  (type_id, delivery_method_id)
        values ( v_type_id_message , v_delivery_method_id_and);

        insert into notification_types_del_methods  (type_id, delivery_method_id)
        values ( v_type_id_message , v_delivery_method_id_or);
end;
/
show errors
