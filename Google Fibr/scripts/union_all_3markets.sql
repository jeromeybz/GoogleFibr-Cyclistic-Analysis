-- SELECT
--   date_created,
--   contacts_n,
--   contacts_n_1,
--   contacts_n_2,
--   contacts_n_3,
--   contacts_n_4,
--   contacts_n_5,
--   contacts_n_6,
--   contacts_n_7,
--   new_type,
--   new_market
-- FROM `fibr.market_1`
-- UNION ALL
-- SELECT
--   date_created,
--   contacts_n,
--   contacts_n_1,
--   contacts_n_2,
--   contacts_n_3,
--   contacts_n_4,
--   contacts_n_5,
--   contacts_n_6,
--   contacts_n_7,
--   new_type,
--   new_market
-- FROM `fibr.market_2`
-- UNION ALL
-- SELECT
--   date_created,
--   contacts_n,
--   contacts_n_1,
--   contacts_n_2,
--   contacts_n_3,
--   contacts_n_4,
--   contacts_n_5,
--   contacts_n_6,
--   contacts_n_7,
--   new_type,
--   new_market
-- FROM `fibr.market_3`
CREATE OR REPLACE TABLE `red-airline-483900-r2.fibr.combined_markets` AS
SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `red-airline-483900-r2.fibr.market_1`
UNION ALL
SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `red-airline-483900-r2.fibr.market_2`
UNION ALL
SELECT
  date_created,
  contacts_n,
  contacts_n_1,
  contacts_n_2,
  contacts_n_3,
  contacts_n_4,
  contacts_n_5,
  contacts_n_6,
  contacts_n_7,
  new_type,
  new_market
FROM `red-airline-483900-r2.fibr.market_3`
