DECLARE
    /******************************************************************************
    NOMBRE:       10_02_Mig_DetMovRecibos_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de mig_detmovrecibo - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 30/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar Asegurados
*/
   --
   l_timestart       NUMBER;
   l_timeend         NUMBER;
   l_time            NUMBER;
   vdummy            NUMBER;
   v_limit_records   NUMBER := 100000; -- limit to 10k to avoid out of memory
   --
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz 
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   b_error           BOOLEAN;
   b_hay_dato        BOOLEAN;
   v_cant            NUMBER := 0;
   --
   TYPE t_mig_detmovrecibo IS TABLE OF mig_detmovrecibo%ROWTYPE;
   l_reg_mig_mcc t_mig_detmovrecibo;
   --
    CURSOR lc_mig_detmovrecibo IS
     SELECT 17459 NCARGA, 1 CESTMIG, a.MIG_PK, a.MIG_FK, 0 NRECIBO, 0 SMOVREC, a.NORDEN, a.IIMPORTE,
            a.FMOVIMI, a.FEFEADM, a.CUSUARI, a.TDESCRIP, a.FCONTAB, a.IIMPORTE_MONCON, a.FCAMBIO
     --select count(*)
      FROM mig_detmovrecibo_cl2 a, mig_movrecibo s
     WHERE 1 = 1
        AND a.mig_fk  = s.mig_pk
        AND s.nrecibo <> 0
      ORDER BY a.mig_pk
        ;
        --SELECT * FROM mig_detmovrecibo_conf s;
        --SELECT * FROM mig_detmovrecibo s for update WHERE s.mig_pk = 'RD30094778';
        --SELECT * FROM sin_tramita_judicial_detper s WHERE mig_fk = '1023871325';
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
  OPEN lc_mig_detmovrecibo;
  LOOP
    --
    FETCH lc_mig_detmovrecibo BULK COLLECT INTO l_reg_mig_mcc LIMIT v_limit_records;
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    --FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    --DELETE FROM mig_detmovrecibo WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_detmovrecibo VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','08_mig_detmovrecibo','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_detmovrecibo%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_detmovrecibo;
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
--DELETE FROM mig_detmovrecibo;
SELECT * FROM mig_detmovrecibo;
SELECT COUNT(*) FROM mig_detmovrecibo;
SELECT COUNT(*) FROM mig_detmovrecibo s WHERE ncarga = 17435 AND cestmig != 1;
SELECT * FROM mig_detmovrecibo s WHERE s.crespue IS NULL;
SELECT * FROM detmovrecibo s;
SELECT * FROM sin_prof_profesionales s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17435 AND s.seqlog > 0;
DELETE FROM control_error s WHERE s.donde = '08_mig_detmovrecibo'
SELECT * FROM control_error s WHERE s.donde = '08_mig_detmovrecibo' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_detmovrecibo);
SELECT * FROM mig_detmovrecibo s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM mig_detmovrecibo s;
-- 09_Mig_MovSeguro_v01.sql
-- 
DECLARE
CURSOR lc_mig_pk IS
SELECT pkmig, pkaxis, to_number(SUBSTR(pkaxis, 1, INSTR(pkaxis, '|')-2)) nrecibo ,
       to_number(SUBSTR(pkaxis, INSTR(pkaxis, '|')+2, LENGTH(pkaxis))) smovrec   
  --SELECT COUNT(*)
  FROM mig_pk_mig_axis WHERE ncarga = 17434;
BEGIN
--
FOR i IN lc_mig_pk LOOP
UPDATE mig_detmovrecibo
  SET nrecibo = i.nrecibo,
      smovrec = i.smovrec,
      cestmig = 2
   WHERE mig_pk = i.pkmig;
END LOOP;
--
END;
--
SELECT * FROM mig_detmovrecibo_parcial_cl1;
SELECT COUNT(*) FROM mig_detmovrecibo WHERE cestmig = 2;
SELECT * FROM log_instalacion WHERE codigo = 'CONF_656';
--30631 - 30822 = 189 x 10 seg
--38976 - 39901 = 925 x min
--43941 - 44104 = 163 x 10 seg
SELECT * FROM mig_detmovrecibo WHERE cestmig = 2;
SELECT * FROM detmovrecibo;
--
SELECT COUNT(*)
  FROM mig_detmovrecibo d, mig_movrecibo a
 WHERE 1 = 1
   AND d.mig_fk = a.mig_pk
   AND d.ncarga = 17438
   AND d.cestmig = 1
   AND a.nrecibo <> 0
ORDER BY d.mig_pk
--
SELECT COUNT(*) FROM mig_logs_axis s WHERE s.ncarga = 17438;
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17438;
DELETE FROM mig_logs_axis s WHERE s.ncarga = 17438;
SELECT * FROM mig_detmovrecibo WHERE mig_fk = '135A072053510FAGU01712100';
--
SELECT * FROM DETMOVRECIBO;
--
SELECT * FROM log_instalacion WHERE codigo = 'CONF_656';
