-- Create table
create table MIG_RIESGOS
(
  ncarga   NUMBER not null,
  cestmig  NUMBER not null,
  mig_pk   VARCHAR2(50) not null,
  mig_fk   VARCHAR2(50),
  mig_fk2  VARCHAR2(50) not null,
  nriesgo  NUMBER(6) not null,
  sseguro  NUMBER not null,
  nmovima  NUMBER(4) not null,
  fefecto  DATE not null,
  sperson  NUMBER(10),
  nmovimb  NUMBER(4),
  fanulac  DATE,
  tnatrie  VARCHAR2(300),
  pdtocom  NUMBER(6,2),
  precarg  NUMBER(6,2),
  pdtotec  NUMBER(6,2),
  preccom  NUMBER(6,2),
  tdescrie CLOB
);
--
-- Add comments to the table 
comment on table MIG_RIESGOS
  is 'Tabla Intermedia migración Riesgos';
-- Add comments to the columns 
comment on column MIG_RIESGOS.ncarga
  is 'Número de carga';
comment on column MIG_RIESGOS.cestmig
  is 'Estado del registro';
comment on column MIG_RIESGOS.mig_pk
  is 'Clave única de MIG_RIESGOS';
comment on column MIG_RIESGOS.mig_fk
  is 'Clave externa para el asegurado (MIG_PERSONAS)';
comment on column MIG_RIESGOS.mig_fk2
  is 'Clave externa para la póliza (MIG_SEGUROS)';
comment on column MIG_RIESGOS.nriesgo
  is 'Número de riesgo';
comment on column MIG_RIESGOS.sseguro
  is 'Número de secuencia de seguro, valor=0, lo calcula el proceso de migración';
comment on column MIG_RIESGOS.nmovima
  is 'Número de movimiento (Alta)';
comment on column MIG_RIESGOS.fefecto
  is 'Fecha de efecto';
comment on column MIG_RIESGOS.sperson
  is 'Número de secuencia de personas, valor=0, lo calcula el proceso de migración';
comment on column MIG_RIESGOS.nmovimb
  is 'Número de movimiento (Baja)';
comment on column MIG_RIESGOS.fanulac
  is 'Fecha de anulación';
comment on column MIG_RIESGOS.tnatrie
  is 'Naturaleza del Riesgo';
comment on column MIG_RIESGOS.pdtocom
  is 'Porcentaje descuento comercial';
comment on column MIG_RIESGOS.precarg
  is 'Porcentaje recargo técnico';
comment on column MIG_RIESGOS.pdtotec
  is 'Porcentaje descuento técnico';
comment on column MIG_RIESGOS.preccom
  is 'Porcentaje recargo comercial';
comment on column MIG_RIESGOS.tdescrie
  is 'Detalle del riesgo';
-- Create/Recreate indexes 
create index MIG_RIESGOS_NCARGA on MIG_RIESGOS (NCARGA);
--
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_RIESGOS
  add constraint MIG_RIESGOS_PK primary key (MIG_PK);
--
--
