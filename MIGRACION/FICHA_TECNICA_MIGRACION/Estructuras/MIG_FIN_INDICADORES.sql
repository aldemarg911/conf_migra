-- Create table
create table MIG_FIN_INDICADORES
(
  ncarga   NUMBER,
  cestmig  NUMBER,
  mig_pk   VARCHAR2(50) not null,
  mig_fk   VARCHAR2(50) not null,
  --
  sfinanci NUMBER not null,
  nmovimi  NUMBER not null,
  --
  findicad DATE,
  imargen  NUMBER,
  icaptrab NUMBER,
  trazcor  VARCHAR2(2000),
  tprbaci  VARCHAR2(2000),
  ienduada NUMBER,
  ndiacar  NUMBER,
  nrotpro  NUMBER,
  nrotinv  NUMBER,
  ndiacicl NUMBER,
  irentab  NUMBER,
  ioblcp   NUMBER,
  iobllp   NUMBER,
  igastfin NUMBER,
  ivalpt   NUMBER,
  cesvalor NUMBER,
  cmoneda  NUMBER,
  fcupo    DATE,
  icupog   NUMBER,
  icupos   NUMBER,
  fcupos   DATE,
  tcupor   VARCHAR2(2000),
  tconcepc VARCHAR2(2000),
  tconceps VARCHAR2(2000),
  tcburea  VARCHAR2(2000),
  tcotros  VARCHAR2(2000),
  cmoncam  NUMBER
);
--
comment on table MIG_FIN_INDICADORES
  is 'Fichero con los datos de indicadores de la ficha financiera.';
-- Add comments to the columns 
comment on column MIG_FIN_INDICADORES.mig_pk
  is 'Clave única de MIG_FIN_INDICADORES';
comment on column MIG_FIN_INDICADORES.mig_fk
  is 'Clave externa para MIG_FIN_GENERAL';  
comment on column FIN_INDICADORES.sfinanci
  is 'Identificador ficha financiera';  
comment on column MIG_FIN_INDICADORES.nmovimi
  is 'Movimiento Indicador';
comment on column MIG_FIN_INDICADORES.findicad
  is 'Fecha indicadores';
comment on column MIG_FIN_INDICADORES.imargen
  is 'Margen operacional';
comment on column MIG_FIN_INDICADORES.icaptrab
  is 'Capital trabajo';
comment on column MIG_FIN_INDICADORES.trazcor
  is 'Razón corriente';
comment on column MIG_FIN_INDICADORES.tprbaci
  is 'Prueba acida';
comment on column MIG_FIN_INDICADORES.ienduada
  is 'Endeudamiento total';
comment on column MIG_FIN_INDICADORES.ndiacar
  is 'Rotación Cartera(Días)';
comment on column MIG_FIN_INDICADORES.nrotpro
  is 'Rotación proveedores';
comment on column MIG_FIN_INDICADORES.nrotinv
  is 'Rotación de inventarios';
comment on column MIG_FIN_INDICADORES.ndiacicl
  is 'Ciclo de efectivo(Días)';
comment on column MIG_FIN_INDICADORES.irentab
  is 'Rentabilidad';
comment on column MIG_FIN_INDICADORES.ioblcp
  is 'Obliga. Fin. CP/Ventas';
comment on column MIG_FIN_INDICADORES.iobllp
  is 'Obliga. Fin. LP/Ventas';
comment on column MIG_FIN_INDICADORES.igastfin
  is 'Gastos. Fin. /UOP';
comment on column MIG_FIN_INDICADORES.ivalpt
  is 'Valoración /PT';
comment on column MIG_FIN_INDICADORES.cesvalor
  is 'Valores en … V.F. 8001075';
comment on column MIG_FIN_INDICADORES.cmoneda
  is 'Moneda';
comment on column MIG_FIN_INDICADORES.fcupo
  is 'Fecha cupo';
comment on column MIG_FIN_INDICADORES.icupog
  is 'Cupo del garantizado';
comment on column MIG_FIN_INDICADORES.icupos
  is 'Cupo sugerido';
comment on column MIG_FIN_INDICADORES.fcupos
  is 'Fecha cupo Sugerido';
comment on column MIG_FIN_INDICADORES.tcupor
  is 'Responsable cupo';
comment on column MIG_FIN_INDICADORES.tconcepc
  is 'Concepto financiero del cliente';
comment on column MIG_FIN_INDICADORES.tconceps
  is 'Concepto del cliente sucursal';
comment on column MIG_FIN_INDICADORES.tcburea
  is 'Concepto Bureau y/o Gerencia técnica';
comment on column MIG_FIN_INDICADORES.tcotros
  is 'Concepto otras áreas';
comment on column MIG_FIN_INDICADORES.cmoncam
  is 'Moneda Cambio';
--
create index MIG_FIN_INDICADORES_NCARGA on MIG_FIN_INDICADORES (NCARGA);
--
alter table MIG_FIN_INDICADORES add constraint MIG_FIN_INDICADORES_PK primary key (MIG_PK);
