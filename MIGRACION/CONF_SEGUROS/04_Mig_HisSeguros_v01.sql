--04_Mig_HisSeguros_v01.sql
-- Solo en caso de NO cargarse en la ejecución del proceso de MIG_seguros
DECLARE
/***************************************************************************
      FUNCTION f_act_hisseg
      Funci¿n que inserta en la tabla historicoseguros con la
      informaci¿n previa a una modificaci¿n de la tabla seguros.
         param in  pmig_fk2:     Identificador de la PK de la tabla MIG_MOVSEGURO.
         param in  psseguro:     Identificador de la p¿liza.
         param in  pnmovimi:     N¿mero de movimiento de la p¿liza.
         param in  ptablas:      EST, POL por defecto es POL   -- 23289/120321 - ECP - 03/09/2012
         return:                0-OK, <>0-Error
   ***************************************************************************/
      num_err NUMBER := 0;
      vdummy NUMBER := 0;
   v_error BOOLEAN := FALSE;
   FUNCTION f_act_hisseg_local(
      pmig_fk2 IN VARCHAR2,
      psseguro IN NUMBER,
      pnmovimi IN NUMBER,
      ptablas IN VARCHAR2 DEFAULT 'POL')
      RETURN NUMBER IS
      lerror         NUMBER := 0;
      xf1paren       DATE := NULL;
      xfcarult       DATE := NULL;
      xttexto        VARCHAR2(50);
      xndurper       NUMBER;
      xfrevisio      DATE;
      xcgasges       NUMBER;
      xcgasred       NUMBER;
      xcmodinv       NUMBER;
      xfrevant       DATE;
      xfefecto_mov   DATE;
      v_historicoseguros historicoseguros%ROWTYPE;
      -- BUG 0022839 - FAL - 24/07/2012
      x_ctipcol      seguroscol.ctipcol%TYPE;
      x_ctipcob      seguroscol.ctipcob%TYPE;
      x_ctipvig      seguroscol.ctipvig%TYPE;
      x_recpor       seguroscol.recpor%TYPE;
      x_cagrupa      seguroscol.cagrupa%TYPE;
      x_prorrexa     seguroscol.prorrexa%TYPE;
      x_cmodalid     seguroscol.cmodalid%TYPE;
      x_fcorte       seguroscol.fcorte%TYPE;
      x_ffactura     seguroscol.ffactura%TYPE;
      -- 23074 - I - JLB - 30/07/2012
      x_cagastexp    seguroscol.cagastexp%TYPE;
      x_cperiogast   seguroscol.cperiogast%TYPE;
      x_iimporgast   seguroscol.iimporgast%TYPE;
      v_nmovimi      NUMBER;
      --
      CURSOR lc_mig_historicoseguros IS
      SELECT h.*
        FROM mig_movseguro ms, mig_historicoseguros h
       WHERE 1 = 1
         AND h.mig_fk2 = pmig_fk2
         AND ms.mig_pk = h.mig_fk2
         AND ms.sseguro <> 0  --movimiento del seguro debe existir
         ; --tomador del seguro debe existir
      --
      /*SELECT a.*
      FROM MIG_HISTORICOSEGUROS a, mig_movseguro s      
     WHERE 1 = 1
        AND a.mig_fk2 = '101010100GU1282421'
        AND a.mig_fk2 = s.mig_pk;*/
      --
   BEGIN
   --
   FOR h IN lc_mig_historicoseguros
   LOOP
     --
      --dbms_output.put_line('Entra '||h.mig_pk);
      --
      BEGIN
         -- 23289/120321 - ECP - 03/09/2012 Inicio
          BEGIN
             SELECT f1paren
               INTO xf1paren
               FROM seguros_ren
              WHERE sseguro = psseguro;
          EXCEPTION
             WHEN OTHERS THEN
                xf1paren := NULL;
          END;
          --
          BEGIN
             SELECT fcarult
               INTO xfcarult
               FROM seguros_assp
              WHERE sseguro = psseguro;
          EXCEPTION
             WHEN OTHERS THEN
                xfcarult := NULL;
          END;
          --
         SELECT NVL(nmovimi, pnmovimi),
                fefecto   --Si no encontramos nada, que haga lo mismo que hasta ahora
           INTO v_nmovimi,
                xfefecto_mov
           FROM movseguro
          WHERE sseguro = psseguro
            AND nmovimi = (SELECT MAX(nmovimi)
                             FROM movseguro
                            WHERE sseguro = psseguro
                              AND cmovseg NOT IN(52)
                              AND nmovimi <= pnmovimi);
         --
         -- 23289/120321 - ECP - 03/09/2012 Fin
         BEGIN
            SELECT ttexto
              INTO xttexto
              FROM bloqueoseg
             WHERE sseguro = psseguro
               AND nmovimi = v_nmovimi
               AND finicio = (SELECT MAX(finicio)
                                FROM bloqueoseg
                               WHERE sseguro = psseguro
                                 AND nmovimi = v_nmovimi);
         EXCEPTION
            WHEN OTHERS THEN
               xttexto := NULL;
         END;
         --
         --modificaci¿ : XCG 05-01-2007 afegim el camp ndurper
         -- 23289/120321 - ECP - 03/09/2012 Inicio
         --
          BEGIN
             SELECT ndurper, frevisio, frevant
               INTO xndurper, xfrevisio, xfrevant
               FROM seguros_aho
              WHERE sseguro = psseguro;
          EXCEPTION
             WHEN OTHERS THEN
                xndurper := NULL;
          END;
         --
         -- 23289/120321 - ECP - 03/09/2012 Fin
         --modificaci¿ : RSC 17-09-2007 afegim els camps de despeses de Unit Linked
         -- 23289/120321 - ECP - 03/09/2012 Inicio
         --
            BEGIN
               SELECT cgasges, cgasred
                 INTO xcgasges, xcgasred
                 FROM seguros_ulk
                WHERE sseguro = psseguro;
            EXCEPTION
               WHEN OTHERS THEN
                  xcgasges := NULL;
                  xcgasred := NULL;
            END;
         --
         -- 23289/120321 - ECP - 03/09/2012 Fin
         --modificaci¿ : RSC 20-09-2007 afegim el camp de model d'inversi¿ de Unit Linked
         -- 23289/120321 - ECP - 03/09/2012 Inicio
         --
            BEGIN
               SELECT cmodinv
                 INTO xcmodinv
                 FROM seguros_ulk
                WHERE sseguro = psseguro;
            EXCEPTION
               WHEN OTHERS THEN
                  xcmodinv := NULL;
            END;
         --
         -- 23289/120321 - ECP - 03/09/2012  Fin

         -- BUG 0022839 - FAL - 24/07/2012
         BEGIN
            SELECT ctipcol, ctipcob, ctipvig, recpor, cagrupa, prorrexa,
                   cmodalid, fcorte, ffactura   -- BUG 23074 - JLB - 30/07/2012
                                             ,
                   cagastexp, cperiogast, iimporgast
              -- BUG -F - 23074
            INTO   x_ctipcol, x_ctipcob, x_ctipvig, x_recpor, x_cagrupa, x_prorrexa,
                   x_cmodalid, x_fcorte, x_ffactura   -- BUG 23074 - JLB - 30/07/2012
                                                   ,
                   x_cagastexp, x_cperiogast, x_iimporgast
              -- BUG - F - 23074
            FROM   seguroscol
             WHERE sseguro = psseguro;
         EXCEPTION
            WHEN OTHERS THEN
               x_ctipcol := NULL;
               x_ctipcob := NULL;
               x_ctipvig := NULL;
               x_recpor := NULL;
               x_cagrupa := NULL;
               x_prorrexa := NULL;
               x_cmodalid := NULL;
               x_fcorte := NULL;
               x_ffactura := NULL;
               -- BUG 23074 - JLB - 30/07/2012
               x_cagastexp := NULL;
               x_cperiogast := NULL;
               x_iimporgast := NULL;
         -- BUG -F - 23074
         END;
         --
         -- FI BUG 0022839
         SELECT sseguro,
                v_nmovimi,
                f_sysdate,
                NVL(h.casegur, casegur),
                NVL(h.cagente, cagente),
                NVL(h.nsuplem, nsuplem),
                NVL(h.fefecto, fefecto),
                NVL(h.creafac, creafac),
                ctarman,
                cobjase,
                ctipreb,
                NVL(h.cactivi, cactivi),
                NVL(h.ccobban, ccobban),
                NVL(h.ctipcoa, ctipcoa),
                NVL(h.ctiprea, ctiprea),
                crecman,
                creccob,
                NVL(h.ctipcom, ctipcom),
                NVL(h.fvencim, fvencim),
                NVL(h.femisio, femisio),
                NVL(h.fanulac, fanulac),
                fcancel,
                NVL(h.csituac, csituac),
                NVL(h.cbancar, cbancar),
                ctipcol,
                NVL(h.fcarant, fcarant),
                NVL(h.fcarpro, fcarpro),
                NVL(h.fcaranu, fcaranu),
                cduraci,
                NVL(h.nduraci, nduraci),
                --nanuali
                NVL(TRUNC((xfefecto_mov - fefecto) / 365), 0) + 1 nanuali,
                NVL(h.iprianu, iprianu),
                NVL(h.cidioma, cidioma),
                nfracci,
                NVL(h.cforpag, cforpag),
                pdtoord,
                nrenova,
                NVL(h.crecfra, crecfra),
                tasegur,
                NVL(h.creteni, creteni),
                NVL(h.ndurcob, ndurcob),
                NVL(h.sciacoa, sciacoa),
                NVL(h.pparcoa, pparcoa),
                NVL(h.npolcoa, npolcoa),
                NVL(h.nsupcoa, nsupcoa),
                tnatrie,
                NVL(h.pdtocom, pdtocom),
                NVL(h.prevali, prevali),
                NVL(h.irevali, irevali),
                NVL(h.ncuacoa, ncuacoa),
                nedamed,
                NVL(h.crevali, crevali),
                NVL(h.cempres, cempres),
                cagrpro,
                nsolici,
                xf1paren,
                xfcarult,
                xttexto,
                NVL(h.ccompani, ccompani),
                NULL,
                NULL,
                xndurper,
                xfrevisio,
                xcgasges,
                xcgasred,
                xcmodinv,
                NVL(h.ctipban, ctipban),
                NVL(h.ctipcob, ctipcob),
                xfrevant,
                sprodtar,
                ncuotar,
                ctipretr,
                cindrevfran,
                precarg,
                pdtotec,
                preccom,
                --
                x_ctipcol,
                x_ctipcob,
                x_ctipvig,
                x_recpor,
                x_cagrupa,
                x_prorrexa,
                x_cmodalid,
                x_cagastexp,
                x_cperiogast,
                x_iimporgast,
                x_fcorte,
                x_ffactura,
                frenova,
                NVL(h.fefeplazo, fefeplazo),
                NVL(h.fvencplazo, fvencplazo)
                -- fin rllf 10/05/2016
           INTO v_historicoseguros
           FROM seguros
          WHERE sseguro = psseguro;

         -- BUG 0020761 - 03/01/2012 - JMF: afegir ncuotar
         INSERT INTO historicoseguros
              VALUES v_historicoseguros;              
         --
         UPDATE mig_historicoseguros
            SET cestmig = 2
          WHERE mig_pk = h.mig_pk;
         --
      EXCEPTION
         WHEN OTHERS THEN
         dbms_output.put_line('ERROR:' || SQLERRM); 
            p_tab_error(f_sysdate, f_user, '{f_act_hisseg}' || psseguro, 1,
                        psseguro || pnmovimi || xf1paren || xfcarult || xttexto, SQLERRM);
            -- Error a l'insertar a la taula historicoseguros
            lerror := 109383;
      END;
     --
   END LOOP;
   --
   RETURN lerror;
   --
   END f_act_hisseg_local;
   --   
   
   /***************************************************************************
      FUNCTION f_ins_mig_logs_axis
      Funci¿n para insertar registros en la tabla de Errores y Warnings del
      proceso de migraci¿n entre las tablas MIG y AXIS
         param in  pncarga:  N¿mero de carga
         param in  pmig_pk:  valor primary key de la tabla MIG
         param in  ptipo:    Tipo Traza (E-Error,W-Warning,I-Informativo)
         param in  ptexto:   Texto de la traza
         return:             C¿digo error
   ***************************************************************************/
   FUNCTION f_ins_mig_logs_axis(
      pncarga IN NUMBER,
      pmig_pk IN VARCHAR2,
      ptipo IN VARCHAR2,
      ptexto IN VARCHAR2)
      RETURN NUMBER IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      v_seq          NUMBER;
   BEGIN
      SELECT sseqlogmig2.NEXTVAL
        INTO v_seq
        FROM DUAL;

      INSERT INTO mig_logs_axis
                  (ncarga, seqlog, fecha, mig_pk, tipo, incid)
           VALUES (pncarga, v_seq, f_sysdate, pmig_pk, ptipo, ptexto);

      COMMIT;
      RETURN 0;
   EXCEPTION
      WHEN OTHERS THEN
         RETURN SQLCODE;
   END f_ins_mig_logs_axis;
BEGIN
  --
  --
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD'))
    INTO vdummy
    FROM dual;
  --
  FOR x IN (SELECT ms.mig_pk, s.ncarga, s.sseguro, ms.nmovimi
            --SELECT COUNT(*)
              FROM mig_seguros s, mig_movseguro ms, mig_historicoseguros h --307018, 271821 tienen <> 0
             WHERE s.sseguro <> 0
               AND ms.mig_fk = s.mig_pk
               AND ms.nmovimi <> 0
               AND h.mig_fk2 = ms.mig_pk
               AND h.cestmig = 1
            )
  LOOP
    --
    IF x.nmovimi > 1 THEN
      --
      num_err := f_act_hisseg_local(x.mig_pk, x.sseguro, x.nmovimi - 1);
      --
      dbms_output.put_line('num_err: '||num_err);          
      IF num_err <> 0 THEN
         num_err := f_ins_mig_logs_axis(x.ncarga, x.mig_pk, 'E',
                                        'Error(f_act_hisseg):' || num_err);
         v_error := TRUE;
         ROLLBACK;
      ELSE
         INSERT INTO mig_pk_mig_axis
              VALUES (x.mig_pk, x.ncarga, 12, 2,
                      x.mig_pk || '|' || x.sseguro || '|' || TO_CHAR(x.nmovimi - 1));
         --
      END IF;
      --
    END IF;
    --
  END LOOP;
--
END;
--
SELECT * FROM mig_pk_mig_axis WHERE pkmig = '118010100GU0391751' AND ncarga = 17417;
--
DELETE FROM mig_logs_axis WHERE ncarga = 17417 AND TRUNC(fecha)=TRUNC(SYSDATE);
SELECT * FROM mig_logs_axis WHERE ncarga = 17417 AND TRUNC(fecha)=TRUNC(SYSDATE);
SELECT * FROM mig_historicoseguros WHERE cestmig != 1;
SELECT * FROM tab_error WHERE TRUNC(ferror) = TRUNC(SYSDATE);
