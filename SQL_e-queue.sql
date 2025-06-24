select
    vehicle_Country,
    count(*) as total_vehicles,
    sum(case when isPriority = 'true' then 1 else 0 end) as priority_vehicles,
    sum(case when isPriority = 'false' then 1 else 0 end) as regular_vehicles,
    round(avg(TIMESTAMPDIFF(MINUTE, entry_Date_Time, exit_Date_Time)), 2) as avg_crossing_time_min,
    round(100 * COUNT(*) / (
            select COUNT(*) 
            from queue_data qd 
            where entry_Date_Time is not null
              and exit_Date_Time is not null
              and cancellation_Date_Time is null),2
    ) as percent_of_total
from 
    queue_data qd 
where 
    entry_Date_Time is not null
    and exit_Date_Time is not null
    and cancellation_Date_Time is null
group by  1
order by  2 desc
limit 10