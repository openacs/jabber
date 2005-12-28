--
--
-- package/jabber/sql/oracle/jabber-create.sql
-- @author Luis Mosteiro Fernandez
--
--

create table jb_services (
			  service	 varchar2(255) primary key,
			  pretty_name    varchar2(255),
				-- active_check_p to control whether service is avaiable (t) or not (f)
			  active_check_p char check(active_check_p in ('t','f'))
			 );


insert into jb_services (service , pretty_name , active_check_p) values ('jabber' , 'Jabber' , 't');
insert into jb_services (service , pretty_name , active_check_p) values ('aim' , 'AIM' , 't');
insert into jb_services (service , pretty_name , active_check_p) values ('yahoo' , 'Yahoo' , 't');
insert into jb_services (service , pretty_name , active_check_p) values ('msn' , 'MSN' , 't');
insert into jb_services (service , pretty_name , active_check_p) values ('icq' , 'ICQ' , 't');



-- Screen
-- Definition as an object
-- Screen saves every screenname, it can be taken as a buddylist
-- users within the OACS System can have several screens, because they can be member in different im-systems
-- moreover the screens of external users are stored in this table
-- implementation as object, because it is imaginable to put a permission
-- on the screenname so not everyone can add this screen to his buddylist

begin
acs_object_type.create_type (
supertype      => 'acs_object',
object_type    => 'jb_screen',
pretty_name    => 'Screen',
pretty_plural  => 'Screens',
table_name     => 'JB_SCREENS',
id_column      => 'SCREEN_ID'
);
end;
/
show errors;


declare
	attr_id acs_attributes.attribute_id%TYPE;
begin
	attr_id := acs_attribute.create_attribute (
	object_type	=> 'jb_screen',
	attribute_name	=> 'user_id',
	pretty_name	=> 'User ID',
	pretty_plural	=> 'User IDs',
	datatype	=> 'integer'
	);

	attr_id := acs_attribute.create_attribute (
	object_type     => 'jb_screen',
	attribute_name  => 'im_screen_name',
	pretty_name     => 'IM Screen Name',
	pretty_plural   => 'IM Screen Names',
	datatype        => 'string'
	);

	attr_id := acs_attribute.create_attribute (
	object_type     => 'jb_screen',
	attribute_name  => 'service',
	pretty_name     => 'Service',
	pretty_plural   => 'Services',
	datatype        => 'string'
	);

	attr_id := acs_attribute.create_attribute (
	object_type     => 'jb_screen',
	attribute_name  => 'status',
	pretty_name     => 'Status',
	pretty_plural   => 'Status',
	datatype        => 'string'
	);

	attr_id := acs_attribute.create_attribute (
	object_type     => 'jb_screen',
	attribute_name  => 'away_msg',
	pretty_name     => 'Away_Message',
	pretty_plural   => 'Away_Messages',
	datatype        => 'string'
	);

	attr_id := acs_attribute.create_attribute (
	object_type     => 'jb_screen',
	attribute_name  => 'resourc',
	pretty_name     => 'Resource',
	pretty_plural   => 'Resources',
	datatype        => 'string'
	);

	attr_id := acs_attribute.create_attribute (
	object_type     => 'jb_screen',
	attribute_name  => 'refcount',
	pretty_name     => 'Reference_Count',
	pretty_plural   => 'Reference_Counts',
	datatype        => 'integer'
	);
end;
/
show errors;

create table jb_screens (
			screen_id       integer primary key references acs_objects(object_id),
				-- user_id is null, if the user is not member of the OACS
			user_id	 	integer references users(user_id), 
			im_screen_name  varchar2(255),  
			service         varchar2(255) references jb_services(service) ,
			status          varchar2(255),
			away_msg        varchar2(4000),
			resourc         varchar2(255),
			refcount        integer,
			unique (im_screen_name , service)
			);

create or replace package jb_screen
as

function new (
	screen_id		in jb_screens.screen_id%TYPE default null,
	user_id			in jb_screens.user_id%TYPE default null,
	im_screen_name		in jb_screens.im_screen_name%TYPE default null,
	service			in jb_screens.service%TYPE default null,
	status			in jb_screens.status%TYPE default null,
	away_msg		in jb_screens.away_msg%TYPE default null,
	resourc			in jb_screens.resourc%TYPE default null,
	refcount		in jb_screens.refcount%TYPE default null,
	object_type		in acs_object_types.object_type%TYPE default 'jb_screen',
	creation_date		in acs_objects.creation_date%TYPE default sysdate,
	creation_user		in acs_objects.creation_user%TYPE default null,
	creation_ip		in acs_objects.creation_ip%TYPE default null,
	context_id		in acs_objects.context_id%TYPE default null
) return jb_screens.screen_id%TYPE;

procedure delete (
	screen_id	in jb_screens.screen_id%TYPE
);
end jb_screen;
/
show errors





create or replace package body jb_screen
as

function new (
	screen_id		in jb_screens.screen_id%TYPE default null,
	user_id			in jb_screens.user_id%TYPE default null,
	im_screen_name		in jb_screens.im_screen_name%TYPE default null,
	service			in jb_screens.service%TYPE default null,
	status			in jb_screens.status%TYPE default null,
	away_msg		in jb_screens.away_msg%TYPE default null,
	resourc			in jb_screens.resourc%TYPE default null,
	refcount		in jb_screens.refcount%TYPE default null,
	object_type		in acs_object_types.object_type%TYPE default 'jb_screen',
	creation_date		in acs_objects.creation_date%TYPE default sysdate,
	creation_user		in acs_objects.creation_user%TYPE default null,
	creation_ip		in acs_objects.creation_ip%TYPE default null,
	context_id		in acs_objects.context_id%TYPE default null
) return jb_screens.screen_id%TYPE
is
	v_screen_id integer;
begin
	v_screen_id := acs_object.new (
	object_id	=> screen_id,
	object_type	=> object_type,
	creation_date	=> creation_date,
	creation_user	=> creation_user,
	creation_ip	=> creation_ip,
	context_id	=> context_id
	);


insert into jb_screens
	(screen_id, user_id, im_screen_name, service, status, away_msg, resourc, refcount)
values
	(v_screen_id, user_id, im_screen_name, service, status, away_msg, resourc, refcount);


return v_screen_id;
end new;

procedure delete (
	screen_id	in jb_screens.screen_id%TYPE
)
is
begin
	delete from jb_screens
	where screen_id = jb_screen.delete.screen_id;

	acs_object.delete(screen_id);
end delete;

end jb_screen;
/
show errors;


-- jb_user_jabber_information
-- this table stores jabber login information for each user

create table jb_user_jabber_information (
			user_id 	 integer primary key references users(user_id),
			jabber_regstate  char(2),
			jabber_passwd	 varchar2(16),	
			autologin	 char(2) check (autologin in ('t','f'))
			);

-- jb_subscription_request


create table jb_subscription_requests (
			-- screen is a full Jabber-ID
			screen            varchar2(255) primary key,
			asked             date
			);
-- jb_message_log
-- log table for messages

create sequence jb_message_log_seq start with 1;

create table jb_message_log (
			message_id   integer primary key,
			user_id      integer references users(user_id),
			message      VARCHAR2(4000),
			send         date,
			conn_state   varchar(2),
				-- receive jabber_id 
			receive_jid  varchar2(1000)  
			); 

-- jb_xml_to_send

create table jb_xml_to_send ( 
			xml     blob,
			stored  date
			);




-- jb_friends
-- this table stores information for all user friends (whether external or internal friends)

create table jb_friends (
			user_id		    integer references users(user_id),
			friend_screen_id    integer references jb_screens(screen_id),
			friend_first_name   varchar2(255),
			friend_last_name    varchar2(255),
			primary key(user_id , friend_screen_id)
			);


-- Conference Room
-- implementation as object to use the permissioning system


begin
acs_object_type.create_type (
supertype      => 'acs_object',
object_type    => 'jb_conference_room',
pretty_name    => 'Conference Room',
pretty_plural  => 'Conference Rooms',
table_name     => 'JB_CONFERENCE_ROOMS',
id_column      => 'room_id'
);
end;
/
show errors;



declare
attr_id acs_attributes.attribute_id%TYPE;
begin
	attr_id := acs_attribute.create_attribute (
	object_type     => 'jb_conference_room',
	attribute_name  => 'creator_jabber_id',
	pretty_name     => 'Creator Jabber ID',
	pretty_plural   => 'Creator Jabber IDs',
	datatype        => 'string'
	);
	
	attr_id := acs_attribute.create_attribute (
	object_type	=> 'jb_conference_room',
	attribute_name  => 'name',
	pretty_name     => 'Name',
	pretty_plural	=> 'Names',
	datatype	=> 'string'
	);
	
	attr_id := acs_attribute.create_attribute (
	object_type	=> 'jb_conference_room',
	attribute_name	=> 'description',
	pretty_name	=> 'Description',
	pretty_plural	=> 'Descriptions',
	datatype	=> 'string'
	);
end;
/	
show errors;

create table jb_conference_rooms ( 
			room_id                 integer primary key references acs_objects(object_id),
			creator_jabber_id       varchar2(255),
				-- jabber_id of the creator
				-- only users having a jabber_id can create a conference room
				-- jabber_ids look like: screen_name_of_the_service@service_name.jabber_server
				-- therefore it has to be varchar
			name                    varchar(100) unique,  
			description             varchar(1000),
                        type                    varchar2(15)
			);


create or replace package jb_conference_room
as

function new (
	room_id			in jb_conference_rooms.room_id%TYPE default null,
	creator_jabber_id	in jb_conference_rooms.creator_jabber_id%TYPE default null,
	name			in jb_conference_rooms.name%TYPE default null,
	description		in jb_conference_rooms.description%TYPE default null,
	object_type		in acs_object_types.object_type%TYPE default 'jb_conference_room',
	creation_date		in acs_objects.creation_date%TYPE default sysdate,
	creation_user		in acs_objects.creation_user%TYPE default null,
	creation_ip		in acs_objects.creation_ip%TYPE default null,
	context_id		in acs_objects.context_id%TYPE default null
) return jb_conference_rooms.room_id%TYPE;

procedure delete (
	room_id	in jb_conference_rooms.room_id%TYPE
);
end jb_conference_room;
/
show errors


create or replace package body jb_conference_room
as

function new (
	room_id			in jb_conference_rooms.room_id%TYPE default null,
	creator_jabber_id	in jb_conference_rooms.creator_jabber_id%TYPE default null,
	name			in jb_conference_rooms.name%TYPE default null,
	description		in jb_conference_rooms.description%TYPE default null,
	object_type		in acs_object_types.object_type%TYPE default 'conference_room',
	creation_date		in acs_objects.creation_date%TYPE default sysdate,
	creation_user		in acs_objects.creation_user%TYPE default null,
	creation_ip		in acs_objects.creation_ip%TYPE default null,
	context_id		in acs_objects.context_id%TYPE default null
) return jb_conference_rooms.room_id%TYPE
is
v_room_id integer;
begin
v_room_id := acs_object.new (
	object_id	=> room_id,
	object_type	=> object_type,
	creation_date	=> creation_date,
	creation_user	=> creation_user,
	creation_ip	=> creation_ip,
	context_id	=> context_id
	);


insert into jb_conference_rooms
	(room_id, creator_jabber_id, name, description)
values
	(v_room_id, creator_jabber_id, name, description);


return v_room_id;
end new;

procedure delete (
	room_id	in jb_conference_rooms.room_id%TYPE
)
is
begin
	delete from jb_conference_rooms
	where room_id = jb_conference_room.delete.room_id;

acs_object.delete(room_id);
end delete;

end jb_conference_room;
/
show errors;






-- Conference Room Thread
-- no implementation as object
-- user permission controlled for entire room, not for a single thread 




create sequence jb_conference_room_threads_seq start with 1;

create table jb_conference_room_threads (
	thread_id         integer primary key,
	room_id	          integer not null references jb_conference_rooms(room_id),
	start_time	  date,	
	end_time          date,
	subject           varchar2(200),
	description       varchar2(1000),
	creator_jabber_id varchar2(255),
	creator_user_id   integer references users(user_id)                                                      
	);


-- Maps Rooms to the threads where the dicussion Started, for storing the structure of a discussion on an major topic, that maybe
-- displayed later .



create  table jb_room_start_from_thread (
                                                  thread_id     not null references jb_conference_room_threads(thread_id),
                                                  room_id       not null references jb_conference_rooms(room_id),
                                                  primary key(thread_id , room_id)
                                                  );



-- maps a Room to a Party so oher users/groups can posibly browes the discussions.

create table jb_room_party_map (
                                party_id      not null references parties(party_id),
                                room_id       not null references  jb_conference_rooms(room_id),
                                primary key (party_id , room_id) 
	                       );

-- stores the group_id's that have access to the conference system
-- conference_only_p indicates if this group was created for conferencing ('t') and we (jabber admin) may be allowed to change it,
-- or if this groups originated some where else in the package.


create table jb_conference_groups (
                                  group_id primary key references groups(group_id),
				  conference_only_p  char(1) default 't' check (conference_only_p in ('t' , 'f') ),
                                  default_room_id unique references jb_conference_rooms(room_id)
                                  );  


create table jb_groups_blocked_conference(
	                                    group_id primary key references groups(group_id)
				             );


-- IMPORTANT
-- creation of a dummy conference room and conference room thread, so the C-module can work!
-- C-module has an own sequence for the threads, but it needs to have a start point, so the database has to provide this start point




create table jb_conference_protocols (
	jabber_id   varchar2(100),
	user_id	    integer references users(user_id),
	message     varchar2(1000),
	stored      date,
	room_id     integer references jb_conference_rooms(room_id),
	thread_id   integer references jb_conference_room_threads(thread_id)   
	) ;

create index jb_conference_protocols_id on jb_conference_protocols(room_id, thread_id);





-- Now come some PL/SQL procedures and functions, which are used by the c-modules

-- validate whether user is registered

create or replace procedure jb_reg_validation(screen_in IN varchar2 , regstate IN varchar2)  is
          v_user_id jb_screens.user_id%TYPE;     
    BEGIN 
     v_user_id := v_user_id;     
 
    END;
  

/
 
show errors
 
-- Update the online state of a user
create or replace procedure jb_update_status (status_in IN varchar2 , resourc_in IN varchar2 , screen_in IN varchar2 , service_in IN varchar2) 
IS
service_long varchar2(255);
BEGIN

   IF service_in = 'a' THEN
	service_long := 'aim' ;
   END IF;
   IF service_in = 'j' THEN
	service_long := 'jabber' ;
   END IF;
   IF service_in = 'm' THEN
	service_long := 'msn' ;
   END IF;
   IF service_in = 'r' THEN
	service_long := 'irc' ;
   END IF;
   IF service_in = 'i' THEN
	service_long := 'icq' ;
   END IF;
   IF service_in = 'y' THEN
	service_long := 'yahoo' ;
   END IF;

	
   update jb_screens SET status = status_in , resourc= resourc_in WHERE LOWER(im_screen_name)=LOWER(screen_in) and service = service_long;
 
   commit;

END;

/

show errors


-- Clear the online states of every one on Login or Logout

create or replace procedure jb_clear_status 
IS
Begin
update jb_screens SET status='offline' , resourc='offline';
commit;
End;
/
show errors
 



--checks if jid_in is in the table of the subscription requests , we store them in ther because we may have to wait 
--for a while till some one (jid_in) answers the request, it returns 0 in case there is nothing known about jid_in
--or n > 0  in case there is something known about jid_in 
     
create or replace function jb_subscription_check (jid_in IN varchar2)
return integer
AS r_exists integer;
BEGIN
 r_exists := 0;
 select count(screen) into r_exists from jb_subscription_requests where lower(screen) = lower(jid_in) ;

 return r_exists;
END;

/

show errors




--inserts a new subscription request

create or replace procedure jb_subscription_insert(jid_in IN varchar2)
IS
BEGIN
    insert into jb_subscription_requests (screen , asked ) values ( jid_in , sysdate);
    commit;
END;

/
show errors

--removes a certain subscription request

create or replace procedure jb_subscription_del (jid_in IN varchar2)
IS
BEGIN
          delete from jb_subscription_requests where lower(screen) = lower(jid_in);
          commit;
END;

/
show errors




--Find the user_id to a given jid, when someone invites us through  sending a jabber invite from his jabber client:

create or replace function jb_get_user_id (screen_in IN varchar2) return integer AS r_user_id integer;  

BEGIN

        Select persons.person_id INTO r_user_id
        FROM persons,  jb_screens
        WHERE persons.person_id = jb_screens.user_id
        AND jb_screens.service = 'jabber'
        AND jb_screens.im_screen_name = screen_in;

        return r_user_id;

END;

/

show errors





--Get the jid from a given user_id 

create or replace function jb_get_jid (user_id_in IN integer) return VARCHAR2 AS r_jid varchar2(150);
BEGIN
  
 Select sn.im_screen_name INTO r_jid 
 FROM jb_screens sn 
 WHERE sn.user_id = user_id_in 
 AND sn.service = 'jabber';

 return r_jid;

END;
/
show errors




--if a room is destroyed or the topic changes, the  discussion on the last topic (thread) ends ,insert this time as thread end time:
 

create or replace procedure jb_conference_thread_finish(thread_id_in IN integer)
IS
BEGIN
     update jb_conference_room_threads set end_time = sysdate where thread_id = thread_id_in;
     commit;
END;
/
show errors





--When a room starts or the  topic changes a new Thread is created :


create or replace procedure jb_conference_thread_new (thread_id_in IN integer ,  room_id_in IN integer , subject_in IN varchar2 , creator_jid_in IN varchar2 , creator_user_id_in IN integer)
IS

BEGIN

 IF creator_user_id_in = 0 THEN

   insert into jb_conference_room_threads (thread_id , room_id , start_time , subject , creator_jabber_id )
   values (thread_id_in , room_id_in , sysdate , subject_in , creator_jid_in );

 ELSE
  
   insert into jb_conference_room_threads (thread_id , room_id , start_time , subject , creator_jabber_id , creator_user_id )
   values (thread_id_in , room_id_in , sysdate , subject_in , creator_jid_in , creator_user_id_in);

 END IF;

 commit;  

END;

/
show errors



--When a message is received from a conference room it is stored in the db:

 
create or replace procedure jb_conference_message(jid_in IN varchar2 , message_in IN varchar2 , room_id_in IN integer , thread_id_in IN integer , user_id_in IN integer)
IS
BEGIN

  IF user_id_in = 0 THEN
    
       insert into jb_conference_protocols (jabber_id , message , stored , room_id , thread_id )
       values (jid_in , message_in , sysdate , room_id_in , thread_id_in );

  ELSE 

      insert into jb_conference_protocols (jabber_id , user_id , message , stored , room_id , thread_id)
      values  (jid_in , user_id_in , message_in , sysdate , room_id_in , thread_id_in );

  END IF;

 COMMIT;

END;
/
show errors;






-- When a room is created (it is maybe recreated every Monday at 8:00 ) see if we already have a room_id for that room.

create or replace function jb_conference_room_check(room_name_in IN varchar2 ) return integer AS r_room_id integer;
BEGIN
      r_room_id := -1;

      select room_id  INTO r_room_id from jb_conference_rooms where lower(name)=lower(room_name_in);

     return r_room_id;

END;
/
show errors





-- When a room is fully new created , create a new Table entry. We do not use the room_id given by the c-module due to the fact that 
-- conference_room is implemented as object


create or replace procedure jb_conference_rooms_new ( user_id_in IN integer , creator_jid_in IN varchar2 , name_in IN varchar2 , description_in IN varchar2) 
IS

BEGIN
  
  
  IF user_id_in = 0 THEN


	declare
	id integer;
	begin
	id := jb_conference_room.new (
		creator_jabber_id => creator_jid_in ,
		name => name_in ,
		description => description_in ,
		object_type => 'jb_conference_room'
		);
	end;


  ELSE

	declare
	id integer;
	begin
	id := jb_conference_room.new (
		creator_jabber_id => creator_jid_in ,
		name => name_in ,
		description => description_in ,
		object_type => 'jb_conference_room' ,
		creation_user => user_id_in
		);
	end;

		
     
  END IF;


 COMMIT;

END;

/
show errors



-- Get the next room_id. This procedure is used in the database to get a new room_id, but it takes the ACS3.x datamodel as basis
-- In the OACS4.x datamodel conference_room is implemented as object, so we do not have a sequence, but we do not want the c-module
-- generate an error, so we give him an integer back, but we do not use this room_id (look above)

create or replace function jb_conference_next_room_id return integer AS r_room_id integer;
BEGIN
  SELECT count(*) INTO r_room_id FROM jb_services;
 
  return r_room_id;
END;
/
show errors 



-- Get the next thread_id

create or replace function jb_conference_next_thread_id return integer AS r_thread_id integer;
BEGIN
  
  SELECT  jb_conference_room_threads_seq.nextval INTO r_thread_id from dual;
  
  return r_thread_id;

END;

/
show errors 

@jabber-notification-create.sql