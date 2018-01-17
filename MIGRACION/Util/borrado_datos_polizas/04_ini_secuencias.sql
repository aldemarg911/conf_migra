/* Formatted on 16/01/2016 12:33 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--INICIO de secuencias y contadores.
--A ejecutar con el usuario propietario de las secuencias
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

DECLARE
   vultimo        NUMBER;
   vmin           NUMBER;
   vcache         NUMBER;
   vvalor         NUMBER;
   vinicial       NUMBER;
   vsql           VARCHAR2(2000);
   vsecuencia     VARCHAR2(100);
   vmaxcont       NUMBER;
   vcempres       VARCHAR2(10) := '17';

   PROCEDURE p_crea_seq_cont IS
      v_valor        NUMBER;
      ex_nodeclared  EXCEPTION;
      PRAGMA EXCEPTION_INIT(ex_nodeclared, -2289);   -- ORA-02289: no existe la secuencia
   BEGIN
      BEGIN
         vsql := 'SELECT SEQ_CONT_' || LPAD(vcempres, 2, '00') || '.NEXTVAL FROM DUAL';

         EXECUTE IMMEDIATE vsql
                      INTO v_valor;
      EXCEPTION
         WHEN ex_nodeclared THEN
            -- ORA-02289: no existe la secuencia
            vsql :=
               'CREATE SEQUENCE SEQ_CONT_' || LPAD(vcempres, 2, '00')
               || ' START WITH 0 MAXVALUE 999999999999999999999999999 MINVALUE 0 NOCYCLE CACHE 20 NOORDER';

            EXECUTE IMMEDIATE vsql;
         WHEN OTHERS THEN
            NULL;
      END;
   END;

   PROCEDURE p_ini_sec(psecuencia IN VARCHAR2, pinicial IN NUMBER) IS
   BEGIN
      --SELECT last_number INTO vultimo FROM user_sequences WHERE sequence_name='SLITERA';
      vsql :=
         'SELECT last_number,min_value,cache_size FROM user_sequences WHERE sequence_name='''
         || psecuencia || '''';

      EXECUTE IMMEDIATE vsql
                   INTO vultimo, vmin, vcache;

      --DBMS_OUTPUT.PUT_LINE('Último='||vultimo||' Min='||vmin);
      IF vultimo = pinicial THEN
         NULL;
      ELSE
         IF vmin <> 0 THEN
            vsql := 'ALTER SEQUENCE ' || psecuencia || ' MINVALUE 0';

            EXECUTE IMMEDIATE vsql;
         END IF;

         IF vcache <> 0 THEN
            vsql := 'ALTER SEQUENCE ' || psecuencia || ' NOCACHE';

            EXECUTE IMMEDIATE vsql;
         END IF;

         IF vultimo - 1 <> 0 THEN
            vsql := 'ALTER SEQUENCE ' || psecuencia || ' INCREMENT BY ' || (vultimo - 1)
                                                                           *(-1);

            --DBMS_OUTPUT.PUT_LINE('vSQL='||vSQL);
            EXECUTE IMMEDIATE vsql;

            vsql := 'SELECT ' || psecuencia || '.NEXTVAL FROM DUAL';

            EXECUTE IMMEDIATE vsql
                         INTO vvalor;
         END IF;

         IF pinicial > 1 THEN
            vsql := 'ALTER SEQUENCE ' || psecuencia || ' INCREMENT BY '
                    || TO_CHAR(pinicial - 1);

            --DBMS_OUTPUT.PUT_LINE('vSQL='||vSQL);
            EXECUTE IMMEDIATE vsql;

            vsql := 'SELECT ' || psecuencia || '.NEXTVAL FROM DUAL';

            EXECUTE IMMEDIATE vsql
                         INTO vvalor;
         END IF;

         vsql := 'ALTER SEQUENCE ' || psecuencia || ' INCREMENT BY 1';

         EXECUTE IMMEDIATE vsql;

         IF pinicial = 1
            AND vmin = 1 THEN
            NULL;
         ELSE
            vsql := 'ALTER SEQUENCE ' || psecuencia || ' MINVALUE ' || vmin;

            EXECUTE IMMEDIATE vsql;
         END IF;

         IF vcache <> 0 THEN
            vsql := 'ALTER SEQUENCE ' || psecuencia || ' CACHE ' || vcache;

            EXECUTE IMMEDIATE vsql;
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.put_line('Error en secuencia = ' || psecuencia || '. Error: ' || SQLERRM);
   END;
BEGIN
--***************************************************************************************************
--***************************************************************************************************
--*********  SECUENCIAS CON RANGOS
--***************************************************************************************************
--***************************************************************************************************
   p_crea_seq_cont;
-------------------------------------------------------------------------------------
--SLITERA
-------------------------------------------------------------------------------------
--   vsecuencia := 'SLITERA';
--   vinicial := 900000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SPRODUC
-------------------------------------------------------------------------------------
--   vsecuencia := 'SPRODUC';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCLABEN
-------------------------------------------------------------------------------------
--   vsecuencia := 'SCLABEN';
--   vinicial := 8000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCLAGEN
-------------------------------------------------------------------------------------
--   vsecuencia := 'SCLAGEN';
--   vinicial := 8000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCLAPRO
-------------------------------------------------------------------------------------
--   vsecuencia := 'SCLAPRO';
--   vinicial := 80000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SGTFORMULAS
-------------------------------------------------------------------------------------
--   vsecuencia := 'SGTFORMULAS';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--STRAMOS
-------------------------------------------------------------------------------------
--   vsecuencia := 'STRAMOS';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SPRCAMOSIN
-------------------------------------------------------------------------------------
--   vsecuencia := 'SPRCAMOSIN';
--   vinicial := 80000000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SIDPRODP
-------------------------------------------------------------------------------------
--   vsecuencia := 'SIDPRODP';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SIDRESC
-------------------------------------------------------------------------------------
--   vsecuencia := 'SIDRESC';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SPRODREPREC
-------------------------------------------------------------------------------------
--   vsecuencia := 'SPRODREPREC';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCOMREA
-------------------------------------------------------------------------------------
--   vsecuencia := 'SCOMREA';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCONTRA
-------------------------------------------------------------------------------------
--   vsecuencia := 'SCONTRA';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCUECAR
-------------------------------------------------------------------------------------
--   vsecuencia := 'SCUECAR';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
---------
--AÑADIDO
---------
-------------------------------------------------------------------------------------
--SDET_TRAMOS
-------------------------------------------------------------------------------------
--   vsecuencia := 'SDET_TRAMOS';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SMODCON
-------------------------------------------------------------------------------------
--   vsecuencia := 'SMODCON';
--   vinicial := 800000;
--   p_ini_sec(vsecuencia, vinicial);
--***************************************************************************************************
--***************************************************************************************************
--*********  SECUENCIAS A VALOR MÁXIMO
--***************************************************************************************************
--***************************************************************************************************
-------------------------------------------------------------------------------------
--SPERSON
-------------------------------------------------------------------------------------
   vsecuencia := 'SPERSON';

   SELECT NVL(MAX(sperson) + 1, 1)
     INTO vinicial
     FROM per_personas;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SPEREAL
-------------------------------------------------------------------------------------
   vsecuencia := 'SPEREAL';
   vinicial := 500000;
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------------
   vsecuencia := 'SNIP';

   SELECT NVL(MAX(snip) + 1, 1)
     INTO vinicial
     FROM per_personas;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SSEGURO
-------------------------------------------------------------------------------------
   vsecuencia := 'SSEGURO';

   SELECT NVL(MAX(sseguro) + 1, 1)
     INTO vinicial
     FROM seguros;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCUMULO
-------------------------------------------------------------------------------------
   vsecuencia := 'SCUMULO';

   SELECT NVL(MAX(scumulo) + 1, 1)
     INTO vinicial
     FROM cumulos;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--CODPLANPENSIONES_SEQ
-------------------------------------------------------------------------------------
   vsecuencia := 'CODPLANPENSIONES_SEQ';

   SELECT NVL(MAX(ccodpla) + 1, 1)
     INTO vinicial
     FROM planpensiones;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--CODDEPOSITARIAS_SEQ
-------------------------------------------------------------------------------------
   vsecuencia := 'CODDEPOSITARIAS_SEQ';

   SELECT NVL(MAX(ccoddep) + 1, 1)
     INTO vinicial
     FROM depositarias;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--CODGESTORAS_SEQ
-------------------------------------------------------------------------------------
   vsecuencia := 'CODGESTORAS_SEQ';

   SELECT NVL(MAX(ccodges) + 1, 1)
     INTO vinicial
     FROM gestoras;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--CODFONPENSIONES_SEQ
-------------------------------------------------------------------------------------
   vsecuencia := 'CODFONPENSIONES_SEQ';

   SELECT NVL(MAX(ccodfon) + 1, 1)
     INTO vinicial
     FROM fonpensiones;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SAGENDA
-------------------------------------------------------------------------------------
--   vsecuencia := 'SAGENDA';

   --   SELECT NVL(MAX(sagenda) + 1, 1)
--     INTO vinicial
--     FROM agensegu;

   --   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCONTRA
-------------------------------------------------------------------------------------
   vsecuencia := 'SCONTRA';

   SELECT NVL(MAX(scontra) + 1, 1)
     INTO vinicial
     FROM codicontratos;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONS_JREPS
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONS_JREPS';

   SELECT NVL(MAX(sproces) + 1, 1)
     INTO vinicial
     FROM consultes_jreports;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SSUBTABLA_LCOL
-------------------------------------------------------------------------------------
--   vsecuencia := 'SSUBTABLA_LCOL';

   --   SELECT NVL(MAX(sproces) + 1, 1)
--     INTO vinicial
--     FROM sgt_subtabs;

   --   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SDETALLE_LCOL
-------------------------------------------------------------------------------------
--   vsecuencia := 'SDETALLE_LCOL';

   --   SELECT NVL(MAX(sproces) + 1, 1)
--     INTO vinicial
--     FROM sgt_subtabs_det;

   --   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SPROCES
-------------------------------------------------------------------------------------
   vsecuencia := 'SPROCES';

   SELECT NVL(MAX(sproces) + 1, 1)
     INTO vinicial
     FROM procesoscab;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SMOVREC
-------------------------------------------------------------------------------------
   vsecuencia := 'SMOVREC';

   SELECT NVL(MAX(smovrec) + 1, 1)
     INTO vinicial
     FROM movrecibo;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SMOVREC_TMP
-------------------------------------------------------------------------------------
   vsecuencia := 'SMOVREC_TMP';

   SELECT NVL(MAX(smovrec) + 1, 1)
     INTO vinicial
     FROM tmp_adm_movrecibo;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SMOVAGR
-------------------------------------------------------------------------------------
   vsecuencia := 'SMOVAGR';

   SELECT NVL(MAX(smovagr) + 1, 1)
     INTO vinicial
     FROM movrecibo;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SMOVAGR_TMP
-------------------------------------------------------------------------------------
   vsecuencia := 'SMOVAGR_TMP';

   SELECT NVL(MAX(smovagr) + 1, 1)
     INTO vinicial
     FROM tmp_adm_movrecibo;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQLOGCORREO
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQLOGCORREO';

   SELECT NVL(MAX(seqlogcorreo) + 1, 1)
     INTO vinicial
     FROM log_correo;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SMAPEAD
-------------------------------------------------------------------------------------
   vsecuencia := 'SMAPEAD';

   SELECT NVL(MAX(smapead) + 1, 1)
     INTO vinicial
     FROM map_debug;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQERROR
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQERROR';

   SELECT NVL(MAX(seqerror) + 1, 1)
     INTO vinicial
     FROM control_error;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_ERROR_TAB_ERROR
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_ERROR_TAB_ERROR';

   SELECT NVL(MAX(seqerror) + 1, 1)
     INTO vinicial
     FROM tab_error;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SIDEPAG
-------------------------------------------------------------------------------------
   vsecuencia := 'SIDEPAG';

   SELECT NVL(MAX(sidepag) + 1, 1)
     INTO vinicial
     FROM pagosini;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SREMESA
-------------------------------------------------------------------------------------
   vsecuencia := 'SREMESA';

   SELECT NVL(MAX(sremesa) + 1, 1)
     INTO vinicial
     FROM remesas;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SREMESA_PREVIO
-------------------------------------------------------------------------------------
   vsecuencia := 'SREMESA_PREVIO';

   SELECT NVL(MAX(sremesa) + 1, 1)
     INTO vinicial
     FROM remesas_previo;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SNREMESA
-------------------------------------------------------------------------------------
   vsecuencia := 'SNREMESA';

   SELECT NVL(MAX(nremesa) + 1, 1)
     INTO vinicial
     FROM remesas;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SSECREN
-------------------------------------------------------------------------------------
--   vsecuencia := 'SECREN';

   --   SELECT NVL(MAX(srecren) + 1, 1)
--     INTO vinicial
--     FROM pagosrenta;

   --   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCUMCUMUL
-------------------------------------------------------------------------------------
   vsecuencia := 'SCUMCUMUL';

   SELECT NVL(MAX(scumulo) + 1, 1)
     INTO vinicial
     FROM cumulos;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SMODIFI
-------------------------------------------------------------------------------------
   vsecuencia := 'SMODIFI';

   SELECT NVL(MAX(smodifi) + 1, 1)
     INTO vinicial
     FROM detmodif;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--S_ERROR
-------------------------------------------------------------------------------------
   vsecuencia := 'S_ERROR';

   SELECT NVL(MAX(serror) + 1, 1)
     INTO vinicial
     FROM int_control_errores;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--STARIFA
-------------------------------------------------------------------------------------
   vsecuencia := 'STARIFA';

   SELECT NVL(MAX(sproces) + 1, 1)
     INTO vinicial
     FROM tmp_garancar;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SGT_SESIONES
-------------------------------------------------------------------------------------
   vsecuencia := 'SGT_SESIONES';

   SELECT NVL(MAX(sesion) + 1, 1)
     INTO vinicial
     FROM sgt_parms_transitorios;

   p_ini_sec(vsecuencia, vinicial);
---------
--AÑADIDO
---------

   -------------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------------
--vsecuencia:='';
--SELECT NVL(MAX()+1,1) INTO vinicial FROM control_error;
--P_INI_SEC(vsecuencia,vinicial);

   --***************************************************************************************************
--***************************************************************************************************
--********* SECUENCIAS CON VALOR INICIAL FIJO
--***************************************************************************************************
--***************************************************************************************************
-------------------------------------------------------------------------------------
--SESTUDI
-------------------------------------------------------------------------------------
   vsecuencia := 'SESTUDI';
   vinicial := '500000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SSOLICIT_CERTIF
-------------------------------------------------------------------------------------
   vsecuencia := 'SSOLICIT_CERTIF';

   SELECT NVL(MAX(nsolici) + 1, 1)
     INTO vinicial
     FROM estseguros;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SSOLICIT
-------------------------------------------------------------------------------------
   vsecuencia := 'SSOLICIT';

   SELECT NVL(MAX(nsolici) + 1, 500000)
     INTO vinicial
     FROM estseguros;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_01
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_01';
   vinicial := '100000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_02
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_02';
   vinicial := '200000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_03
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_03';
   vinicial := '300000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_04
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_04';
   vinicial := '400000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_05
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_05';
   vinicial := '500000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_06
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_06';
   vinicial := '600000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_07
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_07';
   vinicial := '700000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_08
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_08';
   vinicial := '800000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_09
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_09';
   vinicial := '900000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_EMPRESA
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_' || LPAD(vcempres, 2, '00');
   vinicial := RPAD(vcempres, 9, '0');
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_ALN_01
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_ALN_01';
   vinicial := '100000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_ALN_02
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_ALN_02';
   vinicial := '200000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_ALN_03
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_ALN_03';
   vinicial := '300000000';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQ_CONT_ALN_04
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQ_CONT_ALN_04';
   vinicial := '400000000';
   p_ini_sec(vsecuencia, vinicial);
--Añadido
-------------------------------------------------------------------------------------
--SHISCON
-------------------------------------------------------------------------------------
   vsecuencia := 'SHISCON';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCESREA
-------------------------------------------------------------------------------------
   vsecuencia := 'SCESREA';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SHISDETR
-------------------------------------------------------------------------------------
   vsecuencia := 'SHISDETR';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SHISDIR
-------------------------------------------------------------------------------------
   vsecuencia := 'SHISDIR';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SHISMED
-------------------------------------------------------------------------------------
   vsecuencia := 'SHISMED';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SHISPER
-------------------------------------------------------------------------------------
   vsecuencia := 'SHISPER';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SHISREC
-------------------------------------------------------------------------------------
   vsecuencia := 'SHISREC';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SHISTAUT
-------------------------------------------------------------------------------------
   vsecuencia := 'SHISTAUT';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SHISVIN
-------------------------------------------------------------------------------------
   vsecuencia := 'SHISVIN';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--STABERROR
-------------------------------------------------------------------------------------
   vsecuencia := 'STABERROR';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEXCLUS
-------------------------------------------------------------------------------------
   vsecuencia := 'SEXCLUS';

   SELECT NVL(MAX(scesrea) + 1, 1)
     INTO vinicial
     FROM cesionesrea;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SFACULT
-------------------------------------------------------------------------------------
   vsecuencia := 'SFACULT';

   SELECT NVL(MAX(sfacult) + 1, 1)
     INTO vinicial
     FROM cuafacul;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SREAEMI
-------------------------------------------------------------------------------------
   vsecuencia := 'SREAEMI';

   SELECT NVL(MAX(sreaemi) + 1, 1)
     INTO vinicial
     FROM reasegemi;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SREAEMI_TMP
-------------------------------------------------------------------------------------
   vsecuencia := 'SREAEMI_TMP';

   SELECT NVL(MAX(sreaemi) + 1, 1)
     INTO vinicial
     FROM tmp_adm_reasegemi;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SDEVOLU
-------------------------------------------------------------------------------------
   vsecuencia := 'SDEVOLU';

   SELECT NVL(MAX(sdevolu) + 1, 1)
     INTO vinicial
     FROM devbanrecibos;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQDOCU
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQDOCU';

   SELECT NVL(MAX(seqdocu) + 1, 1)
     INTO vinicial
     FROM docrequerida;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SEQPAGO
-------------------------------------------------------------------------------------
   vsecuencia := 'SEQPAGO';

   SELECT NVL(MAX(spago) + 1, 1)
     INTO vinicial
     FROM pagoscomisiones;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SGESTIO
-------------------------------------------------------------------------------------
   vsecuencia := 'SGESTIO';

   SELECT NVL(MAX(sgestio) + 1, 1)
     INTO vinicial
     FROM sin_tramita_gestion;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SINTBATCH
-------------------------------------------------------------------------------------
   vsecuencia := 'SINTBATCH';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--S_COBFALL_DGS
-------------------------------------------------------------------------------------
   vsecuencia := 'S_COBFALL_DGS';

   SELECT NVL(MAX(s_cobfall_dgs) + 1, 1)
     INTO vinicial
     FROM envio_cobfall_dgs;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--S_FSTML_DATOS
-------------------------------------------------------------------------------------
   vsecuencia := 'S_FSTML_DATOS';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--S_INTERFASE
-------------------------------------------------------------------------------------
   vsecuencia := 'S_INTERFASE';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--S_PROCES_INT
-------------------------------------------------------------------------------------
   vsecuencia := 'S_PROCES_INT';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SINTERF
-------------------------------------------------------------------------------------
   vsecuencia := 'SINTERF';

   SELECT NVL(MAX(sinterf) + 1, 1)
     INTO vinicial
     FROM int_mensajes;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SASIGGES
-------------------------------------------------------------------------------------
   vsecuencia := 'SASIGGES';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCAGRCTA
-------------------------------------------------------------------------------------
   vsecuencia := 'SCAGRCTA';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SCARAGR
-------------------------------------------------------------------------------------
   vsecuencia := 'SCARAGR';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SFISCAB
-------------------------------------------------------------------------------------
   vsecuencia := 'SFISCAB';

   SELECT NVL(MAX(sfiscab) + 1, 1)
     INTO vinicial
     FROM fis_cabcierre;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SFISDCO
-------------------------------------------------------------------------------------
   vsecuencia := 'SFISDCO';

   SELECT NVL(MAX(sfisdco) + 1, 1)
     INTO vinicial
     FROM fis_detcierrecobro;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SFISDPA
-------------------------------------------------------------------------------------
   vsecuencia := 'SFISDPA';

   SELECT NVL(MAX(sfisdpa) + 1, 1)
     INTO vinicial
     FROM fis_detcierrepago;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SGESCARTA
-------------------------------------------------------------------------------------
   vsecuencia := 'SGESCARTA';

   SELECT NVL(MAX(sgescarta) + 1, 1)
     INTO vinicial
     FROM gescartas;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SINFORME
-------------------------------------------------------------------------------------
   vsecuencia := 'SINFORME';

   SELECT NVL(MAX(sinforme) + 1, 1)
     INTO vinicial
     FROM informes;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SLOGACT
-------------------------------------------------------------------------------------
   vsecuencia := 'SLOGACT';

   SELECT NVL(MAX(slogact) + 1, 1)
     INTO vinicial
     FROM log_actividad;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SLOGCONSUL
-------------------------------------------------------------------------------------
   vsecuencia := 'SLOGCONSUL';

   SELECT NVL(MAX(slogconsul) + 1, 1)
     INTO vinicial
     FROM log_consultas;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SMEDPAG
-------------------------------------------------------------------------------------
   vsecuencia := 'SMEDPAG';

   SELECT NVL(MAX(smedpag) + 1, 1)
     INTO vinicial
     FROM medpago;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SPRESTAPLAN
-------------------------------------------------------------------------------------
   vsecuencia := 'SPRESTAPLAN';

   SELECT NVL(MAX(sprestaplan) + 1, 1)
     INTO vinicial
     FROM prestaplan;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SREMESES
-------------------------------------------------------------------------------------
   vsecuencia := 'SREMESES';

   SELECT NVL(MAX(sremsesion) + 1, 1)
     INTO vinicial
     FROM remesas;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SSIMULA
-------------------------------------------------------------------------------------
   vsecuencia := 'SSIMULA';

   SELECT NVL(MAX(ssimula) + 1, 1)
     INTO vinicial
     FROM simulaestadist;

   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--SSN_DOCUSEG
-------------------------------------------------------------------------------------
--   vsecuencia := 'SSN_DOCUSEG';
--   vinicial := '1';
--   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--ST234OUT
-------------------------------------------------------------------------------------
   vsecuencia := 'ST234OUT';
   vinicial := '1';
   p_ini_sec(vsecuencia, vinicial);
-------------------------------------------------------------------------------------
--STRAS
-------------------------------------------------------------------------------------
   vsecuencia := 'STRAS';

   SELECT NVL(MAX(stras) + 1, 1)
     INTO vinicial
     FROM trasplainout;

   p_ini_sec(vsecuencia, vinicial);

-------------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------------
--vsecuencia:='';
--vinicial:='';
--P_INI_SEC(vsecuencia,vinicial);

   --***************************************************************************************************
--***************************************************************************************************
--********* CONTADORES
--***************************************************************************************************
--***************************************************************************************************
-------------------------------------------------------------------------------------
--01 Siniestros - 01||ramo
-------------------------------------------------------------------------------------
   BEGIN
      FOR r_co IN (SELECT c.ccontad
                     FROM contadores c
                    WHERE SUBSTR(c.ccontad, 1, 2) = '01'
                      AND TO_NUMBER(SUBSTR(c.ccontad, 3)) NOT IN(SELECT r.cramo
                                                                   FROM codiram r
                                                                  WHERE r.cempres = vcempres)) LOOP
         DELETE FROM contadores
               WHERE ccontad = r_co.ccontad;
      END LOOP;

      FOR r_ram IN (SELECT cramo
                      FROM codiram
                     WHERE cempres = vcempres) LOOP
         BEGIN
            SELECT NVL(MAX(nsinies) + 1, 1)
              INTO vmaxcont
              FROM siniestros si, seguros s
             WHERE si.sseguro = s.sseguro
               AND s.cramo = r_ram.cramo;
         EXCEPTION
            WHEN OTHERS THEN
               DBMS_OUTPUT.put_line('Error 1 contador siniestros ' || SQLERRM);
         END;

         BEGIN
            INSERT INTO contadores
                        (ccontad, ncontad)
                 VALUES ('01' || r_ram.cramo, vmaxcont);
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
               UPDATE contadores
                  SET ncontad = vmaxcont
                WHERE ccontad = '01' || r_ram.cramo;
         END;
      END LOOP;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.put_line('Error 2 contador siniestros ' || SQLERRM);
   END;

-------------------------------------------------------------------------------------
--02 Pólizas   -  02||ramo
-------------------------------------------------------------------------------------
   BEGIN
      FOR r_co IN (SELECT c.ccontad
                     FROM contadores c
                    WHERE SUBSTR(c.ccontad, 1, 2) = '02'
                      AND TO_NUMBER(SUBSTR(c.ccontad, 3)) NOT IN(SELECT r.cramo
                                                                   FROM codiram r
                                                                  WHERE r.cempres = vcempres)) LOOP
         DELETE FROM contadores
               WHERE ccontad = r_co.ccontad;
      END LOOP;

      FOR r_ram IN (SELECT cramo
                      FROM codiram
                     WHERE cempres = vcempres) LOOP
         BEGIN
            SELECT NVL(TO_NUMBER(SUBSTR(LPAD(TO_CHAR(MAX(npoliza) + 1), 8, '0'), 3)), 1)
              INTO vmaxcont
              FROM seguros s
             WHERE cramo = r_ram.cramo;
         --vmaxcont:=TO_NUMBER(SUBSTR(LPAD(TO_CHAR(vmaxcont),8,'0'),3);
         EXCEPTION
            WHEN OTHERS THEN
               DBMS_OUTPUT.put_line('Error 1 contador pólizas ' || SQLERRM);
         END;

         BEGIN
            INSERT INTO contadores
                        (ccontad, ncontad)
                 VALUES ('02' || r_ram.cramo, vmaxcont);
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
               UPDATE contadores
                  SET ncontad = vmaxcont
                WHERE ccontad = '02' || r_ram.cramo;
         END;
      END LOOP;

      BEGIN
         SELECT NVL(TO_NUMBER(SUBSTR(LPAD(TO_CHAR(MAX(npoliza) + 1), 8, '0'), 3)), 1)
           INTO vmaxcont
           FROM seguros s;
      --vmaxcont:=TO_NUMBER(SUBSTR(LPAD(TO_CHAR(vmaxcont),8,'0'),3);
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('Error 3 contador pólizas ' || SQLERRM);
      END;

      BEGIN
         INSERT INTO contadores
                     (ccontad, ncontad)
              VALUES ('0200', vmaxcont);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
            UPDATE contadores
               SET ncontad = vmaxcont
             WHERE ccontad = '0200';
      END;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.put_line('Error 2 contador pólizas ' || SQLERRM);
   END;

-------------------------------------------------------------------------------------
--04 Recibos pruebas -  04||empresa
-------------------------------------------------------------------------------------
   BEGIN
      FOR r_co IN (SELECT c.ccontad
                     FROM contadores c
                    WHERE SUBSTR(c.ccontad, 1, 2) = '04'
                      AND SUBSTR(c.ccontad, 3) <> LPAD(vcempres, 2, '0')) LOOP
         DELETE FROM contadores
               WHERE ccontad = r_co.ccontad;
      END LOOP;

      BEGIN
         SELECT NVL(TO_NUMBER(SUBSTR(LPAD(TO_CHAR(MAX(nrecibo) + 1), 8, '0'), 3)), 1)
           INTO vmaxcont
           FROM recibos r;
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('Error 1 contador recibos pruebas ' || SQLERRM);
      END;

      BEGIN
         INSERT INTO contadores
                     (ccontad, ncontad)
              VALUES ('04' || LPAD(vcempres, 2, '0'), vmaxcont);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
            UPDATE contadores
               SET ncontad = vmaxcont
             WHERE ccontad = '04' || LPAD(vcempres, 2, '0');
      END;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.put_line('Error 2 contador recibos pruebas ' || SQLERRM);
   END;
END;
/