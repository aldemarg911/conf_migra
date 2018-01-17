create table MIG_DETMOVRECIBO_PARCIAL
(
  NCARGA    NUMBER NOT NULL,
  CESTMIG   NUMBER NOT NULL,
  MIG_PK      VARCHAR2(50) NOT NULL,
  MIG_FK      VARCHAR2(50) NOT NULL,
  --
  NRECIBO   NUMBER NOT NULL,
  SMOVREC   NUMBER NOT NULL, 
  NORDEN    NUMBER(2) NOT NULL,
  --
  CCONCEP      NUMBER(2) NOT NULL,
  CGARANT      NUMBER(4),
  NRIESGO      NUMBER(6),
  FMOVIMI      DATE,
  ICONCEP      NUMBER(13,2) NOT NULL,
  ICONCEP_MONPOL      NUMBER(13,2),
  NMOVIMA      NUMBER,
  FCAMBIO      DATE

);
--
comment on column MIG_DETMOVRECIBO_PARCIAL.MIG_PK   is 'Clave única de MIG_DETMOVRECIBO_PARCIAL';
comment on column MIG_DETMOVRECIBO_PARCIAL.MIG_FK   is 'Clave externa para MIG_RECIBOS';
--
comment on column MIG_DETMOVRECIBO.SMOVREC  is 'Secuencial del movimiento';
comment on column MIG_DETMOVRECIBO.NORDEN   is 'Número de movimiento';
comment on column MIG_DETMOVRECIBO.nrecibo  is 'Número de recibo.';
--
comment on column MIG_DETMOVRECIBO_PARCIAL.CCONCEP   is 'Código del concepto (VALOR FIJO:27)';
comment on column MIG_DETMOVRECIBO_PARCIAL.CGARANT   is 'Código de garantía. (Definición Producto)';
comment on column MIG_DETMOVRECIBO_PARCIAL.NRIESGO   is 'Número de Riesgo.';
comment on column MIG_DETMOVRECIBO_PARCIAL.FMOVIMI   is 'Fecha de movimiento';
comment on column MIG_DETMOVRECIBO_PARCIAL.ICONCEP   is 'Importe del concepto en moneda del producto.';
comment on column MIG_DETMOVRECIBO_PARCIAL.ICONCEP_MONPOL   is 'Importe del concepto en moneda de la póliza';
comment on column MIG_DETMOVRECIBO_PARCIAL.NMOVIMA   is 'Número de movimiento de alta.';
comment on column MIG_DETMOVRECIBO_PARCIAL.FCAMBIO   is 'Fecha de cambio';
-- Create/Recreate indexes 
create index MIG_DETMOVRECIBO_PAR_NCARGA on MIG_DETMOVRECIBO_PARCIAL(NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_DETMOVRECIBO_PARCIAL
  add constraint MIG_DETMOVRECIBO_PAR_PK primary key (MIG_PK);
--
