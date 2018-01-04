DECLARE
    /******************************************************************************
    NOMBRE:       29_Mig_PRPC_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de PRPC - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 11/09/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   TYPE t_mig_prpc IS TABLE OF mig_prpc%ROWTYPE;
   l_reg_mig_mcc t_mig_prpc;
   --
    CURSOR lc_mig_prpc IS
     SELECT ROWNUM MIG_PK, 17467 NCARGA, 1 CESTMIG, a.PRODUCTO, 0 SSEGURO, a.POLIZA, a.MOVIMIENTO NMOVIMIENTO, 
            NVL(r.nriesgo, a.NRIESGO) NRIESGO, a.RECIBO, a.GARANTIA, a.FCALCULO, a.FECHA_INICIO, a.IPRPC, 
            a.IPRICOM, a.IPPNAPRIMA, a.IPPNCCOMIS, a.PREA, a.PCOM, a.ICOMIS, a.IPDEVRC, a.IPNCSRC, a.ICOMRC, 
            a.ICNCSRC, a.CTRAMO
       --select count(*)
       --select *
       FROM mig_prpc_cl1 a, mig_seguros s, mig_riesgos r
      WHERE 1 = 1
        AND a.POLIZA  = s.mig_pk (+) --Sacar consulta de los excluidos
        AND s.mig_pk  = r.mig_fk2
        --AND s.ccompani <> 0 --Sacar consulta de los excluidos
        --AND c.sfacult <> 0
      --ORDER BY a.mig_pk
        ;
        --SELECT * FROM mig_prpc s; 
        --SELECT * FROM mig_prpc_conf s;
        --SELECT * FROM mig_garanseg s WHERE s =  ORDER BY s ;           
        --SELECT * FROM ptpplp s;
        --SELECT * FROM mig_prpc_conf s for update WHERE s.mig_pk = 'RD30094778';
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
  OPEN lc_mig_prpc;
  LOOP
    --
    FETCH lc_mig_prpc BULK COLLECT INTO l_reg_mig_mcc LIMIT v_limit_records;
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    --FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    --DELETE FROM mig_prpc WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_prpc VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','29_mig_prpc','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_prpc%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_prpc;
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
--DELETE FROM mig_prpc;
SELECT * FROM mig_prpc_conf WHERE mig_pk = '12705201711119969994450';
SELECT * FROM ptpplp s ;
SELECT * FROM mig_prpc s;
SELECT * FROM POBLACIONES s WHERE s =  ORDER BY s ; 
SELECT * FROM prpc s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_prpc' and seqerror > 9537681 order by seqerror;
DELETE FROM control_error s WHERE s.donde = '26_mig_prpc';
SELECT * FROM control_error s WHERE trunc(fecha)= TRUNC(SYSDATE) AND s.donde = '26_mig_prpc' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_prpc);
SELECT * FROM mig_prpc s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM cesionesrea s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT * FROM All_Objects s WHERE s.OWNER = 'AXIS_D712' AND object_name = 'PAC_JOBS';
--
insert into mig_prpc (NCARGA, CESTMIG, PRODUCTO, POLIZA, SSEGURO, NMOVIMIENTO, RIESGO, GARANTIA, FCALCULO, IPRIDEV, IPRINCS, IPDEVRC, IPNCSRC, FEFEINI, FFINEFE, ICOMAGE, ICOMNCS, ICOMRC, ICNCSRC, IRECFRA, PRECARG, IRECFRANC)
values (17466, 1, 8009, '101010200CU0642861', 0, 1, 0, null, to_date('31-08-2017', 'dd-mm-yyyy'), 13915.00, -675.00, 0.00, 0.00, to_date('17-11-2009', 'dd-mm-yyyy'), to_date('17-11-2017', 'dd-mm-yyyy'), 6000.00, 5712.62, 0.00, 0.00, 0.00, 0.00, 0.00);
