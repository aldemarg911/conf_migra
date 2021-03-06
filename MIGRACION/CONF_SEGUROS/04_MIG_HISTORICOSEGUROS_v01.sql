DECLARE
    /******************************************************************************
    NOMBRE:       04_MIG_HISTORICOSEGUROS_v01.sql
    PROP�SITO:    Procedimiento que ejecuta carga de MIG_HISTORICOSEGUROS - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripci�n
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creaci�n del script.
/* Formatted on 28/09/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   TYPE t_MIG_HISTORICOSEGUROS IS TABLE OF MIG_HISTORICOSEGUROS%ROWTYPE;
   l_reg_mig_mcc t_MIG_HISTORICOSEGUROS;
   --
    CURSOR lc_MIG_HISTORICOSEGUROS IS
     SELECT 17417 NCARGA,1 CESTMIG, a.MIG_PK, a.MIG_FK, a.MIG_FK2, a.MIG_FKDIR, a.CAGENTE, a.NCERTIF, a.FEFECTO, a.CACTIVI,
            a.CCOBBAN, a.CTIPREA, a.CREAFAC, a.CTIPCOM, a.CSITUAC, a.FVENCIM, a.FEMISIO, a.FANULAC, a.IPRIANU, a.CIDIOMA, a.CFORPAG,
            a.CRETENI, a.CTIPCOA, a.SCIACOA, a.PPARCOA, a.NPOLCOA, a.NSUPCOA, a.NCUACOA, a.PDTOCOM, a.CEMPRES, a.SPRODUC, a.CCOMPANI,
            a.CTIPCOB, a.CREVALI, a.PREVALI, a.IREVALI, a.CTIPBAN, a.CBANCAR, a.CASEGUR, a.NSUPLEM, a.CDOMICI, a.NPOLINI, a.FCARANT, 
            a.FCARPRO, a.CRECFRA, a.NDURCOB, a.FCARANU, a.NDURACI, a.NEDAMAR, a.FEFEPLAZO, a.FVENCPLAZO, a.MIG_FK3
     --SELECT count(*)     
      FROM MIG_HISTORICOSEGUROS_cl1 a, mig_movseguro s      
     WHERE 1 = 1
        AND a.mig_fk2 = s.mig_pk
  ORDER BY a.mig_pk
        ; 
        --SELECT * FROM MIG_HISTORICOSEGUROS_conf s WHERE s.mig_pk = '131050100DL0200681';
        --SELECT * FROM mig_movseguro s WHERE s.mig_pk = '101010100GU1282421';
        --select * from seguros where sseguro = 482235;
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
  OPEN lc_MIG_HISTORICOSEGUROS;
  LOOP
    --
    FETCH lc_MIG_HISTORICOSEGUROS BULK COLLECT INTO l_reg_mig_mcc LIMIT 100000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    --FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    --DELETE FROM MIG_HISTORICOSEGUROS WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO MIG_HISTORICOSEGUROS VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','04_MIG_HISTORICOSEGUROS','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_MIG_HISTORICOSEGUROS%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_MIG_HISTORICOSEGUROS;
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
--DELETE FROM MIG_HISTORICOSEGUROS;
SELECT COUNT(*) FROM MIG_HISTORICOSEGUROS WHERE cestmig = 2 AND sseguro != 0;
SELECT * FROM MIG_HISTORICOSEGUROS s ;
SELECT * FROM MIG_HISTORICOSEGUROS_conf s WHERE s.crespue IS NULL
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17427 AND s.seqlog > 0;
DELETE FROM control_error s WHERE s.donde = '04_MIG_HISTORICOSEGUROS'
SELECT * FROM control_error s WHERE s.donde = '04_MIG_HISTORICOSEGUROS' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM MIG_HISTORICOSEGUROS);
SELECT * FROM MIG_HISTORICOSEGUROS s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM MIG_HISTORICOSEGUROS_conf s;
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT * FROM MIG_HISTORICOSEGUROS WHERE mig_pk = '104020200RM0021451';
SELECT * FROM mig_seguros WHERE mig_pk = '104020200RM0021451';
