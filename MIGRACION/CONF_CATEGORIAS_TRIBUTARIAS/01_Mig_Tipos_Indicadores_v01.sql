DECLARE
    /******************************************************************************
    NOMBRE:       01_Mig_Tipos_Indicadores_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de TIPOS_INDICADORES - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 23/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   TYPE t_mig_tipos_indicadores IS TABLE OF mig_tipos_indicadores%ROWTYPE;
   l_reg_mig_mcc t_mig_tipos_indicadores;
   --
    CURSOR lc_mig_tipos_indicadores IS
     SELECT 17414 NCARGA,1 CESTMIG, a.MIG_PK, a.tindica, a.carea, a.ctipreg, a.cimpret, a.ccindid, a.cindsap, a.porcent, a.cclaing,
            a.ibasmin, a.cprovin, a.cpoblac, a.fvigor
     --select *
      FROM mig_tipos_indicadores_cl2 a
     WHERE 1 = 1
        --AND a.mig_fk = s.mig_pk (+)
        AND ccindid IS NULL
  ORDER BY a.mig_pk
        ; 
        --SELECT * FROM mig_tipos_indicadores_conf s;
        --SELECT * FROM mig_tipos_indicadores s WHERE s.mig_pk = '131050100DL0200681';
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
  OPEN lc_mig_tipos_indicadores;
  LOOP
    --
    FETCH lc_mig_tipos_indicadores BULK COLLECT INTO l_reg_mig_mcc LIMIT 1000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    --FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    --DELETE FROM mig_tipos_indicadores WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_tipos_indicadores VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','01_mig_tipos_indicadores','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_tipos_indicadores%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_tipos_indicadores;
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
--DELETE FROM mig_tipos_indicadores;
SELECT * FROM mig_tipos_indicadores;
SELECT * FROM mig_tipos_indicadores_conf s ;
SELECT * FROM mig_tipos_indicadores_conf s WHERE s.crespue IS NULL;
SELECT * FROM tipos_indicadores_det;
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_tipos_indicadores' and seqerror > 9537681 order by seqerror;
DELETE FROM control_error s WHERE s.donde = '03_mig_tipos_indicadores'
SELECT * FROM control_error s WHERE s.donde = '45_mig_tipos_indicadores' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_tipos_indicadores);
SELECT * FROM mig_tipos_indicadores s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM mig_tipos_indicadores_conf s;
SELECT * FROM tipos_indicadores s;
SELECT * FROM tipos_indicadores_det s;
-- 09_Mig_MovSeguro_v01.sql
-- 
-- 09_Mig_MovSeguro_v01.sql
-- Informar Profesionales con Indicadores, se deberían cargar de nuevo con los nuevos códigos.
SELECT p.sprofes,  dp.f_nombre (p.sperson, 1) persona, i.carea, 
      CASE i.carea
      WHEN 1 THEN '1 - Reaseguro'
      WHEN 2 THEN '2 - Intermediario'
      WHEN 3 THEN '3 - Siniestros'
      WHEN 4 THEN '4 - Produccion'
      END TAREA,
      i.ctipind, i.tindica, d.porcent, d.ibasmin, d.cpostal
FROM per_detper dp,
     sin_prof_profesionales p, 
     sin_prof_indicadores   s, 
     tipos_indicadores i,
     tipos_indicadores_det d
WHERE 1 = 1
  AND dp.sperson = p.sperson
  AND p.sprofes = s.sprofes
  AND s.ctipind = i.ctipind
  AND i.ctipind = d.ctipind;
--
TRUNCATE TABLE control_error; 
--
14351920
14349662
--
SELECT seqerror.NEXTVAL FROM dual;
--
SELECT * FROM transformacion.mig_tipos_indicadores_conf _cl2 WHERE upper(tindica) LIKE '%IVA%';
SELECT * FROM mig_tipos_indicadores_cl2;
--
