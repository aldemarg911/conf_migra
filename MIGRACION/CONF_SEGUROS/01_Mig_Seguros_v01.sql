DECLARE
    /******************************************************************************
    NOMBRE:       01_Mig_Seguros_v01
    PROPÓSITO:    Procedimiento que ejecuta carga de SEGUROS - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  cxhgome            1. Creación del script.
/* Formatted on 11/08/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
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
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz 
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   b_error           BOOLEAN;
   b_hay_dato        BOOLEAN;
   v_cant            NUMBER := 0;
   --
   TYPE t_mig_seguros IS TABLE OF mig_seguros%ROWTYPE;
   l_reg_mig_mcc t_mig_seguros;
   --
    CURSOR lc_mig_seguros IS
     SELECT 17417 ncarga,1 CESTMIG, s.MIG_PK,	s.MIG_FK, s.MIG_FKDIR, a.CAGENTE,	s.NPOLIZA,	s.NCERTIF,	s.FEFECTO,	s.CREAFAC,	s.CACTIVI,	
     DECODE(s.CCOBBAN, 0, NULL, s.CCOBBAN) CCOBBAN,	s.CTIPCOA,	s.CTIPREA,	s.CTIPCOM,	s.FVENCIM,	s.FEMISIO,	s.FANULAC,	NULL FCANCEL,	s.CSITUAC,	s.IPRIANU,	s.CIDIOMA,	
     s.CFORPAG,	s.CRETENI,	s.SCIACOA,	s.PPARCOA,	s.NPOLCOA,	s.NSUPCOA,	s.PDTOCOM,	s.NCUACOA,	s.CEMPRES,	s.SPRODUC,	s.CCOMPANI,	
     s.CTIPCOB,	s.CREVALI,	s.PREVALI,	s.IREVALI,	s.CTIPBAN,	s.CBANCAR,	s.CASEGUR,	s.NSUPLEM,	0 SSEGURO,	0 SPERSON,	s.CDOMICI,	
     s.NPOLINI,	NULL CTIPBAN2,	NULL CBANCOB,	s.FCARANT,	s.FCARPRO,	s.CRECFRA,	s.NDURCOB,	s.FCARANU,	NULL CTIPRETR,	NULL CINDREVFRAN,	
     NULL PRECARG,	NULL PDTOTEC,	NULL PRECCOM,	NULL FRENOVA,	s.NPOLINI CPOLCIA,	s.NEDAMAR,	17417 PROCESO,	s.NDURACI,	s.MIG_FK2
       FROM /*transformacion.*/mig_seguros_cl1 s, agentes a
      WHERE 1 = 1
        --AND s.mig_fk2 /*debe ser mig_fk3*/ = a.mig_pk --(+)
        AND s.cagente = a.cagente
        ; 
        --SELECT count(*) FROM mig_seguros_cl1 s;
        SELECT * FROM mig_seguros;
        --SELECT * FROM mig_seguros_cl1 s;
        --SELECT * FROM mig_agentes a;
        --SELECT * FROM mig_seguros_cl1 WHERE fefeplazo IS NOT NULL;
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
  OPEN lc_mig_seguros;
  LOOP
    --
    FETCH lc_mig_seguros BULK COLLECT INTO l_reg_mig_mcc LIMIT 10000;  -- limit to 10k to avoid out of memory
    --
    dbms_output.put_line('I - paso bullk');  
    --
    dbms_output.put_line('...');  
    b_hay_dato := TRUE;
    --
    FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS
    DELETE FROM mig_seguros WHERE mig_pk = l_reg_mig_mcc(i).mig_pk;
    --
    BEGIN
      --      
      FORALL i IN 1..l_reg_mig_mcc.COUNT SAVE EXCEPTIONS    
      INSERT INTO mig_seguros VALUES l_reg_mig_mcc(i);
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
        p_control_error('CXHGOME','01_mig_seguros','['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_reg_mig_mcc(l_idx).mig_pk);
        --
      END LOOP;
      --
    END;
    --
    dbms_output.put_line('F - paso bullk');
    --
    EXIT WHEN lc_mig_seguros%NOTFOUND;
     --
   END LOOP;
   --
   CLOSE lc_mig_seguros;
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
   l_time    := (l_timeend - l_timestart) / 100;
   dbms_output.put_line('Tiempo de Ejecución: ' || l_time || ' ms'); 
   --
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--
UPDATE mig_seguros SET ncarga = 20052;
DELETE FROM mig_seguros;
SELECT * FROM mig_seguros WHERE mig_pk = '124010200CU0779701';
SELECT COUNT(*) FROM mig_seguros WHERE sseguro = 0;
SELECT mig_fk FROM mig_seguros WHERE sseguro = 0;
SELECT * FROM mig_seguros_cl1 WHERE mig_pk = '131010100GU0195041' IN (SELECT mig_pk FROM direccion_tmp)
/*SELECT * FROM mig_direcciones s WHERE s.ncarga = 0;
SELECT count(*) FROM mig_direcciones_conf s WHERE s.ncarga = 17411;
delete FROM mig_direcciones s WHERE s.ncarga = -17411;*/
--SELECT * FROM control_error s WHERE s.donde = '03_mig_seguros' and seqerror > 9537681 order by seqerror;
DELETE FROM control_error s WHERE s.donde = '01_mig_seguros'
SELECT * FROM control_error s WHERE TRUNC(s.fecha) = TRUNC(SYSDATE) AND s.donde = '01_mig_seguros' ORDER BY seqerror;
SELECT * FROM mig_personas WHERE mig_pk IN (SELECT DISTINCT mig_fk FROM mig_seguros);
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17417 AND s.seqlog > 2920694;
--
SELECT COUNT(*) 
FROM mig_seguros s, 
     mig_personas p
WHERE s.mig_fk = p.mig_pk
  AND p.idperson <> 0
  AND s.ncarga = 17417
  AND s.cestmig = 1;
--
124010200CU0779701
--
SELECT s.*
  FROM mig_seguros  s,
       mig_personas p
 WHERE s.mig_fk = p.mig_pk (+)
   AND s.ncarga = 17417
   AND p.idperson IS NULL;
--
SELECT COUNT(*) FROM mig_seguros WHERE ncarga = 17417 AND sseguro = 0;
SELECT * FROM mig_seguros WHERE ncarga = 17417 AND sseguro <> 0;
SELECT COUNT(*) FROM seguros WHERE procesocarga = 17417;
SELECT COUNT(*) FROM seguros WHERE procesocarga = 17417;
SELECT* FROM seguros WHERE procesocarga = 17417 AND sfbureau IS NOT NULL;
SELECT * FROM movseguro WHERE sseguro = 509146;
--
129295 129186 109xmin
129083 128971 112xmin
128762 128652 110xmin
126915 126664  --??? despues de 5:00 pm
126524 125972  --??
125715 125462 253xmin
125262 125004 258xmin --8HRS
122907 122630 277xmin
122485 122210 275xmin
121615 121337 278xmin
120518 120287 231xmin
120036 119766 270xmin
117831 117557 274xmin
84820 84504   316xmin
84152-68496   15656xhr
66617-

--
206.033
  SELECT * FROM fin_parametros s WHERE s.cparam = 'FUENTE_INFORMACION';
  SELECT * FROM MIG_FIN_GENERAL_CL1;
  SELECT * FROM MIG_FIN_INDICADORES_CL1;

--
SELECT * FROM mig_seguros s WHERE s.mig_pk IN('101010100GU1221911', '101010100GU1221991', '101010100GU1223301');
SELECT * FROM mig_personas s WHERE s.mig_pk = '809004542';
SELECT * FROM mig_direcciones s WHERE s.mig_fk IN ('809004542', '830105213', '900412392');
SELECT * FROM mig_cargas_tab_axis s WHERE s.ncarga = 17417; 
SELECT * FROM Per_Direcciones s WHERE s.sperson IN (61507, 112938);
--
SELECT '''' || mig_pk || ''', ' FROM mig_seguros;
--
SELECT COUNT(*) FROM mig_logs_axis s WHERE trunc(s.fecha) = trunc(SYSDATE) AND s.ncarga = 17417 AND s.seqlog > 0;
SELECT * FROM mig_seguros WHERE mig_pk = '105174100PT0005015';
--
SELECT * FROM mig_bureau s;
SELECT * FROM mig_seguros s;
--
DECLARE 
CURSOR lc_bureau IS
 SELECT s.sseguro, b.sbureau
   FROM mig_seguros s, mig_bureau b
  WHERE s.mig_fk2 = b.mig_pk
    AND b.cestmig = 2
    AND s.cestmig <> 1
    AND s.sseguro <> 0;
    --AND s.mig_pk  = x.mig_pk;
BEGIN
  --
  FOR i IN lc_bureau
  LOOP
    --
    UPDATE seguros s
       SET s.sfbureau = i.sbureau
     WHERE s.sseguro = i.sseguro;
    --
   END LOOP;
   --
END;
--
SELECT sg.sseguro, s.mig_pk, sg.npoliza, sg.sproduc, r.nriesgo, r.cestmig, r.tdescrie
  FROM seguros sg,
       mig_seguros s, 
       mig_movseguro m , mig_riesgos r
WHERE s.mig_pk = m.mig_fk
  AND s.sseguro <> 0
  AND m.sseguro <> 0
  AND s.mig_pk = '115010100GU0365451'
  AND s.sseguro = sg.sseguro
  AND s.mig_pk = r.mig_fk2;
--
SELECT * FROM seguros WHERE sseguro = 662832;
SELECT * FROM riesgos WHERE sseguro = 662832;
SELECT * FROM historicoseguros WHERE sseguro = 662832;
--
BEGIN
    INSERT INTO rango_dian_movseguro
      (sseguro, nmovimi , ncertdian, falta, cusualta)
    VALUES
      (psseguro, pnmovimi, pcgrupo||vsucursal||vncontador, f_sysdate, f_user);
END;
