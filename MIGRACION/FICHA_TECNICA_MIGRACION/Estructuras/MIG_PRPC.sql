create table MIG_PRPC
(
  MIG_PK      VARCHAR2(50) NOT NULL,
  ncarga      NUMBER not null,
  cestmig     NUMBER not null,
  --
  producto     NUMBER,
  sseguro     NUMBER not null,
  poliza       VARCHAR2(50),
  nmovimiento   NUMBER(4),
  nriesgo      NUMBER(6),
  recibo       VARCHAR2(50),
  garantia     NUMBER(5),
  fcalculo     DATE,
  fecha_inicio DATE,
  iprpc        NUMBER(17,2),
  ipricom      NUMBER(17,2),
  ippnaprima   NUMBER(17,2),
  ippnccomis   NUMBER(17,2),
  prea         NUMBER(5,2),
  pcom         NUMBER(5,2),
  icomis       NUMBER(17,2),
  ipdevrc      NUMBER(17,2),
  ipncsrc      NUMBER(17,2),
  icomrc       NUMBER(17,2),
  icncsrc      NUMBER(17,2),
  ctramo       NUMBER(3)
);
-- Add comments to the columns 
comment on column MIG_PRPC.ncarga  is 'Número de carga';
comment on column MIG_PRPC.cestmig  is 'Estado del registro';
comment on column MIG_PRPC.PRODUCTO   is 'Clave de producto iAxis ';
comment on column MIG_PRPC.POLIZA   is 'Id póliza en sistema origen (MIG_PK MIG_SEGUROS)';
comment on column MIG_PRPC.NMOVIMIENTO   is 'Número de movimiento';
comment on column MIG_PRPC.NRIESGO   is 'Número de riesgo';
comment on column MIG_PRPC.RECIBO   is 'Id recibo en sistema origen (MIG_PK MIG_RECIBOS)';
comment on column MIG_PRPC.GARANTIA   is 'Código de garantía iAXIs';
comment on column MIG_PRPC.FCALCULO   is 'Fecha de cálculo de la provisión';
comment on column MIG_PRPC.FECHA_INICIO   is 'Fecha inicio  efecto';
comment on column MIG_PRPC.IPRPC   is 'Importe de provisión';
comment on column MIG_PRPC.IPRICOM   is 'Importe Prima neta';
comment on column MIG_PRPC.IPPNAPRIMA   is 'Prima pendiente de cobro no consumida';
comment on column MIG_PRPC.IPPNCCOMIS   is 'Comisión pendiente de cobro no consumida.';
comment on column MIG_PRPC.PREA   is 'Porcentaje reaseguro';
comment on column MIG_PRPC.PCOM   is 'Porcentaje comisión  anulación (según campo ctramo, 1- 3 meses = 25%, 2 – 3 a 6 meses=50%, 3- mayor que 6 meses = 100%). Se utiliza para calcular el campo IPPPC';
comment on column MIG_PRPC.ICOMIS   is 'Importe comisión';
comment on column MIG_PRPC.IPDEVRC   is 'Prima reaseguro cedido';
comment on column MIG_PRPC.IPNCSRC   is 'Prima no consumida reaseguro cedido';
comment on column MIG_PRPC.ICOMRC   is 'Comisión  reaseguro cedido';
comment on column MIG_PRPC.ICNCSRC   is 'Comisión  no consumida reaseguro cedido';
comment on column MIG_PRPC.CTRAMO   is 'Tramo antigüedad aplicable en meses (valor fijo: 1084)';
--
--
create index MIG_PRPC_NCARGA on MIG_PRPC (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_PRPC
  add constraint MIG_PRPC_PK primary key (MIG_PK);
--
