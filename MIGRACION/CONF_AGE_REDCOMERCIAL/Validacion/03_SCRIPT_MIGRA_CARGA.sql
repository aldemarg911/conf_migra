-- Created on 27/06/2017 by HGOMEZ 
declare 
  -- Local variables here
  v_ctx integer;
begin
  -- Test statements here
  select pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24,'USER_BBDD')) INTO v_ctx
  from dual;
  --
  pac_mig_axis.p_migra_cargas('MIGRA_CONF','C',20002);
  --
end;
