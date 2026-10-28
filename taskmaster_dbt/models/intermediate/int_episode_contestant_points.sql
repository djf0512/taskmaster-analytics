-- Unpacks the official episode totals from the episodes file.
-- contestants_raw is a ';'-delimited list of names in seat order, and total_1..total_5 follow the
-- same order, so the Nth name gets total_N. One row per contestant per episode.
with episodes as (

    select * from {{ ref('int_episodes_included') }}

)
, contestants as (

    select
        e.series_name,
        e.episode_number,
        e.episode_title,
        e.air_date,
        trim(contestant.name) as contestant_name,
        contestant.position   as contestant_seat_position,
        case contestant.position
            when 1 then e.total_1
            when 2 then e.total_2
            when 3 then e.total_3
            when 4 then e.total_4
            when 5 then e.total_5
        end as episode_points
    from episodes e,
    unnest(string_split(e.contestants_raw, ';')) with ordinality as contestant(name, position)

)
select * from contestants