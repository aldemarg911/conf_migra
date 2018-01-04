--
-- 07_Mig_Mig_DetMovReciboParcial_v01.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE := 17460;
   v_texto     VARCHAR2(50) := 'MIG_DETMOVRECIBO_PARCIAL_TXT';
  -- 
BEGIN
  --
--  SELECT sncarga.nextval INTO vncarga FROM dual;
       --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', v_texto);
     --
    INSERT INTO mig_cargas_tab_mig
            (ncarga, ntab, tab_org, tab_des)     VALUES
            (vncarga, 59 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', 'MIG_DETMOVRECIBO_PARCIAL');
     --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
  COMMIT;
  --
END;
--
--SELECT * FROM mig_cargas s WHERE s.ncarga = 20082 FOR UPDATE;
--SELECT * FROM mig_cargas_tab_mig s WHERE s.ncarga = 20082 FOR UPDATE;
--
