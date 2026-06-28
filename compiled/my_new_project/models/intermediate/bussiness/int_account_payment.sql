with pay as (
    select *,
        model        = 'account.payment',
        link         = replace('https://intranet.cc1.vn/web?debug=1#id={id}&cids=1&menu_id=556&action=773&model=account.payment&view_type=form', '{id}', cast(id as varchar)),
        create_date_vn = DATEADD(HOUR, 7, create_date)
    from [wh_core].[cc1].[int_xboss__account_payment_current]
    where __is_deleted = 0
),
move as (
    select * from [wh_core].[cc1].[int_xboss__account_move_current]
    where __is_deleted = 0
    and company_id = 1
    and state = 'posted'
),
analytic as (
    select * from [wh_core].[cc1].[int_account_payment_account_analytic_mapping]
),
account as (
    select * from [wh_core].[cc1].[int_account_account]
)

select
    -- keys
    payment_key                         = cast(pay.id as varchar(50))
    ,company_key                        = move.company_id
    ,customer_key                       = pay.partner_id
    ,analytic.account_analytic_key
    ,project_key=analytic.project_id
    -- từ account_move (inherited fields)
    ,move.name                          -- số phiếu (INV/..., BNK/...)
    ,move.date                          -- ngày thanh toán
    ,move.journal_id
    ,move.state                         -- draft / posted / cancel
    ,move.payment_state                 -- not_paid / in_payment / paid

    -- từ account_payment (stored fields)
    ,pay.payment_type                   -- inbound / outbound
    ,pay.partner_type                   -- customer / supplier
    ,pay.payment_method_line_id
    ,pay.currency_id
    ,pay.amount
    ,pay.amount_company_currency_signed
    ,pay.destination_account_id
    ,pay.partner_bank_id
    ,pay.payment_reference              -- memo trên journal entry
    ,pay.ref                            -- số tham chiếu (CUST/CONTRACT/...)
    ,pay.disbursement_code
    ,pay.analytic_distribution
    ,pay.is_reconciled
    ,pay.is_matched
    ,pay.is_internal_transfer

    -- cột dẫn xuất
    ,pay.model
    ,pay.link
    ,pay.create_date_vn

    -- audit
    ,pay.create_date
    ,pay.write_date

from pay
inner join account on pay.destination_account_id = account.id
    and account.code in ('131101001', '131101002')
left join move    on pay.move_id = move.id
left join analytic on pay.id     = analytic.id