<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="insert_log">      
      <querytext>
      insert into jb_message_log ( message_id , user_id , message , send , conn_state , receive_jid) values ( jb_message_log_seq.nextval ,  '[ad_get_user_id]' , :message , sysdate  , :success , :user_log )
      </querytext>
</fullquery>

 
</queryset>
