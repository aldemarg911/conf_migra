-- 04_Carga_Mig_Parpersonas_rel_v01.sql
DECLARE
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
     TYPE t_mig_parpersonas IS TABLE OF mig_parpersonas%ROWTYPE;
     l_reg_mig_mcc t_mig_parpersonas;
     --
      CURSOR lc_mig_parpersonas IS
       SELECT 17413 NCARGA, 1 CESTMIG, a.MIG_PK, a.MIG_FK, a.CPARAM, a.TIPVAL, a.VALVAL
       --Select Count(*)
         FROM mig_parpersonas_cl2 a, mig_personas p
         WHERE 1 = 1
           AND a.mig_fk = p.mig_pk
      ORDER BY a.mig_pk
          ;
     --
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
    -----------------------------------------
    --PARPERSONAS
    -----------------------------------------
    OPEN lc_mig_parpersonas;
    LOOP
      --
      FETCH lc_mig_parpersonas BULK COLLECT INTO l_reg_mig_mcc LIMIT 10000;
      --
      dbms_output.put_line('per_parpersonas - I - paso bullk');
      --
      dbms_output.put_line('...');
      --
      --FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
      --DELETE FROM mig_parpersonas WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
      --
      BEGIN
        --
        FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
        INSERT INTO mig_parpersonas VALUES l_reg_mig_mcc(i);
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
          p_control_error('CXHGOME','07_mig_parpersonas','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
          --
        END LOOP;
        --
      END;
      --
      dbms_output.put_line('per_parpersonas - F - paso bullk');
      --
      COMMIT;
      EXIT WHEN lc_mig_parpersonas%NOTFOUND;
       --
     END LOOP;
     --
     CLOSE lc_mig_parpersonas;
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
