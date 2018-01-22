--
-- 10_Mig_Sin_Movsiniestro_v01.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE := 17441;
  -- 
BEGIN
  --
 -- SELECT sncarga.nextval INTO vncarga FROM dual;
       --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_MOVSINIESTRO_TXT');
     --
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 35 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', 'MIG_SIN_MOVSINIESTRO');
     --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
  COMMIT;
  --
END;
