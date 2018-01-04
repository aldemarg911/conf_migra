DECLARE
    /******************************************************************************
    NOMBRE:       02_Mig_fin_general_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de MIG_FIN_GENERAL - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 13/09/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   TYPE t_mig_fin_general IS TABLE OF mig_fin_general%ROWTYPE;
   l_reg_mig_mcc t_mig_fin_general;
   --
    CURSOR lc_mig_fin_general IS
     SELECT 17447 NCARGA, 1 CESTMIG, a.MIG_PK, a.MIG_FK, 0 SFINANCI, a.TDESCRIP, a.FCCOMER, a.CFOTORUT, a.FRUT,
            a.TTITULO, a.CFOTOCED, a.FEXPICED, a.CPAIS, a.CPROVIN, a.CPOBLAC, a.TINFOAD, a.CCIIU, a.CTIPSOCI, a.CESTSOC, a.TOBJSOC,
            a.TEXPERI, a.FCONSTI, a.TVIGENC
       --SELECT COUNT(*)
       FROM mig_fin_general_cl1 a, MIG_personas p
      WHERE 1 = 1
        AND a.mig_fk  = p.mig_pk  --Sacar consulta de los excluidos
        AND p.idperson <> 0 --Sacar consulta de los excluidos
      --ORDER BY a.mig_pk
        ;
        --SELECT * FROM mig_fin_general s; 
        --SELECT * FROM mig_fin_general_conf s;
        --SELECT * FROM mig_garanseg s WHERE s =  ORDER BY s ;           
        --SELECT * FROM ppna s;
        --SELECT * FROM mig_fin_general_conf s for update WHERE s.mig_pk = 'RD30094778';
        --SELECT * FROM fin_general s WHERE mig_fk = '1023871325';
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
  OPEN lc_mig_fin_general;
  LOOP
    --
    FETCH lc_mig_fin_general BULK COLLECT INTO l_reg_mig_mcc LIMIT v_limit_records;
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    --FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    --DELETE FROM mig_fin_general WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_fin_general VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','02_mig_fin_general','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '/*||l_reg_mig_mcc(l_idx).mig_pk*/);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_fin_general%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_fin_general;
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
--DELETE FROM mig_fin_general;
SELECT COUNT(*) FROM mig_fin_general WHERE cestmig = 2;
SELECT * FROM mig_fin_general WHERE cestmig = 2;
--25193 27241
SELECT * FROM mig_fin_general _conf WHERE mig_pk = '12705201711119969994450';
SELECT * FROM fin_general s ;
SELECT * FROM mig_fin_general s ;
SELECT * FROM sin_prof_profesionales s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_fin_general' and seqerror > 9537681 order by seqerror;
DELETE FROM control_error s WHERE s.donde = '02_mig_fin_general'
SELECT * FROM control_error s WHERE s.donde = '02_mig_fin_general' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_fin_general);
SELECT * FROM mig_fin_general s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM cesionesrea s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT * FROM All_Objects s WHERE s.OWNER = 'AXIS_D712' AND object_name = 'PAC_JOBS';
--
