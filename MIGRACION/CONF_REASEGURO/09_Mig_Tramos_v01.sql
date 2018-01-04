DECLARE
    /******************************************************************************
    NOMBRE:       07_Mig_Tramos
    PROPÓSITO:    Procedimiento que ejecuta carga de TRAMOS - REASEGUROS

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 31/07/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar Tramos de Reaseguro
*/
   --
   --l_data            ARRAY;
   l_timestart       NUMBER;
   l_timeend         NUMBER;
   l_time            NUMBER;
   vdummy            NUMBER;
   --
   vncarga           mig_cargas.ncarga%TYPE := 17437;
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz 
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   b_error           BOOLEAN;
   b_hay_dato        BOOLEAN;
   v_cant            NUMBER := 0;
   --
   TYPE t_mig_tramos IS TABLE OF mig_tramos%ROWTYPE;
   l_reg_mig_mcc t_mig_tramos;
   --
    CURSOR lc_mig_tramos IS
     SELECT DISTINCT 17437 ncarga,1 CESTMIG, MIG_PK, MIG_FK, NVERSIO, 0 SCONTRA, TO_NUMBER(SUBSTR(CTRAMO,1 , 2)) CTRAMO, ITOTTRA, NPLENOS, CFREBOR, PLOCAL,
                  IXLPRIO, IXLEXCE, PSLPRIO, PSLEXCE, NCESION, FULTBOR, IMAXPLO, TO_NUMBER(SUBSTR(NORDEN, 1, 2)) NORDEN, NSEGCON, NSEGVER, IMINXL, IDEPXL, NCTRXL,
                  NVERXL, PTASAXL, IPMD, CFREPMD, CAPLIXL, PLIMGAS, PLIMINX, IDAA, ILAA, CTPRIMAXL, IPRIMAFIJAXL, IPRIMAESTIMADA,
                  CAPLICTASAXL, CTIPTASAXL, CTRAMOTASAXL, PCTPDXL, CFORPAGPDXL, PCTMINXL, PCTPB, NANYOSLOSS, CLOSSCORRIDOR, CCAPPEDRATIO,
                  CREPOS, IBONOREC, IMPAVISO, IMPCONTADO, PCTCONTADO, PCTGASTOS, PTASAAJUSTE, ICAPCOASEG, PREEST, ICOSTOFIJO, PCOMISINTERM
      --SELECT COUNT(*)
       FROM /*transformacion.*/mig_tramos_cl1 mcc
      WHERE 1 = 1
        --AND mcc.mig_pk = '200127001'
        ; 
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
  --CODICONTRATOS
  -----------------------------------------
  OPEN lc_mig_tramos;
  LOOP
    --
    FETCH lc_mig_tramos BULK COLLECT INTO l_reg_mig_mcc LIMIT 10000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');  
    --
    dbms_output.put_line('...');  
    b_hay_dato := TRUE;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_tramos VALUES l_reg_mig_mcc(i);
      --
      NULL;
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
        p_control_error('CXHGOME','09_Mig_Tramos','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(i).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_tramos%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_tramos;
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
   l_time    := l_timeend - l_timestart;
   dbms_output.put_line('Tiempo de Ejecución: ' || l_time || ' ms'); 
   --
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--
DELETE mig_tramos;
SELECT * FROM mig_tramos WHERE cestmig = 2;
DELETE control_error WHERE donde = '09_Mig_Tramos';
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '02_Mig_Direcciones' and seqerror > 9537681 order by seqerror;
  SELECT s.*, c.scontra scontra1 
    FROM mig_tramos s, mig_contratos c
   WHERE s.ncarga = 17437
     AND s.cestmig = 1
     AND s.mig_fk = c.mig_pk;
--
SELECT * FROM mig_contratos WHERE mig_pk = '20132706'
--
SELECT * FROM mig_contratos
--
