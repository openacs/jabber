
create function inline_0() returns integer
as '
declare

tmp_id integer;

begin

select delivery_method_id into tmp_id from notification_delivery_methods where short_name = ''imessage_or_email'';
perform notification_delivery_method__delete(tmp_id);
select delivery_method_id into tmp_id from notification_delivery_methods where short_name = ''imessage_and_email'';
perform notification_delivery_method__delete(tmp_id);

perform acs_sc_binding__delete (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_or_email''
          );

perform acs_sc_binding__delete (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_and_email''
          );

perform acs_sc_impl_alias__delete (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_and_email'',
              ''Send''
          );
perform acs_sc_impl_alias__delete (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_and_email'',
              ''ScanReplies''
          );

perform acs_sc_impl_alias__delete (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_or_email'',
              ''ScanReplies''
          );

perform acs_sc_impl_alias__delete (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_or_email'',
              ''Send''
          );

perform acs_sc_impl__delete (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_or_email''
          );

perform acs_sc_impl__delete (
              ''NotificationDeliveryMethod'',
              ''notification_imessage_and_email''
          );

return 0;

end;' language 'plpgsql';

select inline_0();
drop function inline_0();

drop table jb_xml_to_send;
drop table jb_message_log;
drop table jb_subscription_requests;
drop table jb_user_jabber_information;
drop table jb_conference_protocols;
drop table jb_friends;
drop table jb_room_start_from_thread;
drop table jb_room_party_map;
drop table jb_conference_room_threads;
drop table jb_conference_groups;

drop table jb_screens;

-- select acs_attribute__drop_attribute ('jb_screen', 'user_id');
-- select acs_attribute__drop_attribute ('jb_screen', 'im_screen_name');
-- select acs_attribute__drop_attribute ('jb_screen', 'service');
-- select acs_attribute__drop_attribute ('jb_screen', 'status');
-- select acs_attribute__drop_attribute ('jb_screen', 'away_msg');
-- select acs_attribute__drop_attribute ('jb_screen', 'resourc');
-- select acs_attribute__drop_attribute ('jb_screen', 'refcount');
select acs_object_type__drop_type ('jb_screen', 't');

drop table jb_conference_rooms;

-- select acs_attribute__drop_attribute ('jb_conference_room', 'creator_jabber_id');
select acs_object_type__drop_type ('jb_conference_room', 't');

drop table jb_services;
drop sequence jb_message_log_seq;

drop sequence jb_conference_room_threads_seq;
drop table jb_groups_blocked_conference;

drop function jb_screen__new (integer, integer, varchar, varchar, varchar, varchar, varchar, integer, varchar,timestamptz,integer,varchar,integer) ;
drop function jb_screen__delete (integer) ;
drop function jb_conference_room__new ( integer, varchar, varchar, varchar, varchar, timestamptz,integer,varchar,integer); 
drop function jb_conference_room__delete (integer);
drop function jb_reg_validation(varchar, varchar) ;
drop function jb_update_status (varchar, varchar, varchar, varchar); 
drop function jb_clear_status ();
drop function jb_subscription_check (varchar);
drop function jb_subscription_insert(varchar);
drop function jb_subscription_del (varchar);
drop function jb_get_user_id (varchar);
drop function jb_get_jid (integer);
drop function jb_conference_thread_finish(integer);
drop function jb_conference_thread_new (integer, integer, varchar, varchar, integer);
drop function jb_conference_message(varchar, varchar, integer, integer, integer);
drop function jb_conference_room_check(varchar); 
drop function jb_conference_rooms_new (integer, varchar, varchar, varchar);
drop function jb_conference_next_room_id ();
drop function jb_conference_next_thread_id ();



