-- Create table
create table MIG_FIN_PARINDICADORES
(
  ncarga             NUMBER NOT NULL,
  cestmig            NUMBER NOT NULL,
  mig_pk             VARCHAR2(50) not null,
  mig_fk             VARCHAR2(50) not null,
  fecha_est_fin      DATE,
  vt_per_ant         NUMBER,
  ventas             NUMBER,
  costo_vt           NUMBER,
  gasto_adm          NUMBER,
  util_operac        NUMBER,
  gasto_fin          NUMBER,
  res_ant_imp        NUMBER,
  util_neta          NUMBER,
  invent             NUMBER,
  carte_clie         NUMBER,
  act_corr           NUMBER,
  prop_plnt_eqp      NUMBER,
  tot_act_no_corr    NUMBER,
  act_total          NUMBER,
  o_fin_corto_plazo  VARCHAR2(2000),
  provee_corto_plazo VARCHAR2(2000),
  atc_corto_plazo    NUMBER,
  pas_corr           VARCHAR2(2000),
  o_fin_largo_plazo  VARCHAR2(2000),
  atc_largo_plazo    NUMBER,
  pas_no_corr        NUMBER,
  pas_total          NUMBER,
  patri_peri_ant     NUMBER,
  patri_ano_actual   NUMBER,
  resv_legal         NUMBER,
  cap_social         NUMBER,
  res_ejer_ant       NUMBER,
  prima_accion       NUMBER,
  resv_ocasi         NUMBER,
  valoriza           NUMBER,
  asignado           NUMBER
)
;
comment on table MIG_FIN_INDICADORES
  is 'Fichero con los datos de parámetros de indicadores de la ficha financiera.';
-- Add comments to the columns 
comment on column MIG_FIN_PARINDICADORES.mig_pk
  is 'Clave única de MIG_FINPAR_INDICADORES';
comment on column MIG_FIN_PARINDICADORES.mig_fk
  is 'Clave externa para MIG_FIN_INDICADORES';
comment on column MIG_FIN_PARINDICADORES.fecha_est_fin
  is 'Fecha estados Financieros';
comment on column MIG_FIN_PARINDICADORES.vt_per_ant
  is 'Ventas Periodo Anterior';
comment on column MIG_FIN_PARINDICADORES.ventas
  is 'Ventas';
comment on column MIG_FIN_PARINDICADORES.costo_vt
  is 'Costo Ventas';
comment on column MIG_FIN_PARINDICADORES.gasto_adm
  is 'Gastos Administrativos';
comment on column MIG_FIN_PARINDICADORES.util_operac
  is 'Utilidad Operacional';
comment on column MIG_FIN_PARINDICADORES.gasto_fin
  is 'Gastos Financieros (P y G)';
comment on column MIG_FIN_PARINDICADORES.res_ant_imp
  is 'Resultado antes de impuestos (P y G)';
comment on column MIG_FIN_PARINDICADORES.util_neta
  is 'Utilidad Neta';
comment on column MIG_FIN_PARINDICADORES.invent
  is 'Inventarios';
comment on column MIG_FIN_PARINDICADORES.carte_clie
  is 'Cartera Cliente';
comment on column MIG_FIN_PARINDICADORES.act_corr
  is 'Activo Corriente';
comment on column MIG_FIN_PARINDICADORES.prop_plnt_eqp
  is 'Propiedad Planta y equipo';
comment on column MIG_FIN_PARINDICADORES.tot_act_no_corr
  is 'Total Activo no corriente';
comment on column MIG_FIN_PARINDICADORES.act_total
  is 'Activo Total';
comment on column MIG_FIN_PARINDICADORES.o_fin_corto_plazo
  is 'Obligaciones financieras corto plazo';
comment on column MIG_FIN_PARINDICADORES.provee_corto_plazo
  is 'Proveedores Corto Plazo';
comment on column MIG_FIN_PARINDICADORES.atc_corto_plazo
  is 'Anticipos corto Plazo';
comment on column MIG_FIN_PARINDICADORES.pas_corr
  is 'Pasivo Corriente';
comment on column MIG_FIN_PARINDICADORES.o_fin_largo_plazo
  is 'Obligaciones financieras largo plazo';
comment on column MIG_FIN_PARINDICADORES.atc_largo_plazo
  is 'Anticipos largo Plazo';
comment on column MIG_FIN_PARINDICADORES.pas_no_corr
  is 'Total pasivo no corriente';
comment on column MIG_FIN_PARINDICADORES.pas_total
  is 'Pasivo total';
comment on column MIG_FIN_PARINDICADORES.patri_peri_ant
  is 'Patrimonio periodo anterior';
comment on column MIG_FIN_PARINDICADORES.patri_ano_actual
  is 'Patrimonio año actual (BCE)';
comment on column MIG_FIN_PARINDICADORES.resv_legal
  is 'Reserva legal';
comment on column MIG_FIN_PARINDICADORES.cap_social
  is 'Capital Social';
comment on column MIG_FIN_PARINDICADORES.res_ejer_ant
  is 'Resultado Ejercicios Anteriores';
comment on column MIG_FIN_PARINDICADORES.prima_accion
  is 'Prima en colocación de acciones';
comment on column MIG_FIN_PARINDICADORES.resv_ocasi
  is 'Reservas ocasionales';
comment on column MIG_FIN_PARINDICADORES.valoriza
  is 'Valorizaciones';
comment on column MIG_FIN_PARINDICADORES.asignado
  is 'Inversión suplementaria al capital asignado';
--
create index MIG_FIN_PARINDICADORES_NCARGA on MIG_FIN_PARINDICADORES (NCARGA);
--
alter table MIG_FIN_PARINDICADORES add constraint MIG_FIN_PARINDICADORES_PK primary key (MIG_PK);
