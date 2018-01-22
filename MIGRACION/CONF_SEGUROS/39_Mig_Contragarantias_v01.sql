--
-- 39_Mig_Contragarantias_v01.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE := 17434;
  -- 
BEGIN
  --
  --SELECT sncarga.nextval INTO vncarga FROM dual;
       --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CTGAR_CONTRAGARANTIA_TXT');
     --
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 29 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', 'MIG_CTGAR_CONTRAGARANTIA');
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 30, 'Inserts Directos', 'MIG_CTGAR_DET');
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 31, 'Inserts Directos', 'MIG_CTGAR_INMUEBLE');
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 32, 'Inserts Directos', 'MIG_CTGAR_VEHICULO');
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 33, 'Inserts Directos', 'MIG_CTGAR_CODEUDOR');
     --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
  COMMIT;
  --
END;
