DECLARE
    /******************************************************************************
    NOMBRE:       02_Mig_Direcciones_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de MIG_DIRECCIONES - PRODUCCION

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
   TYPE t_mig_direcciones IS TABLE OF mig_direcciones%ROWTYPE;
   l_reg_mig_mcc t_mig_direcciones;
   --
    CURSOR lc_mig_direcciones IS
     SELECT 17413 NCARGA, 1 CESTMIG, a.MIG_PK,	a.MIG_FK,	a.SPERSON,	a.CAGENTE,	a.CDOMICI,	a.CPOSTAL,	a.CPROVIN,	a.CPOBLAC,	
            NULL CSIGLAS,	a.TNOMVIA,	NULL NNUMVIA,	NULL TCOMPLE,	a.CTIPDIR,	a.CVIAVP,	a.CLITVP,	a.CBISVP,	a.CORVP,	a.NVIAADCO,	a.CLITCO,	
            a.CORCO,	a.NPLACACO,	a.COR2CO,	a.CDET1IA,	a.TNUM1IA,	a.CDET2IA,	a.TNUM2IA,	a.CDET3IA,	a.TNUM3IA,	a.LOCALIDAD,	
            NULL PROCESO,	a.TNUMTEL,	a.TNUMFAX,	a.TNUMMOV,	a.TEMAIL,	a.TALIAS
            SELECT COUNT(*)
       FROM mig_direcciones_conf a
       WHERE 1 = 1 --37.297
       AND a.mig_fk NOT IN (SELECT p.mig_pk FROM mig_personas p WHERE p.ncarga = 17413 AND p.ctipide = 0 AND p.idperson = 0)
       --AND IN (SELECT p.mig_pk FROM mig_personas p WHERE p.ncarga = 17413 AND p.mig_pk IN (SELECT mig_fk FROM mig_seguros WHERE sseguro = 0);
       --AND a.mig_fk IN (SELECT mig_fk FROM mig_seguros WHERE sseguro = 0)
       --AND a.mig_pk = 'A00005041'
      --select * from mig_direcciones_conf      
    ORDER BY a.MIG_PK
        ;         
        --SELECT * FROM mig_direcciones s; 
        --SELECT * FROM mig_direcciones_conf s;
        --SELECT * FROM mig_garanseg s WHERE s =  ORDER BY s ;           
        --SELECT * FROM mig_movrecibo s;
        --SELECT * FROM mig_direcciones_conf s for update WHERE s.mig_pk = 'RD30094778';
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
  OPEN lc_mig_direcciones;
  LOOP
    --
    FETCH lc_mig_direcciones BULK COLLECT INTO l_reg_mig_mcc LIMIT v_limit_records;
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_direcciones WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_direcciones VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','02_mig_direcciones','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_direcciones%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_direcciones;
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

--DELETE FROM mig_direcciones;
SELECT * FROM mig_direcciones_conf WHERE mig_pk = 'A00005041';
SELECT * FROM cesionesrea s ;
SELECT * FROM mig_personas s WHERE s.ncarga = 17413 AND mig_pk = '900910521'
SELECT COUNT(*) FROM mig_direcciones s WHERE s.ncarga = 17413 AND s.cestmig = 2 sperson  0;
SELECT * FROM sin_prof_profesionales s;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_direcciones' and seqerror > 9537681 order by seqerror;
DELETE FROM control_error s WHERE s.donde = '02_mig_direcciones';
SELECT * FROM control_error s 
WHERE 1 = 1
AND TO_DATE(to_char(s.fecha,'dd/mm/yyyy hh:mi PM'),'dd/mm/yyyy hh:mi PM') 
     BETWEEN to_date('13/09/2017 01:00 PM','dd/mm/yyyy hh:mi PM') 
     AND to_date('13/09/2017 07:30 PM','dd/mm/yyyy hh:mi PM')
AND s.donde = '02_mig_direcciones' order by seqerror;
--
SELECT COUNT(*) FROM mig_direcciones s WHERE s.ncarga = 17413 AND sperson != 0;
--
SELECT * FROM mig_direcciones WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_direcciones);
SELECT * FROM mig_direcciones s, mig_direcciones p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM cesionesrea s;
-- 09_Mig_MovSeguro_v01.sql
