DECLARE
    /******************************************************************************
    NOMBRE:       07_Mig_ctacoaseguro
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
   b_error           BOOLEAN;
   b_hay_dato        BOOLEAN;
   v_cant            NUMBER := 0;
   --
   TYPE t_mig_ctacoaseguro IS TABLE OF mig_ctacoaseguro%ROWTYPE;
   l_reg_mig_mcc t_mig_ctacoaseguro;
   --
    CURSOR lc_mig_ctacoaseguro IS
     SELECT 17481 ncarga,1 CESTMIG, a.MIG_PK, a.SMOVCOA, a.MIG_FK2, a.CIMPORT, a.CTIPCOA, a.CMOVIMI, a.IMOVIMI, a.FMOVIMI,
            a.FCONTAB, a.CDEBHAB, a.FLIQCIA, a.PCESCOA, a.SIDEPAG, 0 NRECIBO, 0 SMOVREC, a.CEMPRES, 0 SSEGURO, a.SPRODUC, a.CESTADO,
            a.CTIPMOV, a.TDESCRI, a.TDOCUME, a.IMOVIMI_MONCON, a.FCAMBIO, a.NSINIES, a.CCOMPAPR, a.CMONEDA, a.SPAGCOA, a.CTIPGAS,
            a.FCIERRE, a.NTRAMIT, a.NMOVRES, a.CGARANT, a.MIG_FK3, a.MIG_FK4, a.MIG_FK5
     --select count(*)
     --select *
       FROM mig_ctacoaseguro_cl1 a, mig_companias c, mig_seguros s, mig_recibos r, mig_siniestros sn
      WHERE 1 = 1
        AND a.mig_fk2 = c.mig_pk
        AND a.mig_fk3 = s.mig_pk (+)
        AND a.mig_fk4 = r.mig_pk (+)
        AND a.mig_fk5 = sn.mig_pk (+)
        ;
        --select * from mig_ctacoaseguro
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
  OPEN lc_mig_ctacoaseguro;
  LOOP
    --
    FETCH lc_mig_ctacoaseguro BULK COLLECT INTO l_reg_mig_mcc LIMIT 10000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');  
    --
    dbms_output.put_line('...');  
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_ctacoaseguro WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_ctacoaseguro VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','07_mig_ctacoaseguro','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_ctacoaseguro%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_ctacoaseguro;
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
   p_control_error('CXHGOME','07_mig_ctacoaseguro','Tiempo de Ejecución: '|| l_time || ' ms');
   dbms_output.put_line('Tiempo de Ejecución: ' || l_time || ' ms'); 
   --
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--
DELETE FROM mig_ctacoaseguro s;
SELECT * FROM mig_ctacoaseguro s;
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17481 AND s.seqlog > 0;
SELECT * FROM ctacoaseguro s;
SELECT * FROM all_source s where s.owner = 'AXIS' AND upper(s.text) LIKE UPPER('%insert into ctacoaseguro%');   
--F_INSCTACOAS
DELETE FROM control_error s WHERE s.donde = '07_mig_ctacoaseguro';
SELECT * FROM control_error s WHERE s.donde = '07_mig_ctacoaseguro' order by seqerror;
