CREATE OR REPLACE PROCEDURE csi_gen_cesiones_rea_mig_v2(ppoliza IN NUMBER) IS

  v_context NUMBER;
  vnliqmen  NUMBER;
  vnliqlin  NUMBER;
  vccobban  recibos.ccobban%TYPE;
  vresul    NUMBER;
  vmensaje  t_iax_mensajes;

  FUNCTION f_generar_cesiones_migradas RETURN NUMBER IS

    pcempres    NUMBER := 17;
    pfefecto    DATE := TO_DATE('01011983', 'ddmmyyyy');
    pcdetrea    NUMBER := 0;
    pctanca     NUMBER := 0;
    pultmov     NUMBER := 1; --marcamos a 1 para que vaya por el ultimo movimiento de la poliza
    puser       VARCHAR2(100) := f_user;
    psproduc    NUMBER := NULL;
    b_error     BOOLEAN;
    b_warning   BOOLEAN;
    v_estadomig mig_cargas.estorg%TYPE;
    v_nanuali   seguros.nanuali%TYPE;
    v_ret       NUMBER;

    CURSOR c_pol IS
      SELECT sseguro,
             ctiprea,
             fvto,
             sproduc,
             cforpag,
             fefecto,
             nrenova,
             nmovimi,
             cmotmov,
             fmovimi,
             cmovseg,
             fefecmov,
             tipo,
             cforamor,
             ctipseg,
             fdatagen
        FROM (SELECT s.sseguro,
                     s.ctiprea,
                     DECODE(s.fcaranu, NULL, s.fvencim, s.fcaranu) fvto,
                     s.sproduc,
                     s.cforpag,
                     s.fefecto,
                     s.nrenova,
                     m.nmovimi,
                     m.cmotmov,
                     m.fmovimi,
                     m.cmovseg,
                     m.fefecto fefecmov,
                     'E' tipo,
                     NULL cforamor,
                     s.ctipseg,
                     nvl(m.femisio, m.fmovimi) fdatagen
                FROM seguros s, movseguro m
               WHERE m.fefecto >= pfefecto
                 AND s.cempres = pcempres
                 AND s.csituac < 7
                 AND s.sseguro = m.sseguro
                 AND m.femisio IS NOT NULL -- Los movimientos estan emitidos
                 AND s.csituac NOT IN (4)
                 AND DECODE(s.fcaranu, NULL, s.fvencim, s.fcaranu) >=
                     m.fefecto
                 AND (psproduc IS NULL OR s.sproduc = psproduc)
                 AND pac_anulacion.f_anulada_al_emitir(s.sseguro) = 0
                 AND NOT EXISTS
               (SELECT sseguro
                        FROM cesionesrea ce
                       WHERE ce.sseguro = s.sseguro
                         AND DECODE(ce.cgenera,
                                    6,
                                    0,
                                    (SELECT MAX(a.nmovimi)
                                       FROM cesionesrea a
                                      WHERE a.sseguro = ce.sseguro
                                        AND a.nmovigen = ce.nmovigen)) =
                             DECODE(m.cmovseg, 3, 0, m.nmovimi)
                         AND ce.fefecto = m.fefecto)
                 AND EXISTS
               (SELECT cgenrec
                        FROM codimotmov c
                       WHERE c.cmotmov = m.cmotmov
                          AND (c.cgenrec = 1 OR c.cmovseg IN (3, 4) OR m.cmotmov IN 406)) -- CCB se adiciona el tipo de movimiento 406, para que genere cesion si la poliza existe este movimiento
                 AND EXISTS
               (SELECT nmovimi
                        FROM garanseg g
                       WHERE g.sseguro = m.sseguro
                         AND g.nmovimi = DECODE(m.cmovseg, 3, 1, m.nmovimi))
                 AND m.nmovimi >= (SELECT NVL(MIN(nmovimi), 0)
                                     FROM movseguro m2
                                    WHERE m2.sseguro = m.sseguro
                                      AND m2.cmovseg IN (0, 2))
                 AND s.npoliza = ppoliza) c
       ORDER BY GREATEST(NVL((SELECT MAX(m2.femisio)
                               FROM movseguro m2
                              WHERE m2.sseguro = c.sseguro
                                AND m2.nmovimi < c.nmovimi),
                             TRUNC(c.fmovimi)),
                         c.fdatagen),
                c.sseguro,
                c.nmovimi;

    CURSOR c_ries(wsseguro NUMBER) IS
      SELECT nriesgo
        FROM riesgos
       WHERE sseguro = wsseguro
         AND fanulac IS NULL;
    i            NUMBER := 0;
    lnmovi_vig   NUMBER;
    ltexto       VARCHAR2(120);
    nprolin      NUMBER;
    lmotiu       NUMBER;
    lfini        DATE;
    lffi         DATE;
    lsfacult     NUMBER;
    num_err      NUMBER := 0;
    lorigen      NUMBER;
    ldetces      NUMBER;
    lsproces     NUMBER;
    lcforamor    NUMBER;
    lmeses       NUMBER;
    dd           VARCHAR2(2);
    lfaux        DATE;
    ddmm         VARCHAR2(4);
    l_c          NUMBER;
    cumulo       NUMBER;
    ldatafi      DATE;
    amortit      pk_cuadro_amortizacion.t_amortizacion;
    pimporte     NUMBER;
    lfefecto_ini DATE;
    wfcontab     DATE := TO_DATE('01/01/1900', 'dd/mm/yyyy');
    pncarga      mig_cargas_tab_mig.ncarga%TYPE;
    v_maxmov     NUMBER;
    -- ctiprea = V.Fixe 60
    -- ( El ctiprea = 2 (No es reassegura) es mira tamb? desde la funci?
    -- f_buscatrrea , per? si ho mirem aqu? ens estalviem accessos)
    -- 0 = Normal
    -- 1 = Mai facultatiu
    -- 2 = No es reassegura
    -- 3 = No calculi facultatiu opcionalment(en aquesta emissio),
    -- despr?s es posa a 0 = Normal
    -- 5 = No s'aturi encara que existeixi el quadre de facultatiu (acceptat)
    ------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------
    ------------------------------------------------------------------------------
    FUNCTION f_next_carga RETURN NUMBER IS
      v_seq NUMBER;
    BEGIN
      SELECT sncarga.NEXTVAL INTO v_seq FROM DUAL;
      RETURN v_seq;
    END f_next_carga;

    FUNCTION f_ins_mig_logs_axis(pncarga IN NUMBER,
                                 pmig_pk IN VARCHAR2,
                                 ptipo   IN VARCHAR2,
                                 ptexto  IN VARCHAR2) RETURN NUMBER IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      v_seq NUMBER;
    BEGIN
      SELECT sseqlogmig2.NEXTVAL INTO v_seq FROM DUAL;

      INSERT INTO mig_logs_axis
        (ncarga, seqlog, fecha, mig_pk, tipo, incid)
      VALUES
        (pncarga, v_seq, f_sysdate, pmig_pk, ptipo, ptexto);
      COMMIT;
      RETURN 0;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN SQLCODE;
    END f_ins_mig_logs_axis;

    FUNCTION f_num_proces(puser VARCHAR2, psproces IN OUT NUMBER)
      RETURN NUMBER IS
      num_err NUMBER := 0;
    BEGIN
      num_err := f_procesini(puser,
                             pcempres,
                             'MIGRACIO',
                             'Generaci? de cessions',
                             psproces);
      RETURN num_err;
    END f_num_proces;

    PROCEDURE p_act_migcargastabmig(p_car IN NUMBER,
                                    p_tab IN NUMBER,
                                    p_org IN VARCHAR2,
                                    p_des IN VARCHAR2,
                                    p_est IN VARCHAR2) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

      UPDATE mig_cargas_tab_mig
         SET ffindes = f_sysdate, estdes = p_est
       WHERE ncarga = p_car
         AND ntab = p_tab
         AND tab_org = p_org
         AND tab_des = p_des;

      COMMIT;

    END p_act_migcargastabmig;

    ------------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    PROCEDURE mig_ces_rec(psproces IN NUMBER,
                          psseguro IN NUMBER,
                          pnmovimi IN NUMBER) IS
      CURSOR c_reb(wsseguro NUMBER, wnmovimi NUMBER) IS
        SELECT DISTINCT c.sseguro,
                        r.nrecibo,
                        r.fefecto,
                        r.fvencim,
                        r.cforpag,
                        s.cramo,
                        s.cmodali,
                        s.ctipseg,
                        s.ccolect,
                        s.cactivi,
                        s.fcaranu,
                        s.fefecto fefepol
          FROM cesionesrea c, recibos r, seguros s
         WHERE r.sseguro = wsseguro
           AND r.nmovimi = wnmovimi
           AND c.sseguro = s.sseguro
           AND c.sseguro = r.sseguro
           AND c.sproces = psproces;
      CURSOR c_mov(wnrecibo NUMBER) IS
        SELECT *
          FROM movrecibo
         WHERE nrecibo = wnrecibo
           AND ((cestrec = 0 AND cestant = 0) OR cestrec = 2)
         ORDER BY fmovdia;
      lcprorra     NUMBER;
      lcmodulo     NUMBER;
      ldifdias     NUMBER;
      ldifdiasanu  NUMBER;
      ldifdias2    NUMBER;
      ldifdiasanu2 NUMBER;
      lfanyoprox   DATE;
      ldivisor2    NUMBER;
      ldivisor     NUMBER;
      lfacces      NUMBER;
      lffinany     DATE;
      lfiniany     DATE;
      num_err      NUMBER;
      ltexto       VARCHAR2(120);
    BEGIN
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Se abre el cursor c_reb: -psseguro'||psseguro||' - '||pnmovimi );
      FOR v_reb IN c_reb(psseguro, pnmovimi) LOOP
        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Se abre el cursor c_mov: -v_reb.nrecibo '||v_reb.nrecibo );
        FOR v_mov IN c_mov(v_reb.nrecibo) LOOP
          p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Se hace una validacion inical: v_mov.cestrec '||v_mov.cestrec );
          IF v_mov.cestrec = 0 THEN
            -- Emissi?
            -------------------------
            ------------------------
            BEGIN
              SELECT cprorra
                INTO lcprorra
                FROM productos
               WHERE cramo = v_reb.cramo
                 AND cmodali = v_reb.cmodali
                 AND ctipseg = v_reb.ctipseg
                 AND ccolect = v_reb.ccolect;
            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'lcprorra: '||lcprorra );

            lfanyoprox := ADD_MONTHS(v_reb.fefecto, 12);
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'lfanyoprox: '||lfanyoprox );
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'lfanyoprox: '||lfanyoprox );
            -- C?lculo de d?as
            IF lcprorra = 2 THEN
              -- Mod. 360
              lcmodulo := 3;
            ELSE
              -- Mod. 365
              lcmodulo := 1;
            END IF;
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'lcmodulo: '||lcmodulo );
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Se llama  a la funcion f_difdata: -v_reb.fefecto '||v_reb.fefecto
            ||' -v_reb.fvencim '||v_reb.fvencim||' -3 -3 -ldifdias '||ldifdias);
            num_err := f_difdata(v_reb.fefecto,
                                 v_reb.fvencim,
                                 3,
                                 3,
                                 ldifdias);
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Hubo un error en la funcion num_err: ' || num_err);
            IF num_err <> 0 THEN
              p_literal2(num_err, 1, ltexto);
              num_err := f_ins_mig_logs_axis(pncarga,
                                             v_reb.sseguro,
                                             'E',
                                             ltexto);
            END IF;

            BEGIN
              SELECT fefecto
                INTO lfiniany
                FROM movseguro
               WHERE sseguro = v_reb.sseguro
                 AND nmovimi =
                     (SELECT MAX(nmovimi)
                        FROM movseguro m
                       WHERE sseguro = v_reb.sseguro
                         AND EXISTS (SELECT cgenrec
                                FROM codimotmov c
                               WHERE c.cmotmov = m.cmotmov
                                 AND c.cgenrec = 1)
                         AND fefecto <= v_reb.fefecto);
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                lfiniany := v_reb.fefepol;
            END;

            BEGIN
              SELECT fefecto
                INTO lffinany
                FROM movseguro
               WHERE sseguro = v_reb.sseguro
                 AND nmovimi = (SELECT MIN(nmovimi)
                                  FROM movseguro
                                 WHERE sseguro = v_reb.sseguro
                                   AND cmovseg = 2
                                   AND fefecto > v_reb.fefecto);
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                lffinany := v_reb.fcaranu;
            END;

            lffinany := NVL(lffinany, v_reb.fvencim);
            num_err  := f_difdata(lfiniany, lffinany, 3, 3, ldifdiasanu);
            IF num_err <> 0 THEN
              p_literal2(num_err, 1, ltexto);
              num_err := f_ins_mig_logs_axis(pncarga,
                                             v_reb.sseguro,
                                             'E',
                                             ltexto);
            END IF;

            num_err := f_difdata(v_reb.fefecto,
                                 v_reb.fvencim,
                                 lcmodulo,
                                 3,
                                 ldifdias2);
            -- dias recibo
            IF num_err <> 0 THEN
              p_literal2(num_err, 1, ltexto);
              num_err := f_ins_mig_logs_axis(pncarga,
                                             v_reb.sseguro,
                                             'E',
                                             ltexto);
            END IF;

            num_err := f_difdata(lfiniany,
                                 lffinany,
                                 lcmodulo,
                                 3,
                                 ldifdiasanu2);
            -- dias venta
            IF num_err <> 0 THEN
              p_literal2(num_err, 1, ltexto);
              num_err := f_ins_mig_logs_axis(pncarga,
                                             v_reb.sseguro,
                                             'E',
                                             ltexto);
            END IF;

            num_err := f_difdata(v_reb.fefecto,
                                 lfanyoprox,
                                 lcmodulo,
                                 3,
                                 ldivisor2);
            -- divisor del m?dulo de suplementos para pagos anuales
            IF num_err <> 0 THEN
              p_literal2(num_err, 1, ltexto);
              num_err := f_ins_mig_logs_axis(pncarga,
                                             v_reb.sseguro,
                                             'E',
                                             ltexto);
            END IF;

            -- Els anys de trasp?s han de prorratejar com un any normal, ?s a dir a 365
            IF ldivisor2 = 366 THEN
              ldivisor2 := 365;
            END IF;

            num_err := f_difdata(v_reb.fefepol,
                                 v_reb.fvencim,
                                 lcmodulo,
                                 3,
                                 ldivisor);
            -- divisor del periodo para pago ?nico
            IF num_err <> 0 THEN
              p_literal2(num_err, 1, ltexto);
              num_err := f_ins_mig_logs_axis(pncarga,
                                             v_reb.sseguro,
                                             'E',
                                             ltexto);
            END IF;

            -- Calculem els factors a aplicar per prorratejar
            -- Tamb? el factor per la reasseguran?a = diesrebut/dies cessio
            IF lcprorra IN (1, 2) THEN
              -- Per dies
              IF v_reb.cforpag <> 0 THEN
                IF MOD(ldifdias, 30) = 0 THEN
                  -- No hi ha prorrata
                  lfacces := ldifdias / ldifdiasanu;
                ELSE
                  lfacces := ldifdias2 / ldifdiasanu2;
                END IF;

              ELSE
                lfacces := ldifdias2 / ldifdiasanu2;
              END IF;
            END IF;

            -------------------------
            ------------------------
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Se llama  a la funcion pac_cesionesrea.f_cessio_det: -psproces '||psproces
            ||' -v_reb.sseguro '||v_reb.sseguro||' -v_reb.nrecibo'|| v_reb.nrecibo ||' -v_reb.cactivi'|| v_reb.cactivi ||' -v_reb.cramo '||v_reb.cramo
            ||' -v_reb.cmodali '||v_reb.cmodali||' -v_reb.ctipseg '||v_reb.ctipseg||' -v_reb.ccolect '||v_reb.ccolect||' -v_reb.fefecto '||v_reb.fefecto 
            ||' -lfacces '||lfacces||' -1 -1 ');
            num_err := pac_cesionesrea.f_cessio_det(psproces,
                                                    v_reb.sseguro,
                                                    v_reb.nrecibo,
                                                    v_reb.cactivi,
                                                    v_reb.cramo,
                                                    v_reb.cmodali,
                                                    v_reb.ctipseg,
                                                    v_reb.ccolect,
                                                    v_reb.fefecto,
                                                    v_reb.fvencim,
                                                    lfacces,
                                                    1,
                                                    1);
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Hubo un error en la funcion pac_cesionesrea.f_cessio_det: ' || num_err);
            IF num_err = 0 THEN
              IF pctanca = 0 THEN
                BEGIN
                  UPDATE reasegemi
                     SET fcierre = wfcontab
                   WHERE sproces = psproces
                     AND fcierre IS NULL;
                EXCEPTION
                  WHEN OTHERS THEN
                    p_literal2(151144, 1, ltexto);
                    num_err := f_ins_mig_logs_axis(pncarga,
                                                   v_reb.sseguro,
                                                   'E',
                                                   ltexto || '-' || SQLERRM);
                END;

              ELSE
                BEGIN
                  UPDATE reasegemi
                     SET fgenera = fefecte
                   WHERE sproces = psproces
                     AND fcierre IS NULL;
                EXCEPTION
                  WHEN OTHERS THEN
                    p_literal2(151144, 1, ltexto);
                    num_err := f_ins_mig_logs_axis(pncarga,
                                                   v_reb.sseguro,
                                                   'E',
                                                   ltexto || '-' || SQLERRM);
                END;
              END IF;
            END IF;

          ELSIF v_mov.cestrec = 2 THEN
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'ELSIF v_mov.cestrec = 2 THEN');
            -- Anul.laci?
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Le llama a la funcion pac_cesionesrea.f_cesdet_anu: -v_reb.nrecibo ' || v_reb.nrecibo);
            num_err := pac_cesionesrea.f_cesdet_anu(v_reb.nrecibo);
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.mig_ces_rec', 'Hubo un error en la funcion pac_cesionesrea.f_cesdet_anu: ' || num_err);
            IF num_err = 0 THEN
              IF pctanca = 0 THEN
                BEGIN
                  UPDATE reasegemi
                     SET fcierre = wfcontab
                   WHERE nrecibo = v_reb.nrecibo
                     AND fcierre IS NULL;
                EXCEPTION
                  WHEN OTHERS THEN
                    p_literal2(151144, 1, ltexto);
                    num_err := f_ins_mig_logs_axis(pncarga,
                                                   v_reb.sseguro,
                                                   'E',
                                                   ltexto || '-' || SQLERRM);
                END;

              ELSE
                BEGIN
                  UPDATE reasegemi
                     SET fgenera = fefecte
                   WHERE sproces = psproces
                     AND fcierre IS NULL;
                EXCEPTION
                  WHEN OTHERS THEN
                    p_literal2(151144, 1, ltexto);
                    num_err := f_ins_mig_logs_axis(pncarga,
                                                   v_reb.sseguro,
                                                   'E',
                                                   ltexto || '-' || SQLERRM);
                END;
              END IF;
            END IF;

            IF num_err <> 0 THEN
              p_literal2(num_err, 1, ltexto);
              num_err := f_ins_mig_logs_axis(pncarga,
                                             v_reb.sseguro,
                                             'E',
                                             ltexto);
            END IF;
          END IF;
        END LOOP;
      END LOOP;
    END mig_ces_rec;

    ----------------------------------------------------------------------------
    ------------------------------------------------------------------------------
    PROCEDURE calcula_cessions_rea(psseguro IN NUMBER,
                                   pctiprea IN NUMBER,
                                   pdataini IN DATE,
                                   pdatafi  IN DATE,
                                   psproces IN NUMBER,
                                   pmoneda  IN NUMBER,
                                   pcidioma IN NUMBER) IS
      lnmovimi NUMBER;
      ltexto   VARCHAR2(100);
      nprolin  NUMBER;
      pfecha   DATE;
      num_err  NUMBER;
    BEGIN
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'Inicia el procedimeinto');
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'pctiprea: ' || pctiprea);
      IF pctiprea <> 2 THEN
        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'IF pctiprea <> 2 THEN');
        -- motiu = 5
        -- origen = 2 - Q. amortitzaci?
        SELECT MAX(nmovimi)
          INTO lnmovimi
          FROM garanseg
         WHERE sseguro = psseguro
           AND nriesgo = 1
           AND cgarant IN (1, 2)
           AND (finiefe <= pdataini AND
               (ffinefe IS NULL OR ffinefe > pdataini));
        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'Busca el maximo movimiento: -lnmovimi '||lnmovimi);
        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'Se llama a la funcion f_buscactrrea: -psseguro '||psseguro||' -lnmovimi '||lnmovimi
        ||' -psproces '||psproces||' -5 -pmoneda '||pmoneda||' -2 -pdataini '||pdataini||' -pdatafi '||pdatafi);
        num_err := f_buscactrrea(psseguro,
                                 lnmovimi,
                                 psproces,
                                 5,
                                 pmoneda,
                                 2,
                                 pdataini,
                                 pdatafi);
        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'Hubo error en la fuicnion f_buscactrrea: '||num_err);
        IF num_err <> 0 OR num_err = 99 THEN
          p_literal2(num_err, 1, ltexto);
          num_err := f_ins_mig_logs_axis(pncarga, psseguro, 'E', ltexto);
        ELSE
          p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'Se llama a la funcion f_cessio: -psproces '||psproces||' -5 -pmoneda '||pmoneda
          ||' -pdataini '||pdataini);
          num_err := f_cessio(psproces, 5, pmoneda, pdataini);
          p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'Hubo error en la fuicnion f_cessio: '||num_err);
          IF num_err <> 0 OR num_err = 99 THEN
            p_literal2(num_err, 1, ltexto);
            num_err := f_ins_mig_logs_axis(pncarga, psseguro, 'E', ltexto);
          ELSE
            --crida al detall del periode
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'Se llama a la funcion pac_cesionesrea.f_cessio_det_per: -psseguro '||psseguro||' -pdataini'|| pdataini ||' -pdatafi '||pdatafi
            ||' -psproces '||psproces);
            num_err := pac_cesionesrea.f_cessio_det_per(psseguro,
                                                        pdataini,
                                                        pdatafi,
                                                        psproces);
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.calcula_cessions_rea', 'Hubo error en la fuicnion pac_cesionesrea.f_cessio_det_per: '||num_err);
            IF num_err <> 0 THEN
              p_literal2(num_err, 1, ltexto);
              num_err := f_ins_mig_logs_axis(pncarga, psseguro, 'E', ltexto);
            END IF;

            --------------------------------------------------
            -- Sempre que hi hagi canvis en una p?lissa d'un c?mul, recalcularem totes les p?lisses
            -- d'aquest c?mul
            --------------------------------------------------
          END IF;
        END IF;
      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END calcula_cessions_rea;

    PROCEDURE p_crea_migcargas(p_car IN NUMBER, p_emp IN VARCHAR2) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO mig_cargas
        (ncarga, cempres, finiorg, ffinorg, estorg)
      VALUES
        (p_car, p_emp, f_sysdate, f_sysdate, 'OK');
      COMMIT;
    END p_crea_migcargas;

    PROCEDURE p_crea_migcargastabmig(p_car IN NUMBER,
                                     p_tab IN NUMBER,
                                     p_org IN VARCHAR2,
                                     p_des IN VARCHAR2) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO mig_cargas_tab_mig
        (ncarga, ntab, tab_org, tab_des, finides, ffindes, estdes)
      VALUES
        (p_car, p_tab, p_org, p_des, f_sysdate, NULL, NULL);
      COMMIT;
    END p_crea_migcargastabmig;

    FUNCTION f_ins_mig_cargas_tab_axis(pncarga   IN NUMBER,
                                       pntab     IN NUMBER,
                                       pntabaxis IN NUMBER,
                                       pttabaxis IN VARCHAR2) RETURN NUMBER IS
    BEGIN
      INSERT INTO mig_cargas_tab_axis
        (ncarga, ntab, ntabaxis, ttabaxis)
      VALUES
        (pncarga, pntab, pntabaxis, pttabaxis);
      COMMIT;
      RETURN 0;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN SQLCODE;
    END f_ins_mig_cargas_tab_axis;

    ----------------------------------------------------------------------------
    -- INICI
    ----------------------------------------------------------------------------
  BEGIN
    dbms_output.put_line('INI cesiones pol-PROD');
    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'INI CESIONES');
    pac_iax_login.p_iax_iniconnect(puser);
    pncarga := f_next_carga;
    p_crea_migcargas(pncarga, pcempres);
    p_crea_migcargastabmig(pncarga,
                           1,
                           'P_POST_INSTALACION_REA',
                           'P_MIG_CESIONES');
    b_error     := FALSE;
    b_warning   := FALSE;
    v_estadomig := NULL;
    num_err     := f_ins_mig_cargas_tab_axis(pncarga, 1, 1, 'CESIONESREA');
    num_err     := f_ins_mig_cargas_tab_axis(pncarga, 1, 2, 'CUAFACUL');
    num_err     := f_ins_mig_cargas_tab_axis(pncarga, 1, 3, 'REASEGEMI');
    num_err     := f_ins_mig_cargas_tab_axis(pncarga, 1, 4, 'DETREASEGEMI');
    num_err     := f_ins_mig_cargas_tab_axis(pncarga, 1, 5, 'CUMULOS');
    num_err     := f_ins_mig_cargas_tab_axis(pncarga, 1, 6, 'DESCUMULOS');
    num_err     := f_ins_mig_cargas_tab_axis(pncarga, 1, 7, 'REARIESGOS');
    num_err     := f_num_proces(f_user, lsproces);
    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Busca los datos de las polizas en el cursor c_pol');
    FOR v_pol IN c_pol LOOP
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', '***********');
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Se incializa el proceso para el seguro: '|| v_pol.sseguro);
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Movimiento : '|| v_pol.nmovimi);
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Concepto del Movimiento: '|| v_pol.cmotmov);
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', '***********');
      num_err  := f_proceslin(lsproces,
                              'inici ' || v_pol.sseguro || ':' ||
                              v_pol.nmovimi,
                              v_pol.sseguro,
                              nprolin);
      v_maxmov := v_pol.nmovimi;
      --incorporamos la actualizacion del nanuali para que se genere la cesi?n como si fuera el alta y luego
      --volvemos a dejar la poliza con su valor correcto
      SELECT NVL(nanuali, 1)
        INTO v_nanuali
        FROM seguros
       WHERE sseguro = v_pol.sseguro;

      UPDATE seguros SET nanuali = 1 WHERE sseguro = v_pol.sseguro;
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'pultmov : '|| pultmov);
      IF pultmov = 1 THEN
        BEGIN
          SELECT MAX(nmovimi)
            INTO v_maxmov
            FROM movseguro
           WHERE sseguro = v_pol.sseguro
             AND (cmovseg IN (0, 2) OR cmotmov = 406); -- CCB
        EXCEPTION
          WHEN OTHERS THEN
            b_error := TRUE;
            p_literal2(104349, 1, ltexto);
            num_err := f_ins_mig_logs_axis(pncarga,
                                           v_pol.sseguro || ':' ||
                                           v_pol.nmovimi,
                                           'E',
                                           ltexto);
        END;
      END IF;
      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Se busca el maximo movimiento de la poliza (v_maxmov): '|| v_maxmov);
      IF v_maxmov = v_pol.nmovimi THEN
        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'El movimiento del cursor conicide con el ultimo movimiento: '|| v_maxmov || ' - '||v_pol.nmovimi);
        BEGIN
          SELECT COUNT(c.sseguro)
            INTO l_c
            FROM cuafacul c
           WHERE c.sseguro = v_pol.sseguro
             AND c.cestado = 1;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            SELECT COUNT(c.sseguro)
              INTO l_c
              FROM cuafacul c, reariesgos r
             WHERE c.scumulo = r.scumulo
               AND r.sseguro = v_pol.sseguro
               AND c.cestado = 1;
          WHEN OTHERS THEN
            b_error := TRUE;
            p_literal2(num_err, 104486, ltexto);
            num_err := f_ins_mig_logs_axis(pncarga,
                                           v_pol.sseguro || ':' ||
                                           v_pol.nmovimi,
                                           'E',
                                           ltexto);
        END;
        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', '¿Existen cuadros facultativos (cuafacul)?: '|| l_c);
        num_err := 0;
        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', '¿Occurio un error en busca cuadros facultativos (cuafacul)?: '|| num_err);
        IF l_c = 0 THEN
          p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'No existen cuadros');
          p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'v_pol.tipo: '|| v_pol.tipo);
          IF v_pol.tipo = 'E' THEN
            p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Entro en la validacion de tipo E : '|| v_pol.tipo);
            -- 'E'-Emissio 'Q'-Quadre amortit
            IF v_pol.cmovseg = 3 THEN
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'v_pol.cmovseg : '|| v_pol.cmovseg);
              -- anulaci? ---
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Se hace un llamado a la funcion f_atras - Parametros:  '
                                 || 'lsproces: ' || lsproces ||','
                                 || 'v_pol.sseguro: ' || v_pol.sseguro ||', '
                                 || 'v_pol.fefecmov: ' || v_pol.fefecmov ||', '
                                 || '6, '
                                 || '1, '
                                 || 'v_pol.nmovimi: ' || v_pol.nmovimi ||', '
                                 || 'v_pol.fdatagen: ' || v_pol.fdatagen );
              --
              num_err := f_atras(lsproces,
                                 v_pol.sseguro,
                                 v_pol.fefecmov,
                                 6,
                                 1,
                                 v_pol.nmovimi,
                                 v_pol.fdatagen);
                                 
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error en la funcion f_atras : '|| num_err);      
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'pctanca : '|| pctanca);                
              IF num_err = 0 THEN
                IF pctanca = 0 THEN
                  p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Actualiza la fecha de contavilidad de cesionesrea');
                  BEGIN
                    UPDATE cesionesrea
                       SET fcontab = wfcontab
                     WHERE sproces = lsproces
                       AND fcontab IS NULL;
                  EXCEPTION
                    WHEN OTHERS THEN
                      b_error := TRUE;
                      p_literal2(104859, 1, ltexto);
                      num_err := f_ins_mig_logs_axis(pncarga,
                                                     v_pol.sseguro || ':' ||
                                                     v_pol.nmovimi,
                                                     'E',
                                                     ltexto);
                  END;
                END IF;
              END IF;
              
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error actualizando fecha : '|| num_err);   
              
              IF num_err = 0 THEN
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Abre cursor c_ries'); 
                FOR i IN c_ries(v_pol.sseguro) LOOP
                  p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Inicia el recorrido por riesgos'); 
                  BEGIN
                    SELECT scumulo
                      INTO cumulo
                      FROM reariesgos
                     WHERE sseguro = v_pol.sseguro
                       AND nriesgo = i.nriesgo
                       AND freafin IS NULL;
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Busca los cumulos en la tabla reariesgos : '|| cumulo); 
                    IF cumulo IS NOT NULL THEN
                      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Encuentra cumulo'); 
                      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Llama la funcion f_bajacu: -v_pol.sseguro ' 
                      || v_pol.sseguro || ' -v_pol.fefecmov '||v_pol.fefecmov ); 
                      num_err := f_bajacu(v_pol.sseguro, v_pol.fefecmov);
                      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error en la funcion f_bajacu: '|| num_err); 
                      IF num_err = 0 THEN
                        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Llama a la funcion f_cumulo: -lsproces '
                        || lsproces || ' -cumulo ' || cumulo || ' -v_pol.fefecmov '|| v_pol.fefecmov || '-1 -1 -NULL'); 
                        num_err := f_cumulo(lsproces,
                                            cumulo,
                                            v_pol.fefecmov,
                                            1,
                                            1,
                                            NULL);
                        p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error en la funcion f_cumulo: '|| num_err);
                        IF num_err <> 0 THEN
                          b_warning := TRUE;
                          p_literal2(num_err, 1, ltexto);
                          num_err := f_ins_mig_logs_axis(pncarga,
                                                         v_pol.sseguro || ':' ||
                                                         v_pol.nmovimi,
                                                         'W',
                                                         ltexto);
                        END IF;

                      ELSE
                        b_warning := TRUE;
                        p_literal2(num_err, 1, ltexto);
                        num_err := f_ins_mig_logs_axis(pncarga,
                                                       v_pol.sseguro || ':' ||
                                                       v_pol.nmovimi,
                                                       'W',
                                                       ltexto);
                      END IF;
                    END IF;

                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                      NULL;
                    WHEN OTHERS THEN
                      b_error := TRUE;
                      num_err := f_ins_mig_logs_axis(pncarga,
                                                     v_pol.sseguro || ':' ||
                                                     v_pol.nmovimi,
                                                     'E',
                                                     'Error al buscar cumul');
                  END;
                  
                  p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error en los datos: '|| num_err);
                  
                END LOOP;
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Fin cursor de riesgos');
              ELSE
                b_error := TRUE;
                p_literal2(num_err, 1, ltexto);
                num_err := f_ins_mig_logs_axis(pncarga,
                                               v_pol.sseguro || ':' ||
                                               v_pol.nmovimi,
                                               'E',
                                               ltexto);
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error en validacion: '||num_err);
              END IF;
              
            ELSIF v_pol.cmovseg = 4 THEN
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'v_pol.cmovseg = 4');
              -- Rehabiliatci?
              -- buscamos el ?ltimo movimiento vigente
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Se busca el ultimo movimiento vigente');
              SELECT MAX(nmovimi)
                INTO lnmovi_vig
                FROM movseguro
               WHERE sseguro = v_pol.sseguro
                 AND nmovimi < v_pol.nmovimi
                 AND cmovseg <> 3; -- no anulaci?
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'lnmovi_vig: '||lnmovi_vig);
              lorigen := 1;
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'lorigen: '||lorigen);
              lfini   := v_pol.fefecmov;
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'lfini: '||lfini);
              BEGIN
                -- moviment de renovaci? posterior a l'actual per saber la data de fi
                -- de la cessi? actual
                SELECT fefecto
                  INTO lffi
                  FROM movseguro
                 WHERE sseguro = v_pol.sseguro
                   AND nmovimi = (SELECT MIN(nmovimi)
                                    FROM movseguro
                                   WHERE sseguro = v_pol.sseguro
                                     AND nmovimi > v_pol.nmovimi
                                     AND cmovseg = 2);
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Busca el movimiento de renovacion posterior al actual: '||lffi);
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  lffi := v_pol.fvto;
                WHEN OTHERS THEN
                  b_error := TRUE;
                  num_err := f_ins_mig_logs_axis(pncarga,
                                                 v_pol.sseguro || ':' ||
                                                 v_pol.nmovimi,
                                                 'E',
                                                 'Error movseguro ');
                  num_err := -1;
              END;
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Hubo error en esos movimientos num_err: '||num_err);
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Llama a la funcion f_buscactrrea: -v_pol.sseguro '||
              v_pol.sseguro || ' -lnmovi_vig '||lnmovi_vig||' -9 -1 -lorigen '||lorigen||' -lfini '||lfini||' -lffi '||lffi);
              num_err := f_buscactrrea(v_pol.sseguro,
                                       lnmovi_vig,
                                       lsproces,
                                       9,
                                       1,
                                       lorigen,
                                       lfini,
                                       lffi);
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error la funcion f_buscactrrea: '||num_err);
              IF num_err <> 0 AND num_err <> 99 THEN
                b_warning := TRUE;
                p_literal2(num_err, 1, ltexto);
                num_err := f_ins_mig_logs_axis(pncarga,
                                               v_pol.sseguro || ':' ||
                                               v_pol.nmovimi,
                                               'W',
                                               ltexto);
              ELSIF num_err = 99 THEN
                NULL; -- no hay cesi?n al reaseguro
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'No hay cesion de reaseguro');
              ELSE
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Llama a la funcion f_cessio: -lsproces '||
                lsproces || ' -9 -1 -v_pol.fdatagen '||v_pol.fdatagen);
                num_err := f_cessio(lsproces, 9, 1, v_pol.fdatagen);
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error la funcion f_cessio: '||num_err);
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Valida si se debe realizar ocntavilizacion');
                IF num_err = 0 THEN
                  IF pctanca = 0 THEN
                    BEGIN
                      UPDATE cesionesrea
                         SET fcontab = wfcontab
                       WHERE sproces = lsproces
                         AND fcontab IS NULL;
                    EXCEPTION
                      WHEN OTHERS THEN
                        b_error := TRUE;
                        p_literal2(104859, 1, ltexto);
                        num_err := f_ins_mig_logs_axis(pncarga,
                                                       v_pol.sseguro || ':' ||
                                                       v_pol.nmovimi,
                                                       'E',
                                                       ltexto || '-' ||
                                                       SQLERRM);
                    END;
                  END IF;
                END IF;
                
                IF num_err <> 0 AND num_err <> 99 THEN
                  b_warning := TRUE;
                  p_literal2(num_err, 1, ltexto);
                  num_err := f_ins_mig_logs_axis(pncarga,
                                                 v_pol.sseguro || ':' ||
                                                 v_pol.nmovimi,
                                                 'W',
                                                 ltexto);
                ELSIF num_err = 99 THEN
                  b_warning := TRUE;
                  num_err   := 105382;
                  p_literal2(num_err, 1, ltexto);
                  num_err := f_ins_mig_logs_axis(pncarga,
                                                 v_pol.sseguro || ':' ||
                                                 v_pol.nmovimi,
                                                 'W',
                                                 ltexto);
                END IF;
              END IF;
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Hubo error en el proceso: '|| num_err);
            ELSE
              -- altres moviments
              -- Cal obtenir les DATEs d'inici i final de cessi?
              lfini := v_pol.fefecmov;
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Flujo alternativo lfini: '|| lfini);
              IF v_pol.ctipseg = 3 THEN
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'IF v_pol.ctipseg = 3 THEN');
                BEGIN
                  SELECT DECODE(cforamor, 0, v_pol.cforpag, cforamor)
                    INTO lcforamor
                    FROM seguros_assp
                   WHERE sseguro = v_pol.sseguro;
                  lffi := ADD_MONTHS(lfini, 12 / lcforamor);
                EXCEPTION
                  WHEN OTHERS THEN
                    lffi := v_pol.fvto;
                END;
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Flujo alternativo lffi: '|| lffi);
              ELSE
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Se calcula la fecha si el tipo de seguro es diferente de 3');
                BEGIN
                  -- moviment de renovaci? posterior a l'actual per saber la data de fi
                  -- de la cessi? actual
                  SELECT fefecto
                    INTO lffi
                    FROM movseguro
                   WHERE sseguro = v_pol.sseguro
                     AND nmovimi = (SELECT MIN(nmovimi)
                                      FROM movseguro
                                     WHERE sseguro = v_pol.sseguro
                                       AND nmovimi > v_pol.nmovimi
                                       AND cmovseg = 2);
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                    lffi := v_pol.fvto;
                  WHEN OTHERS THEN
                    b_error := TRUE;
                    num_err := f_ins_mig_logs_axis(pncarga,
                                                   v_pol.sseguro || ':' ||
                                                   v_pol.nmovimi,
                                                   'E',
                                                   'Error movseguro ');
                    num_err := -1;
                END;
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Flujo alternativo lffi: '|| lffi);
              END IF;
              p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Hubo error en el calculo de la fecha: '||num_err);
              IF num_err = 0 THEN
                p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'IF v_pol.ctiprea <> 2 THEN');
                IF v_pol.ctiprea <> 2 THEN
                  p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'IF v_pol.cmotmov = 100 THEN');
                  IF v_pol.cmotmov = 100 THEN
                    -- Nova producci?
                    lmotiu := 3;
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Nueva Produccion lmotiu: '||lmotiu);
                    --- V.Fixe 128 (3 = Nova producci?)
                  ELSIF v_pol.cmovseg = 2 THEN
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'ELSIF v_pol.cmovseg = 2 THEN');
                    -- Renovaci?
                    lmotiu := 5;
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Renovacion lmotiu: '||lmotiu);
                  ELSE
                    -- Suplemento
                    -- lmotiu = V.Fixe 128 ( Tipus de registre a cessionesrea)
                    lmotiu := 4; --Suplemento normal...
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Suplemento lmotiu: '||lmotiu);
                    IF v_pol.ctiprea NOT IN (5, 1, 3) THEN
                      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Tipo de reaseguro: '||v_pol.ctiprea);
                      -- Suplement amb facultatiu: es t? d'aturar...
                      BEGIN
                        --
                        SELECT sfacult
                          INTO lsfacult
                          FROM cuafacul
                         WHERE sseguro = v_pol.sseguro
                           AND finicuf <= lfini
                           AND (ffincuf > lfini OR ffincuf IS NULL);
                        num_err := 107439; -- 'Parar facultativo';
                        b_error := TRUE;
                        p_literal2(num_err, 1, ltexto);
                        num_err := f_ins_mig_logs_axis(pncarga,
                                                       v_pol.sseguro || ':' ||
                                                       v_pol.nmovimi,
                                                       'E',
                                                       ltexto);
                      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error de cuadro facultativo num_err: '||num_err);
                      EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                          NULL;
                        WHEN TOO_MANY_ROWS THEN
                          num_err := 107439;
                          p_literal2(num_err, 1, ltexto);
                          b_error := TRUE;
                          num_err := f_ins_mig_logs_axis(pncarga,
                                                         v_pol.sseguro || ':' ||
                                                         v_pol.nmovimi,
                                                         'E',
                                                         ltexto);
                        WHEN OTHERS THEN
                          b_error := TRUE;
                          num_err := 107518;
                          p_literal2(num_err, 1, ltexto);
                          num_err := f_ins_mig_logs_axis(pncarga,
                                                         v_pol.sseguro || ':' ||
                                                         v_pol.nmovimi,
                                                         'E',
                                                         ltexto);
                      END;
                    END IF;
                  END IF;
                  p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error de cuadro facultativo num_err: '||num_err);
                  IF num_err = 0 THEN
                    lorigen := 1;
                    ldetces := NULL;
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Se llama a la funcion f_parproductos: -v_pol.sproduc '
                    ||v_pol.sproduc||' -REASEGURO -ldetces '||ldetces);
                    num_err := f_parproductos(v_pol.sproduc,
                                              'REASEGURO',
                                              ldetces);
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Error en f_parproductos: '||num_err);
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'lorigen: '||lorigen);
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'ldetces: '||ldetces);
                    IF lmotiu = 3 OR (v_pol.cforpag = 0 AND lmotiu <> 5) THEN
                      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'IF lmotiu = 3 OR (v_pol.cforpag = 0 AND lmotiu <> 5) THEN');
                      IF NVL(ldetces, 1) = 2 THEN
                        -- Q. amort.
                        lorigen := 2;
                        lmeses  := 12 / lcforamor;
                        dd      := '31';
                        lfaux   := TO_DATE('31/12/' ||
                                           TO_CHAR(v_pol.fefecto, 'yyyy'),
                                           'dd/mm/yyyy');
                        IF last_day(lfini) = lfini AND
                           MOD(to_number(to_char(lfini, 'mm')),
                               12 / lcforamor) = 0 THEN
                          lffi := lfini;
                        ELSE
                          BEGIN
                            WHILE TRUE LOOP
                              lfaux := f_summeses(lfaux, -lmeses, dd);
                              IF lfaux <= v_pol.fefecto THEN
                                lffi := f_summeses(lfaux, lmeses, dd);
                                EXIT;
                              END IF;
                            END LOOP;

                          EXCEPTION
                            WHEN OTHERS THEN
                              b_error := TRUE;
                              num_err := f_ins_mig_logs_axis(pncarga,
                                                             v_pol.sseguro || ':' ||
                                                             v_pol.nmovimi,
                                                             'E',
                                                             'ERROR f_summeses 1 ');
                          END;
                        END IF;

                      ELSE
                        lmeses := 12;
                        dd     := SUBSTR(LPAD(v_pol.nrenova, 4, 0), 3, 2);
                        ddmm   := dd ||
                                  SUBSTR(LPAD(v_pol.nrenova, 4, 0), 1, 2);
                        lfaux  := v_pol.fvto;
                        IF last_day(lfini) = lfini AND
                           MOD(to_number(to_char(lfini, 'mm')),
                               12 / lcforamor) = 0 THEN
                          lffi := lfini;
                        ELSE
                          BEGIN
                            WHILE TRUE LOOP
                              lfaux := f_summeses(lfaux, -lmeses, dd);
                              IF lfaux <= v_pol.fefecto THEN
                                lffi := f_summeses(lfaux, lmeses, dd);
                                EXIT;
                              END IF;
                            END LOOP;

                          EXCEPTION
                            WHEN OTHERS THEN
                              b_error := TRUE;
                              num_err := f_ins_mig_logs_axis(pncarga,
                                                             v_pol.sseguro || ':' ||
                                                             v_pol.nmovimi,
                                                             'E',
                                                             'ERROR f_summeses 2 ');
                          END;
                        END IF;
                      END IF;
                    END IF;
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Hubo algun error en la fecha num_err: '||num_err);
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Se llama a la funcion f_buscactrrea: -v_pol.sseguro '
                    ||v_pol.sseguro||' -v_pol.nmovimi '||v_pol.nmovimi||' -lsproces '||lsproces||' -lmotiu '||lmotiu||' -1 -lorigen '||lorigen||' -lfini '||lfini||' -lffi '||lffi);
                    num_err := f_buscactrrea(v_pol.sseguro,
                                             v_pol.nmovimi,
                                             lsproces,
                                             lmotiu,
                                             1,
                                             lorigen,
                                             lfini,
                                             lffi);
                    dbms_output.put_line('despues de F_Buscactrrea, num_err: ' ||
                                         num_err);
                    p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Hubo algun error despues de f_buscactrrea: '||num_err);
                    IF num_err <> 0 AND num_err <> 99 THEN
                      b_error := TRUE;
                      p_literal2(num_err, 1, ltexto);
                      num_err := f_ins_mig_logs_axis(pncarga,
                                                     v_pol.sseguro || ':' ||
                                                     v_pol.nmovimi,
                                                     'E',
                                                     ltexto);
                    ELSIF num_err = 99 THEN
                      num_err := 0;
                    ELSE
                      p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Se llama a la funcion f_cessio: -lsproces '
                      ||lsproces||' -lmotiu '||lmotiu||' -1 -v_pol.fdatagen '||v_pol.fdatagen);
                      num_err := f_cessio(lsproces,
                                          lmotiu,
                                          1,
                                          v_pol.fdatagen);
                      dbms_output.put_line('despues de f_cessio, num_err: ' ||
                                           num_err);
                       p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2.f_generar_cesiones_migradas', 'Hubo algun error despues de f_cessio: '||num_err);
                      IF num_err = 0 THEN
                        IF pctanca = 0 THEN
                          BEGIN
                            UPDATE cesionesrea
                               SET fcontab = wfcontab
                             WHERE sproces = lsproces
                               AND fcontab IS NULL;
                          EXCEPTION
                            WHEN OTHERS THEN
                              b_error := TRUE;
                              p_literal2(104859, 1, ltexto);
                              num_err := f_ins_mig_logs_axis(pncarga,
                                                             v_pol.sseguro || ':' ||
                                                             v_pol.nmovimi,
                                                             'E',
                                                             ltexto);
                          END;
                        END IF;
                      END IF;

                      IF num_err <> 0 AND num_err <> 99 THEN
                        b_error := TRUE;
                        p_literal2(num_err, 1, ltexto);
                        num_err := f_ins_mig_logs_axis(pncarga,
                                                       v_pol.sseguro || ':' ||
                                                       v_pol.nmovimi,
                                                       'E',
                                                       ltexto);
                      ELSIF num_err = 99 THEN
                        num_err := 105382; --No te facultatiu
                        b_error := TRUE;
                        p_literal2(num_err, 1, ltexto);
                        num_err := f_ins_mig_logs_axis(pncarga,
                                                       v_pol.sseguro || ':' ||
                                                       v_pol.nmovimi,
                                                       'E',
                                                       ltexto);
                      ELSE
                        -- Si ?s emissio d una p?lissa que es reassegura en
                        -- el q.amortitzaci? :Cal calcular el detall de cessions
                        -- pel periode de la emissi?
                        IF NVL(lorigen, 1) = 2 THEN
                          num_err := pac_cesionesrea.f_cessio_det_per(v_pol.sseguro,
                                                                      lfini,
                                                                      lffi,
                                                                      lsproces);
                          IF num_err = 0 THEN
                            IF pctanca = 0 AND pcdetrea = 1 THEN
                              BEGIN
                                UPDATE reasegemi
                                   SET fcierre = wfcontab
                                 WHERE sproces = lsproces
                                   AND fcierre IS NULL;
                              EXCEPTION
                                WHEN OTHERS THEN
                                  b_error := TRUE;
                                  p_literal2(151144, 1, ltexto);
                                  num_err := f_ins_mig_logs_axis(pncarga,
                                                                 v_pol.sseguro || ':' ||
                                                                 v_pol.nmovimi,
                                                                 'E',
                                                                 ltexto || '-' ||
                                                                 SQLERRM);
                              END;

                            ELSE
                              BEGIN
                                UPDATE reasegemi
                                   SET fgenera = fefecte
                                 WHERE sproces = lsproces
                                   AND fcierre IS NULL;
                              EXCEPTION
                                WHEN OTHERS THEN
                                  p_literal2(151144, 1, ltexto);
                                  num_err := f_ins_mig_logs_axis(pncarga,
                                                                 v_pol.sseguro,
                                                                 'E',
                                                                 ltexto || '-' ||
                                                                 SQLERRM);
                              END;
                            END IF;
                          END IF;

                          IF num_err <> 0 THEN
                            b_error := TRUE;
                            p_literal2(num_err, 1, ltexto);
                            num_err := f_ins_mig_logs_axis(pncarga,
                                                           v_pol.sseguro || ':' ||
                                                           v_pol.nmovimi,
                                                           'E',
                                                           ltexto);
                          END IF;
                        END IF;
                      END IF;
                    END IF;

                  ELSE
                    b_error := TRUE;
                    p_literal2(num_err, 1, ltexto);
                    num_err := f_ins_mig_logs_axis(pncarga,
                                                   v_pol.sseguro || ':' ||
                                                   v_pol.nmovimi,
                                                   'E',
                                                   ltexto);
                  END IF;
                END IF;

              ELSE
                b_error := TRUE;
                p_literal2(num_err, 1, ltexto);
                num_err := f_ins_mig_logs_axis(pncarga,
                                               v_pol.sseguro || ':' ||
                                               v_pol.nmovimi,
                                               'E',
                                               ltexto);
              END IF;
            END IF;

          ELSE
            -- 'Q' quadre amortitz
            ------------------------------------------------------------------
            -- Quadre d'amortitzaci?
            ------------------------------------------------------------------
            -- Cridem al c?lcul de cessions de la reasseguran?a
            ldatafi := ADD_MONTHS(v_pol.fmovimi, 12 / v_pol.cforamor);

            SELECT add_months(trunc(last_day(v_pol.fefecto), 'YYYY'),
                              (12 / v_pol.cforamor) *
                              ceil(to_number(to_char(last_day(v_pol.fefecto),
                                                     'MM')) * v_pol.cforamor / 12)) - 1
              INTO lfefecto_ini
              FROM DUAL;
            pk_cuadro_amortizacion.calcular_cuadro(v_pol.sseguro,
                                                   lfefecto_ini);
            --pk_CUADRO_AMORTIZACION.pinta_cuadro;
            FOR i IN 1 .. 2000 LOOP
              pk_cuadro_amortizacion.ver_mensajes(i, amortit);
              pimporte := amortit.pendiente;
              IF amortit.famort >= TRUNC(v_pol.fmovimi) THEN
                EXIT;
              END IF;
            END LOOP;

            --Updategem les garanties de mort i d'ivalidesa
            UPDATE garanseg
               SET icapital = pimporte, icaptot = pimporte
             WHERE sseguro = v_pol.sseguro
               AND nriesgo = 1
               AND cgarant IN (1, 2)
               AND (finiefe <= v_pol.fmovimi AND
                   (ffinefe IS NULL OR ffinefe > v_pol.fmovimi));
            calcula_cessions_rea(v_pol.sseguro,
                                 v_pol.ctiprea,
                                 v_pol.fmovimi,
                                 ldatafi,
                                 lsproces,
                                 1,
                                 1);
          END IF;
        END IF;

        --- Fem les cessions dels rebuts del moviment
        IF pcdetrea = 1 THEN
          mig_ces_rec(lsproces, v_pol.sseguro, v_pol.nmovimi);
        END IF;

        i := i + 1;

        UPDATE seguros
           SET nanuali = v_nanuali
         WHERE sseguro = v_pol.sseguro;
        IF i > 100 THEN
          COMMIT;
          i := 0;
        END IF;
      END IF;
    END LOOP;

    num_err := f_procesfin(lsproces, 0);
    IF b_error THEN
      v_estadomig := 'ERROR';
      v_ret       := 8;
    ELSIF b_warning THEN
      v_estadomig := 'WARNING';
      v_ret       := 0;
    ELSE
      v_estadomig := 'OK';
      v_ret       := 0;
    END IF;

    p_act_migcargastabmig(pncarga,
                          1,
                          'P_POST_INSTALACION_REA',
                          'P_MIG_CESIONES',
                          v_estadomig);
    COMMIT;
    RETURN v_ret;
  END f_generar_cesiones_migradas;

BEGIN
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(17,
                                                                     'USER_BBDD'))
    INTO v_context
    FROM DUAL;
  p_control_error('AXIS_POS', 'csi_gen_cesiones_rea_mig_v2', 'Inicio');
  p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2', 'Inicio trazas tmp');

  vresul := f_generar_cesiones_migradas;

  IF vresul <> 0 THEN
    p_control_error('AXIS_POS',
                    'csi_gen_cesiones_rea_mig_v2',
                    'Error= ' || vresul);
  END IF;

  p_control_error('AXIS_POS', 'csi_gen_cesiones_rea_mig_v2', 'Fin');
  p_control_error(ppoliza, 'csi_gen_cesiones_rea_mig_v2', 'Fin trazas tmp');

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    p_control_error('AXIS_POS',
                    'csi_gen_cesiones_rea_mig_v2',
                    'ERROR=' || SQLERRM);
END csi_gen_cesiones_rea_mig_v2;
/
