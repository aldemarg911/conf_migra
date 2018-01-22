DECLARE
    /******************************************************************************
    NOMBRE:       40_Mig_mig_ctgar_contragarantia_v01.sql
    PROPÓSITO:    Procedimiento que ejecuta carga de MIG_CTGAR_CONTRAGARANTIA - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 22/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   TYPE t_mig_ctgar_contragarantia IS TABLE OF mig_ctgar_contragarantia%ROWTYPE;
   l_reg_mig_mcc t_mig_ctgar_contragarantia;
   --
    CURSOR lc_mig_ctgar_contragarantia IS
     SELECT 17426 NCARGA,1 CESTMIG, a.MIG_PK, a.MIG_FK, a.SCONTGAR, a.NMOVIMI, a.TDESCRIPCION,
            a.CTIPO, a.CCLASE, a.CMONEDA, a.IVALOR, a.FVENCIMI, a.NEMPRESA, a.NRADICA, a.FCREA, a.DOCUMENTO,
            a.CTENEDOR, a.TOBSTEN, a.CESTADO, a.CORIGEN, a.TCAUSA, a.TAUXILIA, a.CIMPRESO, a.CUSUALT, a.FALTA
     --SELECT COUNT(*)
      FROM MIG_CTGAR_CONTRAGARANTIA_cl1 a
     WHERE 1 = 1
        --AND a.mig_pk IN ('RD2002507102', 'RD31090590131', 'RD7004255107', 'RD2002888102', 'RD23020493123', 'CF100005102', 'CF100007102')
ORDER BY a.mig_pk
        ; 
        --SELECT * FROM mig_ctgar_contragarantia_conf s WHERE s.mig_pk = '131050100DL0200681';
        --SELECT * FROM MIG_CTGAR_DET_cl1 WHERE cbanco IS NOT NULL; 
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
  OPEN lc_mig_ctgar_contragarantia;
  LOOP
    --
    FETCH lc_mig_ctgar_contragarantia BULK COLLECT INTO l_reg_mig_mcc LIMIT 100000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');
    --
    dbms_output.put_line('...');
    b_hay_dato := TRUE;
    --
    --FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    --DELETE FROM mig_ctgar_contragarantia WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_ctgar_contragarantia VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','40_mig_ctgar_contragarantia','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_ctgar_contragarantia%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_ctgar_contragarantia;
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
--DELETE FROM mig_ctgar_contragarantia;
SELECT COUNT(*) FROM mig_ctgar_contragarantia WHERE cestmig = 2;
SELECT * FROM mig_ctgar_contragarantia s ;
SELECT * FROM mig_ctgar_contragarantia_conf s WHERE s.crespue IS NULL
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_ctgar_contragarantia' and seqerror > 9537681 order by seqerror;
DELETE FROM control_error s WHERE s.donde = '40_mig_ctgar_contragarantia'
SELECT * FROM control_error s WHERE s.donde = '40_mig_ctgar_contragarantia' order by seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_ctgar_contragarantia);
SELECT * FROM mig_ctgar_contragarantia s, mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0;
--
SELECT * FROM mig_ctgar_contragarantia_conf s;
--
prompt Importing table MIG_CTGAR_CONTRAGARANTIA_cl1...
set feedback off
set define off
insert into MIG_CTGAR_CONTRAGARANTIA (NCARGA, CESTMIG, MIG_PK, MIG_FK, SCONTGAR, NMOVIMI, TDESCRIPCION, CTIPO, CCLASE, CMONEDA, IVALOR, FVENCIMI, NEMPRESA, NRADICA, FCREA, DOCUMENTO, CTENEDOR, TOBSTEN, CESTADO, CORIGEN, TCAUSA, TAUXILIA, CIMPRESO, CUSUALT, FALTA)
values (17426, 1, 'RD1000038101', null, 0, 1, 'PAGARE ABIERTO', 1, 1, '8', 0, null, null, 'RD1000038', to_date('03-03-2003', 'dd-mm-yyyy'), null, 5, 'PAGARE ABIERTO', 1, 2, '0', null, 0, 'N/H', to_date('03-03-2003', 'dd-mm-yyyy'));

prompt Done.
--
-- 09_Mig_MovSeguro_v01.sql
-- 
SELECT * FROM mig_logs_axis WHERE TRUNC(fecha) = TRUNC(SYSDATE);
SELECT COUNT(*) FROM mig_logs_axis WHERE TRUNC(fecha) = TRUNC(SYSDATE);
-- 68994
-- 72751 - 76482: 3731
--
SELECT * FROM sin_siniestro s 
WHERE NOT EXISTS (SELECT '' FROM SIN_MOVSINIESTRO m
                  WHERE s.nsinies = m.nsinies);
--
SELECT * FROM sin_siniestro s WHERE nsinies = 201780351107;
SELECT * FROM SIN_MOVSINIESTRO m  WHERE m.nsinies = 201780351107;
--
DECLARE
vcontgar NUMBER;
BEGIN
         SELECT nradica
           INTO vcontgar
           FROM ctgar_contragarantia
          WHERE nradica = 'CF2875078';
dbms_output.put_line('vcontgar: '||vcontgar);         
END;
--
SELECT *
  FROM mig_ctgar_contragarantia
  WHERE ncarga = pncarga
   AND cestmig = 1
  ORDER BY mig_pk;
--
SELECT pac_eco_monedas.f_obtener_cmonint(pmoneda => '8') FROM dual; --convierto 1 a COP
--
SELECT * FROM mig_ctgar_contragarantia s WHERE mig_fk IS NULL;
SELECT COUNT(*) FROM mig_ctgar_contragarantia s WHERE s.scontgar != 0;
SELECT COUNT(*) FROM MIG_CTGAR_DET s WHERE s.cestmig != 1;
SELECT COUNT(*) FROM MIG_CTGAR_INMUEBLE WHERE cestmig != 1;
SELECT COUNT(*) FROM MIG_CTGAR_vehiculo WHERE cestmig != 1;
SELECT COUNT(*) FROM Mig_Ctgar_Codeudor WHERE cestmig != 1;
--
DELETE ctgar_contragarantia WHERE scontgar IN (SELECT s.scontgar FROM mig_ctgar_contragarantia s WHERE s.scontgar != 0);
-- 767
SELECT * FROM mig_ctgar_det s, mig_ctgar_contragarantia c
WHERE s.mig_fk = c.mig_pk
SELECT COUNT(*) FROM mig_ctgar_det s
SELECT * FROM mig_ctgar_codeudor s WHERE s.scontgar != 0;
--
SELECT * FROM mig_ctgar_det;
SELECT * FROM mig_ctgar_contragarantia s WHERE cmoneda IS NOT NULL;
SELECT * FROM ctgar_contragarantia WHERE scontgar = 451640;
SELECT COUNT(*) FROM mig_ctgar_contragarantia s WHERE scontgar = 0;
SELECT * FROM ctgar_det s WHERE scontgar = 832
SELECT * FROM ctgar_det s WHERE scontgar IN (SELECT scontgar FROM mig_ctgar_contragarantia s WHERE scontgar != 0);
--
SELECT COUNT(*) FROM ctgar_contragarantia s WHERE nradica IN (SELECT nradica FROM mig_ctgar_contragarantia s );
DELETE FROM ctgar_contragarantia s WHERE nradica IN (SELECT nradica FROM mig_ctgar_contragarantia s );
SELECT * FROM ctgar_contragarantia s WHERE nradica IN (SELECT nradica FROM mig_ctgar_contragarantia s );
--
SELECT COUNT(*) FROM per_contragarantia WHERE scontgar IN (SELECT scontgar FROM mig_ctgar_contragarantia s WHERE scontgar != 0);
--
SELECT incid, COUNT(*) FROM mig_logs_axis s WHERE s.ncarga = 17426 AND s.seqlog > 6393877 GROUP BY incid; 
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17426 AND s.seqlog > 0 GROUP BY incid; 
--
SELECT * FROM mig_ctgar_contragarantia s WHERE s.mig_pk = 'RD5153887105';
SELECT COUNT(*) FROM mig_ctgar_codeudor s WHERE cestmig = 1;
SELECT * FROM ctgar_codeudor s WHERE cestmig = 1;
--
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17426 AND s.incid LIKE 'ctgar%' AND s.incid != 'ctgar_det - Error insertar contragarantía: ORA-20000: ORU-10027: buffer overflow, limit of 10000 bytes';
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17426 AND incid LIKE '%ctgar_inm%';
SELECT DISTINCT SUBSTR(incid, 1, INSTR(incid, '-')) FROM mig_logs_axis s WHERE s.ncarga = 17426 AND incid LIKE '%ctgar%';
--
SELECT * FROM mig_ctgar_det WHERE cestmig = 2;
--
SELECT a.*, p.idperson p_Sperson_codeu
--select count(*)
 FROM mig_ctgar_codeudor a, mig_ctgar_contragarantia c, mig_personas p
WHERE a.ncarga = 17426
  AND a.cestmig = 2
  AND a.mig_fk = c.mig_pk
  AND a.mig_fk2 = p.mig_pk
--
SELECT COUNT(*) FROM mig_pk_mig_axis WHERE ncarga = 17426 AND ntabaxis = 1;
--
SELECT *
  FROM mig_ctgar_det d, mig_ctgar_vehiculo a
  WHERE a.ncarga = 17439
   AND a.cestmig = 1
   AND a.mig_fk = d.mig_pk;
--
SELECT * FROM mig_tipos_indicadores;
--
SELECT * FROM mig_ctgar_contragarantia WHERE mig_pk IN ('RD2002507102', 'RD2002888102', 'RD23020493123', 'RD31090590131', 'RD7004255107');
--
SELECT * FROM MIG_CTGAR_DET WHERE MIG_PK IN ('RD23020493123','RD2002888102', 'RD2002507102','RD7004255107','RD23020492','RD31090590131') -- Vehiculos
SELECT * FROM MIG_CTGAR_DET WHERE MIG_PK IN ('RD2002507102','RD7004255107','RD23020492','RD31090590131')  -- para Inmuebles
