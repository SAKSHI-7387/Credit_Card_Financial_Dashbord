select * from cc_detail

SELECT COUNT(*) FROM cc_detail;

DELETE FROM cc_detail
WHERE ctid IN (
    SELECT ctid
    FROM (
        SELECT ctid,
               ROW_NUMBER() OVER (
                   PARTITION BY
                       client_num,
                       card_category,
                       annual_fees,
                       activation_30_days,
                       customer_acq_cost,
                       week_start_date,
                       week_num,
                       qtr,
                       current_year,
                       credit_limit,
                       total_revolving_bal,
                       total_trans_amt,
                       total_trans_ct,
                       avg_utilization_ratio,
                       use_chip,
                       exp_type,
                       interest_earned,
                       delinquent_acc
                   ORDER BY ctid
               ) AS rn
        FROM cc_detail
    ) t
    WHERE rn > 1
);
SELECT COUNT(*) FROM cc_detail;

select * from cust_detail;

DELETE FROM cust_detail
WHERE ctid IN (
    SELECT ctid
    FROM (
        SELECT ctid,
               ROW_NUMBER() OVER (
                   PARTITION BY client_num
                   ORDER BY ctid
               ) AS rn
        FROM cust_detail
    ) t
    WHERE rn > 1
);


SELECT COUNT(*) FROM cust_detail;

copy cc_detail 
from 'D:\BCA_PROJECT\power_bi project\cc_add.csv'
delimiter','
csv header;

select * from cust_detail;

copy cust_detail 
from 'D:\BCA_PROJECT\power_bi project\cust_add.csv'
delimiter','
csv header;

SELECT COUNT(*) total_rows,
       COUNT(DISTINCT client_num) unique_clients
FROM cust_detail;

SELECT client_num, COUNT(*)
FROM cust_detail
GROUP BY client_num
HAVING COUNT(*) > 1;

SELECT client_num, COUNT(*)
FROM cust_detail
GROUP BY client_num
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

DELETE FROM cust_detail
WHERE ctid IN (
    SELECT ctid
    FROM (
        SELECT ctid,
               ROW_NUMBER() OVER (
                   PARTITION BY client_num
                   ORDER BY ctid
               ) AS rn
        FROM cust_detail
    ) t
    WHERE rn > 1
);

SELECT COUNT(*) total_rows,
       COUNT(DISTINCT client_num) unique_clients
FROM cust_detail;



