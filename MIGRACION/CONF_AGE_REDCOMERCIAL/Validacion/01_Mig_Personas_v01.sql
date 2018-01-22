DECLARE
    /******************************************************************************
    NOMBRE:       01_Mig_Personas_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de mig_personas - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 08/09/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   TYPE t_mig_personas IS TABLE OF mig_personas%ROWTYPE;
   l_reg_mig_mcc t_mig_personas;
   --
    CURSOR lc_mig_personas IS
     SELECT 17413 NCARGA, 1 CESTMIG, a.MIG_PK,	0 IDPERSON,	a.SNIP,	a.CTIPIDE,	a.NNUMIDE,	a.CESTPER,	a.CPERTIP,	a.FULTMOD,	a.SWPUBLI,	DECODE(LENGTH(CSEXPER), 1, CSEXPER, 0) CSEXPER,
            a.FNACIMI,	a.CAGENTE,	a.TAPELLI1,	a.TAPELLI2,	a.TNOMBRE,	a.CESTCIV,	a.CPAIS,	a.CPROFES,	a.CNACIO,	NULL CTIPDIR,	
            NULL CTIPVIA,	NULL TNOMVIA,	NULL NNUMVIA,	NULL TCOMPLE,	NULL CPOSTAL,	NULL CPOBLAC,	NULL CPROVIN,	NULL CTIPDIR2,	
            NULL CTIPVIA2,	NULL TNOMVIA2,	NULL NNUMVIA2,	NULL TCOMPLE2,	NULL CPOSTAL2,	NULL CPOBLAC2,	NULL CPROVIN2,	NULL TNUMTEL,	
            NULL TNUMFAX,	NULL TNUMMOV,	NULL TEMAIL,	a.CTIPBAN,	a.CBANCAR,	a.CIDIOMA,	NULL CTIPIDE2,	NULL NNUMIDE2,	
            NULL FJUBILA,	a.TNOMBRE2,	a.TDIGITOIDE,	NULL PROCESO,	NULL FVENCIM,	NULL COCUPACION,	NULL FANTIGUEDAD,	a.FDEFUNC
       FROM /*transformacion.*/mig_personas_conf a
       WHERE a.ctipide = 0 --37.293 tipo = 0, se pasarían 37.207
       AND a.mig_pk NOT IN (SELECT p.mig_pk FROM mig_personas p WHERE p.ncarga = 17411 AND p.ctipide = 38 AND p.idperson <> 0)
      --select * from mig_personas_conf      
    ORDER BY CTIPIDE, NNUMIDE
        ;         
        --SELECT * FROM mig_personas s; 
        --SELECT * FROM mig_personas_conf s;
        --SELECT * FROM mig_garanseg s WHERE s =  ORDER BY s ;           
        --SELECT * FROM mig_movrecibo s;
        --SELECT * FROM mig_personas_conf s for update WHERE s.mig_pk = 'RD30094778';
        --SELECT * FROM cuacesfac s WHERE mig_fk = '1023871325';
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
  OPEN lc_mig_personas;
  LOOP
    --
    FETCH lc_mig_personas BULK COLLECT INTO l_reg_mig_mcc LIMIT v_limit_records;
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_personas WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_personas VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','01_mig_personas','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_personas%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_personas;
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
--DELETE FROM mig_personas;
SELECT * FROM mig_personas_conf WHERE mig_pk = '12705201711119969994450';
SELECT * FROM cesionesrea s ;
SELECT COUNT(*) FROM mig_personas s WHERE s.ncarga = 17413;
SELECT * FROM sin_prof_profesionales s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_personas' and seqerror > 9537681 order by seqerror;
DELETE FROM control_error s WHERE s.donde = '03_mig_personas'
SELECT * FROM control_error s WHERE s.donde = '01_mig_personas' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_personas);
SELECT * FROM mig_personas s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM cesionesrea s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT * FROM TIPOS_INDICADORES s WHERE s.
