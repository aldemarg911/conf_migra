--
-- 25_Mig_Sin_Tramita_Movpago_v01.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE;
   v_texto     VARCHAR2(50) := 'MIG_SIN_TRAMITA_MOVPAGO_TXT';
  -- 
BEGIN
  --
  SELECT sncarga.nextval INTO vncarga FROM dual;
       --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', v_texto);
     --
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 40 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', REPLACE(v_texto, SUBSTR(v_texto, -4)));
     --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
  COMMIT;
  --
END;
SELECT * FROM mig_cargas s WHERE s.ncarga = 20076;
SELECT * FROM mig_cargas_tab_mig s WHERE s.ncarga = 20076;
