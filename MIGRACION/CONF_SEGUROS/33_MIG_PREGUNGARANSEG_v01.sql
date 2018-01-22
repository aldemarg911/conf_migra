--
-- 33_MIG_PREGUNGARANSEG_v01.sql : Crea los registros de configuraci�n
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE := 17433;
  -- 
BEGIN
  --
 -- SELECT sncarga.nextval INTO vncarga FROM dual;
       --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (vncarga, 24, f_sysdate, f_sysdate, 'OK', 'MIG_PREGUNGARANSEG_TXT');
     --
     INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (vncarga, 28 /*DOC-108![mig_cargas_tab_mig]*/, 'Inserts Directos', 'MIG_PREGUNGARANSEG');
     --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
  COMMIT;
  --
END;