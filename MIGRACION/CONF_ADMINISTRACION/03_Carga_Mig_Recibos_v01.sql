-- 03_Carga_Mig_Recibos_v01.sql
DECLARE
   vdummy            NUMBER;
   vncarga           mig_cargas.ncarga%TYPE := 17456;
   v_nerr            NUMBER;
   v_cant            NUMBER;
   v_seqlog          NUMBER := 0;
   --
   l_timestart       NUMBER;
   l_timeend         NUMBER;
   l_time            NUMBER;
   --   
BEGIN
  --
  l_timestart := dbms_utility.get_time(); 
  --
  DELETE FROM mig_logs_axis s WHERE s.ncarga = vncarga;
  DELETE FROM mig_cargas_tab_axis s WHERE s.ncarga = vncarga;
  UPDATE mig_cargas_tab_mig s SET finides = NULL WHERE s.ncarga = vncarga;
  SELECT MAX(s.seqlog) INTO v_seqlog FROM mig_logs_axis s WHERE s.ncarga = vncarga;
  --
  dbms_output.put_line('- v_seqlog:'||NVL(v_seqlog, 0));
  --
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD'))
    INTO vdummy
    FROM dual;
    --
    -- 0. 01_Mig_Recibos_v01.sql  (Crea registros de carga)
    -- 1. 02_Mig_Recibos_v01.sql  (Migra registros de _CONF a MIG_)
    -- 2. - void -
    -- 3. Ejecutar este script
    -- 4. Actualizar T[s] documento DOC-108
    --
    pac_mig_axis_conf.p_migra_cargas(pid     => 'MIG_RECIBOS_TXT',
                                     ptipo   => 'C',
                                     pncarga => vncarga);
    --
    SELECT COUNT(*) INTO v_cant FROM mig_logs_axis s WHERE s.ncarga = vncarga AND s.seqlog > NVL(v_seqlog, 0);
    dbms_output.put_line('SELECT * FROM mig_logs_axis s WHERE s.ncarga = ' || vncarga || ' AND s.seqlog > ' || NVL(v_seqlog, 0) || ';');
    SELECT COUNT(*) INTO v_cant FROM mig_logs_axis s WHERE s.ncarga = vncarga;
    dbms_output.put_line('v_cant errores [mig_logs_axis] log: '||v_cant);
    --
    l_timeend := dbms_utility.get_time(); 
    l_time    := (l_timeend - l_timestart) / 100;
    dbms_output.put_line('Tiempo de Ejecución: ' || l_time ||' [s]'); 
    --
    COMMIT;
   --
END;
