
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

drop package jb_screen;
drop table jb_screens;
execute acs_object_type.drop_type('jb_screen');
show errors



drop package jb_conference_room;
drop table jb_conference_rooms;
execute acs_object_type.drop_type('jb_conference_room');
show errors

drop table jb_services;
drop sequence jb_message_log_seq;

drop procedure jb_reg_validation;
drop procedure jb_update_status;
drop procedure jb_clear_status;
drop function jb_subscription_check;
drop procedure jb_subscription_insert;
drop procedure jb_subscription_del;
drop function jb_get_user_id;
drop function jb_get_jid;
drop procedure jb_conference_thread_finish;
drop procedure jb_conference_thread_new;
drop procedure jb_conference_message;
drop function jb_conference_room_check;
drop procedure jb_conference_rooms_new;
drop function jb_conference_next_room_id;
drop function jb_conference_next_thread_id;
