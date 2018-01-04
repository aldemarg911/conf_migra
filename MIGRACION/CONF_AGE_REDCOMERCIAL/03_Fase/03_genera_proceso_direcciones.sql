/* Formatted on 05/07/2012 10:23 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
DECLARE
   vlinea         VARCHAR2(2000);
   vcdomici       NUMBER;

   FUNCTION f_isnull(pvalor IN VARCHAR2, ptipo IN VARCHAR2)
      RETURN VARCHAR2 IS
   BEGIN
      IF pvalor IS NULL THEN
         RETURN 'NULL';
      END IF;

      IF ptipo = 'N' THEN
         RETURN pvalor;
      END IF;

      IF ptipo = 'V' THEN
         RETURN CHR(39) || pvalor || CHR(39);
      END IF;
   END f_isnull;
BEGIN
   vlinea := 'DECLARE';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea := 'vdummy   number;';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea := 'vcagentecia number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vcpais number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vcont number;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vtdomici per_direcciones.tdomici%TYPE;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vcdomici per_direcciones.cdomici%TYPE;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vsperson per_direcciones.sperson%TYPE;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'vconf          VARCHAR2(50);';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
--   vlinea := 'vtraza number;';
--   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   vlinea := 'BEGIN';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea :=
           'SELECT suceso INTO vconf FROM control_error WHERE ID = ''carga_red_comercial_150'';';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea := 'IF vconf = ''END'' THEN';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea :=
      'SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(12, ''USER_BBDD'')) INTO vdummy FROM dual;';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea :=
      'SELECT cagente INTO vcagentecia FROM redcomercial WHERE cempres = 12 AND ctipage = 0 AND fmovfin IS NULL AND cpadre IS NULL;';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   -- Obtenemos el pais por defecto
   vlinea := 'vcpais := pac_parametros.f_parinstalacion_n(''PAIS_DEF'');';
   p_control_error('txema_mig', 'proceso mig red comercial', vlinea);

   FOR x IN (SELECT   *
                 FROM lcol_direc_ext_20150731
             ORDER BY mig_pk) LOOP
      vlinea := 'begin';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
--      vlinea := 'vtraza := ' || x.mig_pk || ';';
--      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'select count(*) into vcont from mig_direcciones where mig_fk=' || CHR(39)
                || '05INTERMEDIARIO' || x.mig_pk || CHR(39) || ';';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'if vcont >0 then';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'UPDATE PER_DIRECCIONES SET CTIPDIR  = ' || f_isnull(x.ctipdir, 'N');
      vlinea := vlinea || ', TNOMVIA  = ' || f_isnull(x.nnumvia, 'V');
      vlinea := vlinea || ', CPOSTAL  = ' || f_isnull(x.cpostal, 'V');
      vlinea := vlinea || ', CPOBLAC  = ' || f_isnull(x.cpoblac, 'N');
      vlinea := vlinea || ', CPROVIN  = ' || f_isnull(x.cprovin, 'N');
      vlinea := vlinea || ', CVIAVP  = ' || f_isnull(x.cviavp, 'N');
      vlinea := vlinea || ', CLITVP   = ' || f_isnull(x.clitvp, 'N');
      vlinea := vlinea || ', CBISVP   = ' || f_isnull(x.cbisvp, 'N');
      vlinea := vlinea || ', CORVP    = ' || f_isnull(x.corvp, 'N');
      vlinea := vlinea || ', NVIAADCO = ' || f_isnull(x.nviaadco, 'N');
      vlinea := vlinea || ', CLITCO   = ' || f_isnull(x.clitco, 'N');
      vlinea := vlinea || ', CORCO    = ' || f_isnull(x.corco, 'N');
      vlinea := vlinea || ', NPLACACO = ' || f_isnull(x.nplacaco, 'N');
      vlinea := vlinea || ', COR2CO   = ' || f_isnull(x.cor2co, 'N');
      vlinea := vlinea || ', CDET1IA  = ' || f_isnull(x.cdet1ia, 'N');
      vlinea := vlinea || ', TNUM1IA  = ' || f_isnull(x.tnum1ia, 'V');
      vlinea := vlinea || ', CDET2IA  = ' || f_isnull(x.cdet2ia, 'N');
      vlinea := vlinea || ', TNUM2IA  = ' || f_isnull(x.tnum2ia, 'V');
      vlinea := vlinea || ', CDET3IA  = ' || f_isnull(x.cdet3ia, 'N');
      vlinea := vlinea || ', TNUM3IA  = ' || f_isnull(x.tnum3ia, 'V');
      vlinea := vlinea || ', CUSUARI  = f_user';
      vlinea := vlinea || ', FMOVIMI  = f_sysdate';
      vlinea := vlinea || ', TDOMICI  = pac_persona.f_tdomici(csiglas,'
                || f_isnull(x.nnumvia, 'V') || ', nnumvia,';
      vlinea := vlinea || 'tcomple,' || f_isnull(x.cviavp, 'N') || ', '
                || f_isnull(x.clitvp, 'N') || ',' || f_isnull(x.cbisvp, 'N') || ',';
      vlinea := vlinea || f_isnull(x.corvp, 'N') || ', ' || f_isnull(x.nviaadco, 'N') || ', '
                || f_isnull(x.clitco, 'N') || ', ' || f_isnull(x.corco, 'N') || ',';
      vlinea := vlinea || f_isnull(x.nplacaco, 'N') || ', ' || f_isnull(x.cor2co, 'N') || ', '
                || f_isnull(x.cdet1ia, 'N') || ',';
      vlinea := vlinea || f_isnull(x.tnum1ia, 'V') || ', ' || f_isnull(x.cdet2ia, 'N') || ', '
                || f_isnull(x.tnum2ia, 'V') || ',';
      vlinea := vlinea || f_isnull(x.cdet3ia, 'N') || ', ' || f_isnull(x.tnum3ia, 'V') || ')';
      vlinea := vlinea
                || ' WHERE  SPERSON  = (select idperson from mig_personas where mig_pk='
                || CHR(39) || '05INTERMEDIARIO' || x.mig_pk || CHR(39) || ')';
      vlinea := vlinea
                || ' AND    CDOMICI  = (select cdomici from mig_direcciones where mig_fk='
                || CHR(39) || '05INTERMEDIARIO' || x.mig_pk || CHR(39)
                || ' and ncarga=(select max(ncarga) from mig_direcciones where mig_fk='
                || CHR(39) || '05INTERMEDIARIO' || x.mig_pk || CHR(39) || '));';
      p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
      vlinea := 'else';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'vtdomici :=  pac_persona.f_tdomici(NULL,' || f_isnull(x.nnumvia, 'V')
                || ', NULL,';
      vlinea := vlinea || 'NULL,' || f_isnull(x.cviavp, 'N') || ', '
                || f_isnull(x.clitvp, 'N') || ',' || f_isnull(x.cbisvp, 'N') || ',';
      vlinea := vlinea || f_isnull(x.corvp, 'N') || ', ' || f_isnull(x.nviaadco, 'N') || ', '
                || f_isnull(x.clitco, 'N') || ', ' || f_isnull(x.corco, 'N') || ',';
      vlinea := vlinea || f_isnull(x.nplacaco, 'N') || ', ' || f_isnull(x.cor2co, 'N') || ', '
                || f_isnull(x.cdet1ia, 'N') || ',';
      vlinea := vlinea || f_isnull(x.tnum1ia, 'V') || ', ' || f_isnull(x.cdet2ia, 'N') || ', '
                || f_isnull(x.tnum2ia, 'V') || ',';
      vlinea := vlinea || f_isnull(x.cdet3ia, 'N') || ', ' || f_isnull(x.tnum3ia, 'V') || ');';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'select idperson into vsperson from mig_personas where mig_pk=' || CHR(39)
                || '05INTERMEDIARIO' || x.mig_pk || CHR(39) || ';';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'if vsperson <> 0 then';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea :=
         'SELECT nvl(max(cdomici),0)+1 into vcdomici from per_direcciones where sperson = vsperson;';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'INSERT INTO PER_DIRECCIONES (';
      vlinea := vlinea || 'SPERSON, CAGENTE, CDOMICI,';
      vlinea := vlinea || 'CTIPDIR, TNOMVIA,';
      vlinea := vlinea || 'TDOMICI, CPOSTAL, CPOBLAC, ';
      vlinea := vlinea || 'CPROVIN, CVIAVP, CLITVP, ';
      vlinea := vlinea || 'CBISVP, CORVP, NVIAADCO, ';
      vlinea := vlinea || 'CLITCO, CORCO, NPLACACO, ';
      vlinea := vlinea || 'COR2CO, CDET1IA, TNUM1IA, ';
      vlinea := vlinea || 'CDET2IA, TNUM2IA, CDET3IA, TNUM3IA, CUSUARI, FMOVIMI) ';
      vlinea := vlinea || 'VALUES ( vsperson, vcagentecia, vcdomici,';
      vlinea := vlinea || f_isnull(x.ctipdir, 'N') || ', ' || f_isnull(x.nnumvia, 'V') || ', ';
      vlinea := vlinea || 'vtdomici,' || f_isnull(x.cpostal, 'V') || ', '
                || f_isnull(x.cpoblac, 'N') || ', ';
      vlinea := vlinea || f_isnull(x.cprovin, 'N') || ', ' || f_isnull(x.cviavp, 'N') || ', '
                || f_isnull(x.clitvp, 'N') || ', ';
      vlinea := vlinea || f_isnull(x.cbisvp, 'N') || ', ' || f_isnull(x.corvp, 'N') || ', '
                || f_isnull(x.nviaadco, 'N') || ', ';
      vlinea := vlinea || f_isnull(x.clitco, 'N') || ', ' || f_isnull(x.corco, 'N') || ', '
                || f_isnull(x.nplacaco, 'N') || ', ';
      vlinea := vlinea || f_isnull(x.cor2co, 'N') || ', ' || f_isnull(x.cdet1ia, 'N') || ', '
                || f_isnull(x.tnum1ia, 'V') || ', ';
      vlinea := vlinea || f_isnull(x.cdet2ia, 'N') || ', ' || f_isnull(x.tnum2ia, 'V') || ', '
                || f_isnull(x.cdet3ia, 'N') || ', ' || f_isnull(x.tnum3ia, 'V')
                || ', F_USER, F_SYSDATE);';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'end if;';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'end if;';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'exception when others then';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'dbms_output.put_line(' || CHR(39) || 'Error en el intermediario:' || x.mig_pk
                || ', error : ' || CHR(39) || '||sqlcode||' || CHR(39) || '-' || CHR(39)
                || '||sqlerrm);';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
      vlinea := 'end;';
      p_control_error('txema_mig', 'proceso mig red comercial', vlinea);
   END LOOP;

   vlinea := 'end if;';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea := 'exception when others then';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea := 'dbms_output.put_line(' || CHR(39) || 'Error:' || CHR(39) || '||sqlcode);';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea := 'rollback;';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea := 'END;';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
   vlinea := '/';
   p_control_error('txema_mig', 'proceso actualiza direcciones', vlinea);
END;
