select pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24,'USER_BBDD')) from dual;
exec pac_mig_axis.p_migra_cargas('MIGRA_CONF','C',17405);
-- el X es el valor obtenido en el script 04_genera_carga_a_partir_de_tablas_ext.sql (vncarga) y que se inserta en 
-- MIG_CARGAS (descripcion MIGRA_CONF)
--

