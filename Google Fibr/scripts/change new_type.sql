-- SELECT new_type, 
--   case
--     when new_type = 'type_1' then 'Account Management'
--     when new_type = 'type_2' then 'Technician Troubleshooting'
--     when new_type = 'type_3' then 'Scheduling'
--     when new_type = 'type_4' then 'Construction'
--     when new_type = 'type_5' then 'Internet and Wifi'
--     end as new_types
-- FROM `red-airline-483900-r2.fibr.combined_markets`

update `red-airline-483900-r2.fibr.combined_markets`
set new_type = case
    when new_type = 'type_1' then 'Account Management'
    when new_type = 'type_2' then 'Technician Troubleshooting'
    when new_type = 'type_3' then 'Scheduling'
    when new_type = 'type_4' then 'Construction'
    when new_type = 'type_5' then 'Internet and Wifi'
    ELSE new_type 
  end
where new_type in ('type_1', 'type_2', 'type_3', 'type_4', 'type_5');