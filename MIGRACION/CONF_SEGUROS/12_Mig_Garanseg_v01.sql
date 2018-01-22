DECLARE
    /******************************************************************************
    NOMBRE:       13_Mig_Garanseg_v01
    PROPÓSITO:    Procedimiento que ejecuta carga de RIESGOS - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 17/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar Asegurados
*/
   --
   --l_data            ARRAY;
   l_timestart       NUMBER;
   l_timeend         NUMBER;
   l_time            NUMBER;
   vdummy            NUMBER;
   --
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz 
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   b_error           BOOLEAN;
   b_hay_dato        BOOLEAN;
   v_cant            NUMBER := 0;
   --
   TYPE t_mig_garanseg IS TABLE OF mig_garanseg%ROWTYPE;
   l_reg_mig_mcc t_mig_garanseg;
   --
    CURSOR lc_mig_garanseg IS
     SELECT 17426 ncarga,1 CESTMIG, a.MIG_PK, a.MIG_FK, a.CGARANT, a.NRIESGO, a.NMOVIMI, 0 SSEGURO,
          a.FINIEFE, a.ICAPITAL, a.PRECARG, a.IEXTRAP, a.IPRIANU, a.FFINEFE, a.IRECARG, a.IPRITAR, a.FALTA,
          a.CREVALI, a.PREVALI, a.IREVALI, a.NMOVIMA, a.PDTOCOM, a.IDTOCOM, a.TOTANU, 0 PDTOTEC, a.PRECCOM,
          a.IDTOTEC, a.IRECCOM, a.FINIVIG, a.FFINVIG, 0 CCOBPRIMA, 0 IPRIDEV 
          --SELECT COUNT(*)
        FROM /*transformacion.*/mig_garanseg_cl2 a, mig_seguros s, mig_movseguro m
       WHERE m.mig_pk = a.mig_fk
         AND s.mig_pk = m.mig_fk
         --AND s.sseguro <> 0
         --AND m.sseguro <> 0
        --AND s.mig_pk = '131050100DL0200681'
        ; 
        --SELECT count(*) FROM mig_garanseg_cl1 s WHERE s.mig_pk = '131050100DL0200681';
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
  OPEN lc_mig_garanseg;
  LOOP
    --
    FETCH lc_mig_garanseg BULK COLLECT INTO l_reg_mig_mcc LIMIT 100000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    --FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    --DELETE FROM mig_garanseg WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_garanseg VALUES l_reg_mig_mcc(i);
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
        p_control_error('ALUNA','13_mig_garanseg','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_garanseg%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_garanseg;
   --
   IF NOT b_error 
      AND b_hay_dato
   THEN
    --
    COMMIT;
    dbms_output.put_line('- Ini pac_mig_axis.p_migra_cargas -');
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

/*DELETE mig_garanseg;
SELECT * FROM mig_garanseg WHERE sseguro = 0 ;
SELECT COUNT(*) FROM mig_garanseg WHERE cestmig = 1; 
--969764 968075 -1689xmin
SELECT COUNT(*) FROM mig_logs_axis s WHERE s.ncarga = 17421;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_garanseg' and seqerror > 9537681 order by seqerror;  */
/*DELETE FROM control_error s WHERE s.donde = '13_mig_garanseg'
SELECT * FROM control_error s WHERE s.donde = '13_mig_garanseg' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_garanseg);
SELECT * FROM mig_garanseg s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM all_constraints
SELECT * FROM mig_garanseg_conf s;
SELECT * FROM mig_seguros m WHERE mig_pk = '101010200CU1274111';
SELECT * FROM mig_riesgos m WHERE mig_fk = '101010200CU1274111';
SELECT * FROM mig_movseguro m WHERE mig_pk = '101010200CU1274111';
SELECT * FROM mig_garanseg WHERE sseguro = 0 AND mig_pk = '101010200CU1274111101020020';
-- 09_Mig_MovSeguro_v01.sql
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17421 AND s.seqlog > 0;
--
SELECT * FROM seguros WHERE sseguro = 485259;
SELECT * FROM movseguro WHERE sseguro = 485259;
SELECT * FROM riesgos WHERE sseguro = 485259;
--
SELECT  COUNT(*)
  FROM mig_garanseg a, mig_seguros s, mig_movseguro m
 WHERE m.mig_pk = a.mig_fk
   AND s.mig_pk = m.mig_fk
   AND a.ncarga = 17421
--   AND a.cestmig = 1
   AND s.sseguro <> 0
   AND m.sseguro <> 0
--   AND a.mig_pk = '101010200CU1274111101020020'
ORDER BY a.mig_pk;  */
