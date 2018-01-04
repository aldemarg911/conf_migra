DECLARE
    /******************************************************************************
    NOMBRE:       05_Mig_MovRecibos_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de mig_movrecibo - PRODUCCION

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
   TYPE t_mig_movrecibo IS TABLE OF mig_movrecibo%ROWTYPE;
   l_reg_mig_mcc t_mig_movrecibo;
   --
    CURSOR lc_mig_movrecibo IS
     SELECT 17457 NCARGA, 1 CESTMIG, a.MIG_PK, a.MIG_FK, 0 NRECIBOS, 0 SMOVREC, a.CESTREC, a.FMOVINI, a.FMOVFIN, a.FEFEADM, a.FMOVDIA, a.CMOTMOV
     --SELECT count(*)
      FROM mig_movrecibo_cl2 a, mig_recibos s
     WHERE 1 = 1
        AND a.mig_fk  = s.mig_pk
        --AND s.nrecibo <> 0
      ORDER BY a.mig_pk
        ;
        --SELECT * FROM mig_movrecibo_conf s;
        --SELECT * FROM mig_movrecibo s for update WHERE s.mig_pk = 'RD30094778';
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
  OPEN lc_mig_movrecibo;
  LOOP
    --
    FETCH lc_mig_movrecibo BULK COLLECT INTO l_reg_mig_mcc LIMIT v_limit_records;
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_movrecibo WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_movrecibo VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','05_mig_movrecibo','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_movrecibo%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_movrecibo;
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

--DELETE FROM mig_movrecibo;
/*SELECT * FROM seguros s WHERE s.sseguro = 5265;
SELECT COUNT(*) FROM mig_movrecibo s WHERE s.nrecibo != 0;
SELECT * FROM movrecibo s WHERE nrecibo = '900000715' AND smovrec = 347733;
SELECT * FROM mig_recibos WHERE nrecibo = '900000715' AND smovrec = 347733;
SELECT * FROM mig_movrecibo WHERE nrecibo != 0;
SELECT * FROM mig_movrecibo s ;
SELECT * FROM mig_movrecibo s WHERE s.crespue IS NULL
SELECT * FROM sin_prof_profesionales s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
/*SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17434 AND s.seqlog > 0;
SELECT incid, COUNT(*) FROM mig_logs_axis s WHERE s.ncarga = 17434 AND s.seqlog > 0 GROUP BY incid;
DELETE FROM control_error s WHERE s.donde = '03_mig_movrecibo'
SELECT * FROM control_error s WHERE s.donde = '45_mig_movrecibo' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_movrecibo);
SELECT * FROM mig_movrecibo s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM mig_movrecibo s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT * FROM TIPOS_INDICADORES s WHERE s.;
SELECT COUNT(*)
  FROM mig_movrecibo a, mig_recibos r, mig_seguros s
 WHERE r.mig_pk = a.mig_fk
   AND a.ncarga = 17434
   AND s.mig_pk = r.mig_fk
   AND a.cestmig = 2
ORDER BY a.mig_pk;
*/