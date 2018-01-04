-- 02_Migra_Contratos
DECLARE
   vdummy            NUMBER;
   vncarga           mig_cargas.ncarga%TYPE := 20047;
   v_nerr            NUMBER;
   v_cant            NUMBER;
BEGIN
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD'))
    INTO vdummy
    FROM dual;
    --
    v_nerr := pac_mig_axis.f_migra_tramos(vncarga, 8);
    --
    dbms_output.put_line('error Proceso: '|| v_nerr);
    --
    SELECT COUNT(*) INTO v_cant FROM mig_logs_axis s WHERE s.seqlog > 2202843;
    dbms_output.put_line('v_cant errores log: '||v_cant);
    --
   COMMIT;
   --
END;
