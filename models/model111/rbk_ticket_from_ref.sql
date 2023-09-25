select orderstatus,statusname,cnt from {{ ref('rbk_ticket') }}
where refername_ibu = 'direct'