<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="insert_log">      
      <querytext>
      insert into jb_message_log ( message_id, user_id , message , send ,
      conn_state, receive_jid) values ( nextval('jb_message_log_seq') , :user_id , :message , current_timestamp  , :success , :user_log )
      </querytext>
</fullquery>

 
</queryset>
