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
  is 'Tabla Intermedia migraci�n Riesgos';
-- Add comments to the columns 
comment on column MIG_RIESGOS.ncarga
  is 'N�mero de carga';
comment on column MIG_RIESGOS.cestmig
  is 'Estado del registro';
comment on column MIG_RIESGOS.mig_pk
  is 'Clave �nica de MIG_RIESGOS';
comment on column MIG_RIESGOS.mig_fk
  is 'Clave externa para el asegurado (MIG_PERSONAS)';
comment on column MIG_RIESGOS.mig_fk2
  is 'Clave externa para la p�liza (MIG_SEGUROS)';
comment on column MIG_RIESGOS.nriesgo
  is 'N�mero de riesgo';
comment on column MIG_RIESGOS.sseguro
  is 'N�mero de secuencia de seguro, valor=0, lo calcula el proceso de migraci�n';
comment on column MIG_RIESGOS.nmovima
  is 'N�mero de movimiento (Alta)';
comment on column MIG_RIESGOS.fefecto
  is 'Fecha de efecto';
comment on column MIG_RIESGOS.sperson
  is 'N�mero de secuencia de personas, valor=0, lo calcula el proceso de migraci�n';
comment on column MIG_RIESGOS.nmovimb
  is 'N�mero de movimiento (Baja)';
comment on column MIG_RIESGOS.fanulac
  is 'Fecha de anulaci�n';
comment on column MIG_RIESGOS.tnatrie
  is 'Naturaleza del Riesgo';
comment on column MIG_RIESGOS.pdtocom
  is 'Porcentaje descuento comercial';
comment on column MIG_RIESGOS.precarg
  is 'Porcentaje recargo t�cnico';
comment on column MIG_RIESGOS.pdtotec
  is 'Porcentaje descuento t�cnico';
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
