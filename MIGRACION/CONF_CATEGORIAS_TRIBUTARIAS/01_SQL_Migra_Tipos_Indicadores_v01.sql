--01_SQL_Migra_Tipos_Indicadores_v01.sql
--
-- Consideraciones: Así como se acrga el texto en TINDICA así queda.
--
DECLARE
  --
  v_ctipind NUMBER;
  v_count   NUMBER;
  --
  l_reg_tipos_ind     tipos_indicadores     %ROWTYPE;
  l_reg_tipos_ind_det tipos_indicadores_det %ROWTYPE;
   --
    CURSOR lc_mig_tipos_indicadores IS
     SELECT s.mig_pk, s.tindica, s.carea, s.ctipreg, s.cimpret, s.ccindid, s.cindsap, s.fvigor, COUNT(*) ind_detalle
       FROM /*transformacion.*/mig_tipos_indicadores s 
       WHERE 1 = 1
         AND mig_pk IN ('111384I23', '112384J23')
       GROUP BY s.mig_pk, s.tindica, s.carea, s.ctipreg, s.cimpret, s.ccindid, s.cindsap, s.fvigor;
   --
    CURSOR lc_mig_tipos_indicadores_det(p_mig_pk VARCHAR2) IS
     SELECT s.porcent, s.cclaing, s.ibasmin, s.cprovin, s.cpoblac, s.fvigor
       FROM mig_tipos_indicadores s
       WHERE 1 = 1
       --  AND mig_pk IN ('111384I23', '112384J23')
         AND mig_pk = NVL(p_mig_pk, mig_pk);
   --
BEGIN
  --
  FOR i IN lc_mig_tipos_indicadores
  LOOP
    --
    l_reg_tipos_ind := NULL;
    --
    SELECT MAX(NVL(ctipind,0)) + 1
      INTO v_ctipind
      FROM tipos_indicadores ti;
    --
    l_reg_tipos_ind.ctipind  := v_ctipind;
    l_reg_tipos_ind.tindica  := i.tindica; --Texto por Indicador
    l_reg_tipos_ind.carea    := i.carea  ;
    l_reg_tipos_ind.ctipreg  := i.ctipreg;
    l_reg_tipos_ind.cimpret  := i.cimpret;
    l_reg_tipos_ind.ccindid  := i.ccindid;
    l_reg_tipos_ind.cindsap  := i.cindsap;
    l_reg_tipos_ind.ffalta   := i.fvigor ;
    l_reg_tipos_ind.cusualta := USER     ;
    --
    INSERT INTO TIPOS_INDICADORES VALUES l_reg_tipos_ind;
    --
    v_count := 0;
    --
    FOR j IN lc_mig_tipos_indicadores_det(i.mig_pk)
    LOOP
      --
      v_count := v_count + 1;
      --
      l_reg_tipos_ind_det := NULL;
      --
      l_reg_tipos_ind_det.ctipind  := l_reg_tipos_ind.ctipind; --PK
      l_reg_tipos_ind_det.ndetall  := v_count  ;
      l_reg_tipos_ind_det.porcent  := j.porcent;
      l_reg_tipos_ind_det.cclaing  := j.cclaing;
      l_reg_tipos_ind_det.ibasmin  := j.ibasmin;
      l_reg_tipos_ind_det.cpostal  := j.cpoblac;
      l_reg_tipos_ind_det.fvigor   := j.fvigor ;
      l_reg_tipos_ind_det.falta    := TRUNC(SYSDATE);
      l_reg_tipos_ind_det.cusualta := USER     ;
      --
      INSERT INTO TIPOS_INDICADORES_DET VALUES l_reg_tipos_ind_det;
      --
    END LOOP;
    --
  END LOOP;
  --
END;
--
--SELECT MAX(ctipind) FROM tipos_indicadores s ;       
--SELECT * FROM tipos_indicadores s WHERE s.ctipind > 376
--SELECT * FROM tipos_indicadores_det s WHERE s.ctipind > 376;
--
 SELECT s.*
   FROM mig_tipos_indicadores s 
   WHERE 1 = 1
     AND mig_pk IN ('111384I23', '112384J23');
--
SELECT * FROM tipos_indicadores s WHERE s.ccindid = '4I';
SELECT * FROM tipos_indicadores_det s WHERE s.ctipind = 160;
SELECT * FROM all_source s WHERE s.owner = 'AXIS' AND UPPER(s.text) LIKE UPPER('%f_retefuente%');
PAC_IAX_SIN_IMP_SAP;
PAC_IMPUESTOS_CONF;
PAC_IAX_LISTVALORES.F_GET_REGIMENFISCAL;
PAC_CONTAB_CONF
--
SELECT * FROM agentes s WHERE s.ctipiva = 2;
SELECT * FROM retenciones
--
SELECT * FROM DESCRIPCIONRET s WHERE s.cidioma = 8;

SELECT * FROM regimen_fiscal s ;
SELECT * FROM NO s ;
SELECT * FROM per_regimenfiscal;
--
SELECT ff_desvalorfijo(85,8,2) FROM dual;
--
SELECT * FROM agentes s WHERE s.ctipiva = 2;

 SELECT c.* 
    FROM transformacion.mig_contratos_conf c, transformacion.mig_codicontratos_conf c1
   WHERE 1 = 1
     AND c.mig_fk = c1.mig_pk;
--
SELECT * FROM transformacion.mig s WHERE s =  ORDER BY s ;   


SELECT * FROM per_personas s WHERE s.sperson = 1031;
SELECT * FROM transformacion.mig_tipos_indicadores_conf s WHERE s.tindica LIKE '%Reteiva  15% - %'
SELECT * FROM per_regimenfiscal;
SELECT * FROM agentes s WHERE s.sperson = 1031;
SELECT * FROM DESCRIPCIONRET s WHERE s.cidioma = 8 ORDER BY 1;
SELECT rf.cregfiscal, ff_desvalorfijo(1045, 8, rf.cregfiscal) tregfiscal 
  FROM regimen_fiscal rf WHERE 1 = 1 AND rf.ctipper = 1 AND rf.fhasta IS NULL ORDER BY cregfiscal ASC;
SELECT * FROM DESCRIPCIONIVA WHERE CIDIOMA = 8;
SELECT * FROM retenciones s;
--
SELECT * FROM TIPOS_INDICADORES s ;
SELECT * FROM TIPOS_INDICADORES s ;
SELECT * FROM SIN_PROF_INDICADORES s;
SELECT * FROM all_tab_columns s WHERE s.owner = 'AXIS' AND column_name LIKE '%CREGFISCAL%';
SELECT * FROM REGFISCAL_IVARETENC s;
SELECT * FROM DELPER_REGIMENFISCAL s;
SELECT * FROM PER_REGIMENFISCAL s;
pac_impuestos_conf.f_indicador_agent
--
SELECT * FROM per_personas s WHERE s.sperson = 2568;
SELECT * FROM sin_prof_profesionales s WHERE sprofes = 10;
SELECT * FROM sin_prof_indicadores s;
--SELECT * FROM mig_companias s WHERE s.mig_pk = '444444212';
--SELECT * FROM transformacion.mig_companias_conf s WHERE s.mig_pk = '444444212';
--SELECT * FROM companias s;
SELECT ff_desvalorfijo(800102,8,0) FROM dual s;  
SELECT * FROM detvalores s WHERE s.cvalor = 800102;
--
pac_impuestos
--
   SELECT DECODE(r.cregfiscal, 6, 0, 8, 0, DECODE(p.ctipper, 1, 1, 2))
        FROM agentes a,
             per_personas p,
             (SELECT sperson,
                     cregfiscal
                FROM per_regimenfiscal
               WHERE (sperson, fefecto) IN
                     (SELECT sperson,
                             MAX(fefecto)
                        FROM per_regimenfiscal
                       GROUP BY sperson)) r
       WHERE a.cagente = 6000006
         AND p.sperson = a.sperson
         AND p.sperson = r.sperson(+);
--
SELECT * FROM transformacion.mig_companias_conf s WHERE mig_pk = '24000';
SELECT * FROM transformacion.mig_codicontratos_conf s;
SELECT * FROM transformacion.mig_contratos_conf s;
--
      SELECT pac_parametros.f_parempresa_t(24, 'PAC_IMPUESTOS')
        FROM DUAL;
--
SELECT * FROM tab_error s WHERE s.TOBJETO = 'FAC';
    SELECT itasa
      FROM eco_tipocambio
     WHERE fcambio=(SELECT max(fcambio)
                      FROM eco_tipocambio
                     WHERE cmonori='TPS')
       AND cmonori = 'TPS';
--
SELECT * FROM cfg_files s ;
SELECT * FROM dba_directories;
--
SELECT * FROM transformacion.mig_contratos_conf s;  
--
-- ************************************** --
SELECT * FROM regimen_fiscal;
SELECT * FROM CODIGORET;
SELECT * FROM retenciones;
SELECT * FROM Per_Regimenfiscal;
SELECT * FROM agentes;
SELECT * FROM agentes_comp;
SELECT * FROM tipoiva;
SELECT * FROM DESCRIPCIONRET WHERE cidioma = 8;
SELECT * FROM detvalores WHERE cvalor = 1045 AND cidioma = 8;
SELECT * FROM tipos_indicadores s;
SELECT * FROM tipos_indicadores_det s;
SELECT * FROM int_codigos_emp s WHERE ccodigo LIKE '%TIPO_IDENTIFICADOR_PERSONA%';
-- ************************************** --
SELECT * FROM mig_tipos_indicadores s;
-- 09_Mig_MovSeguro_v01.sql
-- Informar Profesionales con Indicadores, se deberían cargar de nuevo con los nuevos códigos.
SELECT p.sprofes,  f_nombre (p.sperson, 1) persona, i.carea, 
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
-- Generamos el listado de retenciones asociadas a los indicadores a borrrar e informar
SELECT * FROM RETENCIONES WHERE CTIPIND IS NOT NULL;
--
SELECT * 
  FROM tipos_indicadores i,
       tipos_indicadores_det d
 WHERE i.ctipind = d.ctipind
   AND i.ctipind >= 377
--
SELECT * FROM tipos_indicadores_det d
--
/*Aqui buscamos los códigos generados*/
SELECT pkmig, LTRIM(REPLACE(pkaxis, pkmig)) ctipind
FROM mig_pk_mig_axis WHERE ncarga = 17414;
--
SELECT orden, desde, NVL(hasta, desde) hasta, valor
  FROM sgt_det_tramos;
--
  WHERE tramo = (SELECT detalle_tramo
                   FROM sgt_vigencias_tramos
                  WHERE tramo = ntramo
                    AND fecha_efecto =
                                 (SELECT MAX(fecha_efecto)
                                    FROM sgt_vigencias_tramos
                                   WHERE tramo = ntramo
                                     AND fecha_efecto <= ftope))
ORDER BY orden;
--
SELECT i.ctipind, i.tindica, decode(i.carea, 1, '1 - Reaseguro', 2, '2 - Intermediarios',  3, '3 - Siniestros',  4, '4 - Producción') area, decode( i.ctipreg, 1, '1 - Impuesto', 2, '2 - Retencion') ctipreg,
 decode(i.cimpret, 1, '1-IVA', 2, '2-Retefuente', 3, '3-ReteIVA', 4, '4-ReteICA') cimpret, CCINDID, CINDSAP, FFALTA, CTIPCOAREA, d.porcent, d.ibasmin, d.cpostal, d.fvigor
  FROM tipos_indicadores i,
       tipos_indicadores_det d
 WHERE i.ctipind = d.ctipind (+);
--
SELECT * FROM CODIGOIVA;
SELECT * FROM All_Tab_Columns WHERE column_name = 'CTIPIVA';
SELECT * FROM DETVALORES WHERE ;
SELECT * FROM VALORES WHERE CIDIOMA = 8 AND UPPER( TVALOR ) LIKE '%IVA%';
SELECT * FROM detvalores WHERE cvalor = 1045 AND cidioma = 8;
pac_carga_per_red_cl2

tipoiva
