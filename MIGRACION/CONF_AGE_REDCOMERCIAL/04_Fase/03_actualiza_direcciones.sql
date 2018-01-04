/* Formatted on 07/03/2013 15:40 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
DECLARE
   vdummy         NUMBER;
   vcagentecia    NUMBER;
   vcpais         NUMBER;
   vcont          NUMBER;
   vtdomici       per_direcciones.tdomici%TYPE;
   vcdomici       per_direcciones.cdomici%TYPE;
   vsperson       per_direcciones.sperson%TYPE;
   vconf          VARCHAR2(50);
BEGIN
   SELECT suceso
     INTO vconf
     FROM control_error
    WHERE ID = 'carga_red_comercial_25';

   IF vconf = 'END' THEN
      SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(12, 'USER_BBDD'))
        INTO vdummy
        FROM DUAL;

      SELECT cagente
        INTO vcagentecia
        FROM redcomercial
       WHERE cempres = 12
         AND ctipage = 0
         AND fmovfin IS NULL
         AND cpadre IS NULL;

      vcpais := pac_parametros.f_parinstalacion_n('PAIS_DEF');

      BEGIN
         SELECT COUNT(*)
           INTO vcont
           FROM mig_direcciones
          WHERE mig_fk = '05INTERMEDIARIO05INTERMEDIARIO201302271';

         IF vcont > 0 THEN
            UPDATE per_direcciones
               SET ctipdir = 10,
                   tnomvia = '101',
                   cpostal = NULL,
                   cpoblac = 1,
                   cprovin = 11,
                   cviavp = 13,
                   clitvp = NULL,
                   cbisvp = NULL,
                   corvp = NULL,
                   nviaadco = 70,
                   clitco = 2,
                   corco = NULL,
                   nplacaco = 70,
                   cor2co = NULL,
                   cdet1ia = NULL,
                   tnum1ia = '17',
                   cdet2ia = NULL,
                   tnum2ia = NULL,
                   cdet3ia = NULL,
                   tnum3ia = NULL,
                   cusuari = f_user,
                   fmovimi = f_sysdate,
                   tdomici = pac_persona.f_tdomici(csiglas, '101', nnumvia, tcomple, 13, NULL,
                                                   NULL, NULL, 70, 2, NULL, 70, NULL, NULL,
                                                   '17', NULL, NULL, NULL, NULL)
             WHERE sperson = (SELECT idperson
                                FROM mig_personas
                               WHERE mig_pk = '05INTERMEDIARIO05INTERMEDIARIO201302271')
               AND cdomici = (SELECT cdomici
                                FROM mig_direcciones
                               WHERE mig_fk = '05INTERMEDIARIO05INTERMEDIARIO201302271'
                                 AND ncarga = (SELECT MAX(ncarga)
                                                 FROM mig_direcciones
                                                WHERE mig_fk =
                                                         '05INTERMEDIARIO05INTERMEDIARIO201302271'));
         ELSE
            vtdomici := pac_persona.f_tdomici(NULL, '101', NULL, NULL, 13, NULL, NULL, NULL,
                                              70, 2, NULL, 70, NULL, NULL, '17', NULL, NULL,
                                              NULL, NULL);

            SELECT idperson
              INTO vsperson
              FROM mig_personas
             WHERE mig_pk = '05INTERMEDIARIO05INTERMEDIARIO201302271';

            IF vsperson <> 0 THEN
               SELECT NVL(MAX(cdomici), 0) + 1
                 INTO vcdomici
                 FROM per_direcciones
                WHERE sperson = vsperson;

               INSERT INTO per_direcciones
                           (sperson, cagente, cdomici, ctipdir, tnomvia, tdomici, cpostal,
                            cpoblac, cprovin, cviavp, clitvp, cbisvp, corvp, nviaadco, clitco,
                            corco, nplacaco, cor2co, cdet1ia, tnum1ia, cdet2ia, tnum2ia,
                            cdet3ia, tnum3ia, cusuari, fmovimi)
                    VALUES (vsperson, vcagentecia, vcdomici, 10, '101', vtdomici, NULL,
                            1, 11, 13, NULL, NULL, NULL, 70, 2,
                            NULL, 70, NULL, NULL, '17', NULL, NULL,
                            NULL, NULL, f_user, f_sysdate);
            END IF;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.put_line
                            ('Error en el intermediario:05INTERMEDIARIO201302271, error : '
                             || SQLCODE || '-' || SQLERRM);
      END;

      BEGIN
         SELECT COUNT(*)
           INTO vcont
           FROM mig_direcciones
          WHERE mig_fk = '05INTERMEDIARIO05INTERMEDIARIO201303051';

         IF vcont > 0 THEN
            UPDATE per_direcciones
               SET ctipdir = 10,
                   tnomvia = '2',
                   cpostal = NULL,
                   cpoblac = 1,
                   cprovin = 54,
                   cviavp = 9,
                   clitvp = 5,
                   cbisvp = NULL,
                   corvp = NULL,
                   nviaadco = 0,
                   clitco = 14,
                   corco = NULL,
                   nplacaco = 62,
                   cor2co = NULL,
                   cdet1ia = NULL,
                   tnum1ia = NULL,
                   cdet2ia = NULL,
                   tnum2ia = NULL,
                   cdet3ia = NULL,
                   tnum3ia = NULL,
                   cusuari = f_user,
                   fmovimi = f_sysdate,
                   tdomici = pac_persona.f_tdomici(csiglas, '2', nnumvia, tcomple, 9, 5, NULL,
                                                   NULL, 0, 14, NULL, 62, NULL, NULL, NULL,
                                                   NULL, NULL, NULL, NULL)
             WHERE sperson = (SELECT idperson
                                FROM mig_personas
                               WHERE mig_pk = '05INTERMEDIARIO05INTERMEDIARIO201303051')
               AND cdomici = (SELECT cdomici
                                FROM mig_direcciones
                               WHERE mig_fk = '05INTERMEDIARIO05INTERMEDIARIO201303051'
                                 AND ncarga = (SELECT MAX(ncarga)
                                                 FROM mig_direcciones
                                                WHERE mig_fk =
                                                         '05INTERMEDIARIO05INTERMEDIARIO201303051'));
         ELSE
            vtdomici := pac_persona.f_tdomici(NULL, '2', NULL, NULL, 9, 5, NULL, NULL, 0, 14,
                                              NULL, 62, NULL, NULL, NULL, NULL, NULL, NULL,
                                              NULL);

            SELECT idperson
              INTO vsperson
              FROM mig_personas
             WHERE mig_pk = '05INTERMEDIARIO05INTERMEDIARIO201303051';

            IF vsperson <> 0 THEN
               SELECT NVL(MAX(cdomici), 0) + 1
                 INTO vcdomici
                 FROM per_direcciones
                WHERE sperson = vsperson;

               INSERT INTO per_direcciones
                           (sperson, cagente, cdomici, ctipdir, tnomvia, tdomici, cpostal,
                            cpoblac, cprovin, cviavp, clitvp, cbisvp, corvp, nviaadco, clitco,
                            corco, nplacaco, cor2co, cdet1ia, tnum1ia, cdet2ia, tnum2ia,
                            cdet3ia, tnum3ia, cusuari, fmovimi)
                    VALUES (vsperson, vcagentecia, vcdomici, 10, '2', vtdomici, NULL,
                            1, 54, 9, 5, NULL, NULL, 0, 14,
                            NULL, 62, NULL, NULL, NULL, NULL, NULL,
                            NULL, NULL, f_user, f_sysdate);
            END IF;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.put_line
                            ('Error en el intermediario:05INTERMEDIARIO201303051, error : '
                             || SQLCODE || '-' || SQLERRM);
      END;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('Error:' || SQLCODE);
      ROLLBACK;
END;
/