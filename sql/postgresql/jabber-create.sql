--
--
-- package/jabber/sql/oracle/jabber-create.sql
-- @author Luis Mosteiro Fernandez
--
--

create table jb_services (
			  service	 varchar(255) primary key,
			  pretty_name    varchar(255),
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

create function inline_jab ()
returns integer as '
begin
perform acs_object_type__create_type (
 ''jb_screen'' ,
 ''Screen'' ,
 ''Screens'' ,
 ''acs_object'' ,
 ''JB_SCREENS'' ,
 ''SCREEN_ID'' ,
 ''jabber'' ,
 ''f'' ,
 null ,
 null
);

return null;
end;' language 'plpgsql';

select inline_jab();
drop function inline_jab();

  
select acs_attribute__create_attribute (
	'jb_screen',		   -- object_type    
	'user_id',					   -- attribute_name 
	'integer',					   -- datatype       
	'User ID',					   -- pretty_name    
	'User IDs',					   -- pretty_plural  
	null,						   -- table_name
	null,						   -- column_name
	null,					   -- default_value
	1,					   -- min_n_values
	1,					   -- max_n_values
	null,					   -- sort_order
	null,			   -- storage
	'f'					   -- static_p
);

  
select acs_attribute__create_attribute (
	'jb_screen',		   -- object_type    
	'im_screen_name',				   -- attribute_name 
	'string',					   -- datatype       
	'IM Screen Name',				   -- pretty_name    
	'IM Screen Names',				   -- pretty_plural  
	null,						   -- table_name
	null,						   -- column_name
	null,					   -- default_value
	1,					   -- min_n_values
	1,					   -- max_n_values
	null,					   -- sort_order
	null,			   -- storage
	'f'					   -- static_p
);

 
select acs_attribute__create_attribute (
	'jb_screen',		   -- object_type    
	'service',				   -- attribute_name 
	'string',					   -- datatype       
	'Service',				   -- pretty_name    
	'Services',				   -- pretty_plural  
	null,						   -- table_name
	null,						   -- column_name
	null,					   -- default_value
	1,					   -- min_n_values
	1,					   -- max_n_values
	null,					   -- sort_order
	null,			   -- storage
	'f'					   -- static_p
);

 
select acs_attribute__create_attribute (
	'jb_screen',		   -- object_type    
	'status',				   -- attribute_name 
	'string',					   -- datatype       
	'Status',				   -- pretty_name    
	'Status',				   -- pretty_plural  
	null,						   -- table_name
	null,						   -- column_name
	null,					   -- default_value
	1,					   -- min_n_values
	1,					   -- max_n_values
	null,					   -- sort_order
	null,			   -- storage
	'f'					   -- static_p
);


select acs_attribute__create_attribute (
	'jb_screen',		   -- object_type    
	'away_msg',				   -- attribute_name 
	'string',					   -- datatype       
	'Away_Message',				   -- pretty_name    
	'Away_Messages',				   -- pretty_plural  
	null,						   -- table_name
	null,						   -- column_name
	null,					   -- default_value
	1,					   -- min_n_values
	1,					   -- max_n_values
	null,					   -- sort_order
	null,			   -- storage
	'f'					   -- static_p
);


select acs_attribute__create_attribute (
	'jb_screen',		   -- object_type    
	'resourc',				   -- attribute_name 
	'string',					   -- datatype       
	'Resource',				   -- pretty_name    
	'Resources',				   -- pretty_plural  
	null,						   -- table_name
	null,						   -- column_name
	null,					   -- default_value
	1,					   -- min_n_values
	1,					   -- max_n_values
	null,					   -- sort_order
	null,			   -- storage
	'f'					   -- static_p
);


select acs_attribute__create_attribute (
	'jb_screen',		   -- object_type    
	'refcount',				   -- attribute_name 
	'integer',					   -- datatype       
	'Reference_Count',				   -- pretty_name    
	'Reference_Counts',				   -- pretty_plural  
	null,						   -- table_name
	null,						   -- column_name
	null,					   -- default_value
	1,					   -- min_n_values
	1,					   -- max_n_values
	null,					   -- sort_order
	null,			   -- storage
	'f'					   -- static_p
);


create table jb_screens (
			screen_id       integer primary key references acs_objects(object_id),
				-- user_id is null, if the user is not member of the OACS
			user_id	 	integer references users(user_id), 
			im_screen_name  varchar(255),  
			service         varchar(255) references jb_services(service) ,
			status          varchar(255),
			away_msg        varchar(4000),
			resourc         varchar(255),
			refcount        integer,
			unique (im_screen_name , service)
			);


-- Defining the jb_screen package functions


create or replace function jb_screen__new (integer , integer , varchar , varchar , varchar , varchar , varchar , integer , varchar , timestamp with time zone , integer , varchar , integer) 
returns integer as '
declare

	p_screen_id	  alias for $1;
        p_user_id	  alias for $2;
	p_im_screen_name  alias for $3;
	p_service         alias for $4;
	p_status          alias for $5;
	p_away_msg        alias for $6;
	p_resourc         alias for $7;
	p_refcount        alias for $8;
	p_object_type     alias for $9;	
	p_creation_date   alias for $10;
	p_creation_user	  alias for $11;
	p_creation_ip	  alias for $12;
	p_context_id      alias for $13;
 	v_screen_id       integer;
	v_refcount        integer;
	v_object_type       varchar(255);
begin


if p_object_type is null then
	v_object_type := ''jb_screen'';
else
       v_object_type := p_object_type;
end if;

if p_refcount is null then 
	v_refcount :=  0;
else
	v_refcount := p_refcount;
end if;


v_screen_id := acs_object__new (
		p_screen_id,
                v_object_type,
	        p_creation_date,
        	p_creation_user,
	        p_creation_ip,
	        p_context_id ,
		''t''
	);



insert into jb_screens
	(screen_id, user_id, im_screen_name, service, status, away_msg, resourc, refcount)
values
	(v_screen_id, p_user_id, p_im_screen_name, p_service, p_status, p_away_msg, p_resourc, p_refcount);

return v_screen_id;
end;' language 'plpgsql';






create function jb_screen__delete(integer)
returns integer as '
declare
 	p_screen_id  alias for $1;
begin



	delete from jb_screens
	where screen_id = p_screen_id;

	perform acs_object__delete(p_screen_id);

return p_screen_id;
end;' language 'plpgsql';



-- jb_screen Package definition end


-- jb_user_jabber_information
-- this table stores jabber login information for each user

create table jb_user_jabber_information (
			user_id 	 integer primary key references users(user_id),
			jabber_regstate  char(2),
			jabber_passwd	 varchar(16),	
			autologin	 char(2) check (autologin in ('t','f'))
			);

-- jb_subscription_request


create table jb_subscription_requests (
			-- screen is a full Jabber-ID
			screen            varchar(255) primary key,
			asked             date
			);
-- jb_message_log
-- log table for messages


create sequence jb_message_log_seq start 1;

create table jb_message_log (
			message_id   integer primary key,
			user_id      integer references users(user_id),
			message      VARCHAR(4000),
			send         date,
			conn_state   varchar(2),
				-- receive jabber_id 
			receive_jid  varchar(1000)  
			); 

-- jb_xml_to_send

create table jb_xml_to_send ( 
			xml     bytea,
			stored  date
			);




-- jb_friends
-- this table stores information for all user friends (whether external or internal friends)

create table jb_friends (
			user_id		    integer references users(user_id),
			friend_screen_id    integer references jb_screens(screen_id),
			friend_first_name   varchar(255),
			friend_last_name    varchar(255),
			primary key(user_id , friend_screen_id)
			);


-- Conference Room
-- implementation as object to use the permissioning system

create or replace function inline_jab ()
returns integer as '
begin
perform acs_object_type__create_type (
 ''jb_conference_room'' ,
 ''Conference Room'' ,
 ''Conference Rooms'' ,
 ''acs_object'' ,
 ''JB_CONFERENCE_ROOMS'' ,
 ''room_id'' ,
 ''jabber_conference'' ,
 ''f'' ,
 null ,
 null
);

return null;
end;' language 'plpgsql';

select inline_jab();
drop function inline_jab();


select acs_attribute__create_attribute (
	'jb_conference_room',		   -- object_type    
	'creator_jabber_id',		   -- attribute_name 
	'string',			   -- datatype       
	'Creator Jabber ID',		   -- pretty_name    
	'Creator Jabber IDs',		   -- pretty_plural  
	null,				   -- table_name
	null,				   -- column_name
	null,				   -- default_value
	1,				   -- min_n_values
	1,				   -- max_n_values
	null,				   -- sort_order
	null,			 	   -- storage
	'f'				   -- static_p
);



select acs_attribute__create_attribute (
	'jb_conference_room',		   -- object_type    
	'name',		   		   -- attribute_name 
	'string',			   -- datatype       
	'Name',				   -- pretty_name    
	'Names',			   -- pretty_plural  
	null,				   -- table_name
	null,				   -- column_name
	null,				   -- default_value
	1,				   -- min_n_values
	1,				   -- max_n_values
	null,				   -- sort_order
	null,			 	   -- storage
	'f'				   -- static_p
);


select acs_attribute__create_attribute (
	'jb_conference_room',		   -- object_type    
	'description',		   		   -- attribute_name 
	'string',			   -- datatype       
	'Description',				   -- pretty_name    
	'Descriptions',			   -- pretty_plural  
	null,				   -- table_name
	null,				   -- column_name
	null,				   -- default_value
	1,				   -- min_n_values
	1,				   -- max_n_values
	null,				   -- sort_order
	null,			 	   -- storage
	'f'				   -- static_p
);



select acs_attribute__create_attribute (
	'jb_conference_room',		   -- object_type    
	'room_id',		   		   -- attribute_name 
	'integer',			   -- datatype       
	'Room ID',				   -- pretty_name    
	'Room IDs',			   -- pretty_plural  
	null,				   -- table_name
	null,				   -- column_name
	null,				   -- default_value
	1,				   -- min_n_values
	1,				   -- max_n_values
	null,				   -- sort_order
	null,			 	   -- storage
	'f'				   -- static_p
);



select acs_attribute__create_attribute (
	'jb_conference_room',		   -- object_type    
	'type',		   		   -- attribute_name 
	'string',			   -- datatype       
	'Type',				   -- pretty_name    
	'Types',			   -- pretty_plural  
	null,				   -- table_name
	null,				   -- column_name
	null,				   -- default_value
	1,				   -- min_n_values
	1,				   -- max_n_values
	null,				   -- sort_order
	null,			 	   -- storage
	'f'				   -- static_p
);




create table jb_conference_rooms ( 
			room_id                 integer primary key references acs_objects(object_id),
			creator_jabber_id       varchar(255),
				-- jabber_id of the creator
				-- only users having a jabber_id can create a conference room
				-- jabber_ids look like: screen_name_of_the_service@service_name.jabber_server
				-- therefore it has to be varchar
			name                    varchar(100) unique,  
			description             varchar(1000),
                        type                    varchar(15)
			);






create or replace function jb_conference_room__new (integer , varchar , varchar , varchar ,  varchar , timestamp with time zone , integer , varchar , integer) 
returns integer as '
declare
        p_room_id             alias for $1;
        p_creator_jabber_id   alias for $2;
        p_name                alias for $3;
        p_description         alias for $4;
	p_object_type         alias for $5;	
	p_creation_date       alias for $6;
	p_creation_user	      alias for $7;
	p_creation_ip	      alias for $8;
	p_context_id          alias for $9;
        v_room_id             integer;
        v_object_type         varchar;
begin


IF p_object_type is null then
  
      v_object_type := ''jb_conference_room'';

ELSE 

      v_object_type := p_object_type;

END IF;


v_room_id := acs_object__new (
	p_room_id,
	v_object_type,
	p_creation_date,
	p_creation_user,
	p_creation_ip,
	p_context_id
	);


insert into jb_conference_rooms
	(room_id, creator_jabber_id, name, description)
values
	(v_room_id, p_creator_jabber_id, p_name, p_description);


return v_room_id;

end;
' language 'plpgsql';





create or replace function jb_conference_room__delete (integer )
returns integer as '
declare
	p_room_id     alias for $1;
begin
	delete from jb_conference_rooms
	where room_id = p_room_id;


perform acs_object__delete(p_room_id);
return p_room_id;
end;
' language 'plpgsql';








-- Conference Room Thread
-- no implementation as object
-- user permission controlled for entire room, not for a single thread 




create sequence jb_conference_room_threads_seq start 1;
create sequence jb_conference_rooms_seq start 1;

create table jb_conference_room_threads (
	thread_id         integer primary key,
	room_id	          integer not null references jb_conference_rooms(room_id),
	start_time	  date,	
	end_time          date,
	subject           varchar(200),
	description       varchar(1000),
	creator_jabber_id varchar(255),
	creator_user_id   integer references users(user_id)                                                      
	);


-- Maps Rooms to the threads where the dicussion Started, for storing the structure of a discussion on an major topic, that maybe
-- displayed later .



create  table jb_room_start_from_thread (
                                                  thread_id    integer not null references jb_conference_room_threads(thread_id),
                                                  room_id       integer not null references jb_conference_rooms(room_id),
                                                  primary key(thread_id , room_id)
                                                  );



-- maps a Room to a Party so oher users/groups can posibly browes the discussions.

create table jb_room_party_map (
                                party_id      integer not null references parties(party_id),
                                room_id       integer not null references  jb_conference_rooms(room_id),
                                primary key (party_id , room_id) 
	                       );

-- stores the group_id's that have access to the conference system
-- conference_only_p indicates if this group was created for conferencing ('t') and we (jabber admin) may be allowed to change it,
-- or if this groups originated some where else in the package.


create table jb_conference_groups (
                                  group_id integer primary key references groups(group_id),
				  conference_only_p  char(1) default 't' check (conference_only_p in ('t' , 'f') ),
                                  default_room_id integer unique references jb_conference_rooms(room_id)
                                  );  


create table jb_groups_blocked_conference(
	                                    group_id integer primary key references groups(group_id)
				             );


-- IMPORTANT
-- creation of a dummy conference room and conference room thread, so the C-module can work!
-- C-module has an own sequence for the threads, but it needs to have a start point, so the database has to provide this start point




create table jb_conference_protocols (
	jabber_id   varchar(100),
	user_id	    integer references users(user_id),
	message     varchar(1000),
	stored      timestamp,
	room_id     integer references jb_conference_rooms(room_id),
	thread_id   integer references jb_conference_room_threads(thread_id)   
	) ;

create index jb_conference_protocols_id on jb_conference_protocols(room_id, thread_id);





-- Now come some PL/SQL procedures and functions, which are used by the c-modules

-- validate whether user is registered

create or replace function jb_reg_validation(varchar , varchar)  returns integer as '
declare
	screen_in    alias for $1;
	regstate     alias for $2;
        v_user_id jb_screens.user_id%TYPE;     
    BEGIN 
     v_user_id := v_user_id;     
     return 1;
    END;
' language 'plpgsql';
	
	
  


 

 
-- Update the online state of a user
create or replace function jb_update_status (varchar , varchar ,  varchar , varchar) returns integer as '
declare 
	status_in      alias for $1;
	resourc_in     alias for $2;
	screen_in      alias for $3;
	service_in     alias for $4;	
        service_long varchar(255);
        aim  varchar;
	jabber varchar;
BEGIN

aim := ''a'';
jabber := ''j'';


   IF service_in = ''a'' THEN	service_long := ''aim'';   END IF;

   IF service_in = ''j'' THEN service_long := ''jabber'';   END IF;

   IF service_in = ''m'' THEN service_long := ''msn'';   END IF;
   IF service_in = ''r'' THEN service_long := ''irc'';   END IF;
   IF service_in = ''i'' THEN service_long := ''icq'';   END IF;
 

--IF service_in = ''j'' THEN service_long := ''jabber''; END IF;
	
   update jb_screens SET status = status_in , resourc= resourc_in WHERE LOWER(im_screen_name)=LOWER(screen_in) and service = service_long;
 
   return 1;

END;
' language 'plpgsql';




-- Clear the online states of every one on Login or Logout

create or replace function jb_clear_status() returns integer as ' 
Begin
update jb_screens SET status=''offline'' , resourc=''offline'';
return 1;
End;
' language 'plpgsql';


 



--checks if jid_in is in the table of the subscription requests , we store them in ther because we may have to wait 
--for a while till some one (jid_in) answers the request, it returns 0 in case there is nothing known about jid_in
--or n > 0  in case there is something known about jid_in 
     
create or replace function jb_subscription_check (varchar)
returns integer as '
declare
jid_in   alias for $1;
r_exists integer;
BEGIN
 r_exists := 0;
 select count(screen) into r_exists from jb_subscription_requests where lower(screen) = lower(jid_in) ;

 return r_exists;
END;
' language 'plpgsql';







--inserts a new subscription request

create or replace function jb_subscription_insert(varchar) returns integer as '
declare 
	jid_in    alias for $1;
BEGIN
    insert into jb_subscription_requests (screen , asked ) values ( jid_in , sysdate);

return 1;   
END;
' language 'plpgsql';


--removes a certain subscription request

create or replace function jb_subscription_del (varchar) returns integer as '
DECLARE
	jid_in alias for $1;
BEGIN
          delete from jb_subscription_requests where lower(screen) = lower(jid_in);
          
return 1;
END;
' language 'plpgsql';






--Find the user_id to a given jid, when someone invites us through  sending a jabber invite from his jabber client:

create or replace function jb_get_user_id (varchar) returns integer AS '
DECLARE
 screen_in alias for $1;
 r_user_id integer;  

BEGIN

        Select persons.person_id INTO r_user_id
        FROM persons,  jb_screens
        WHERE persons.person_id = jb_screens.user_id
        AND jb_screens.service = ''jabber''
        AND jb_screens.im_screen_name = screen_in;

        return r_user_id;

END;
' language 'plpgsql';








--Get the jid from a given user_id 

create or replace function jb_get_jid (integer) returns VARCHAR AS '
DECLARE 
 user_id_in   alias for $1;
 r_jid        varchar(150);
BEGIN
  
 Select sn.im_screen_name INTO r_jid 
 FROM jb_screens sn 
 WHERE sn.user_id = user_id_in 
 AND sn.service = ''jabber'';

 return r_jid;

END;
' language 'plpgsql';



--if a room is destroyed or the topic changes, the  discussion on the last topic (thread) ends ,insert this time as thread end time:
 

create or replace function jb_conference_thread_finish(integer) returns integer as '
DECLARE
	thread_id_in    alias for $1;
BEGIN
     update jb_conference_room_threads set end_time = sysdate where thread_id = thread_id_in;
return 1;     
END;
' language 'plpgsql';





--When a room starts or the  topic changes a new Thread is created :


create or replace function jb_conference_thread_new (integer , integer , varchar , varchar ,  integer) returns integer as '
DECLARE
	thread_id_in       alias for $1;
	room_id_in         alias for $2;
	subject_in         alias for $3;
	creator_jid_in     alias for $4;
	creator_user_id_in alias for $5;
	
BEGIN

 IF creator_user_id_in = 0 THEN

   insert into jb_conference_room_threads (thread_id , room_id , start_time , subject , creator_jabber_id )
   values (thread_id_in , room_id_in , CURRENT_TIMESTAMP , subject_in , creator_jid_in );

 ELSE
  
   insert into jb_conference_room_threads (thread_id , room_id , start_time , subject , creator_jabber_id , creator_user_id )
   values (thread_id_in , room_id_in , CURRENT_TIMESTAMP , subject_in , creator_jid_in , creator_user_id_in);

 END IF;

 return 1;  

END;
' language 'plpgsql';




--When a message is received from a conference room it is stored in the db:

 
create or replace function jb_conference_message(varchar ,  varchar , integer , integer , integer) returns integer as '
DECLARE
	jid_in        alias for $1;
	message_in    alias for $2;
	room_id_in    alias for $3;
	thread_id_in  alias for $4;
	user_id_in    alias for $5;
BEGIN

  IF user_id_in = 0 THEN
    
       insert into jb_conference_protocols (jabber_id , message , stored , room_id , thread_id )
       values (jid_in , message_in , CURRENT_TIMESTAMP , room_id_in , thread_id_in );

  ELSE 

      insert into jb_conference_protocols (jabber_id , user_id , message , stored , room_id , thread_id)
      values  (jid_in , user_id_in , message_in , CURRENT_TIMESTAMP , room_id_in , thread_id_in );

  END IF;

 return 1;

END;
' language 'plpgsql';






-- When a room is created (it is maybe recreated every Monday at 8:00 ) see if we already have a room_id for that room.

create or replace function jb_conference_room_check(varchar) returns integer AS '
DECLARE
	room_name_in  alias for $1;
        r_room_id     integer;
BEGIN
      r_room_id := -1;

      select room_id  INTO r_room_id from jb_conference_rooms where lower(name)=lower(room_name_in);

     return r_room_id;

END;
' language 'plpgsql';






-- When a room is fully new created , create a new Table entry. We do not use the room_id given by the c-module due to the fact that 
-- conference_room is implemented as object


create or replace function jb_conference_rooms_new ( integer ,  varchar , varchar , varchar) returns integer as ' 
DECLARE
	user_id_in      alias for $1;
	creator_jid_in  alias for $2;
	name_in         alias for $3;
	description_in  alias for $4;
	v_id integer;

BEGIN
  
  
  IF user_id_in = 0 THEN

        
	v_id := jb_conference_room__new (
	       null ,
	       creator_jid_in ,
	       name_in ,
	       description_in ,
	       ''jb_conference_room'' ,
 	       current_timestamp , 
  	       null , 
	       null ,
	       null
		);
	


  ELSE


	v_id := jb_conference_room__new (
	       null ,
	       creator_jid_in ,
	       name_in ,
	       description_in ,
	       ''jb_conference_room'' ,
 	       current_timestamp , 
  	       user_id_in , 
	       null ,
	       null
		);
			
		
     
  END IF;

return 1;


END;
' language 'plpgsql';




-- Get the next room_id. This procedure is used in the database to get a new room_id, but it takes the ACS3.x datamodel as basis
-- In the OACS4.x datamodel conference_room is implemented as object, so we do not have a sequence, but we do not want the c-module
-- generate an error, so we give him an integer back, but we do not use this room_id (look above)

create or replace function jb_conference_next_room_id() returns integer AS '
DECLARE
 r_room_id integer;
BEGIN
  SELECT nextval(''jb_conference_rooms_seq'') INTO r_room_id;
 
  return r_room_id;
END;
' language 'plpgsql'; 



-- Get the next thread_id

create or replace function jb_conference_next_thread_id() returns integer AS '
DECLARE
 r_thread_id integer;
BEGIN
  
  SELECT  nextval(''jb_conference_room_threads_seq'') INTO r_thread_id;
  
  return r_thread_id;

END;
' language 'plpgsql';
 


create or replace function jb_make_group_conference_group(varchar , integer) returns integer AS '
DECLARE
  p_room_name alias for $1;
  p_group_id  alias for $2;
  v_room_id   integer;
BEGIN

  SELECT room_id INTO v_room_id
  FROM jb_conference_rooms
  WHERE lower(name) = lower(p_room_name);

  UPDATE jb_conference_groups
  SET default_room_id = v_room_id
  WHERE group_id = p_group_id;

 return 1;

END;
' language 'plpgsql';



--\i jabber-notification-create.sql
