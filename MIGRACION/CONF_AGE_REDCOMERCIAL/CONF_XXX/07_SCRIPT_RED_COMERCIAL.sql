/* ******************* FORMATTED ON 08/07/2016 11:13 a.m. ***************************
Versión   Descripción

01.       Carga red comercial (Johan Esteban - CONFIANZA)
************************************************************************************* */
--
--
--
DECLARE
   vncarga           mig_cargas.ncarga%TYPE;
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- Agente raiz 
   v_agente_pervisio NUMBER := 19000; -- Agente vision personas por defecto si no viene informado
   vdummy            NUMBER;
BEGIN
   SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24,
                                                                      'USER_BBDD'))
     INTO vdummy
     FROM dual;
   --
   UPDATE mig_cargas_tab_mig SET estdes = 'DEL' WHERE ncarga = 17382;
   COMMIT;
   --
   pac_mig_axis.p_borra_cargas(pcestado => 'DEL', pncarga => 17382);   
   --
   SELECT sncarga.nextval INTO vncarga FROM dual;
   --
   dbms_output.put_line('El ncarga es :' || vncarga);
   --
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (vncarga, 24, f_sysdate, f_sysdate, 'OK', 'MIGRA_CONF');

   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (vncarga, 1, 'Inserts Directos', 'MIG_PERSONAS');

   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (vncarga, 2, 'Inserts Directos', 'MIG_DIRECCIONES');
   --
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (vncarga, 3, 'Inserts Directos', 'MIG_AGENTES');
   --
   --
   DELETE MIG_PERSONAS;
   DELETE MIG_DIRECCIONES;
   DELETE MIG_AGENTES;
   -----------------------------------------
   --PERSONAS
   -----------------------------------------
   INSERT INTO mig_personas
      (ncarga, cestmig, mig_pk, idperson, snip, ctipide, nnumide, cestper,
       cpertip, fultmod, swpubli, csexper, fnacimi, cagente, tapelli1,
       tapelli2, tnombre, cestciv, cpais, cprofes, cnacio, ctipdir, ctipvia,
       tnomvia, nnumvia, tcomple, cpostal, cpoblac, cprovin, ctipdir2,
       ctipvia2, tnomvia2, nnumvia2, tcomple2, cpostal2, cpoblac2, cprovin2,
       tnumtel, tnumfax, tnummov, temail, ctipban, cbancar, cidioma,
       ctipide2, nnumide2, fjubila, tnombre2, tdigitoide)
      SELECT vncarga,
             1,
             mig_pk,
             --      DECODE(idperson, NULL, 'null', idperson) idperson,
             0 idperson,
             NULL,
             ctipide,
             nnumide,
             1,
             1,
             NULL,
             swpubli,
             DECODE(length(csexper), 1, csexper, 0) csexper,
             fnacimi,
             DECODE(cagente, NULL, v_agente_padre, cagente) cagente,
             tapell1,
             tapell2,
             tnom,
             cestciv,
             170 cpais, --NVL(cpais, 170), -- por defecto poner COLOMBIA (ver CPAISES)
             cprofes,
             170 cnacio, --NVL(cpais, 170), -- por defecto poner COLOMBIA (ver CPAISES)
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             nnumtel,
             nnumfax,
             nnummov,
             tmail,
             NULL,
             NULL,
             8,
             NULL ctipide2,
             NULL nnumide2,
             NULL fjubila,
             NULL tnombre2,
             NULL tdigitoide
        FROM mig_personas_ext
       ORDER BY mig_pk;

   -----------------------------------------
   --DIRECCIONES
   -----------------------------------------
   FOR x IN (SELECT mig_pk,
                    mig_fk,
                    0 sperson,
                    DECODE(cagente, NULL, NULL, cagente) cagente,
                    DECODE(cdomici, NULL, NULL, cdomici) cdomici,
                    DECODE(cpostal,
                           NULL,
                           NULL,
                           chr(39) || cpostal || chr(39)) cpostal,
                    DECODE(cprovin, NULL, NULL, cprovin) cprovin,
                    DECODE(cpoblac, NULL, NULL, cpoblac) cpoblac,
                    DECODE(tnomvia,
                           NULL,
                           NULL,
                           chr(39) || tnomvia || chr(39)) tnomvia,
                    DECODE(ctipdir, NULL, 1, ctipdir) ctipdir,
                    DECODE(cviavp, NULL, NULL, cviavp) cviavp,
                    DECODE(clitvp, NULL, NULL, clitvp) clitvp,
                    DECODE(cbisvp, NULL, NULL, cbisvp) cbisvp,
                    DECODE(corvp, NULL, NULL, corvp) corvp,
                    DECODE(nviaadco, NULL, NULL, nviaadco) nviaadco,
                    DECODE(clitco, NULL, NULL, clitco) clitco,
                    DECODE(corco, NULL, NULL, corco) corco,
                    DECODE(nplacaco, NULL, NULL, nplacaco) nplacaco,
                    DECODE(cor2co, NULL, NULL, cor2co) cor2co,
                    DECODE(cdet1ia, NULL, NULL, cdet1ia) cdet1ia,
                    DECODE(tnum1ia,
                           NULL,
                           NULL,
                           chr(39) || tnum1ia || chr(39)) tnum1ia,
                    DECODE(cdet2ia, NULL, NULL, cdet2ia) cdet2ia,
                    DECODE(tnum2ia,
                           NULL,
                           NULL,
                           chr(39) || tnum2ia || chr(39)) tnum2ia,
                    DECODE(cdet3ia, NULL, NULL, cdet3ia) cdet3ia,
                    DECODE(tnum3ia,
                           NULL,
                           NULL,
                           chr(39) || tnum3ia || chr(39)) tnum3ia
               FROM mig_direcciones_ext
              ORDER BY mig_pk,
                       mig_fk)
   LOOP
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
   END LOOP;

   -----------------------------------------
   --AGENTES
   -----------------------------------------
   INSERT INTO mig_agentes
      (ncarga, cestmig, mig_pk, mig_fk, cagente, idperson, ctipage, cactivo,
       cretenc, ctipiva, ccomisi, cpadre, fmovini, fmovfin, cpervisio,
       cpernivel, cpolvisio, cpolnivel, finivig, ctipadn, cagedep, ctipint,
       cageclave, cofermercan, frecepcontra, cidoneidad, spercomp, ccompani,
       cofipropia, cclasif, nplanpago, nnotaria, cprovin, cpoblac,
       nescritura, faltasoc, tgerente, tcamaracomercio, csobrecomisi, talias,
       cliquido, nregdgs)
      SELECT vncarga,
             1,
             mig_pk,
             mig_fk,
             f_set_agente(24, ctipage) cagente,
             0 idperson,
             ctipage,
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
        FROM mig_agentes_ext
       ORDER BY mig_pk,
                mig_fk;
   --
   COMMIT;
   --
   dbms_output.put_line('Migra red comercial');
   --Migra la red comercial
   IF vncarga != 17382 THEN
      pac_mig_axis.p_migra_cargas('MIGRA_CONF', 'C', vncarga);
   END IF;
   --
   COMMIT;
   --
END;
/
