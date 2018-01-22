--
-- 13_Mig_Sin_Tramitacion_v01.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE := 17442;
  -- v_texto     VARCHAR2(50) := 'MIG_SIN_TRAMITACION_TXT';
  -- 
BEGIN
  --
 -- SELECT sncarga.nextval INTO vncarga FROM dual;
       --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITACION_TXT');
     --
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 41 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', 'MIG_SIN_TRAMITACION');
     --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
  COMMIT;
  --
END;
--SELECT * FROM mig_cargas s WHERE s.ncarga = 17452 ;
--SELECT * FROM mig_cargas_tab_mig s WHERE s.ncarga = 20072 ;
