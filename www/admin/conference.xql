<?xml version="1.0"?>
<queryset>

<fullquery name="get_conference_groups">      
      <querytext>
      SELECT (g.group_name) as group_name , (g.group_id) as group_id 
                                  FROM jb_conference_groups jcg, groups g 
                                  WHERE jcg.conference_only_p = 't'
                                  AND   g.group_id = jcg.group_id
      </querytext>
</fullquery>

 
</queryset>
