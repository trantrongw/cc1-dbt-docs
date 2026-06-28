WITH ranked_data AS (
    SELECT
        account_analytic_key
        ,business_plan_id
        ,business_unit_id
        ,department_id
        ,revenue_item_id
        ,cost_item_id
        -- Đánh số thứ tự cho từng nhóm account_analytic_key
        ,ROW_NUMBER() OVER (
            PARTITION BY account_analytic_key 
            ORDER BY id DESC
         ) AS row_num
    FROM [wh_core].[cc1].[int_account_analytic_union]
)
SELECT 
     account_analytic_key
    ,business_plan_id
    ,business_unit_id
    ,department_id
    ,revenue_item_id
    ,cost_item_id
FROM ranked_data
WHERE row_num = 1 -- Chỉ lấy duy nhất 1 dòng cho mỗi key