DECLARE
    /******************************************************************************
    NOMBRE:       20_Mig_sin_tramita_reserva_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de MIG_SIN_TRAMITA_RESERVA - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 25/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar Asegurados
*/
   --
   l_timestart       NUMBER;
   l_timeend         NUMBER;
   l_time            NUMBER;
   vdummy            NUMBER;
   v_limit_records   NUMBER := 10000; -- limit to 10k to avoid out of memory
   --
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz 
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   b_error           BOOLEAN;
   b_hay_dato        BOOLEAN;
   v_cant            NUMBER := 0;
   --
   TYPE t_mig_sin_tramita_reserva IS TABLE OF mig_sin_tramita_reserva%ROWTYPE;
   l_reg_mig_mcc t_mig_sin_tramita_reserva;
   --
    CURSOR lc_mig_sin_tramita_reserva IS
     SELECT 17454 NCARGA, 1 CESTMIG, a.MIG_PK, a.MIG_FK, 0 NSINIES, a.NTRAMIT, a.CTIPRES, a.NMOVRES, a.CGARANT, a.CCALRES, a.FMOVRES,
          a.CMONRES, a.IRESERVA, a.IPAGO, a.IINGRESO, a.IRECOBRO, a.ICAPRIE, a.IPENALI, a.FRESINI, a.FRESFIN, a.FULTPAG, 0 SPROCES, a.FCONTAB,
          NVL(a.CUSUALT, 'MIGRA_CONF'), a.FALTA, a.CUSUMOD, a.FMODIFI, a.IPREREC, a.CTIPGAS, NULL IRESERVA_MONCIA, NULL IPAGO_MONCIA, NULL IINGRESO_MONCIA,
          NULL IRECOBRO_MONCIA, NULL ICAPRIE_MONCIA, NULL IPENALI_MONCIA, NULL IPREREC_MONCIA, NULL FCAMBIO, a.IFRANQ, NULL IFRANQ_MONCIA,
          NULL IDRES, NULL CMOVRES, NULL SIDEPAG
--select count(*)
      FROM mig_sin_tramita_reserva_cl1 a, mig_sin_tramitacion s
     WHERE 1 = 1
        AND a.mig_fk = s.mig_pk
        AND s.nsinies <> 0
      ORDER BY a.mig_pk
        ;
        --SELECT * FROM mig_sin_tramita_reserva_conf s for update; WHERE s.mig_pk = '131050100DL0200681';
        --SELECT * FROM mig_sin_tramita_reserva s for update WHERE s.mig_pk = 'RD30094778';
        --SELECT * FROM sin_tramitacion s WHERE mig_fk = '1023871325';
   --
   dml_errors EXCEPTION;
   PRAGMA EXCEPTION_INIT(dml_errors, -24381);
   l_errors  NUMBER;
   l_errno   NUMBER;
   l_msg     VARCHAR2(4000);
   l_idx     NUMBER;
   --
BEGIN
  --
  l_timestart := dbms_utility.get_time(); 
  --
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD'))
    INTO vdummy
    FROM dual;
  --
  b_error    := FALSE;
  b_hay_dato := FALSE;
  --
  -----------------------------------------
  --SEGUROS
  -----------------------------------------
  OPEN lc_mig_sin_tramita_reserva;
  LOOP
    --
    FETCH lc_mig_sin_tramita_reserva BULK COLLECT INTO l_reg_mig_mcc LIMIT v_limit_records;
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_sin_tramita_reserva WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_sin_tramita_reserva VALUES l_reg_mig_mcc(i);
      --
    EXCEPTION
    WHEN DML_ERRORS THEN
      --
      l_errors := SQL%bulk_exceptions.count;
      --
      dbms_output.put_line('l_errors:'||l_errors);
      --
      FOR i IN 1 .. l_errors
      LOOP
        --
        l_errno := SQL%BULK_EXCEPTIONS(i).error_code;
        l_msg   := SQLERRM(-l_errno);
        l_idx   := SQL%BULK_EXCEPTIONS(i).error_index;
        --
        p_control_error('CXHGOME','20_mig_sin_tramita_reserva','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_sin_tramita_reserva%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_sin_tramita_reserva;
   --
   IF NOT b_error 
      AND b_hay_dato
   THEN
    --
    COMMIT;
    dbms_output.put_line('- COMMIT -');
    --
   ELSE
    --
    ROLLBACK;
    dbms_output.put_line('- ROLLBACK -');
    --
   END IF;
   --
   l_timeend := dbms_utility.get_time(); 
   l_time    := (l_timeend - l_timestart) / 100;
   dbms_output.put_line('Tiempo de Ejecución: ' || l_time || ' seg'); 
   --
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--DELETE FROM mig_sin_tramita_reserva;
SELECT * FROM mig_sin_tramita_reserva;
SELECT * FROM mig_sin_tramita_reserva_conf s ;
SELECT * FROM mig_sin_tramita_reserva_conf s WHERE s.crespue IS NULL
SELECT * FROM sin_prof_profesionales s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_sin_tramita_reserva' and seqerror > 9537681 order by seqerror;
DELETE FROM control_error s WHERE s.donde = '20_mig_sin_tramita_reserva';
SELECT * FROM control_error s WHERE s.donde = '20_mig_sin_tramita_reserva' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_sin_tramita_reserva);
SELECT * FROM mig_sin_tramita_reserva s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
UPDATE mig_sin_tramita_reserva s SET cestmig = 1;
SELECT * FROM sin_tramita_reserva s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT   a.* /*a.*, s.nsinies s_nsinies, s.fsinies fsinies, s.sseguro sseguro,
                         s.nriesgo nriesgo, t.ctramit ctramit, s.ccausin ccausin,
                         s.cmotsin cmotsin, s.fnotifi fnotifi, seg.sproduc sproduc,
                         NVL(seg.cactivi, 0) cactivi*/ 
    FROM mig_sin_tramita_reserva a, mig_sin_tramitacion t, mig_sin_siniestro s,
         seguros seg
   WHERE t.mig_pk = a.mig_fk
     AND s.mig_pk = t.mig_fk
     AND a.ncarga = 17454
--     AND a.cestmig = 1
     AND seg.sseguro = s.sseguro
     AND a.mig_pk = '13105010098141'
ORDER BY a.mig_fk, a.nmovres;
--
SELECT * FROM sin_tramitacion WHERE nsinies = 201780351097;
--
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17454 AND s.seqlog > 0;
--
SELECT * FROM tab_error WHERE TRUNC(SYSDATE)= TRUNC(f_sysdate) AND ntraza = 7;

SELECT * FROM user_constraints WHERE constraint_name = 'SIN_TRARES_TRAMITACION_FK';

