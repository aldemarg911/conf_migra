--
-- 06_Mig_ctacoaseguro.sql : Crea los registros de configuración
--
DECLARE
  --
   vncarga     mig_cargas.ncarga %TYPE;
   v_texto     VARCHAR2(50) := 'MIG_CTACOASEGURO_TXT';
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
            (vncarga, 81, 'Inserts Directos', 'MIG_CTACOASEGURO');
    --
     dbms_output.put_line('El ncarga es :' || vncarga);
     --
     COMMIT;
  --
END;
--
SELECT * FROM mig_cargas s WHERE s.ncarga = 17415 FOR UPDATE;
SELECT * FROM mig_cargas_tab_mig s WHERE s.ncarga = 17415 FOR UPDATE;
--
insert into mig_personas (NCARGA, CESTMIG, MIG_PK, IDPERSON, SNIP, CTIPIDE, NNUMIDE, CESTPER, CPERTIP, FULTMOD, SWPUBLI, CSEXPER, FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, CESTCIV, CPAIS, CPROFES, CNACIO, CTIPDIR, CTIPVIA, TNOMVIA, NNUMVIA, TCOMPLE, CPOSTAL, CPOBLAC, CPROVIN, CTIPDIR2, CTIPVIA2, TNOMVIA2, NNUMVIA2, TCOMPLE2, CPOSTAL2, CPOBLAC2, CPROVIN2, TNUMTEL, TNUMFAX, TNUMMOV, TEMAIL, CTIPBAN, CBANCAR, CIDIOMA, CTIPIDE2, NNUMIDE2, FJUBILA, TNOMBRE2, TDIGITOIDE, PROCESO, FVENCIM, COCUPACION, FANTIGUEDAD, FDEFUNC)
values (17419, 1, '034646', 0, 'A0683079', 0, '034646', 0, 2, to_date('17-10-2016', 'dd-mm-yyyy'), 1, 0, null, 19000, 'CONSORCIO MACEVA', null, null, null, 170, null, 170, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, ' ', null, null, null, null, null);
--
SELECT COUNT(*) FROM mig_personas_conf s WHERE ctipide = 0 AND mig_pk NOT IN (SELECT s.mig_pk FROM mig_personas s WHERE ctipide = 38 AND idperson <> 0);
SELECT * FROM mig_personas s WHERE ctipide = 38 AND idperson <> 0 AND mig_pk = '105238000';
--

