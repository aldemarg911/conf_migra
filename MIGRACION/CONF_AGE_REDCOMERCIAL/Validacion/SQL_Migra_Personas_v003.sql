CREATE OR REPLACE PROCEDURE p_load_persona
 IS
    /******************************************************************************
    NOMBRE:       p_load_persona
    PROPÓSITO:    Procedimiento que ejecuta carga de personas - migracion

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  ???                1. Creación del package.
/* Formatted on 27/06/2012 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar las Personas, Direcciones, per_agr_marcas, Personas_Rel y mig_regimenfiscal
*/
   --
   vncarga           mig_cargas.ncarga%TYPE;
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz 
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   vdummy            NUMBER;
   b_error           BOOLEAN;
   b_hay_personas    BOOLEAN;
   v_cant            NUMBER := 0;
   --
    CURSOR lc_mig_personas(p_ncarga NUMBER) IS
     SELECT p_ncarga NCARGA, 1 CESTMIG, 0 IDPERSON, MIG_PK, SNIP, CTIPIDE, NNUMIDE, 
            CESTPER, CPERTIP, FULTMOD, SWPUBLI, DECODE(LENGTH(CSEXPER), 1, CSEXPER, 0) CSEXPER, 
            FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, 
            CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC            
       FROM /*transformacion.*/mig_personas_conf mpc
       --SELECT COUNT(*) FROM mig_personas_conf mpc
      WHERE 1 = 1
        AND mpc.nnumide IS NOT NULL
        AND  (    ctipide  IS NOT NULL 
              AND cestper  IS NOT NULL 
              AND cpertip  IS NOT NULL
              AND swpubli  IS NOT NULL
              AND tapelli1 IS NOT NULL
             )
        AND mig_pk NOT IN (SELECT DISTINCT mpc.mig_pk
                             FROM /*transformacion.*/mig_personas_conf mpc, per_personas p
                            WHERE 1 = 1
                              AND mpc.nnumide = p.nnumide
                              AND mpc.ctipide = p.ctipide
                              AND  (    mpc.ctipide  IS NOT NULL 
                                    AND mpc.cestper  IS NOT NULL 
                                    AND mpc.cpertip  IS NOT NULL
                                    AND mpc.swpubli  IS NOT NULL
                                    AND mpc.tapelli1 IS NOT NULL
                                   )
                              AND (SELECT COUNT(sperson) 
                                     FROM per_personas 
                                    WHERE nnumide = mpc.nnumide
                                      AND ctipide = mpc.ctipide) > 0)        
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
     /*INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (p_ncarga, 4, 'Inserts Directos', 'MIG_REGIMENFISCAL');*/
     --
     INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des)
     VALUES
        (p_ncarga, 4, 'Inserts Directos', 'MIG_AGENTES');
     --
   END pi_mig_cargas;
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
  DELETE mig_personas WHERE mig_pk IN (SELECT mig_pk FROM mig_personas_conf);
  DELETE mig_direcciones WHERE mig_pk IN (SELECT mig_pk FROM mig_direcciones_conf);
  DELETE mig_personas_rel WHERE mig_pk IN (SELECT mig_pk FROM mig_personas_rel);
  DELETE mig_agentes WHERE mig_pk IN (SELECT mig_pk FROM mig_agentes_conf);
  DELETE control_error WHERE donde = 'p_load_persona' AND TRUNC(fecha) = TRUNC(SYSDATE);
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
                      AND cpoblac IS NOT NULL
                    ORDER BY mig_pk, mig_fk
                    )
         LOOP
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
         INSERT INTO mig_personas_rel(NCARGA, CESTMIG, MIG_PK, MIG_FK, 
                                      FKREL, CTIPREL, PPARTICIPACION, ISLIDER
                                      )
         SELECT vncarga NCARGA, 1 CESTMIG, MIG_PK, MIG_FK, 
                FKREL, CTIPREL, PPARTICIPACION, ISLIDER
           FROM /*transformacion.*/mig_personas_rel_conf mpc
          WHERE 1 = 1
            AND MIG_FK = l_per.MIG_PK;
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
       /*BEGIN
         --
         DELETE mig_regimenfiscal WHERE mig_fk = l_per.MIG_PK;
         --SELECT * FROM mig_regimenfiscal s;
         --
         INSERT INTO mig_regimenfiscal(NCARGA, CESTMIG, MIG_PK, MIG_FK,
                                       NANUALI, FEFECTO, CREGFIS)
         SELECT vncarga NCARGA, 1 CESTMIG, MIG_PK, MIG_FK, 
                NANUALI, NVL(FEFECTO, TRUNC(SYSDATE)), CREGFIS
           FROM /*transformacion.mig_regimenfiscal_conf rf
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
       END;*/
       --
       --MIG_AGENTES
       --
       BEGIN
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
               DECODE(cpernivel, 0, 1, cpernivel) cpernivel,
               v_agente_pervisio cpolvisio,
               DECODE(cpolnivel, 0, 1, cpolnivel) cpolnivel,
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
       EXCEPTION
       WHEN OTHERS THEN
         --
         dbms_output.put_line('mig_agentes - ERR:'||SQLERRM);
         b_error := TRUE;
         --
       END;
       --
       v_cant := v_cant + 1;
       --
       IF MOD(v_cant,1000)= 0
       THEN
         --
         p_control_error('CXHGOME','p_load_persona','v_cant:'||v_cant); 
         --
       END IF;
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
    --
   ELSE
    --
    ROLLBACK;
    dbms_output.put_line('- ROLLBACK -');
    --
   END IF;
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
END p_load_persona;
