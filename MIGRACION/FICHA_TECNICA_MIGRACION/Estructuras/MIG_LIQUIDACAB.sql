-- Create table
create table MIG_LIQUIDACAB
(
  ncarga   NUMBER,
  cestmig  NUMBER,
  mig_pk   VARCHAR2(50) not null,
  cagente  NUMBER not null,
  nliqmen  NUMBER(4) not null,
  fliquid  DATE,
  fmovimi  DATE not null,
  ctipoliq NUMBER(2),
  cestado  NUMBER(3),
  cusuari  VARCHAR2(20),
  fcobro   DATE
)
;
-- Add comments to the columns 
comment on column MIG_LIQUIDACAB.mig_pk
  is 'Clave única de MIG_LIQUIDACAB';
comment on column MIG_LIQUIDACAB.cagente
  is 'Código de agente';
comment on column MIG_LIQUIDACAB.nliqmen
  is 'Número de  liquidación';
comment on column MIG_LIQUIDACAB.fliquid
  is 'Fecha de liquidación';
comment on column MIG_LIQUIDACAB.fmovimi
  is 'Fecha del movimiento';
comment on column MIG_LIQUIDACAB.ctipoliq
  is 'Tipo de liquidación (0 Real - 1 Previo)';
comment on column MIG_LIQUIDACAB.cestado
  is 'Estado de la liquidación (1-Liquidado, 2-Liquidado importe, 3-Liquidada comisión)';
comment on column MIG_LIQUIDACAB.cusuari
  is 'Usuario que realiza la liquidación';
comment on column MIG_LIQUIDACAB.fcobro
  is 'Fecha de cobro';
