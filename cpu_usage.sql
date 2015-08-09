WITH uso_cpu AS (
SELECT REPLACE(target_name, '.acp', '') INSTANCIA,
  TO_CHAR(METRICA.rollup_timestamp, 'HH24') HORA,
  ROUND(NVL(METRICA.average, 0), 2) PROMEDIO
    FROM sysman.mgmt$metric_hourly METRICA
      WHERE METRICA.target_name IN (SELECT m.member_target_name FROM MGMT$TARGET_MEMBERS m WHERE m.aggregate_target_name IN ('DataBase Produccion')) 
        AND METRICA.metric_column = 'host_cpu_usage_pct'
        AND TRUNC(METRICA.rollup_timestamp) = TRUNC(SYSDATE-1)
      ORDER BY to_char(METRICA.rollup_timestamp, 'HH24') ASC
)
SELECT x.INSTANCIA
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '06') "HH06"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '07') "HH07"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '08') "HH08"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '09') "HH09"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '10') "HH10"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '11') "HH11"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '12') "HH12"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '13') "HH13"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '14') "HH14"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '15') "HH15"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '16') "HH16"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '17') "HH17"
       ,(SELECT NVL(y.PROMEDIO,0) FROM uso_cpu y WHERE y.INSTANCIA = x.INSTANCIA AND y.HORA = '18') "HH18"
  FROM ( 
         SELECT DISTINCT m.INSTANCIA FROM uso_cpu m
       ) x
  ORDER BY x.INSTANCIA;
