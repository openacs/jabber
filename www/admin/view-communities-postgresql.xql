<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="get_dotlrn_communities">      
      <querytext>
      FIX ME DECODE
 
    select dotlrn_communities.community_id,
           dotlrn_communities.community_type,
           dotlrn_communities.pretty_name,
           dotlrn_communities.description,
           dotlrn_communities.package_id,
           dotlrn_community__url(dotlrn_communities.community_id) as url,
           dotlrn_member_rels_approved.rel_type,
           dotlrn_member_rels_approved.role,
           '' as role_pretty_name,
           decode(dotlrn_community_admin_p(dotlrn_communities.community_id, dotlrn_member_rels_approved.user_id),'f',0,1) as admin_p
    from dotlrn_communities,
         dotlrn_member_rels_approved
    where dotlrn_member_rels_approved.user_id = :user_id
    and dotlrn_communities.community_id = dotlrn_member_rels_approved.community_id
    and dotlrn_communities.community_type != 'dotlrn_community'
    order by dotlrn_communities.pretty_name


      </querytext>
</fullquery>

 
</queryset>
