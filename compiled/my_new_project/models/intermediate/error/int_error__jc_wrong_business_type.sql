select
    a.id,
    model = 'job.costing',
    link  = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=1271&action=2180&model=job.costing&view_type=form', '{id}', cast(a.id as varchar)),
    error_code = 'JC001'
from [wh_core].[cc1].[int_xboss__job_costing_current] a
where a.__is_deleted = 0
    and a.company_id = 1
    and a.business_type = 'construction'
    and lower(a.name) like '%ngân sách%'