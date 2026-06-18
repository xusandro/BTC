

WITH WHALES AS (

SELECT
output_address,
sum(output_value) as total_sent,
count(*) as tx_count


FROM {{ ref('stg_btc_transactions') }} 

WHERE output_value > 10

group by output_address
order by total_sent desc

)




SELECT
w.output_address,
w.total_sent,
w.tx_count,
{{convert_to_usd('w.total_sent')}} AS total_sent_usd
FROM 
WHALES w
ORDER BY total_sent DESC 