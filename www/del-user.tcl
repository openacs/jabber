set user_id [ad_conn user_id]
db_dml del "delete from jb_screens where user_id = :user_id"
db_dml del2 "delete from jb_user_jabber_information where user_id = :user_id"
ns_returnredirect index