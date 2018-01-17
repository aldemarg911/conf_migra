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
  is 'Clave �nica de MIG_LIQUIDACAB';
comment on column MIG_LIQUIDACAB.cagente
  is 'C�digo de agente';
comment on column MIG_LIQUIDACAB.nliqmen
  is 'N�mero de  liquidaci�n';
comment on column MIG_LIQUIDACAB.fliquid
  is 'Fecha de liquidaci�n';
comment on column MIG_LIQUIDACAB.fmovimi
  is 'Fecha del movimiento';
comment on column MIG_LIQUIDACAB.ctipoliq
  is 'Tipo de liquidaci�n (0 Real - 1 Previo)';
comment on column MIG_LIQUIDACAB.cestado
  is 'Estado de la liquidaci�n (1-Liquidado, 2-Liquidado importe, 3-Liquidada comisi�n)';
comment on column MIG_LIQUIDACAB.cusuari
  is 'Usuario que realiza la liquidaci�n';
comment on column MIG_LIQUIDACAB.fcobro
  is 'Fecha de cobro';
