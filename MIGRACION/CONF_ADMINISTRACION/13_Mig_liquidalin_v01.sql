--
-- 10_Mig_Liquidacab_v01.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE := 17462;
  -- 
BEGIN
  --
 -- SELECT sncarga.nextval INTO vncarga FROM dual;
       --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', 'MIG_LIQUIDALIN_TXT');
     --
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 60 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', 'MIG_LIQUIDALIN');
     --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
  COMMIT;
  --
  END;
--
--SELECT * FROM mig_cargas s WHERE s.ncarga = 17441 FOR UPDATE;
--SELECT * FROM mig_cargas_tab_mig s WHERE s.ncarga = 17441 FOR UPDATE;
--
