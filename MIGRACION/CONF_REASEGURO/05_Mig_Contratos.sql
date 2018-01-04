--
-- 05_Mig_Contratos.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE;
   v_texto     VARCHAR2(50) := 'MIG_CONTRATOS_TXT';
  -- 
BEGIN
  --
  --SELECT sncarga.nextval INTO vncarga FROM dual;
  --
  vncarga := 17436;
  DELETE mig_cargas_tab_mig WHERE ncarga = vncarga;
  DELETE mig_cargas WHERE ncarga = vncarga;
     --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', v_texto);
     --
     INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (vncarga, 9 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', 'MIG_CONTRATOS');
     --
     dbms_output.put_line('El ncarga es :' || vncarga);
     --
     COMMIT;
  --
END;
--
