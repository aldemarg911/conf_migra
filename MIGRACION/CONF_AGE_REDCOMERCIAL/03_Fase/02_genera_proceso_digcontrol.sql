/* Formatted on 22/06/2012 12:14 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
DECLARE
   vlinea         VARCHAR2(2000);
BEGIN
   vlinea := 'DECLARE';
   p_control_error('txema_mig', 'actualiza digito', vlinea);
   vlinea := 'vconf          VARCHAR2(50);';
   p_control_error('txema_mig', 'actualiza digito', vlinea);
   vlinea := 'BEGIN';
   p_control_error('txema_mig', 'actualiza digito', vlinea);
   vlinea :=
           'SELECT suceso INTO vconf FROM control_error WHERE ID = ''carga_red_comercial_150'';';
   p_control_error('txema_mig', 'actualiza digito', vlinea);
   vlinea := 'IF vconf = ''END'' THEN';
   p_control_error('txema_mig', 'actualiza digito', vlinea);
   vlinea :=
           'pac_iax_login.p_iax_iniconnect(pac_parametros.f_parempresa_t(12, ''USER_BBDD''));';
   p_control_error('txema_mig', 'actualiza digito', vlinea);

   FOR x IN (SELECT '05INTERMEDIARIO' || i.mig_pk clave, tdigitoid
               FROM lcol_intermed_ext_20150731 i
              WHERE tdigitoid IS NOT NULL) LOOP
      vlinea := 'UPDATE per_personas SET tdigitoide = ' || x.tdigitoid;
      p_control_error('txema_mig', 'actualiza digito', vlinea);
      vlinea := 'WHERE sperson=(select idperson from mig_personas where mig_pk=' || CHR(39)
                || x.clave || CHR(39) || ');';
      p_control_error('txema_mig', 'actualiza digito', vlinea);
   END LOOP;

   vlinea := 'end if;';
   p_control_error('txema_mig', 'actualiza digito', vlinea);
   vlinea := 'end;';
   p_control_error('txema_mig', 'actualiza digito', vlinea);
   vlinea := '/';
   p_control_error('txema_mig', 'actualiza digito', vlinea);
END;
