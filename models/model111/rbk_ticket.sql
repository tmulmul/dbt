{{ config(materialized="table") }}

with
    source_data as (

        select orderstatus, refername_ibu, count(1) as cnt
        from fbu_edw.edw_deal_rbk_rebook_ticket_eng_d
        where orderdate between '2023-09-17' and '2023-09-18'
        group by orderstatus, refername_ibu

    ),

    n as (
        select 'S' as orderstatus, '成功' as statusname
        union all
        select 'R' as orderstatus, '全退' as statusname
        union all
        select 'P' as orderstatus, '处理中' as statusname
    )

select source_data.*, n.statusname
from source_data
join n on source_data.orderstatus = n.orderstatus
