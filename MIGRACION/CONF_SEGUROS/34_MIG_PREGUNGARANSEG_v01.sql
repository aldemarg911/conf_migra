DECLARE
    /******************************************************************************
    NOMBRE:       33_MIG_PREGUNGARANSEG_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de PREGUNGARANSEG - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 22/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   TYPE t_mig_pregungaranseg IS TABLE OF mig_pregungaranseg%ROWTYPE;
   l_reg_mig_mcc t_mig_pregungaranseg;
   --
    CURSOR lc_mig_pregungaranseg IS
     SELECT 17433 NCARGA,1 CESTMIG, a.MIG_PK, a.MIG_FK,
            0 SSEGURO, a.NRIESGO, a.CGARANT, a.CPREGUN, to_number(replace(a.CRESPUE, '.', ','))
         --SELECT COUNT(*)
        FROM mig_pregungaranseg_cl2 a, mig_seguros s
       WHERE s.mig_pk = a.mig_fk
       --  AND a.mig_fk = '105010200CU0529351'
    ORDER BY a.mig_pk
        --AND s.mig_pk = '131050100DL0200681'
        ; 
        --SELECT * FROM mig_pregungaranseg_conf s WHERE s.mig_pk = '131050100DL0200681';
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
  OPEN lc_mig_pregungaranseg;
  LOOP
    --
    FETCH lc_mig_pregungaranseg BULK COLLECT INTO l_reg_mig_mcc LIMIT 10000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_pregungaranseg WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_pregungaranseg VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','34_mig_pregungaranseg','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_pregungaranseg%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_pregungaranseg;
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

/*
SELECT * FROM mig_pregungaranseg s WHERE s.mig_fk = '105010200CU0529351';
SELECT * FROM seguros WHERE sseguro = 274319;
SELECT * FROM garanseg WHERE sseguro = 274319;
SELECT * FROM pregungaranseg WHERE sseguro = 274319;
--DELETE FROM mig_pregungaranseg;
SELECT * FROM mig_pregungaranseg WHERE sseguro != 0;
SELECT * FROM mig_pregungaranseg_conf s WHERE s.mig_pk IN ('101010100GU0884501010101015', '101010100GU0884501010101017', '101010100GU0884501010101030');
SELECT * FROM mig_pregungaranseg_conf s WHERE s.crespue IS NULL
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
/*SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17430 AND s.seqlog > 0;
DELETE FROM control_error s WHERE s.donde = '03_mig_pregungaranseg'
SELECT * FROM control_error s WHERE s.donde = '25_mig_pregungaranseg' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_pregungaranseg);
SELECT * FROM mig_pregungaranseg s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM mig_pregungaranseg s;
SELECT * FROM pregungaranseg s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT   COUNT(*)
  FROM     mig_pregungaranseg a, mig_seguros s, mig_movseguro m, codipregun p
     WHERE m.mig_pk = a.mig_fk
       AND s.mig_pk = m.mig_fk
       AND p.cpregun = a.cpregun
       AND a.ncarga = 17430
       AND a.cestmig = 1;
*/