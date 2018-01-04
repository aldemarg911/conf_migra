--
-- 11_00_Mig_cuadroces_v01.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE;
  -- 
BEGIN
  --
  SELECT sncarga.nextval INTO vncarga FROM dual;
       --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CUADROCES_TXT');
     --
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 11 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', 'MIG_CUADROCES');
     --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
  COMMIT;
  --
END;
