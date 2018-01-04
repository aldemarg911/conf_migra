DECLARE
    /******************************************************************************
    NOMBRE:       03_Mig_CodiContratos
    PROPÓSITO:    Procedimiento que ejecuta carga de CodiContratos - REASEGUROS

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 01/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar CodiContratos de Reaseguro
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
   TYPE t_mig_CodiContratos IS TABLE OF mig_CodiContratos%ROWTYPE;
   l_reg_mig_mcc t_mig_CodiContratos;
   --
    CURSOR lc_mig_CodiContratos IS
     SELECT DISTINCT 20047 ncarga,1 CESTMIG, MIG_PK, MIG_FK, NVERSION, 0 SCONTRA, SPLENO, CEMPRES, CTIPREA, FINICTR,
       FFINCTR, NCONREL, SCONAGR, CVIDAGA, CVIDAIR, CTIPCUM, CVALID, CRETIRA, CMONEDA, TDESCRIPCION, CDEVENTO
       FROM /*transformacion.*/mig_CodiContratos_conf mcc
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
  --CODICodiContratos
  -----------------------------------------
  OPEN lc_mig_CodiContratos;
  LOOP
    --
    FETCH lc_mig_CodiContratos BULK COLLECT INTO l_reg_mig_mcc LIMIT 500;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');  
    --
    dbms_output.put_line('...');  
    b_hay_dato := TRUE;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_CodiContratos VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','03_Mig_CodiContratos','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(i+1).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_CodiContratos%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_CodiContratos;
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
SELECT * FROM mig_CodiContratos; --WHERE mig_pk IN (SELECT mig_pk FROM direccion_tmp)
--DELETE FROM mig_CodiContratos WHERE scontra = 0;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '02_Mig_Direcciones' and seqerror > 9537681 order by seqerror;
