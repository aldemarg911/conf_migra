-- Create table
create table MIG_MOVSEGURO
(
  ncarga  NUMBER not null,
  cestmig NUMBER not null,
  mig_pk  VARCHAR2(50) not null,
  mig_fk  VARCHAR2(50) not null,
  sseguro NUMBER not null,
  nmovimi NUMBER(4) not null,
  cmotmov NUMBER(3) not null,
  fmovimi DATE not null,
  fefecto DATE not null,
  cusumov VARCHAR2(20),
  cmotven NUMBER(3),
  cmovseg NUMBER(2)
);
-- Add comments to the table 
comment on table MIG_MOVSEGURO
  is 'Tabla Intermedia migración de Movimientos de Pólizas';
-- Add comments to the columns 
comment on column MIG_MOVSEGURO.ncarga
  is 'Número de carga';
comment on column MIG_MOVSEGURO.cestmig
  is 'Estado del registro';
comment on column MIG_MOVSEGURO.mig_pk
  is 'Clave única de MIG_MOVSEGURO';
comment on column MIG_MOVSEGURO.mig_fk
  is 'Clave externa para la póliza (MIG_SEGUROS)';
comment on column MIG_MOVSEGURO.sseguro
  is 'Número de secuencia de seguro, valor=0, lo calcula el proceso de migración';
comment on column MIG_MOVSEGURO.nmovimi
  is 'Número de movimiento';
comment on column MIG_MOVSEGURO.cmotmov
  is 'Código motivo de movimiento';
comment on column MIG_MOVSEGURO.fmovimi
  is 'Fecha del movimiento';
comment on column MIG_MOVSEGURO.fefecto
  is 'Fecha de efecto';
comment on column MIG_MOVSEGURO.cusumov
  is 'Usuario que realiza el movimiento';
comment on column MIG_MOVSEGURO.cmotven
  is 'Código motivo de movimiento. (Ver punto 9.1.1.1	Valor Código de movimiento, tipo anulación)';
comment on column MIG_MOVSEGURO.cmovseg
  is 'Código movimiento seguro (Marcar movimiento anulado = 52)';
-- Create/Recreate indexes 
create index MIG_MOVSEGURO_NCARGA on MIG_MOVSEGURO (NCARGA);
create index MIG_MOVSEGURO_NU on MIG_MOVSEGURO (MIG_FK);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_MOVSEGURO
  add constraint MIG_MOVSEGURO_PK primary key (MIG_PK);
--
