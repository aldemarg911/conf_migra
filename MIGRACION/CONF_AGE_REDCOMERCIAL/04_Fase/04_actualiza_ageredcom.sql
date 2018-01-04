/* Formatted on 06/09/2012 17:20 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
--delete from ageredcom;

DECLARE
   vcagente       NUMBER;
   vcempres       NUMBER;
   vctipage       NUMBER;
   vfmovini       DATE;
   vfmovfin       DATE;
   vfbaja         DATE;
   vc00           NUMBER;
   vc01           NUMBER;
   vc02           NUMBER;
   vc03           NUMBER;
   vc04           NUMBER;
   vc05           NUMBER;
   vc06           NUMBER;
   vc07           NUMBER;
   vc08           NUMBER;
   vc09           NUMBER;
   vc10           NUMBER;
   vc11           NUMBER;
   vc12           NUMBER;
   vcpervisio     NUMBER;
   vcpernivel     NUMBER;
   vcpolvisio     NUMBER;
   vcpolnivel     NUMBER;
   votro          NUMBER := 0;

   CURSOR c_principal IS
      SELECT   a.cagente, a.fbajage, r.fmovini, r.cempres
          FROM agentes a, redcomercial r
         WHERE a.cagente = r.cagente
           AND a.cagente IN(SELECT cagente
                              FROM mig_agentes
                             WHERE ncarga = (SELECT ncarga
                                               FROM mig_cargas
                                              WHERE ID = 'carga_red_comercial_10'))
      ORDER BY a.cagente;
BEGIN
   FOR c IN c_principal LOOP
      DELETE FROM ageredcom
            WHERE cagente = c.cagente;

      vcagente := NULL;
      vcempres := NULL;
      vctipage := NULL;
      vfmovini := NULL;
      vfmovfin := NULL;
      vfbaja := NULL;
      vc00 := 0;
      vc01 := 0;
      vc02 := 0;
      vc03 := 0;
      vc04 := 0;
      vc05 := 0;
      vc06 := 0;
      vc07 := 0;
      vc08 := 0;
      vc09 := 0;
      vc10 := 0;
      vc11 := 0;
      vc12 := 0;
      vcpervisio := NULL;
      vcpernivel := NULL;
      vcpolvisio := NULL;
      vcpolnivel := NULL;

      FOR rc IN (SELECT     cempres, cagente, fmovini, fmovfin, ctipage, cpervisio, cpernivel,
                            cpolvisio, cpolnivel, cpadre
                       FROM redcomercial
                 START WITH cagente = c.cagente
                        --AND fmovini = c.fmovini
                        AND cempres = c.cempres
                 CONNECT BY cagente = PRIOR cpadre
                        AND cempres = PRIOR cempres) LOOP
         IF rc.cagente = c.cagente THEN
            vcagente := rc.cagente;
            vcempres := rc.cempres;
            vfmovini := rc.fmovini;
            vfmovfin := rc.fmovfin;
            vctipage := rc.ctipage;
            vcpervisio := rc.cpervisio;
            vcpernivel := rc.cpernivel;
            vcpolvisio := rc.cpolvisio;
            vcpolnivel := rc.cpolnivel;
            vfbaja := c.fbajage;
         END IF;

         IF votro = 1 THEN
            IF rc.ctipage = 0 THEN
               NULL;
            ELSIF rc.ctipage = 1 THEN
               vc00 := 0;
            ELSIF rc.ctipage = 2 THEN
               vc00 := 0;
               vc01 := 0;
            ELSIF rc.ctipage = 3 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
            ELSIF rc.ctipage = 4 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
            ELSIF rc.ctipage = 5 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
               vc04 := 0;
            ELSIF rc.ctipage = 6 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
               vc04 := 0;
               vc05 := 0;
            ELSIF rc.ctipage = 7 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
               vc04 := 0;
               vc05 := 0;
               vc06 := 0;
            ELSIF rc.ctipage = 8 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
               vc04 := 0;
               vc05 := 0;
               vc06 := 0;
               vc07 := 0;
            ELSIF rc.ctipage = 9 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
               vc04 := 0;
               vc05 := 0;
               vc06 := 0;
               vc07 := 0;
               vc08 := 0;
            ELSIF rc.ctipage = 10 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
               vc04 := 0;
               vc05 := 0;
               vc06 := 0;
               vc07 := 0;
               vc08 := 0;
               vc09 := 0;
            ELSIF rc.ctipage = 11 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
               vc04 := 0;
               vc05 := 0;
               vc06 := 0;
               vc07 := 0;
               vc08 := 0;
               vc09 := 0;
               vc10 := 0;
            ELSIF rc.ctipage = 12 THEN
               vc00 := 0;
               vc01 := 0;
               vc02 := 0;
               vc03 := 0;
               vc04 := 0;
               vc05 := 0;
               vc06 := 0;
               vc07 := 0;
               vc08 := 0;
               vc09 := 0;
               vc10 := 0;
               vc11 := 0;
            ELSE
               NULL;
            END IF;
         END IF;

         IF rc.fmovfin IS NOT NULL
            OR votro = 1 THEN
            vfmovini := rc.fmovini;
            vfmovfin := rc.fmovfin;
            votro := 0;
         END IF;

         IF rc.ctipage = 0 THEN
            vc00 := rc.cagente;
         ELSIF rc.ctipage = 1 THEN
            vc01 := rc.cagente;
         ELSIF rc.ctipage = 2 THEN
            vc02 := rc.cagente;
         ELSIF rc.ctipage = 3 THEN
            vc03 := rc.cagente;
         ELSIF rc.ctipage = 4 THEN
            vc04 := rc.cagente;
         ELSIF rc.ctipage = 5 THEN
            vc05 := rc.cagente;
         ELSIF rc.ctipage = 6 THEN
            vc06 := rc.cagente;
         ELSIF rc.ctipage = 7 THEN
            vc07 := rc.cagente;
         ELSIF rc.ctipage = 8 THEN
            vc08 := rc.cagente;
         ELSIF rc.ctipage = 9 THEN
            vc09 := rc.cagente;
         ELSIF rc.ctipage = 10 THEN
            vc10 := rc.cagente;
         ELSIF rc.ctipage = 11 THEN
            vc11 := rc.cagente;
         ELSIF rc.ctipage = 12 THEN
            vc12 := rc.cagente;
         ELSE
            NULL;
         END IF;

         IF rc.cpadre IS NULL THEN
            IF vcagente IS NOT NULL
               AND vcempres IS NOT NULL
               AND vfmovini IS NOT NULL THEN
               BEGIN
                  INSERT INTO ageredcom
                              (cagente, cempres, ctipage, fmovini, fmovfin, fbaja,
                               c00, c01, c02, c03, c04, c05, c06, c07, c08, c09,
                               c10, c11, c12, cpervisio, cpernivel, cpolvisio,
                               cpolnivel)
                       VALUES (vcagente, vcempres, vctipage, vfmovini, vfmovfin, vfbaja,
                               vc00, vc01, vc02, vc03, vc04, vc05, vc06, vc07, vc08, vc09,
                               vc10, vc11, vc12, vcpervisio, vcpernivel, vcpolvisio,
                               vcpolnivel);

                  COMMIT;
               EXCEPTION
                  WHEN DUP_VAL_ON_INDEX THEN
                     NULL;
               END;

               votro := 1;
            END IF;
         END IF;
      END LOOP;
   END LOOP;

   COMMIT;
END;
/