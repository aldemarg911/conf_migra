PL/SQL Developer Test script 3.0
13
begin
  -- Call the procedure
  --pac_carga_tipos_indicado_conf.p_borra_tipos_indicadores;
  pac_carga_per_red_cl2.P_BORRA_personas;
  pac_carga_per_red_cl2.p_carga_personas(ptab_des => 'MIG_PERSONAS');
  pac_carga_per_red_cl2.p_carga_personas(ptab_des => 'MIG_DIRECCIONES');
  pac_carga_per_red_cl2.p_carga_personas(ptab_des => 'MIG_PERSONAS_REL');
  pac_carga_per_red_cl2.p_carga_personas(ptab_des => 'MIG_AGENTES');
  pac_carga_per_red_cl2.p_carga_personas(ptab_des => 'MIG_PER_AGR_MARCAS');
  pac_carga_per_red_cl2.p_carga_personas(ptab_des => 'MIG_REGIMENFISCAL');
  --
  --COMMIT;
end;
1
ptab_des
0
-5
0