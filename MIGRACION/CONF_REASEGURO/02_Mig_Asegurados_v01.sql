-- 02_Migra_Asegurados_v01
DECLARE
   vdummy            NUMBER;
   vncarga           mig_cargas.ncarga%TYPE := 20049;
   v_nerr            NUMBER;
   v_cant            NUMBER;
BEGIN
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD'))
    INTO vdummy
    FROM dual;
    --
    v_nerr := pac_mig_axis_conf.f_migra_asegurados(pncarga => vncarga, pntab => 8);
    --
    dbms_output.put_line('error Proceso: '|| v_nerr);
    --
    SELECT COUNT(*) INTO v_cant FROM mig_logs_axis s WHERE s.seqlog > 2202843;
    dbms_output.put_line('v_cant errores log: '||v_cant);
    --
   COMMIT;
   --
END;
