/* Formatted on 16/01/2016 12:33 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
DECLARE
   vcempres       NUMBER := 24;
   vcusuari       VARCHAR2(20);
   -- := 'AXIS_CSI';   -- Usuario que quedar� en pie
   vsseguro       NUMBER;
   vt_mensaje     VARCHAR2(1000);

   CURSOR c_seguros IS
      SELECT sseguro
        FROM seguros s
       where CEMPRES = VCEMPRES
       --and sseguro = 1006
       ;

   CURSOR c_estseguros IS
      SELECT sseguro
        FROM estseguros s
       WHERE cempres = vcempres;

   CURSOR recibos IS
      SELECT nrecibo
        FROM recibos
       WHERE sseguro = vsseguro
         AND cempres = vcempres;

   CURSOR docum_gedox IS
      SELECT d.iddocgedox
        FROM docummovseg d
       WHERE sseguro = vsseguro;

   v_contador     NUMBER;
   retval         NUMBER;
   tipotablas     NUMBER;
   psalida        NUMBER;
BEGIN
   IF vcusuari IS NULL THEN
      SELECT pac_parametros.f_parempresa_t(vcempres, 'USER_BBDD')
        INTO vcusuari
        FROM DUAL;
   END IF;

   pac_iax_login.p_iax_iniconnect(vcusuari);
   v_contador := 1;

   DELETE      reaseguro
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      reariesgos
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   FOR reggar IN c_seguros LOOP
      vsseguro := reggar.sseguro;
      p_tab_error(f_sysdate, 'CONF_BORR', 'bucle 1 reggar', 1, ' vsseguro --> ' || vsseguro, 'OK');

      DELETE FROM ptpplp_previo
            WHERE sseguro = vsseguro;

      DELETE FROM cnvpolizas
            WHERE sseguro = vsseguro;

      DELETE FROM segcartera
            WHERE sseguro = vsseguro;

      DELETE FROM pppc_previo
            WHERE sseguro = vsseguro;

      DELETE FROM pppc
            WHERE sseguro = vsseguro;

      DELETE FROM detimplibreta
            WHERE sseguro = vsseguro;

      DELETE FROM implibreta
            WHERE sseguro = vsseguro;

      DELETE FROM ptpplp
            WHERE sseguro = vsseguro;

      DELETE FROM ppnc_previo
            WHERE sseguro = vsseguro;

      DELETE FROM ppnc
            WHERE sseguro = vsseguro;

      DELETE FROM reemplazos
            WHERE sseguro = vsseguro;

      DELETE FROM spemaya
            WHERE sseguro = vsseguro;

      DELETE FROM provisiones
            WHERE sseguro = vsseguro;

      DELETE FROM ppnc_previo
            WHERE sseguro = vsseguro;

      DELETE FROM clauparseg
            WHERE sseguro = vsseguro;

      DELETE FROM prestaren
            WHERE sseguro = vsseguro;

      DELETE FROM regularizaciones
            WHERE sseguro = vsseguro;

--      DELETE FROM parpggbvarext_poliza
--            WHERE sseguro = vsseguro;

      --      DELETE FROM parprogarint_poliza
--            WHERE sseguro = vsseguro;

      --      DELETE FROM parpggbvaruni_poliza
--            WHERE sseguro = vsseguro;

      --      DELETE FROM parpggbvar_poliza
--            WHERE sseguro = vsseguro;
      DELETE FROM penaliseg
            WHERE sseguro = vsseguro;

      DELETE FROM detreasegemi
            WHERE sreaemi IN(SELECT sreaemi
                               FROM reasegemi
                              WHERE sseguro = vsseguro);

      DELETE FROM reasegemi
            WHERE sseguro = vsseguro;

      DELETE FROM ppempleo
            WHERE sseguro = vsseguro;

      DELETE FROM pila_cumulos
            WHERE sseguro = vsseguro;

      DELETE FROM pila_ifases
            WHERE sseguro = vsseguro;

      DELETE FROM planfiscal
            WHERE sseguro = vsseguro;

      DELETE FROM reariesgos
            WHERE sseguro = vsseguro;

      DELETE FROM cuadre_cc
            WHERE sseguro = vsseguro;

      DELETE FROM reaseguro
            WHERE sseguro = vsseguro;

      DELETE FROM planrentas
            WHERE sseguro = vsseguro;

      DELETE FROM primariesgo
            WHERE sseguro = vsseguro;

      DELETE FROM planseguros
            WHERE sseguro = vsseguro;

      DELETE FROM sup_solicitud
            WHERE sseguro = vsseguro;

      DELETE FROM anuseg
            WHERE sseguro = vsseguro;

      DELETE FROM anuclaususeg
            WHERE sseguro = vsseguro;

      DELETE FROM pila_pendientes_dup
            WHERE sseguro = vsseguro;

      DELETE FROM pila_planes
            WHERE sseguro = vsseguro;

      DELETE FROM liqresreaaux_err
            WHERE sseguro = vsseguro;

      DELETE FROM liqresreaaux
            WHERE sseguro = vsseguro;

      DELETE FROM contador_pendientes
            WHERE sseguro = vsseguro;

      DELETE FROM detctaempleados
            WHERE sseguro = vsseguro;

      DELETE FROM tmp_fis_rescate
            WHERE sseguro = vsseguro;

      DELETE FROM pagosreaxl
            WHERE nsinies IN(SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      DELETE FROM liquidareaxl
            WHERE nsinies IN(SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      DELETE FROM agensini
            WHERE nsinies IN(SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      DELETE FROM diariotramitacion
            WHERE nsinies IN(SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      DELETE FROM tramitacionsini
            WHERE nsinies IN(SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      DELETE FROM valorasini
            WHERE nsinies IN(SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      DELETE FROM pagogarantia
            WHERE sidepag IN(SELECT sidepag
                               FROM pagosini
                              WHERE nsinies IN(SELECT nsinies
                                                 FROM siniestros
                                                WHERE sseguro = vsseguro));

      DELETE FROM ctaseguro_detalle
            WHERE (sseguro, nnumlin, fcontab) IN(
                                  SELECT sseguro, nnumlin, fcontab
                                    FROM ctaseguro
                                   WHERE sidepag IN(
                                                    SELECT sidepag
                                                      FROM pagosini
                                                     WHERE nsinies IN(
                                                                      SELECT nsinies
                                                                        FROM siniestros
                                                                       WHERE sseguro =
                                                                                      vsseguro)));

      DELETE FROM ctaseguro_libreta
            WHERE (sseguro, nnumlin, fcontab) IN(
                                  SELECT sseguro, nnumlin, fcontab
                                    FROM ctaseguro
                                   WHERE sidepag IN(
                                                    SELECT sidepag
                                                      FROM pagosini
                                                     WHERE nsinies IN(
                                                                      SELECT nsinies
                                                                        FROM siniestros
                                                                       WHERE sseguro =
                                                                                      vsseguro)));

      DELETE FROM ctaseguro
            WHERE sidepag IN(SELECT sidepag
                               FROM pagosini
                              WHERE nsinies IN(SELECT nsinies
                                                 FROM siniestros
                                                WHERE sseguro = vsseguro));

      DELETE FROM pagosini
            WHERE nsinies IN(SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      DELETE FROM destinatarios
            WHERE nsinies IN(SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      -- Nuevo modulo de siniestros
      DELETE FROM agd_obs_vision
            WHERE (cempres, idobs) IN(SELECT cempres, idobs
                                        FROM agd_observaciones
                                       WHERE nsinies IN(SELECT nsinies
                                                          FROM sin_siniestro
                                                         WHERE sseguro = vsseguro));

      DELETE FROM agd_movobs
            WHERE (cempres, idobs) IN(SELECT cempres, idobs
                                        FROM agd_observaciones
                                       WHERE nsinies IN(SELECT nsinies
                                                          FROM sin_siniestro
                                                         WHERE sseguro = vsseguro));

      DELETE FROM agd_observaciones
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM agd_siniestro
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_agenda
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_destinatario
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_detdano
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_dano
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_demand
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_detdescripcion
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_detdireccion
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_detpersona
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_detvehiculo
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_documento
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_juzgado
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramite_lesiones
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramite_recobro
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramite_mov
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramite
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_localiza
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_movimiento
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_profesional
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_reserva
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_personasrel
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_detgestion
            WHERE sgestio IN(SELECT sgestio
                               FROM sin_tramita_gestion
                              WHERE nsinies IN(SELECT nsinies
                                                 FROM sin_siniestro
                                                WHERE sseguro = vsseguro));

      DELETE FROM sin_tramita_docgestion
            WHERE sgestio IN(SELECT sgestio
                               FROM sin_tramita_gestion
                              WHERE nsinies IN(SELECT nsinies
                                                 FROM sin_siniestro
                                                WHERE sseguro = vsseguro));

      DELETE FROM sin_tramita_movgestion
            WHERE sgestio IN(SELECT sgestio
                               FROM sin_tramita_gestion
                              WHERE nsinies IN(SELECT nsinies
                                                 FROM sin_siniestro
                                                WHERE sseguro = vsseguro));

      DELETE FROM sin_tramita_gestion
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_movpago
            WHERE sidepag IN(SELECT sidepag
                               FROM sin_tramita_pago
                              WHERE nsinies IN(SELECT nsinies
                                                 FROM sin_siniestro
                                                WHERE sseguro = vsseguro));

      DELETE FROM sin_tramita_pago_gar
            WHERE sidepag IN(SELECT sidepag
                               FROM sin_tramita_pago
                              WHERE nsinies IN(SELECT nsinies
                                                 FROM sin_siniestro
                                                WHERE sseguro = vsseguro));

      DELETE FROM sin_siniestro_referencias
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_tramita_pago
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_movsiniestro
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);
      --
      DELETE FROM sin_tramita_judicial_detper --conf
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro); 
      --
      DELETE FROM sin_tramita_judicial_audien --conf
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);
      --
      DELETE FROM sin_tramita_valpretension --conf
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);
      --
      DELETE FROM sin_tramita_judicial --conf
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);
      --
      DELETE FROM sin_tramita_valpretfiscal --conf
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);
      --
      DELETE FROM sin_tramita_fiscal --conf
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);
                                                            
      DELETE FROM sin_tramitacion
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM sin_primas_consumidas
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM reamovpagos
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);

      DELETE FROM pagossinces
            WHERE nsinies IN(SELECT TO_NUMBER(nsinies)
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro
                             UNION ALL
                             SELECT nsinies
                               FROM siniestros
                              WHERE sseguro = vsseguro);

      DELETE FROM remuneracion_canal_sin
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);
                              
      DELETE FROM sin_tramita_reservadet --conf
            WHERE nsinies IN(SELECT nsinies
                               FROM sin_siniestro
                              WHERE sseguro = vsseguro);
      --
      DELETE FROM sin_siniestro
            WHERE sseguro = vsseguro;
      --
      DELETE FROM siniestros
            WHERE sseguro = vsseguro;

      DELETE FROM remesas
            WHERE sseguro = vsseguro;

      FOR reg IN recibos LOOP
         p_tab_error(f_sysdate, 'CONF_BORR', 'bucle 2 recibos', 1,
                     ' reg.nrecibo --> ' || reg.nrecibo, 'OK');

         DELETE FROM recibosclon
               WHERE nreciboant = reg.nrecibo;

         DELETE FROM adm_recunif
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM recanudevban
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cnvrecibos
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre_total01
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre_total02
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre_total03
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre_total04
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre001
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre002
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre003
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre004
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre01
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre02
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre03
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre04
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre05
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre06
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre07
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cuadre08
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM cartaavis
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM agentescob
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM detrecibos
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM recibosredcom
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM devbanrecibos
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM adm_recunif_his
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM liquidalin
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM liquidalincia
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM domiciliaciones
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM extrarec
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM ctacoaseguro
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM tmp_impagados
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM int_reparto_ctactes
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM detrecmovsegurocol
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM detrecmovsegurocol
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM detmovrecibo_parcial --conf
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM detmovrecibo
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM liqmovrec
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM movreciboi
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM movrecibo
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM vdetrecibos_monpol
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM vdetrecibos
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM detrecibos
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM adm_recunif
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM hisrecibos
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM notificaciones
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM traspacarage
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM comrecibo
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM agd_movobs
               WHERE (cempres, idobs) IN(SELECT cempres, idobs
                                           FROM agd_observaciones
                                          WHERE nrecibo = reg.nrecibo);

         DELETE FROM agd_observaciones
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM adm_liquida_recibos
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM remuneracion_canal_rec
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM recibos_comp
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM detrecibos_fcambio --conf
               WHERE nrecibo = reg.nrecibo;

         DELETE FROM recibos
               WHERE nrecibo = reg.nrecibo;
      END LOOP;

      -- Seguimos con tablas de seguros.
      DELETE FROM ppnc_previo
            WHERE sseguro = vsseguro;

      DELETE FROM ppnc
            WHERE sseguro = vsseguro;

      DELETE FROM ibnr
            WHERE sseguro = vsseguro;

      DELETE FROM ibnr_previo
            WHERE sseguro = vsseguro;

      DELETE FROM ppnc_previo
            WHERE sseguro = vsseguro;

      DELETE FROM clausuesp
            WHERE sseguro = vsseguro;

      DELETE FROM hisagensegu
            WHERE sseguro = vsseguro;

      DELETE FROM agensegu
            WHERE sseguro = vsseguro;

      DELETE FROM motreten_rev
            WHERE sseguro = vsseguro;

      DELETE FROM motretencion
            WHERE sseguro = vsseguro;

      DELETE FROM historicoriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM agentescob
            WHERE sseguro = vsseguro;

      DELETE FROM ctaseguro_detalle_previo
            WHERE sseguro = vsseguro;

      DELETE FROM ctaseguro_libreta_previo
            WHERE sseguro = vsseguro;

      DELETE FROM ctaseguro_libreta
            WHERE sseguro = vsseguro;

      DELETE FROM ctaseguro_previo
            WHERE sseguro = vsseguro;

      DELETE FROM ctaseguro_detalle
            WHERE sseguro = vsseguro;

      DELETE FROM ctaseguro
            WHERE sseguro = vsseguro;

      DELETE FROM provmat_previo
            WHERE sseguro = vsseguro;

      DELETE FROM provmat
            WHERE sseguro = vsseguro;

      DELETE FROM planrentasextra
            WHERE sseguro = vsseguro;

      DELETE FROM movpagren
            WHERE srecren IN(SELECT srecren
                               FROM pagosrenta
                              WHERE sseguro = vsseguro);

      DELETE FROM autconductores
            WHERE sseguro = vsseguro;

      DELETE FROM autdetriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM autriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM historicoseguros
            WHERE sseguro = vsseguro;

      DELETE FROM historicooficinas
            WHERE sseguro = vsseguro;

      DELETE FROM pagosrenta
            WHERE sseguro = vsseguro;

      DELETE FROM carenseg
            WHERE sseguro = vsseguro;

      DELETE FROM agd_movobs
            WHERE (cempres, idobs) IN(SELECT cempres, idobs
                                        FROM agd_observaciones
                                       WHERE sseguro = vsseguro);

      DELETE FROM agd_observaciones
            WHERE sseguro = vsseguro;

      DELETE FROM agd_poliza
            WHERE sseguro = vsseguro;

      DELETE FROM segdisin
            WHERE sseguro = vsseguro;

      DELETE FROM segdisin2
            WHERE sseguro = vsseguro;

      DELETE FROM notibajagar
            WHERE sseguro = vsseguro;

      DELETE FROM ctactes
            WHERE sseguro = vsseguro;

      DELETE FROM notibajaseg
            WHERE sseguro = vsseguro;

      DELETE FROM excluseg
            WHERE sseguro = vsseguro;

      DELETE FROM anuexcluseg
            WHERE sseguro = vsseguro;

      DELETE FROM resulseg
            WHERE sseguro = vsseguro;

      DELETE FROM anudetgaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM anudetprimas --conf
            WHERE sseguro = vsseguro;

      DELETE FROM anugaranseg
            WHERE sseguro = vsseguro;

      DELETE      anubenespseg
            WHERE sseguro = vsseguro;

      DELETE FROM anuriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM pregunpolseg
            WHERE sseguro = vsseguro;

      DELETE FROM pregunsegtab
            WHERE sseguro = vsseguro;

      DELETE FROM pregunseg
            WHERE sseguro = vsseguro;

      DELETE FROM comisigaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM pregungaransegtab
            WHERE sseguro = vsseguro;

      DELETE FROM pregungaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM seg_cbancar
            WHERE sseguro = vsseguro;

      DELETE FROM detgaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM DETPRIMAS --conf
            WHERE sseguro = vsseguro;
            
      DELETE FROM garanseg
            WHERE sseguro = vsseguro;

      DELETE FROM asegurados
            WHERE sseguro = vsseguro;

      DELETE FROM motretencion
            WHERE sseguro = vsseguro;

      DELETE FROM tomadores
            WHERE sseguro = vsseguro;

      DELETE FROM reglassegtramos
            WHERE sseguro = vsseguro;

      DELETE FROM reglasseg
            WHERE sseguro = vsseguro;

      DELETE FROM histomadores
            WHERE sseguro = vsseguro;

      DELETE FROM claubenseg
            WHERE sseguro = vsseguro;

      DELETE FROM clauparaseg
            WHERE sseguro = vsseguro;

      DELETE FROM claususeg
            WHERE sseguro = vsseguro;

      DELETE FROM sitriesgo
            WHERE sseguro = vsseguro;

      DELETE FROM cesionesrea
            WHERE sseguro = vsseguro;

      DELETE FROM reembactosfac
            WHERE nreemb IN(SELECT nreemb
                              FROM reembolsos
                             WHERE sseguro = vsseguro);

      DELETE FROM reembfact
            WHERE nreemb IN(SELECT nreemb
                              FROM reembolsos
                             WHERE sseguro = vsseguro);

      DELETE FROM reembolsos
            WHERE sseguro = vsseguro;

      DELETE FROM saldodeutorseg
            WHERE sseguro = vsseguro;

      DELETE FROM prestamoseg
            WHERE sseguro = vsseguro;

      DELETE FROM anupregunseg
            WHERE sseguro = vsseguro;

      DELETE FROM anupregunpolseg
            WHERE sseguro = vsseguro;

      DELETE FROM anupregungaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM anumotretencion
            WHERE sseguro = vsseguro;

      DELETE FROM anudetmovseguro
            WHERE sseguro = vsseguro;

      DELETE FROM anuasegurados
            WHERE sseguro = vsseguro;

      DELETE FROM prestaextrapp
            WHERE sseguro = vsseguro;

      DELETE FROM prestaplan
            WHERE sseguro = vsseguro;

      DELETE FROM benespseg
            WHERE sseguro = vsseguro;

      DELETE FROM bf_bonfranseg --conf
            WHERE sseguro = vsseguro;

      DELETE FROM asegurados_innom --conf
            WHERE sseguro = vsseguro;

      DELETE FROM riesgos
            WHERE sseguro = vsseguro;

      DELETE FROM anupsucontrolseg
            WHERE sseguro = vsseguro;

      DELETE FROM psucontrolseg
            WHERE sseguro = vsseguro;

      DELETE FROM docrequerida
            WHERE sseguro = vsseguro;

      DELETE FROM traspacarage
            WHERE sseguro = vsseguro;

      DELETE FROM traspacarage
            WHERE sseguro = vsseguro;

      DELETE FROM pregunpolcar
            WHERE sseguro = vsseguro;

      DELETE FROM cuafacul
            WHERE sseguro = vsseguro;

      DELETE FROM fis_rescate
            WHERE sseguro = vsseguro;

      DELETE FROM seguredcom
            WHERE sseguro = vsseguro;

      DELETE FROM segcartera
            WHERE sseguro = vsseguro;

      DELETE FROM motanumov
            WHERE sseguro = vsseguro;

      DELETE FROM seguredcom2
            WHERE sseguro = vsseguro;

      DELETE FROM segurosredcom
            WHERE sseguro = vsseguro;

      DELETE FROM intertecseg
            WHERE sseguro = vsseguro;

      DELETE FROM texmovseguro
            WHERE sseguro = vsseguro;

      DELETE FROM detrecmovsegurocol
            WHERE sseguro_0 = vsseguro;

      DELETE FROM detrecmovsegurocol
            WHERE sseguro_cert = vsseguro;

      DELETE FROM detmovsegurocol
            WHERE sseguro_0 = vsseguro;

      DELETE FROM detmovsegurocol
            WHERE sseguro_cert = vsseguro;

      DELETE FROM prestcuadroseg
            WHERE sseguro = vsseguro;

      DELETE FROM evoluprovmatseg
            WHERE sseguro = vsseguro;

      DELETE FROM detmovseguro
            WHERE sseguro = vsseguro;

      DELETE FROM pbex
            WHERE sseguro = vsseguro;

      DELETE FROM pbex_previo
            WHERE sseguro = vsseguro;

      DELETE FROM psu_retenidas
            WHERE sseguro = vsseguro;

      DELETE FROM anupsu_retenidas
            WHERE sseguro = vsseguro;

      DELETE FROM movseguro
            WHERE sseguro = vsseguro;

      DELETE FROM ctaseguro_libreta
            WHERE sseguro = vsseguro;

      DELETE FROM ctaseguro
            WHERE sseguro = vsseguro;

      DELETE FROM seguros_act
            WHERE sseguro = vsseguro;

      DELETE FROM seguredcom
            WHERE sseguro = vsseguro;

      DELETE FROM segurosredcom
            WHERE sseguro = vsseguro;

      DELETE FROM alm_proc_det_prev
            WHERE sseguro = vsseguro;

      DELETE FROM alm_proceso_det
            WHERE sseguro = vsseguro;

      DELETE FROM seguros_assp
            WHERE sseguro = vsseguro;

      DELETE FROM seguros_ren
            WHERE sseguro = vsseguro;

      DELETE FROM seguros_ulk
            WHERE sseguro = vsseguro;

      DELETE FROM seguros_aho
            WHERE sseguro = vsseguro;

      DELETE FROM envio_cobfall_dgs
            WHERE sseguro = vsseguro;

      DELETE FROM gescartas
            WHERE sseguro = vsseguro;

      DELETE FROM hispagosrenta
            WHERE sseguro = vsseguro;

      --Esborrat dels documents de gedox
      FOR cr_doc IN docum_gedox LOOP
         pac_axisgedox.borrar_documento(cr_doc.iddocgedox, vt_mensaje);
      END LOOP;

      DELETE FROM aportaseg
            WHERE sseguro = vsseguro;

      DELETE FROM primas_consumidas
            WHERE sseguro = vsseguro;

      DELETE FROM tmp_primas_consumidas
            WHERE sseguro = vsseguro;

      DELETE FROM ext_liquidalin
            WHERE cempres = vcempres;

      DELETE FROM bloqueoseg
            WHERE sseguro = vsseguro;

      DELETE FROM docummovseg
            WHERE sseguro = vsseguro;

      DELETE FROM coacedido
            WHERE sseguro = vsseguro;

      DELETE FROM coacuadro
            WHERE sseguro = vsseguro;

      DELETE FROM remuneracion_canal_pol
            WHERE sseguro = vsseguro;

      DELETE FROM tmp234_out
            WHERE stras IN(SELECT stras
                             FROM trasplainout
                            WHERE sseguro = vsseguro);

      DELETE FROM trasplainout
            WHERE sseguro = vsseguro;

      DELETE FROM reamovpagos
            WHERE sseguro = vsseguro;

      DELETE FROM age_corretaje
            WHERE sseguro = vsseguro;

      DELETE FROM ctacoaseguro
            WHERE sseguro = vsseguro;

      DELETE FROM ctacoaseguroaux
            WHERE sseguro = vsseguro;
            
      DELETE FROM suspensionseg
            WHERE sseguro = vsseguro;
            
      DELETE FROM ctgar_seguro--conf
            WHERE sseguro = vsseguro;

      DELETE FROM seguros
            WHERE sseguro = vsseguro;

      v_contador := v_contador + 1;

      IF MOD(v_contador, 200) = 0 THEN
         COMMIT;--
         NULL;
      END IF;
   END LOOP;

   COMMIT;--
   DBMS_OUTPUT.put_line(' Hemos borrado los SEGUROS -->  OK ! ');
   p_tab_error(f_sysdate, 'CONF_BORR', 'Borrado SEGUROS', 1,
               ' Hemos borrado los SEGUROS -->  OK ! ', 'OK');

   FOR reg IN (SELECT DISTINCT sperson
                          FROM estper_personas) LOOP
      DELETE FROM estper_ccc
            WHERE sperson = reg.sperson;

      DELETE FROM estper_contactos
            WHERE sperson = reg.sperson;

      DELETE FROM estper_direcciones
            WHERE sperson = reg.sperson;

      DELETE FROM estper_identificador
            WHERE sperson = reg.sperson;

      DELETE FROM estper_irpf
            WHERE sperson = reg.sperson;

      DELETE FROM estper_lopd
            WHERE sperson = reg.sperson;

      DELETE FROM estper_regimenfiscal
            WHERE sperson = reg.sperson;

      DELETE FROM estper_nacionalidades
            WHERE sperson = reg.sperson;

      DELETE FROM estper_vinculos
            WHERE sperson = reg.sperson;

      DELETE FROM estper_parpersonas
            WHERE sperson = reg.sperson;

      DELETE FROM estper_detper
            WHERE sperson = reg.sperson;

      DELETE FROM estper_personas
            WHERE sperson = reg.sperson;
   END LOOP;

   COMMIT;--
   DBMS_OUTPUT.put_line(' Hemos borrado las ESTPERSONAS -->  OK ! ');
   p_tab_error(f_sysdate, 'CONF_BORR', 'Borrado ESTPERSONAS', 2,
               ' Hemos borrado las ESTPERSONAS -->  OK ! ', 'OK');

   FOR reg IN (SELECT sperson
                 FROM per_personas
                WHERE sperson NOT IN(SELECT NVL(sperson, -1)
                                       FROM companias
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM fonpensiones
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM gestoras
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM agentes
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM empresas
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM promotores
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM empleados
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM representantes
                                     UNION
                                     SELECT NVL(spercoord, -1)
                                       FROM representantes
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM usuarios
                                     UNION
                                     SELECT NVL(sperson, -1)
                                       FROM sin_prof_profesionales)) 
    LOOP
      --
      p_tab_error(f_sysdate, 'CONF_BORR', 'bucle 3 regper', 1, ' sperson --> ' || reg.sperson, 'OK');
      --
      DELETE FROM asegurados
            WHERE sperson = reg.sperson;

      DELETE FROM tomadores
            WHERE sperson = reg.sperson;

      DELETE FROM cumulos
            WHERE sperson = reg.sperson;

      DELETE FROM lre_personas
            WHERE sperlre = reg.sperson;

      DELETE FROM proveedores
            WHERE sperson = reg.sperson;

      DELETE FROM per_sarlaft
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_sarlaft
            WHERE sperson = reg.sperson;

      DELETE FROM per_documentos
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_documentos
            WHERE sperson = reg.sperson;

      DELETE FROM per_regimenfiscal
            WHERE sperson = reg.sperson;

      DELETE FROM per_personas_rel
            WHERE sperson = reg.sperson;

      DELETE FROM per_personas_rel
            WHERE sperson_rel = reg.sperson;

      DELETE FROM hisper_personas_rel
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_personas_rel
            WHERE sperson_rel = reg.sperson;

      DELETE FROM per_direcciones
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_direcciones
            WHERE sperson = reg.sperson;

      DELETE FROM per_ccc
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_ccc
            WHERE sperson = reg.sperson;

      DELETE FROM per_contactos
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_contactos
            WHERE sperson = reg.sperson;

      DELETE FROM per_identifica
            WHERE sperson = reg.sperson;

      DELETE FROM per_identificador
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_identificador
            WHERE sperson = reg.sperson;

      DELETE FROM per_irpf
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_irpf
            WHERE sperson = reg.sperson;

      DELETE FROM per_irpfdescen
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_irpfdescen
            WHERE sperson = reg.sperson;

      DELETE FROM per_irpfmayores
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_irpfmayores
            WHERE sperson = reg.sperson;

      DELETE FROM perlopd_contactos
            WHERE sperson = reg.sperson;

      DELETE FROM hisperlopd_contactos
            WHERE sperson = reg.sperson;

      DELETE FROM per_lopd
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_lopd
            WHERE sperson = reg.sperson;

      DELETE FROM per_nacionalidades
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_nacionalidades
            WHERE sperson = reg.sperson;

      DELETE FROM per_potencial
            WHERE sperson = reg.sperson;

      DELETE FROM per_vinculos
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_vinculos
            WHERE sperson = reg.sperson;

      DELETE FROM per_parpersonas
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_parpersonas --CONF
            WHERE sperson = reg.sperson;

      DELETE FROM per_detper
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_detper
            WHERE sperson = reg.sperson;

      DELETE FROM irpfpersonas
            WHERE sperson = reg.sperson;

      DELETE FROM remuneracion_canal
            WHERE sperson = reg.sperson;          

      FOR f IN (SELECT sfinanci FROM fin_general WHERE sperson = reg.sperson)
      LOOP
        --
        DELETE FROM FIN_ENDEUDAMIENTO
              WHERE sfinanci = f.sfinanci; --conf
        --
      DELETE FROM fin_indicadores
              WHERE sfinanci = f.sfinanci; --conf
        --
        DELETE FROM fin_d_renta
              WHERE sfinanci = f.sfinanci; --conf
        --
      END LOOP;
      --
      DELETE FROM sin_tramita_destinatario
            WHERE sperson = reg.sperson; --conf
      --
      DELETE FROM per_contragarantia
            WHERE sperson = reg.sperson; --conf
      --
      DELETE FROM fin_general
            WHERE sperson = reg.sperson; --conf

      DELETE FROM sin_tramita_destinatario
            WHERE sperson = reg.sperson; --conf
            
      DELETE FROM ctgar_codeudor
            WHERE sperson = reg.sperson; --conf

      DELETE FROM per_personas
            WHERE sperson = reg.sperson;

      DELETE FROM hisper_personas
            WHERE sperson = reg.sperson;

      COMMIT;--
   END LOOP;
   --
   COMMIT;--
   DBMS_OUTPUT.put_line(' Hemos borrado las PERSONAS -->  OK ! ');
   p_tab_error(f_sysdate, 'CONF_BORR', 'Borrado PERSONAS', 3, ' Hemos borrado las PERSONAS -->  OK ! ', 'OK');

   FOR reggar IN c_estseguros LOOP
      vsseguro := reggar.sseguro;

      DELETE FROM estdocrequerida
            WHERE sseguro = vsseguro;

      DELETE FROM estreemplazos
            WHERE sseguro = vsseguro;

      DELETE FROM estevoluprovmatseg
            WHERE sseguro = vsseguro;

      DELETE FROM estpsucontrolseg
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_act
            WHERE sseguro = vsseguro;

      DELETE FROM estpenaliseg
            WHERE sseguro = vsseguro;

      DELETE FROM estsegdisin2
            WHERE sseguro = vsseguro;

      DELETE FROM estpresttitulares
            WHERE sseguro = vsseguro;

      DELETE FROM estintertecseggar
            WHERE sseguro = vsseguro;

      DELETE FROM estclaubenseg
            WHERE sseguro = vsseguro;

      DELETE FROM estseg_cbancar
            WHERE sseguro = vsseguro;

      DELETE FROM estintertecseg
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_ren
            WHERE sseguro = vsseguro;

      DELETE FROM estpregungaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM estmotreten_rev
            WHERE sseguro = vsseguro;

      DELETE FROM estdetgaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM estgaranseg_sbpri
            WHERE sseguro = vsseguro;

      DELETE FROM estgaranseggas
            WHERE sseguro = vsseguro;

      DELETE FROM estevoluprovmatseg
            WHERE sseguro = vsseguro;

      DELETE FROM estcoacedido --con
            WHERE sseguro = vsseguro;

      DELETE FROM estcoacuadro
            WHERE sseguro = vsseguro;

      DELETE FROM estcoacedido
            WHERE sseguro = vsseguro;

      DELETE FROM esttomadores
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_ulk
            WHERE sseguro = vsseguro;

      DELETE FROM estmotretencion
            WHERE sseguro = vsseguro;

      DELETE FROM estclauparseg
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_assp
            WHERE sseguro = vsseguro;

      DELETE FROM estriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM estautriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM estprestcuadroseg
            WHERE sseguro = vsseguro;

      DELETE FROM estpregunseg
            WHERE sseguro = vsseguro;

      DELETE FROM estpregunpolseg
            WHERE sseguro = vsseguro;

      DELETE FROM estplanrentasirreg
            WHERE sseguro = vsseguro;

      DELETE FROM estgaransegcom
            WHERE sseguro = vsseguro;

      DELETE FROM estgaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM estpregungaranseg
            WHERE sseguro = vsseguro;

      DELETE FROM estpregunpolseg
            WHERE sseguro = vsseguro;

      DELETE FROM estpregunseg
            WHERE sseguro = vsseguro;

      DELETE FROM estriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM estseg_cbancar
            WHERE sseguro = vsseguro;

      DELETE FROM esttomadores
            WHERE sseguro = vsseguro;

      DELETE FROM estclaususeg
            WHERE sseguro = vsseguro;

      DELETE FROM estexclugarseg
            WHERE sseguro = vsseguro;

      DELETE FROM estdetembarcriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM estassegurats
            WHERE sseguro = vsseguro;

      DELETE FROM estcomisionsegu
            WHERE sseguro = vsseguro;

      DELETE FROM estdetmovseguro
            WHERE sseguro = vsseguro;

      DELETE FROM estevoluprovmatseg
            WHERE sseguro = vsseguro;

      DELETE FROM estprestamoseg
            WHERE sseguro = vsseguro;

      DELETE FROM estresulseg
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_act
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_aho
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_assp
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_ren
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros_ulk
            WHERE sseguro = vsseguro;

      DELETE FROM estautdetriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM estdetembarcriesgos
            WHERE sseguro = vsseguro;

      DELETE FROM estdetmovseguro
            WHERE sseguro = vsseguro;

      DELETE FROM estage_corretaje
            WHERE sseguro = vsseguro;

      DELETE FROM estagensegu --conf
            WHERE sseguro = vsseguro;

      DELETE FROM estseguros
            WHERE sseguro = vsseguro;

      COMMIT;--
   END LOOP;

   COMMIT;--
   DBMS_OUTPUT.put_line(' Hemos borrado las tablas dependientes de ESTSEGUROS -->  OK ! ');
   p_tab_error(f_sysdate, 'CONF_BORR', 'Borrado ESTSEGUROS', 4,
               ' Hemos borrado las tablas dependientes de ESTSEGUROS -->  OK ! ', 'OK');

   DELETE      reaseguro
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      reariesgos
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      movctatecnica
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      reaseguroaux
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      movctaaux
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      ctapb
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      ctapbaux
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      liqresreaaux
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      liqresreaaux_err
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      detreasegemi
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   DELETE      reasegemi
         WHERE sseguro IN(SELECT sseguro
                            FROM cesionesrea
                           WHERE scontra IN(SELECT scontra
                                              FROM codicontratos
                                             WHERE cempres = vcempres));

   DELETE      cesionesrea
         WHERE scontra IN(SELECT scontra
                            FROM codicontratos
                           WHERE cempres = vcempres);

   COMMIT;--
   DBMS_OUTPUT.put_line(' Hemos borrado datos de REASEGURO -->  OK ! ');
   p_tab_error(f_sysdate, 'CONF_BORR', 'Borrado datos de REASEGURO', 8,
               ' Hemos borrado datos de REASEGURO -->  OK ! ', 'OK');

--   DELETE FROM cablibsin
--         WHERE cempres = vcempres;
   DELETE FROM cabventasaux
         WHERE cempres = vcempres;

--   DELETE FROM cabventascontabaux
--         WHERE cempres = vcempres;
   DELETE FROM cap_carrega_col
         WHERE cempres = vcempres;

--   DELETE FROM cobbancario_tmp
--         WHERE cempres = vcempres;
   DELETE FROM devbanordenantes
         WHERE ccobban IN(SELECT ccobban
                            FROM cobbancario
                           WHERE cempres = vcempres);

   DELETE FROM detcontab
         WHERE cempres = vcempres;

   DELETE FROM contab
         WHERE cempres = vcempres;

   DELETE FROM contab_asient_dia
         WHERE cempres = vcempres;

   DELETE FROM ctactes_previo
         WHERE cempres = vcempres;

   DELETE FROM ctactes
         WHERE cempres = vcempres;

   DELETE FROM ctactescia
         WHERE cempres = vcempres;

   DELETE FROM ctapb
         WHERE cempres = vcempres;

   DELETE FROM ctapbaux
         WHERE cempres = vcempres;

   DELETE FROM ctrl_provis
         WHERE cempres = vcempres;

--   DELETE FROM cuadremerita
--         WHERE cempres = vcempres;
   DELETE FROM cuadre_cc
         WHERE cempres = vcempres;

   DELETE FROM devbanordenantes
         WHERE sdevolu IN(SELECT sdevolu
                            FROM devbanpresentadores
                           WHERE cempres = vcempres);

   DELETE FROM devbanpresentadores
         WHERE cempres = vcempres;

   DELETE FROM difseguros
         WHERE cempres = vcempres;

   COMMIT;--

   DELETE FROM notificaciones
         WHERE cempres = vcempres;

   DELETE FROM domiciliaciones
         WHERE cempres = vcempres;

--   DELETE FROM estado_recibos
--         WHERE cempres = vcempres;
   DELETE FROM fis_detcierrecobro
         WHERE sfiscab IN(SELECT sfiscab
                            FROM fis_cabcierre
                           WHERE cempres = vcempres);

   DELETE FROM fis_detcierrepago
         WHERE sfiscab IN(SELECT sfiscab
                            FROM fis_cabcierre
                           WHERE cempres = vcempres);

   DELETE FROM fis_cabcierre
         WHERE cempres = vcempres;

--   DELETE FROM fis_cabcierre_tmp
--         WHERE cempres = vcempres;
   DELETE FROM tmp_vliquidativos2
         WHERE ccesta IN(SELECT ccodfon
                           FROM fondos
                          WHERE cempres = vcempres);

   DELETE FROM historicoseguros
         WHERE cempres = vcempres;

   DELETE FROM remuneracion_canal
         WHERE cempres = vcempres;

   DELETE FROM hisventas
         WHERE cempres = vcempres;

   DELETE FROM his_contable
         WHERE cempres = vcempres;

   DELETE FROM his_contab_asient
         WHERE cempres = vcempres;

   DELETE FROM his_recibos
         WHERE cempres = vcempres;

--   DELETE FROM his_reciboscar
--         WHERE cempres = vcempres;
   COMMIT;--

--   DELETE FROM his_recibosredcom
--         WHERE cempres = vcempres;

   --   DELETE FROM his_seguros
--         WHERE cempres = vcempres;

   --   DELETE FROM his_ventas
--         WHERE cempres = vcempres;

   --   DELETE FROM his_ventasaux
--         WHERE cempres = vcempres;

   --   DELETE FROM his_ventascontab
--         WHERE cempres = vcempres;

   --   DELETE FROM his_ventascontabaux
--         WHERE cempres = vcempres;
   DELETE FROM ibnr
         WHERE cempres = vcempres;

   DELETE FROM ibnr_previo
         WHERE cempres = vcempres;

   DELETE FROM upr
         WHERE cempres = vcempres;

   DELETE FROM upr_previo
         WHERE cempres = vcempres;

   DELETE FROM ldg
         WHERE cempres = vcempres;

   DELETE FROM ldg_previo
         WHERE cempres = vcempres;

   DELETE FROM liqresreaaux
         WHERE cempres = vcempres;

   DELETE FROM liqresreaaux_err
         WHERE cempres = vcempres;

   DELETE FROM liquidalin
         WHERE cempres = vcempres;

   DELETE FROM liquidacab
         WHERE cempres = vcempres;

   DELETE FROM liquidalincia
         WHERE cempres = vcempres;

   DELETE FROM liquidacabcia
         WHERE cempres = vcempres;

   DELETE FROM liquida_dia
         WHERE cempres = vcempres;

--   DELETE FROM listimpcabaux
--         WHERE cempres = vcempres;

   --   DELETE FROM margenbruto
--         WHERE cempres = vcempres;
   DELETE FROM medpago
         WHERE cempres = vcempres;

   DELETE FROM meritacion
         WHERE cempres = vcempres;

   DELETE FROM mig_cargas
         WHERE cempres = vcempres;

   DELETE FROM mig_seguros
         WHERE cempres = vcempres;

   DELETE FROM movctaaux
         WHERE cempres = vcempres;

   COMMIT;--

--   DELETE FROM movctatecnica_aux
--         WHERE cempres = vcempres;
   DELETE FROM movventas
         WHERE cempres = vcempres;

   DELETE FROM movventascontab
         WHERE cempres = vcempres;

   DELETE FROM pbex
         WHERE cempres = vcempres;

   DELETE FROM pestab
         WHERE cempres = vcempres;

   DELETE FROM pestab_previo
         WHERE cempres = vcempres;

   DELETE FROM ppnc
         WHERE cempres = vcempres;

   DELETE FROM ppnc_cia
         WHERE cempres = vcempres;

   DELETE FROM ppnc_previo
         WHERE cempres = vcempres;

   DELETE FROM pppc
         WHERE cempres = vcempres;

   DELETE FROM pppc_previo
         WHERE cempres = vcempres;

   DELETE FROM pppc_lcol
         WHERE cempres = vcempres;

   DELETE FROM pppc_lcol_previ
         WHERE cempres = vcempres;

   DELETE FROM pppc_lcol_matriz
         WHERE cempres = vcempres;

   DELETE FROM pppc_lcol_matriz_previ
         WHERE cempres = vcempres;

   DELETE FROM domici
         WHERE sproces IN(SELECT sproces
                            FROM procesoscab
                           WHERE cempres = vcempres);

   DELETE FROM procesoslin
         WHERE sproces IN(SELECT sproces
                            FROM procesoscab
                           WHERE cempres = vcempres);

   DELETE FROM detflujo_pasivos
         WHERE sproces IN(SELECT sproces
                            FROM procesoscab
                           WHERE cempres = vcempres);

   DELETE FROM flujo_pasivos
         WHERE sproces IN(SELECT sproces
                            FROM procesoscab
                           WHERE cempres = vcempres);

   DELETE FROM recanudevban
         WHERE sprocini IN(SELECT sproces
                             FROM procesoscab
                            WHERE cempres = vcempres);

   DELETE FROM traspacar
         WHERE sproces IN(SELECT sproces
                            FROM procesoscab
                           WHERE cempres = vcempres);

   DELETE FROM traspacar
         WHERE cempres = vcempres;

   DELETE FROM procesoscab
         WHERE cempres = vcempres;

   DELETE FROM provmat
         WHERE cempres = vcempres;

   COMMIT;--

   DELETE FROM provmat_previo
         WHERE cempres = vcempres;

   DELETE FROM ptpplp
         WHERE cempres = vcempres;

   DELETE FROM ptpplp_cia
         WHERE cempres = vcempres;

   DELETE FROM ptpplp_previo
         WHERE cempres = vcempres;

   DELETE FROM ptpplp_lcol
         WHERE cempres = vcempres;

   DELETE FROM ptpplp_lcol_previo
         WHERE cempres = vcempres;

   DELETE FROM reaseguro
         WHERE cempres = vcempres;

   DELETE FROM reaseguroaux
         WHERE cempres = vcempres;

   DELETE FROM reaseguro_snv
         WHERE cempres = vcempres;

   DELETE FROM reasiniaux
         WHERE cempres = vcempres;

   DELETE FROM reasiniaux_bak
         WHERE cempres = vcempres;

--   DELETE FROM recibos_2005
--         WHERE cempres = vcempres;

   --   DELETE FROM recibos_tmp
--         WHERE cempres = vcempres;

   --   DELETE FROM seguros_carga7
--         WHERE cempres = vcempres;
   DELETE FROM seguros_fcaranu
         WHERE cempres = vcempres;

   DELETE FROM seguros_fcarpro
         WHERE cempres = vcempres;

--   DELETE FROM seguros_tmp
--         WHERE cempres = vcempres;
   DELETE FROM siniestros_cc
         WHERE cempres = vcempres;

--   DELETE FROM tmp_seguredcom
--         WHERE cempres = vcempres;

   --   DELETE FROM tmp_segurosredcom
--         WHERE cempres = vcempres;

   --   DELETE FROM t_audito_ppnc
--         WHERE cempres = vcempres;

   --   DELETE FROM t_audito_provprest
--         WHERE cempres = vcempres;
   DELETE FROM ventas
         WHERE cempres = vcempres;

   DELETE FROM resumfinv
         WHERE cempres = vcempres;

   DELETE FROM int_reparto_ctactes
         WHERE cempres = vcempres;

   DELETE FROM estado_proc_recibos
         WHERE cempres = vcempres;

   DELETE FROM procesoslin
         WHERE sproces IN(SELECT sproces
                            FROM procesoscab
                           WHERE cempres = vcempres);

   DELETE FROM procesoscab
         WHERE cempres = vcempres;

   DELETE FROM remesas
         WHERE cempres = vcempres;

   DELETE FROM ventasaux
         WHERE cempres = vcempres;

   DELETE FROM ventascontab
         WHERE cempres = vcempres;

   DELETE FROM ventascontabaux
         WHERE cempres = vcempres;

   COMMIT;--
   DBMS_OUTPUT.put_line(' Hemos borrado dependencias EMPRESA -->  OK ! ');
   p_tab_error(f_sysdate, 'CONF_BORR', 'Borrado dependencias EMPRESA', 9,
               ' Hemos borrado dependencias EMPRESA -->  OK ! ', 'OK');
/*EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('Error al borrar ' || SQLERRM);
      p_tab_error(f_sysdate, 'CONF_BORR', 'Error al borrar', 0, SQLCODE, SQLERRM);
      rollback;*/
END;
/
--select * from rango_dian_movseguro
