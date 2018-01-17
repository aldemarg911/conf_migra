--
-- Create table
create table MIG_MOVRECIBO
(
  ncarga  NUMBER not null,
  cestmig NUMBER not null,
  mig_pk  VARCHAR2(50) not null,
  mig_fk  VARCHAR2(50) not null,
  --
  nrecibo NUMBER,
  smovrec NUMBER,
  --
  cestrec NUMBER(1) not null,  
  fmovini DATE,
  fmovfin DATE,
  fefeadm DATE,
  fmovdia DATE,
  cmotmov NUMBER(3)
);
-- Add comments to the table 
comment on table MIG_MOVRECIBO
  is 'Tabla Intermedia migración movimientos de Recibos';
-- Add comments to the columns 
comment on column MOVRECIBO.smovrec
  is 'Secuencial del movimiento';
comment on column MOVRECIBO.nrecibo
  is 'Número de recibo.';
comment on column MIG_MOVRECIBO.ncarga
  is 'Número de carga';
comment on column MIG_MOVRECIBO.cestmig
  is 'Estado del registro';
comment on column MIG_MOVRECIBO.mig_pk
  is 'Clave única de MIG_MOVRECIBO';
comment on column MIG_MOVRECIBO.mig_fk
  is 'Clave externa para el recibo (MIG_RECIBOS)';
comment on column MIG_MOVRECIBO.cestrec
  is 'Estado Recibo 0-Pendiente,1-cobrado,2-anulado';
comment on column MIG_MOVRECIBO.fmovini
  is 'Fecha inicial del movimiento';
comment on column MIG_MOVRECIBO.fmovfin
  is 'Fecha final del movimiento';
comment on column MIG_MOVRECIBO.fefeadm
  is 'Fecha efecto del movimiento a nivel administrativo';
comment on column MIG_MOVRECIBO.cmotmov
  is 'Codigo motivo movimiento';
-- Create/Recreate indexes 
create index MIG_MOVRECIBO_NCARGA on MIG_MOVRECIBO (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_MOVRECIBO
  add constraint MIG_MOVRECIBO_PK primary key (MIG_PK);

