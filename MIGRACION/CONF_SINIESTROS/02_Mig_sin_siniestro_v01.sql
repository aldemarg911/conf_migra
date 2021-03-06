DECLARE
    /******************************************************************************
    NOMBRE:       08_Mig_sin_siniestro_v01.sql
    PROP�SITO:    Procedimiento que ejecuta carga de MIG_SIN_SINIESTRO - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripci�n
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creaci�n del script.
/* Formatted on 24/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   TYPE t_mig_sin_siniestro IS TABLE OF mig_sin_siniestro%ROWTYPE;
   l_reg_mig_mcc t_mig_sin_siniestro;
   --
    CURSOR lc_mig_sin_siniestro IS
     SELECT 20070 NCARGA, 1 CESTMIG, a.MIG_PK,	a.MIG_FK, a.NSINIES, 0 SSEGURO,	a.NRIESGO,	a.NMOVIMI,	
     a.FSINIES,	a.FNOTIFI,	a.CCAUSIN,	a.CMOTSIN,	a.CEVENTO,	a.CCULPAB,	a.CRECLAMA,	a.NASEGUR,	a.CMEDDEC,	
     a.CTIPDEC,	a.TNOM1DEC TNOMDEC,	a.TAPE1DEC,	a.TAPE2DEC,	a.TTELDEC,	a.TSINIES,	NVL(a.CUSUALT, 'CONF_MIG'),	NVL(a.FALTA, F_SYSDATE),	NVL(a.CUSUMOD, 'CONF_MIG'), 
     a.FMODIFI,	a.NCUACOA,	a.NSINCOA,	a.CSINCIA, a.TEMAILDEC, a.CTIPIDE, a.NNUMIDE, a.TNOM2DEC, a.TNOM1DEC, NULL CAGENTE, NULL CCARPETA
     --SELECT *
      FROM mig_sin_siniestro_cl2 a, mig_seguros s
     WHERE 1 = 1
        AND a.mig_fk = s.mig_pk
        AND s.sseguro <> 0
        /*AND d.mig_fk = p.mig_pk (+)*/
      ORDER BY a.mig_pk
        ; 
        --SELECT * FROM mig_sin_siniestro_conf s for update; WHERE s.mig_pk = '131050100DL0200681';
        --SELECT * FROM mig_sin_siniestro s for update WHERE s.mig_pk = 'RD30094778';
        --SELECT * FROM sin_prof_indicadores s WHERE mig_fk = '1023871325';
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
  OPEN lc_mig_sin_siniestro;
  LOOP
    --
    FETCH lc_mig_sin_siniestro BULK COLLECT INTO l_reg_mig_mcc LIMIT 100000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_sin_siniestro WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_sin_siniestro VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','08_mig_sin_siniestro','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_sin_siniestro%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_sin_siniestro;
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
   dbms_output.put_line('Tiempo de Ejecuci�n: ' || l_time || ' seg'); 
   --
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--
/*
DELETE FROM mig_sin_siniestro;
SELECT COUNT(*) FROM mig_sin_siniestro WHERE cestmig != 1; -- 2155
SELECT * FROM mig_sin_siniestro_conf s ;
SELECT * FROM mig_sin_siniestro_conf s WHERE s.crespue IS NULL
SELECT * FROM sin_prof_profesionales s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_sin_siniestro' and seqerror > 9537681 order by seqerror;
/*DELETE FROM control_error s WHERE s.donde = '08_mig_sin_siniestro';
SELECT * FROM control_error s WHERE s.donde = '08_mig_sin_siniestro' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_sin_siniestro);
SELECT * FROM mig_sin_siniestro s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM mig_sin_siniestro_conf s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT * FROM TIPOS_INDICADORES s WHERE s.;
--
SELECT * FROM 
--
SELECT COUNT(*)
  FROM mig_sin_siniestro a, mig_seguros s
 WHERE s.mig_pk = a.mig_fk
   AND a.ncarga = 17444 
   AND a.cestmig = 1
ORDER BY a.mig_pk
--
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17444 AND s.seqlog > 0;
SELECT * FROM mig_sin_siniestro s WHERE s.mig_pk = '1030101006548';
SELECT   *
  FROM mig_riesgos
 WHERE mig_fk2 = '124010200CU0685331'
*/