/* Formatted on 04/08/2016 21:56 (Formatter Plus v.1.0) - (CSI-Factory Standard Format v.3.0) */
DECLARE

  v_context NUMBER;

BEGIN

  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(17,
                                                                     'USER_BBDD'))
    INTO v_context
    FROM DUAL;

  p_control_error('AXIS_POS', 'CSIREASEXECGENCESIO', 'Inicio');

  DELETE FROM control_error WHERE id = 'CBUITRAGO';
  UPDATE codimotmov SET cgenrec = 1 WHERE cmotmov = 406;

  csi_gen_cesiones_rea_mig_v2(3700003479);
  csi_gen_cesiones_rea_mig_v2(3700003480);
  csi_gen_cesiones_rea_mig_v2(3700003481);

  UPDATE codimotmov SET cgenrec = 0 WHERE cmotmov = 406;

  p_control_error('AXIS_POS', 'CSIREASEXECGENCESIO', 'Fin');

  INSERT INTO LOG_INSTALACION
    (FECHA, USUARIO, ERROR, CODIGO, TITULO)
  VALUES
    (f_sysdate,
     f_user,
     NULL,
     'CSIREASEXECGENCESIO',
     'csi_execgencesionesrea_v1');

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    p_control_error('AXIS_POS', 'CSIREASEXECGENCESIO', 'ERROR=' || SQLERRM);
END;
/
