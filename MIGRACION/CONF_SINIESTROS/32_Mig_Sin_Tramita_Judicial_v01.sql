DECLARE
    /******************************************************************************
    NOMBRE:       32_Mig_Sin_Tramita_Judicial_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de MIG_SIN_TRAMITA_JUDICIAL - PRODUCCION

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
   TYPE t_mig_sin_tramita_judicial IS TABLE OF mig_sin_tramita_judicial%ROWTYPE;
   l_reg_mig_mcc t_mig_sin_tramita_judicial;
   --
    CURSOR lc_mig_sin_tramita_judicial IS
     SELECT 17448 NCARGA, 1 CESTMIG, 0 nsinies, 0 ntramit, a.MIG_PK,	a.MIG_FK,	a.MIG_FK2,	a.NORDEN,	a.CPROCESO,	a.TPROCESO,	a.CPOSTAL,	
     a.CPOBLAC,	a.CPROVIN,	a.TIEXTERNO,	a.SPROFES,	a.FRECEP,	a.FNOTIFI,	a.FVENCIMI,	a.FRESPUES,	a.FCONCIL,	a.FDESVIN,	
     a.TPRETEN,	a.TEXCEP1,	a.TEXCEP2,	a.FAUDIEN,	a.HAUDIEN,	a.TAUDIEN,	a.CCONTI,	a.CDESPA,	a.TLAUDIE,	a.CAUDIEN,	
     a.CDESPAO,	a.TLAUDIEO,	a.CAUDIENO,	a.SABOGAU,	a.CORAL,	a.CESTADO,	a.CRESOLU,	a.FINSTA1,	a.FINSTA2, a.FNUEVA, a.TRESULT,	
     a.CPOSICI,	a.CDEMAND,	a.SAPODERA,	a.IDEMAND,	a.FTDEMAN,	a.ICONDEN, a.CSENTEN, a.FSENTE1, a.FSENTE2, a.CTSENTE, a.TFALLO, a.FMODIFI, a.CUSUALT
     , NULL CASACION,	NULL FCASACI,	NULL CSENTEN2,	NULL FTSENTE /*Ojo habilitar para la version 25. Ya deberían estar inf estos campos*/
     --select *
      FROM mig_sin_tra_judicial_cl2 a, mig_sin_siniestro s, mig_sin_tramitacion t
     WHERE 1 = 1
        AND a.mig_fk = s.mig_pk
        AND a.mig_fk2 = t.mig_pk
        AND s.nsinies <> 0
        AND t.nsinies <> 0
      ORDER BY a.mig_pk
        ;
        --SELECT * FROM mig_sin_tra_judicial_cl1 s for update; WHERE s.mig_pk = '131050100DL0200681';
        --SELECT * FROM mig_sin_tramita_judicial s for update WHERE s.mig_pk = 'RD30094778';
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
  OPEN lc_mig_sin_tramita_judicial;
  LOOP
    --
    FETCH lc_mig_sin_tramita_judicial BULK COLLECT INTO l_reg_mig_mcc LIMIT v_limit_records;
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_sin_tramita_judicial WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_sin_tramita_judicial VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','32_mig_sin_tramita_judicial','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_sin_tramita_judicial%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_sin_tramita_judicial;
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
--DELETE FROM mig_sin_tramita_judicial;
/*SELECT * FROM mig_sin_tramita_judicial_conf;
SELECT * FROM mig_sin_tramita_judicial s ;
SELECT * FROM mig_sin_tramita_judicial s WHERE s.crespue IS NULL
SELECT * FROM sin_prof_profesionales s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_sin_tramita_judicial' and seqerror > 9537681 order by seqerror;
/*DELETE FROM control_error s WHERE s.donde = '03_mig_sin_tramita_judicial'
SELECT * FROM control_error s WHERE s.donde = '45_mig_sin_tramita_judicial' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_sin_tramita_judicial);
SELECT * FROM mig_sin_tramita_judicial s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM mig_sin_tramita_judicial s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT * FROM TIPOS_INDICADORES s WHERE s.
*/