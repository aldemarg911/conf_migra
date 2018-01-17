-- Create table
create table MIG_AGD_OBSERVACIONES
(
  ncarga  NUMBER not null,
  cestmig NUMBER not null,
  --
  MIG_PK       VARCHAR2(50) NOT NULL,
  MIG_FK       VARCHAR2(50) NOT NULL,
  CTIPOBS      NUMBER(1) NOT NULL,
  TTITOBS      VARCHAR2(100) NOT NULL,
  TOBS         VARCHAR2(2000) NOT NULL,
  CTIPAGD      NUMBER(2) NOT NULL,
  NTRAMIT      NUMBER(3),
  PUBLICO      NUMBER(1),
  CCONOBS      NUMBER(2) NOT NULL,
  FALTA        DATE NOT NULL
);
-- Add comments to the table 
comment on table MIG_AGD_OBSERVACIONES
  is 'Fichero con los apuntes/anotaciones del siniestro.';
-- Add comments to the columns 
comment on column MIG_AGD_OBSERVACIONES.ncarga   is 'Número de carga';
comment on column MIG_AGD_OBSERVACIONES.cestmig  is 'Estado del registro';
comment on column MIG_AGD_OBSERVACIONES.MIG_PK   is 'Clave única de MIG_AGD_OBSERVACIONES';
comment on column MIG_AGD_OBSERVACIONES.MIG_FK   is 'Clave externa para MIG_SIN_SINIESTRO';
comment on column MIG_AGD_OBSERVACIONES.CTIPOBS   is '0-Automático, 1-Manual';
comment on column MIG_AGD_OBSERVACIONES.TTITOBS   is 'Título observación del Apunte (llevará un dato genérico para la migración)';
comment on column MIG_AGD_OBSERVACIONES.TOBS      is 'Descripción Obs/Apunte';
comment on column MIG_AGD_OBSERVACIONES.CTIPAGD   is 'Tipo Observación/Apunte';
comment on column MIG_AGD_OBSERVACIONES.NTRAMIT   is 'Tramitación del cual pertenece la Obs./Apunte (NULL si pertenece al Siniestro)';
comment on column MIG_AGD_OBSERVACIONES.PUBLICO   is '0-No, 1-Sí';
comment on column MIG_AGD_OBSERVACIONES.CCONOBS   is 'Código de Concepto Obs/Apu V.F depende de la tabla AGD_OBS_CONF (VF 21)';
comment on column MIG_AGD_OBSERVACIONES.FALTA     is 'Fecha de alta del apunte en la agenda';
-- Create/Recreate indexes 
create index MIG_AGD_OBSERVACIONES_NCARGA on MIG_AGD_OBSERVACIONES (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_AGD_OBSERVACIONES
  add constraint MIG_AGD_OBSERVACIONES_PK primary key (MIG_PK);
