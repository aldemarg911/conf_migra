DECLARE
    /******************************************************************************
    NOMBRE:       01_Mig_Companias
    PROPÓSITO:    Procedimiento que ejecuta carga de Direcciones - migracion

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 07/07/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar las Personas, Direcciones, per_agr_marcas, Personas_Rel y mig_regimenfiscal
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
   TYPE t_mig_companias IS TABLE OF mig_companias%ROWTYPE;
   l_reg_mig_mcc t_mig_companias;
   --
    CURSOR lc_mig_companias IS
     SELECT 17415 ncarga,1 CESTMIG, a.MIG_PK, a.MIG_FK, 0 CCOMPANI, a.TCOMPANI, a.CTIPCOM
       FROM /*transformacion.*/mig_companias_cl1 a
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
  --CONTRATOS
  -----------------------------------------
  OPEN lc_mig_companias;
  LOOP
    --
    FETCH lc_mig_companias BULK COLLECT INTO l_reg_mig_mcc LIMIT 1000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');  
    --
    dbms_output.put_line('...');  
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_companias WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_companias VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','01_Mig_Companias','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(i).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_companias%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_companias;
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
   p_control_error('CXHGOME','01_Mig_Companias','Tiempo de Ejecución: '|| l_time || ' ms');
   dbms_output.put_line('Tiempo de Ejecución: ' || l_time || ' ms'); 
   --
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--
SELECT * FROM all_source s where s.owner = 'AXIS_D712' AND upper(s.text) LIKE UPPER('%pac_rea.f_set_codicontratos%');    
PAC_MD_COMPANIAS; PAC_MD_REA
SELECT * FROM mig_companias WHERE cestmig = 2;
--
SELECT * FROM mig_direcciones_conf s WHERE s.mig_pk IN ('A01974161', 'A04728871', 'A04756551', 'A04762723', 'A07127781');
SELECT * FROM poblaciones s WHERE (s.cprovin, s.cpoblac) IN (
SELECT s.cprovin, s.cpoblac FROM mig_direcciones_conf s WHERE s.mig_pk IN ('A01974161', 'A04728871', 'A04756551', 'A04762723', 'A07127781')
);
--
SELECT * FROM bancos s
SELECT * FROM TIPOS_CUENTADES s WHERE CIDIOMA = 8 AND ctipban IN (88, 90, 178, 190, 97, 197, 170);
--
SELECT * FROM TIPOS_CUENTA s WHERE ctipban IN (88, 90, 178, 190, 97, 197, 170);
SELECT * FROM mig_companias WHERE mig_pk = 'A00011066';
--
SELECT * FROM mig_companias s
WHERE s.ncarga = 17415
  AND mig_fk = '800216567';
--
SELECT * FROM mig_per s WHERE s.mig_fk = '900332590';
SELECT * FROM reaseguro;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '02_Mig_Direcciones' and seqerror > 9537681 order by seqerror;
