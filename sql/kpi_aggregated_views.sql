-- HABOT BigQuery Aggregated KPI View Engine
CREATE OR REPLACE VIEW `habot_enterprise_telemetry.vw_mobile_kpi_summary` AS
SELECT
  event_date,
  trace_id,
  COUNT(DISTINCT user_id) AS active_engineers,
  AVG(latency_ms) AS avg_api_latency,
  SAFE_DIVIDE(
    COUNTIF(execution_status = 'PASS'),
    COUNT(1)
  ) * 100.0 AS process_completion_rate,
  CURRENT_TIMESTAMP() AS query_execution_timestamp
FROM
  `habot_enterprise_telemetry.step_execution_events`
WHERE
  event_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
GROUP BY
  event_date,
  trace_id;
