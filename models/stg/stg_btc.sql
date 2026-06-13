{{ config(materialized='incremental', incremental_strategy='merge', unique_key ='HASH_KEY') }}




SELECT
*
FROM
{{ source('btc', 'btc') }}



{% if is_incremental() %}


WHERE BLOCK_TIMESTAMP >= (select (max(BLOCK_TIMESTAMP)) from {{this}})


{% endif %}