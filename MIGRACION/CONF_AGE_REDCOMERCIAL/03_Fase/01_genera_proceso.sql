/* Formatted on 22/06/2012 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar la red comercial de Liberty Colombia
*/

DECLARE
   vind           NUMBER;
   vncarga        mig_cargas.ncarga%TYPE;
   vlinea         VARCHAR2(2000);
   vnumerr        NUMBER;
   vcagedep       VARCHAR2(100);
BEGIN
   vlinea := 'DECLARE';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vdummy   number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vncarga number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vcagente number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vcagentecia number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vcpais number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vnumerr number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vcpadre number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vctipiva number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vcretenc number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
------------
   vlinea := 'BEGIN';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   --Inicializamos usuario contexto.
   vlinea :=
      'SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(12, ''USER_BBDD'')) INTO vdummy FROM dual;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'SELECT sncarga.NEXTVAL INTO vncarga FROM DUAL;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'dbms_output.put_line(''ncarga:''||vncarga);';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   -- Obtenemos el agente correspondiente a la compañia.
   vlinea :=
      'SELECT cagente INTO vcagentecia FROM redcomercial WHERE cempres = 12 AND ctipage = 0 AND fmovfin IS NULL AND cpadre IS NULL;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   -- Obtenemos el pais por defecto
   vlinea := 'vcpais := pac_parametros.f_parinstalacion_n(''PAIS_DEF'');';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea:='p_control_error(''carga_red_comercial_150'', ''proceso'', ''START'');';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea :=
      'INSERT INTO MIG_CARGAS (NCARGA, CEMPRES, FINIORG, FFINORG, ESTORG, ID) VALUES ( vncarga, 12, f_sysdate, f_sysdate,';
   vlinea := vlinea || CHR(39) || 'OK' || CHR(39) || ',' || CHR(39) || 'carga_red_comercial_150'
             || CHR(39) || ');';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'INSERT INTO MIG_CARGAS_TAB_MIG (NCARGA, NTAB, TAB_ORG, TAB_DES) VALUES (';
   vlinea := vlinea || 'vncarga, 1,' || CHR(39) || 'Inserts Directos' || CHR(39) || ','
             || CHR(39) || 'MIG_PERSONAS' || CHR(39) || ');';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   --
   vlinea := 'INSERT INTO MIG_CARGAS_TAB_MIG (NCARGA, NTAB, TAB_ORG, TAB_DES) VALUES (';
   vlinea := vlinea || 'vncarga, 2,' || CHR(39) || 'Inserts Directos' || CHR(39) || ','
             || CHR(39) || 'MIG_AGENTES' || CHR(39) || ');';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   --
   vlinea := 'INSERT INTO MIG_CARGAS_TAB_MIG (NCARGA, NTAB, TAB_ORG, TAB_DES) VALUES (';
   vlinea := vlinea || 'vncarga, 3,' || CHR(39) || 'Inserts Directos' || CHR(39) || ','
             || CHR(39) || 'MIG_REGIMENFISCAL' || CHR(39) || ');';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vind := 0;

-----------------------------------------
--INTERMEDIARIOS
-----------------------------------------
   FOR x IN (SELECT   '05INTERMEDIARIO' || i.mig_pk mig_pk, ctipide, nnumide,
                      NVL(cestper, 0) cestper, ctipper,
                      'to_date(' || CHR(39) || fultmov || CHR(39) || ',''yyyymmdd'')' fultmov,
                      swpubli, DECODE(csexper, NULL, 'null', csexper) csexper,
                      DECODE(fnacimi,
                             NULL, 'NULL',
                             'to_date(' || CHR(39) || fnacimi || CHR(39) || ',''yyyymmdd'')')
                                                                                      fnacimi,
                      DECODE(tapell1, NULL, 'null', CHR(39) || tapell1 || CHR(39)) tapell1,
                      DECODE(tapell2, NULL, 'null', CHR(39) || tapell2 || CHR(39)) tapell2,
                      DECODE(tnom, NULL, 'null', CHR(39) || tnom || CHR(39)) tnom,
                      DECODE(cestciv, NULL, 'null', cestciv) cestciv,
                      DECODE(cpais, NULL, 'null', cpais) cpais,
                      DECODE(cprofes, NULL, 'null', cprofes) cprofes,
                      DECODE(cnacio, NULL, 'null', cnacio) cnacio,
                      DECODE(nnumtel, NULL, 'null', CHR(39) || nnumtel || CHR(39)) nnumtel,
                      DECODE(nnumfax, NULL, 'null', CHR(39) || nnumfax || CHR(39)) nnumfax,
                      DECODE(tnom2, NULL, 'null', CHR(39) || tnom2 || CHR(39)) tnom2, cpadre,
                      a.cagente,
                      DECODE(frecepcion,
                             NULL, 'NULL',
                             'to_date(' || CHR(39) || frecepcion || CHR(39) || ',''yyyymmdd'')')
                                                                                   frecepcion,
                      a.ctipint,
                      DECODE(a.cageagr, NULL, 'null', '4' || LPAD(a.cageagr, 6, 0)) cageagr,
                      ',' || DECODE(recepcion, NULL, 0, recepcion) || ','
                      || DECODE(frecepcion,
                                NULL, 'NULL',
                                'to_date(' || CHR(39) || frecepcion || CHR(39)
                                || ',''yyyymmdd'')') toferta,
                      a.idoneo, DECODE(spercomp, NULL, 'null', spercomp) spercomp,
                      DECODE(oficiprop, NULL, 'null', oficiprop) oficiprop,
                      DECODE(clasifint, NULL, 'null', clasifint) clasifint,
                      DECODE(notaria, NULL, 'null', notaria) notaria,
                      DECODE(depnotaria, NULL, 'null', depnotaria) depnotaria,
                      DECODE(ciudadnot, NULL, 'null', ciudadnot) ciudadnot,
                      DECODE(nescritura, NULL, 'null', nescritura) nescritura,
                      DECODE(fconstitu,
                             NULL, 'NULL',
                             'to_date(' || CHR(39) || fconstitu || CHR(39) || ',''yyyymmdd'')')
                                                                                    fconstitu,
                      DECODE(gerente, NULL, 'null', CHR(39) || gerente || CHR(39)) gerente,
                      DECODE(ciudadcam,
                             NULL, 'null',
                             CHR(39) || ciudadcam || CHR(39)) ciudadcam,
                      DECODE(csobcom, NULL, 'null', csobcom) csobcom,
                      DECODE(calias, NULL, 'null', CHR(39) || calias || CHR(39)) calias,
                      DECODE(cliquido, NULL, 'null', cliquido) cliquido,
                      DECODE(ccomisi, NULL, 'null', ccomisi) ccomisi,
                      'to_date(' || CHR(39) || '01/01/1990' || CHR(39)
                      || ',''dd/mm/yyyy'')' feccre,
                      i.ctipreg
                 FROM lcol_intermed_ext_20150731 i,
                      lcol_agentes_ext_20150731 a   /*, lcol_redinter_ext ri*/
                WHERE a.mig_pk = i.mig_pk
             ORDER BY i.mig_pk) LOOP
      vlinea := 'INSERT INTO MIG_PERSONAS (';
      vlinea := vlinea || 'NCARGA, CESTMIG, MIG_PK,      ';
      vlinea := vlinea || 'IDPERSON, SNIP, CTIPIDE,      ';
      vlinea := vlinea || 'NNUMIDE, CESTPER, CPERTIP,    ';
      vlinea := vlinea || 'FULTMOD, SWPUBLI, CSEXPER,    ';
      vlinea := vlinea || 'FNACIMI, CAGENTE, TAPELLI1,   ';
      vlinea := vlinea || 'TAPELLI2, TNOMBRE, CESTCIV,   ';
      vlinea := vlinea || 'CPAIS, CPROFES, CNACIO,       ';
      vlinea := vlinea || 'TNUMTEL, TNUMFAX,   ';
      vlinea := vlinea || 'CIDIOMA,   ';
      vlinea := vlinea || ' TNOMBRE2)  ';
      vlinea := vlinea || 'VALUES ( ';
      vlinea := vlinea || 'vncarga, 1, ' || CHR(39) || x.mig_pk || CHR(39) || ',';
      vlinea := vlinea || '0, null, ' || x.ctipide || ',';
      vlinea := vlinea || CHR(39) || x.nnumide || CHR(39) || ', ' || x.cestper || ', '
                || x.ctipper || ', ';
      vlinea := vlinea || x.fultmov || ',' || x.swpubli || ',' || x.csexper || ',';
      vlinea := vlinea || x.fnacimi || ', vcagentecia, ' || x.tapell1 || ', ';
      vlinea := vlinea || x.tapell2 || ', ' || x.tnom || ', ' || x.cestciv || ', ';
      vlinea := vlinea || x.cpais || ',' || x.cprofes || ',' || x.cnacio || ',';
      vlinea := vlinea || x.nnumtel || ',' || x.nnumfax || ', 8' || ',' || x.tnom2 || ');';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      --
      vlinea := 'select cagente into vcpadre from mig_agentes where mig_pk=''04' || x.cpadre
                || CHR(39) || ';';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'vcagente := 4||LPAD(' || CHR(39) || x.cagente || CHR(39) || ',6,''0'');';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      --
      vcagedep := NULL;

            vcagedep := ',NULL, null,';

      IF x.ctipreg IS NOT NULL THEN
         vlinea := 'BEGIN';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
         vlinea :=
            'select ctipiva, cretenc into vctipiva, vcretenc FROM regfiscal_ivaretenc WHERE cregfiscal = '
            || x.ctipreg || ';';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
         vlinea := 'EXCEPTION WHEN OTHERS THEN';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
         vlinea := 'vctipiva:=0;';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
         vlinea := 'vcretenc:=0;';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
         vlinea := 'END;';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      ELSE
         vlinea := 'vctipiva:=0;';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
         vlinea := 'vcretenc:=0;';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      END IF;

      --
      vlinea := 'INSERT INTO MIG_AGENTES (';
      vlinea := vlinea || 'NCARGA, CESTMIG, MIG_PK,';
      vlinea := vlinea || 'MIG_FK, CAGENTE, ';
      vlinea := vlinea || 'CTIPAGE, CACTIVO, CRETENC, ';
      vlinea := vlinea || 'CTIPIVA, CCOMISI, CPADRE, ';
      vlinea := vlinea || 'FMOVINI, CPERVISIO, ';
      vlinea := vlinea || 'CPERNIVEL, CPOLVISIO, CPOLNIVEL,';
      vlinea := vlinea || 'IDPERSON,FINIVIG,ctipadn,cagedep,';
      vlinea := vlinea || 'ctipint,cageclave,cofermercan, frecepcontra,';
      vlinea := vlinea || ' cidoneidad, spercomp, cofipropia, cclasif,';
      vlinea := vlinea || ' nnotaria, cprovin, cpoblac, nescritura,';
      vlinea := vlinea || ' faltasoc, tgerente, tcamaracomercio, csobrecomisi,';
      vlinea := vlinea || ' talias, cliquido) VALUES (';
      vlinea := vlinea || 'vncarga,1, ' || CHR(39) || x.mig_pk || CHR(39) || ', ';
      vlinea := vlinea || CHR(39) || x.mig_pk || CHR(39) || ', vcagente,';
      vlinea := vlinea || '4, 1, vcretenc,';
      vlinea := vlinea || 'vctipiva, ' || x.ccomisi || ', vcpadre,';
      vlinea := vlinea || x.feccre || ', vcagentecia, 1, vcagente, 1, 0,' || x.feccre
                || vcagedep || x.ctipint || ',' || x.cageagr || x.toferta || ',' || x.idoneo
                || ',' || x.spercomp || ',' || x.oficiprop || ',' || x.clasifint || ','
                || x.notaria || ',' || x.depnotaria || ',' || x.ciudadnot || ','
                || x.nescritura || ',' || x.fconstitu || ',' || x.gerente || ',' || x.ciudadcam
                || ',' || x.csobcom || ',' || x.calias || ',' || x.cliquido || ');';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);

      ----
      IF x.ctipreg IS NOT NULL THEN
         vlinea := 'INSERT INTO MIG_REGIMENFISCAL (';
         vlinea := vlinea || 'NCARGA, CESTMIG, MIG_PK,';
         vlinea := vlinea || 'MIG_FK, NANUALI, FEFECTO,';
         vlinea := vlinea || 'CREGFIS) VALUES ( vncarga, 1,' || CHR(39) || x.mig_pk || CHR(39)
                   || ', ';
         vlinea := vlinea || CHR(39) || x.mig_pk || CHR(39)
                   || ', 2012, to_date(''01012012'',''ddmmyyyy''),' || x.ctipreg || ');';
         p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      END IF;
   END LOOP;

   vlinea := 'pac_mig_axis.p_migra_cargas(' || CHR(39) || 'carga_red_comercial_150' || CHR(39)
             || ');';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'UPDATE control_error SET suceso = ''END'' WHERE ID = ''carga_red_comercial_150'';';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'END;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := '/';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
END;
