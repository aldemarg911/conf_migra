/* Formatted on 07/03/2013 14:16 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
DECLARE
   vdummy         NUMBER;
   vncarga        NUMBER;
   vcagente       NUMBER;
   vcagentecia    NUMBER;
   vcpais         NUMBER;
   vnumerr        NUMBER;
   vcpadre        NUMBER;
   vctipiva       NUMBER;
   vcretenc       NUMBER;
BEGIN
   SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(12, 'USER_BBDD'))
     INTO vdummy
     FROM DUAL;

   SELECT sncarga.NEXTVAL
     INTO vncarga
     FROM DUAL;

   DBMS_OUTPUT.put_line('ncarga:' || vncarga);

   SELECT cagente
     INTO vcagentecia
     FROM redcomercial
    WHERE cempres = 12
      AND ctipage = 0
      AND fmovfin IS NULL
      AND cpadre IS NULL;

   vcpais := pac_parametros.f_parinstalacion_n('PAIS_DEF');
   p_control_error('carga_red_comercial_25', 'proceso', 'START');

   INSERT INTO mig_cargas
               (ncarga, cempres, finiorg, ffinorg, estorg, ID)
        VALUES (vncarga, 12, f_sysdate, f_sysdate, 'OK', 'carga_red_comercial_25');

   INSERT INTO mig_cargas_tab_mig
               (ncarga, ntab, tab_org, tab_des)
        VALUES (vncarga, 1, 'Inserts Directos', 'MIG_PERSONAS');

   INSERT INTO mig_cargas_tab_mig
               (ncarga, ntab, tab_org, tab_des)
        VALUES (vncarga, 2, 'Inserts Directos', 'MIG_AGENTES');

   INSERT INTO mig_cargas_tab_mig
               (ncarga, ntab, tab_org, tab_des)
        VALUES (vncarga, 3, 'Inserts Directos', 'MIG_REGIMENFISCAL');

   INSERT INTO mig_personas
               (ncarga, cestmig, mig_pk, idperson, snip, ctipide,
                nnumide, cestper, cpertip, fultmod, swpubli, csexper,
                fnacimi, cagente,
                tapelli1, tapelli2, tnombre, cestciv, cpais, cprofes, cnacio,
                tnumtel, tnumfax, cidioma, tnombre2)
        VALUES (vncarga, 1, '05INTERMEDIARIO05INTERMEDIARIO201302271', 0, NULL, 37,
                '9003735608', 0, 1, TO_DATE('', 'yyyymmdd'), 1, 1,
                TO_DATE('19720627', 'yyyymmdd'), vcagentecia,
                'J & M LTDA. ASESORES EN SEGUROS', NULL, NULL, NULL, 170, NULL, 170,
                '2536374', '0', 8, NULL);

   SELECT cagente
     INTO vcpadre
     FROM mig_agentes
    WHERE mig_pk = '04103';

   vcagente := 4 || LPAD('34169', 6, '0');

   BEGIN
      SELECT ctipiva, cretenc
        INTO vctipiva, vcretenc
        FROM regfiscal_ivaretenc
       WHERE cregfiscal = 2;
   EXCEPTION
      WHEN OTHERS THEN
         vctipiva := 0;
         vcretenc := 0;
   END;

   INSERT INTO mig_agentes
               (ncarga, cestmig, mig_pk,
                mig_fk, cagente, ctipage, cactivo, cretenc, ctipiva,
                ccomisi, cpadre, fmovini, cpervisio, cpernivel, cpolvisio, cpolnivel,
                idperson, finivig, ctipadn, cagedep, ctipint, cageclave, cofermercan,
                frecepcontra, cidoneidad, spercomp, cofipropia, cclasif, nnotaria, cprovin,
                cpoblac, nescritura, faltasoc, tgerente, tcamaracomercio, csobrecomisi,
                talias, cliquido)
        VALUES (vncarga, 1, '05INTERMEDIARIO05INTERMEDIARIO201302271',
                '05INTERMEDIARIO05INTERMEDIARIO201302271', vcagente, 4, 1, vcretenc, vctipiva,
                70, vcpadre, TO_DATE('01/01/1990', 'dd/mm/yyyy'), vcagentecia, 1, vcagente, 1,
                0, TO_DATE('01/01/1990', 'dd/mm/yyyy'), NULL, NULL, 4, 4034169, 0,
                NULL, 1, NULL, NULL, NULL, NULL, 11,
                1, NULL, NULL, 'MARCELA BERMUDEZ CAMPOS', 'BOGOTA', NULL,
                NULL, 0);

   INSERT INTO mig_regimenfiscal
               (ncarga, cestmig, mig_pk,
                mig_fk, nanuali,
                fefecto, cregfis)
        VALUES (vncarga, 1, '05INTERMEDIARIO05INTERMEDIARIO201302271',
                '05INTERMEDIARIO05INTERMEDIARIO201302271', 2012,
                TO_DATE('01012012', 'ddmmyyyy'), 2);

   INSERT INTO mig_personas
               (ncarga, cestmig, mig_pk, idperson, snip, ctipide,
                nnumide, cestper, cpertip, fultmod, swpubli, csexper,
                fnacimi, cagente, tapelli1, tapelli2, tnombre,
                cestciv, cpais, cprofes, cnacio, tnumtel, tnumfax, cidioma, tnombre2)
        VALUES (vncarga, 1, '05INTERMEDIARIO05INTERMEDIARIO201303051', 0, NULL, 36,
                '60339215', 0, 1, TO_DATE('', 'yyyymmdd'), 1, 2,
                TO_DATE('19700303', 'yyyymmdd'), vcagentecia, 'MOROS', 'SANCHEZ', 'AMPARO',
                NULL, 170, NULL, 170, '5741928', '0', 8, NULL);

   SELECT cagente
     INTO vcpadre
     FROM mig_agentes
    WHERE mig_pk = '0443';

   vcagente := 4 || LPAD('43058', 6, '0');

   BEGIN
      SELECT ctipiva, cretenc
        INTO vctipiva, vcretenc
        FROM regfiscal_ivaretenc
       WHERE cregfiscal = 1;
   EXCEPTION
      WHEN OTHERS THEN
         vctipiva := 0;
         vcretenc := 0;
   END;

   INSERT INTO mig_agentes
               (ncarga, cestmig, mig_pk,
                mig_fk, cagente, ctipage, cactivo, cretenc, ctipiva,
                ccomisi, cpadre, fmovini, cpervisio, cpernivel, cpolvisio, cpolnivel,
                idperson, finivig, ctipadn, cagedep, ctipint, cageclave, cofermercan,
                frecepcontra, cidoneidad, spercomp, cofipropia, cclasif, nnotaria, cprovin,
                cpoblac, nescritura, faltasoc, tgerente, tcamaracomercio, csobrecomisi,
                talias, cliquido)
        VALUES (vncarga, 1, '05INTERMEDIARIO05INTERMEDIARIO201303051',
                '05INTERMEDIARIO05INTERMEDIARIO201303051', vcagente, 4, 1, vcretenc, vctipiva,
                70, vcpadre, TO_DATE('01/01/1990', 'dd/mm/yyyy'), vcagentecia, 1, vcagente, 1,
                0, TO_DATE('01/01/1990', 'dd/mm/yyyy'), NULL, NULL, 3, 4043058, 0,
                NULL, 1, NULL, NULL, NULL, NULL, 54,
                1, NULL, NULL, 'YAMILE  ALVARADO', 'CUCUTA', NULL,
                NULL, 0);

   INSERT INTO mig_regimenfiscal
               (ncarga, cestmig, mig_pk,
                mig_fk, nanuali,
                fefecto, cregfis)
        VALUES (vncarga, 1, '05INTERMEDIARIO05INTERMEDIARIO201303051',
                '05INTERMEDIARIO05INTERMEDIARIO201303051', 2012,
                TO_DATE('01012012', 'ddmmyyyy'), 1);

   pac_mig_axis.p_migra_cargas('carga_red_comercial_25');

   UPDATE control_error
      SET suceso = 'END'
    WHERE ID = 'carga_red_comercial_25';
END;
/