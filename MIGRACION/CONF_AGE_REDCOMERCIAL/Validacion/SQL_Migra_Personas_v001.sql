/* Formatted on 27/06/2012 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar las Personas, Direcciones, per_agr_marcas, Personas_Rel y mig_regimenfiscal
*/
DECLARE
   --
   vncarga           mig_cargas.ncarga%TYPE;
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz 
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   vdummy            NUMBER;
   b_error           BOOLEAN;
   b_hay_personas    BOOLEAN;
   v_per_tot         NUMBER := 0;
   v_dir_tot         NUMBER := 0;
   v_mar_tot         NUMBER := 0;
   v_rel_tot         NUMBER := 0;
   v_reg_tot         NUMBER := 0;
   v_age_tot         NUMBER := 0;
   --
    CURSOR lc_mig_personas(p_ncarga NUMBER) IS
     SELECT /*p_ncarga*/0 NCARGA, 1 CESTMIG, 0 IDPERSON, MIG_PK, SNIP, CTIPIDE, NNUMIDE, 
            CESTPER, CPERTIP, FULTMOD, SWPUBLI, DECODE(LENGTH(CSEXPER), 1, CSEXPER, 0) CSEXPER, 
            FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, 
            CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC
       FROM /*transformacion.*/mig_personas_conf mpc
      WHERE mpc.nnumide IS NOT NULL
/*        AND NOT EXISTS (SELECT '' FROM per_personas
                                 WHERE nnumide = mpc.nnumide
                                   AND ctipide = mpc.ctipide)*/
        AND NOT EXISTS (SELECT '' FROM agentes a
                                 WHERE a.cagente = (SELECT sperson 
                                                      FROM per_personas 
                                                     WHERE nnumide = mpc.nnumide
                                                       AND ctipide = mpc.ctipide)
                       )
        AND MIG_PK IN ('A0243127', 'A0555140', 'A0543803', 'A0077138', '900930211')
        --AND mig_pk = 'A0021916'
        /*and (    ctipide is null 
              or cestper is null 
              or cpertip is null
              or cpertip is null
              or cpertip is null
              or swpubli is null
              or tapelli1 is null
             )*/
        AND  (    ctipide  IS NOT NULL 
              AND cestper  IS NOT NULL 
              AND cpertip  IS NOT NULL
              AND swpubli  IS NOT NULL
              AND tapelli1 IS NOT NULL
             )
    ORDER BY CTIPIDE, NNUMIDE;
   --
   PROCEDURE pi_mig_cargas(p_ncarga NUMBER) IS
     --
     v_sperson  per_personas.sperson%TYPE;
     --
   BEGIN
     --
     INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg, id)
     VALUES
        (p_ncarga, 24, f_sysdate, f_sysdate, 'OK', 'MIGRA_CONF');
     --
     INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (p_ncarga, 1, 'Inserts Directos', 'MIG_PERSONAS');
     --
     INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (p_ncarga, 2, 'Inserts Directos', 'MIG_DIRECCIONES');
     --   
     INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (p_ncarga, 3, 'Inserts Directos', 'MIG_PERSONAS_REL');
     --
     INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (p_ncarga, 4, 'Inserts Directos', 'MIG_REGIMENFISCAL');
     --
     INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (p_ncarga, 5, 'Inserts Directos', 'MIG_AGENTES');
     --
   END pi_mig_cargas;
   --
   PROCEDURE pi_borra_persona(p_ctipide NUMBER, p_nnumide VARCHAR2) IS
     --
     v_sperson  per_personas.sperson%TYPE;
     --
   BEGIN
      --
      SELECT sperson INTO v_sperson
        FROM per_personas s
       WHERE s.ctipide = p_ctipide AND s.nnumide = p_nnumide;
      --
      SELECT sperson --INTO v_sperson
        FROM per_personas s
       WHERE s.ctipide = 37 AND s.nnumide = '9009302112';      
      --
      DELETE FROM PER_IDENTIFICADOR WHERE sperson = v_sperson;
      DELETE FROM PER_DIRECCIONES WHERE sperson = v_sperson;
      DELETE FROM PER_PERSONAS_REL WHERE sperson = v_sperson;
      DELETE FROM PER_DETPER WHERE sperson = v_sperson;
      DELETE FROM PER_REGIMENFISCAL WHERE sperson = v_sperson;
      DELETE FROM PER_PERSONAS WHERE sperson = v_sperson;
      --
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --
      NULL;
      --
    WHEN OTHERS THEN
      --
      dbms_output.put_line('Error:'||SQLERRM);  
      --
   END pi_borra_persona;
   --
BEGIN
  --
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD'))
    INTO vdummy
    FROM dual;
  --
  b_error        := FALSE;
  b_hay_personas := FALSE;
  --
  SELECT sncarga.nextval INTO vncarga FROM dual;
  --
  pi_mig_cargas(p_ncarga => vncarga);
  --
  dbms_output.put_line('El ncarga es :' || vncarga);
  --
   -----------------------------------------
   --PERSONAS
   -----------------------------------------
   --
   FOR l_per IN lc_mig_personas(p_ncarga => vncarga)
   LOOP
     --
     b_hay_personas := TRUE;
     --
     BEGIN
       --
       pi_borra_persona(p_ctipide => l_per.ctipide, p_nnumide => l_per.nnumide);
       --
       DELETE mig_personas WHERE mig_pk = l_per.MIG_PK;
       INSERT INTO mig_personas(
               NCARGA, CESTMIG, IDPERSON, MIG_PK, SNIP, CTIPIDE, NNUMIDE, 
               CESTPER, CPERTIP, FULTMOD, SWPUBLI, CSEXPER, 
               FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, 
               CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC)
       VALUES (l_per.NCARGA, l_per.CESTMIG, l_per.IDPERSON, l_per.MIG_PK, l_per.SNIP, l_per.CTIPIDE, l_per.NNUMIDE, 
               l_per.CESTPER, l_per.CPERTIP, l_per.FULTMOD, l_per.SWPUBLI, l_per.CSEXPER, 
               l_per.FNACIMI, l_per.CAGENTE, l_per.TAPELLI1, l_per.TAPELLI2, l_per.TNOMBRE, l_per.TNOMBRE2, l_per.CESTCIV, l_per.CPAIS, l_per.CPROFES, 
               l_per.CNACIO, l_per.CTIPBAN, l_per.CBANCAR, l_per.CIDIOMA, l_per.TDIGITOIDE, l_per.FDEFUNC);
       --
       v_per_tot := v_per_tot + SQL%ROWCOUNT;
       --  
       -----------------------------------------
       --DIRECCIONES
       -----------------------------------------
       -- 
       BEGIN
         --
         FOR x IN (SELECT mig_pk, mig_fk, 0 sperson, cagente, cdomici, cpostal,
                          cprovin, cpoblac, tnomvia, ctipdir, cviavp, clitvp,
                          cbisvp, corvp, nviaadco, clitco, corco, nplacaco,
                          cor2co, cdet1ia, tnum1ia, cdet2ia, tnum2ia, cdet3ia,
                          tnum3ia, localidad, tnumtel, tnumfax, tnummov, temail
                          talias
                     FROM /*transformacion.*/mig_direcciones_conf
                    WHERE 1 = 1
                      AND MIG_FK = l_per.MIG_PK
                      AND cprovin IS NOT NULL
                    ORDER BY mig_pk, mig_fk
                    )
         LOOP
           --
           DELETE mig_direcciones WHERE mig_fk = l_per.MIG_PK;
           --
            INSERT INTO mig_direcciones
               (ncarga, cestmig, mig_pk, mig_fk, sperson, cagente, cdomici,
                cpostal, cprovin, cpoblac, tnomvia, ctipdir, cviavp, clitvp,
                cbisvp, corvp, nviaadco, clitco, corco, nplacaco, cor2co, cdet1ia,
                tnum1ia, cdet2ia, tnum2ia, cdet3ia, tnum3ia)
            VALUES
               (vncarga, 1, x.mig_pk, x.mig_fk, x.sperson, x.cagente, x.cdomici,
                x.cpostal, x.cprovin, x.cpoblac, x.tnomvia, x.ctipdir, x.cviavp,
                x.clitvp, x.cbisvp, x.corvp, x.nviaadco, x.clitco, x.corco,
                x.nplacaco, x.cor2co, x.cdet1ia, x.tnum1ia, x.cdet2ia, x.tnum2ia,
                x.cdet3ia, x.tnum3ia);
            --
            v_dir_tot := v_dir_tot + SQL%ROWCOUNT;
            --
         END LOOP;
         --         
       EXCEPTION
       WHEN OTHERS THEN
         --
         dbms_output.put_line('DIRECCIONES - ERR:'||SQLERRM);
         b_error := TRUE;
         --
       END;
       --
       --MIG_PERSONAS_REL
       --
       BEGIN
         --
         DELETE mig_personas_rel WHERE mig_fk = l_per.MIG_PK;
         --SELECT * FROM mig_regimenfiscal;
         --
         INSERT INTO mig_personas_rel(NCARGA, CESTMIG, MIG_PK, MIG_FK, 
                                      FKREL, CTIPREL, PPARTICIPACION, ISLIDER
                                      )
         SELECT vncarga NCARGA, 1 CESTMIG, MIG_PK, MIG_FK, 
                FKREL, CTIPREL, PPARTICIPACION, ISLIDER
           FROM /*transformacion.*/mig_personas_rel_conf mpc
          WHERE 1 = 1
            AND MIG_FK = l_per.MIG_PK;
         --
         v_rel_tot := v_rel_tot + SQL%ROWCOUNT;
         --
       EXCEPTION
       WHEN OTHERS THEN
         --
         dbms_output.put_line('MIG_PERSONAS_REL - ERR:'||SQLERRM);
         b_error := TRUE;
         --
       END;
       --
       --MIG_REGIMENFISCAL
       --
       BEGIN
         --
         DELETE mig_regimenfiscal WHERE mig_fk = l_per.MIG_PK;
         --SELECT * FROM mig_regimenfiscal s;
         --
         INSERT INTO mig_regimenfiscal(NCARGA, CESTMIG, MIG_PK, MIG_FK,
                                       NANUALI, FEFECTO, CREGFIS)
         SELECT vncarga NCARGA, 1 CESTMIG, MIG_PK, MIG_FK, 
                NANUALI, NVL(FEFECTO, TRUNC(SYSDATE)), CREGFIS
           FROM /*transformacion.*/mig_regimenfiscal_conf rf
          WHERE 1 = 1
            AND MIG_FK  = l_per.MIG_PK;
         --
         v_reg_tot := v_reg_tot + SQL%ROWCOUNT;
         --
       EXCEPTION
       WHEN OTHERS THEN
         --
         dbms_output.put_line('mig_regimenfiscal - ERR:'||SQLERRM);
         b_error := TRUE;
         --
       END;
       --
       --MIG_AGENTES
       --
       BEGIN
         --
         DELETE mig_agentes WHERE mig_fk = l_per.MIG_PK;
         --SELECT * FROM mig_agentes s;
         --
         INSERT INTO mig_agentes(ncarga, cestmig, mig_pk, mig_fk, cagente, idperson, ctipage, cactivo,
                         cretenc, ctipiva, ccomisi, cpadre, fmovini, fmovfin, cpervisio,
                         cpernivel, cpolvisio, cpolnivel, finivig, ctipadn, cagedep, ctipint,
                         cageclave, cofermercan, frecepcontra, cidoneidad, spercomp, ccompani,
                         cofipropia, cclasif, nplanpago, nnotaria, cprovin, cpoblac,
                         nescritura, faltasoc, tgerente, tcamaracomercio, csobrecomisi, talias,
                         cliquido, nregdgs)
        --
        SELECT vncarga,
               1,
               mig_pk,
               mig_fk,
               f_set_agente(24, ctipage) cagente,
               0 idperson,
               ctipage, -- nvl(ctipage,5),
               --ojo con esto la aspecifiación es incorrecta 0 activo 1- inactivo, cuando es al reves
               cactivo,
               cretenc,
               ctipiva,
               to_number(REPLACE(REPLACE(REPLACE(ccomisi, 'GC', ''),
                                         '#N/A',
                                         1),
                                 'GR',
                                 '')) ccomisi,
               cpadre,
               NVL(fmovini, f_sysdate),
               fmovfin,
               v_agente_pervisio cpervisio,
               cpernivel,
               cpolvisio,
               cpolnivel,
               fmovini finivig,
               --    DECODE(ctipadn, NULL, 'null', ctipadn) ctipadn,
               NULL ctipadn,
               NULL cagedep,
               --DECODE(ctipint, NULL, 'null', ctipint) ctipint,
               NULL ctipint,
               --DECODE(cageclave, NULL, 'null', cageclave) cageclave,
               NULL cageclave,
               --DECODE(cofermercan, NULL, 'null', cofermercan) cofermercan,
               NULL cofermercan,
               --DECODE(frecepcontra, NULL, 'null', 'to_date(' || CHR(39) || to_char(frecepcontra,'yyyymmdd') || CHR(39) || ',''yyyymmdd'')') frecepcontra,
               NULL frecepcontra,
               --DECODE(cidoneidad, NULL, 'null', cidoneidad) cidoneidad,
               NULL cidoneidad,
               --DECODE(spercomp, NULL, 'null', spercomp) spercomp,
               NULL spercomp,
               NULL ccompani,
               NULL cofipropia,
               NULL cclasif,
               NULL nplanpago,
               NULL nnotaria,
               --    DECODE(cprovin, NULL, 'null', cprovin) cprovin, 
               NULL cprovin,
               --DECODE(cpoblac, NULL, 'null', cpoblac) cpoblac,
               NULL cpoblac,
               NULL nescritura,
               NULL faltasoc,
               NULL tgerente,
               NULL tcamaracomercio,
               NULL csobrecomisi,
               --DECODE(talias, NULL, 'null', CHR(39) || talias || CHR(39)) talias,
               NULL talias,
               --DECODE(cliquido, NULL, 'null', cliquido) cliquido,
               NULL cliquido,
               NULL nregdgs
             FROM /*transformacion.*/ mig_agentes_conf a
            WHERE 1 = 1
              AND a.MIG_FK  = l_per.MIG_PK;
         --
         v_age_tot := v_age_tot + SQL%ROWCOUNT;
         --
       EXCEPTION
       WHEN OTHERS THEN
         --
         dbms_output.put_line('mig_regimenfiscal - ERR:'||SQLERRM);
         b_error := TRUE;
         --
       END;
       --
     EXCEPTION
     WHEN OTHERS THEN
       --
       dbms_output.put_line('LOOP PERSONAS [' ||l_per.CTIPIDE||', '|| l_per.NNUMIDE ||'] - ERR:'||SQLERRM);
       b_error := TRUE;
       --
     END;  
     --
   END LOOP;
   --
   IF NOT b_error 
      AND b_hay_personas
   THEN
    --
    dbms_output.put_line('- Ini pac_mig_axis.p_migra_cargas -');
    pac_mig_axis.p_migra_cargas('MIGRA_CONF', 'C', vncarga);
    --
   ELSE
    --
    ROLLBACK;
    dbms_output.put_line('- ROLLBACK -');
    --
   END IF;
   --
   FOR l_reg IN (SELECT p.* 
                   FROM mig_personas p, mig_per_agr_marcas_conf pam
                  WHERE p.ncarga = vncarga
                    AND NVL(p.idperson, 0) != 0
                    AND p.mig_pk = pam.mig_fk)
   LOOP
     --
     --Se debe cargar después, porq el sperson no existe a este punto
     -- Cargamos marcas de [mig_per_agr_marcas_conf] solo para personas a cargar
     BEGIN
       --
       INSERT INTO per_agr_marcas(CEMPRES, SPERSON, CMARCA, NMOVIMI,
                                  CTIPO, CTOMADOR, CCONSORCIO, CASEGURADO,
                                  CCODEUDOR, CBENEF, CACCIONISTA, CINTERMED,
                                  CREPRESEN, CAPODERADO, CPAGADOR, OBSERVACION,
                                  CUSER, FALTA)
       SELECT 24 CEMPRES, l_reg.idperson SPERSON, LPAD(pam.cmarca,4,'0'), pam.nmovimi,
             pam.CTIPO, pam.CTOMADOR, pam.CCONSORCIO, pam.CASEGURADO,
             pam.CCODEUDOR, pam.CBENEF, pam.CACCIONISTA, pam.CINTERMED,
             pam.CREPRESEN, pam.CAPODERADO, pam.CPAGADOR, pam.tobseva OBSERVACION,
             f_user CUSER, TRUNC(SYSDATE) FALTA
         FROM /*transformacion.*/mig_per_agr_marcas_conf pam
        WHERE 1 = 1
          --AND MIG_FK IN ('A0243127', 'A0555140', 'A0543803', 'A0077138');
          AND MIG_FK = l_reg.MIG_PK; 
       --
       v_mar_tot := v_mar_tot + SQL%ROWCOUNT;
       --
       --dbms_output.put_line('l_reg.MIG_PK:'||l_reg.MIG_PK||', l_reg.idperson:'||l_reg.idperson||', l_reg.nnumide:'||l_reg.nnumide||', Insert:'||SQL%ROWCOUNT||', v_mar_tot:'||v_mar_tot||', SQL%ROWCOUNT:'||SQL%ROWCOUNT);
       --
     EXCEPTION
     WHEN OTHERS THEN
       --
       dbms_output.put_line('per_agr_marcas ['||l_reg.MIG_PK|| ', ' ||l_reg.CTIPIDE||', '|| l_reg.NNUMIDE ||'] - ERR:'||SQLERRM);
       b_error := TRUE;
     END;
     --
   END LOOP;
   --
   dbms_output.put_line('Personas:'||v_per_tot||', Direcciones:'||v_dir_tot||', per_agr_marcas:'||v_mar_tot||', Personas_Rel:'||v_rel_tot||', y mig_regimenfiscal:'||v_reg_tot||', Agentes:'||v_age_tot);
   --
   IF b_hay_personas
   THEN
     --
     COMMIT;
     dbms_output.put_line('*COMMIT*');
     --
   END IF;
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--
SELECT * FROM AGR_MARCAS s WHERE s.cempres = 24 AND s.cmarca = LPAD(49,4,'0');
SELECT * FROM mig_cargas s;
SELECT * FROM mig_cargas_tab_mig WHERE tab_des LIKE '%PER%';
SELECT * FROM mig_orden_axis WHERE TABLA LIKE '%PERSONAS%'
SELECT * FROM mig_personas_conf s;
SELECT * FROM mig_direcciones_conf s;
SELECT * FROM mig_logs_axis s order by ncarga;
--
SELECT * FROM sin_prof_profesionales;
SELECT * FROM SIN_MOVSINIESTRO s ;
--
SELECT * FROM all_source s where s.owner = 'AXIS_D712' AND upper(s.text) LIKE UPPER('%sin_codtramitador%');
PAC_SINIESTROS;
SELECT * FROM sin_codtramitador s WHERE s =  ORDER BY s ; 
--
-- Origen
SELECT * FROM mig_personas s where mig_pk IN ('A0243127', 'A0555140', 'A0543803', 'A0077138', '900930211');
SELECT * FROM mig_agentes s where mig_fk IN ( '900930211');
SELECT * FROM mig_personas_rel s;
SELECT * FROM mig_direcciones s;
SELECT * FROM mig_regimenfiscal s;
SELECT * FROM mig_per_agr_marcas_conf FOR UPDATE;
--SELECT * FROM transformacion.mig_per_agr_marcas_conf;
--
-- destino
SELECT * FROM agentes s WHERE s.sperson = 2896;
SELECT * FROM per_personas s where sperson in (2843, 2844, 2845, 2896);
SELECT * FROM per_personas_rel s where sperson in (2843, 2844, 2845);
SELECT * FROM per_direcciones s where sperson in (2843, 2844, 2845);
SELECT * FROM per_regimenfiscal s where sperson in (2843, 2844, 2845);
SELECT * FROM per_agr_marcas WHERE sperson = 2849;
--
SELECT * FROM mig_logs_axis s order by ncarga;
pac_iax_persona.f_get_det_persona;
pac_mig_axis--
SELECT * FROM all_constraints s WHERE s.OWNER = 'AXIS_D712' and s.CONSTRAINT_NAME = 'PER_IDENTIFICA_PER_DETPER_FK';
SELECT * FROM poblaciones s WHERE s.cpoblac = 11001;
--
SELECT * FROM per_personas s where nnumide = '9006254903';
SELECT * FROM PER_DETPER where sperson = 2839;
SELECT * FROM PER_IDENTIFICADOR where sperson = 2839;
--
DELETE FROM PER_IDENTIFICADOR where sperson = 2839;
DELETE FROM PER_DETPER where sperson = 2839;
DELETE FROM per_personas s where nnumide = '9006254903';
--
SELECT * FROM tab_error s; 
SELECT * FROM control_error s WHERE TO_DATE(to_char(s.fecha,'dd/mm/yyyy hh:mi PM'),'dd/mm/yyyy hh:mi PM') 
BETWEEN to_date('29/06/2017 07:00 AM','dd/mm/yyyy hh:mi PM') AND to_date('29/06/2017 03:30 PM','dd/mm/yyyy hh:mi PM');
--
pac_md_persona
--
SELECT * FROM MIG_PERSONAS s WHERE s.IDPERSON = 2851;
SELECT * FROM mig_cargas_tab_axis WHERE ncarga = 20014;
SELECT * FROM Per_Agr_Marcas s WHERE s.sperson = 2851;
SELECT * FROM per_cargas WHERE sperson = 2851;
pac_dincartera;
--
SELECT * FROM  COMISIONVIG_AGENTE s WHERE s.cagente = '40001';
SELECT * FROM agentes s WHERE s =  ORDER BY s ;   
SELECT *
         FROM agr_marcas;
SELECT *
         FROM per_agr_marcas;
        WHERE cempres = pcempres
          AND cmarca =  pcmarca
--
SELECT * FROM TIPOS_CUENTA s WHERE ctipban = 197; 
