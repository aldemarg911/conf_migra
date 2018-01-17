-- Create table
create table MIG_SIN_TRAMITA_VALPRETENSION
(
  ncarga  NUMBER,
  cestmig NUMBER,
  mig_pk  VARCHAR2(50) not null,
  mig_fk  VARCHAR2(50) not null,
  mig_fk2 VARCHAR2(50) not null,
  norden  NUMBER(3) not null,
  cgarant NUMBER(4) not null,
  ipreten NUMBER,
  fbaja   DATE,
  fmodifi DATE,
  cusualt VARCHAR2(20)
)
;
-- Add comments to the columns 
comment on column MIG_SIN_TRAMITA_VALPRETENSION.mig_pk
  is 'Clave única de MIG_SIN_TRAMITA_VALPRETENSION';
comment on column MIG_SIN_TRAMITA_VALPRETENSION.mig_fk
  is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAMITA_VALPRETENSION.mig_fk2
  is 'Clave externa de MIG_SIN_TRAMITA_JUDICIAL';
comment on column MIG_SIN_TRAMITA_VALPRETENSION.norden
  is 'Numero Orden Proceso';
comment on column MIG_SIN_TRAMITA_VALPRETENSION.cgarant
  is 'Código de garantía';
comment on column MIG_SIN_TRAMITA_VALPRETENSION.ipreten
  is 'Importe de pretensión';
comment on column MIG_SIN_TRAMITA_VALPRETENSION.fbaja
  is 'Fecha Baja Registro';
comment on column MIG_SIN_TRAMITA_VALPRETENSION.fmodifi
  is 'Fecha Creación/Modificación';
comment on column MIG_SIN_TRAMITA_VALPRETENSION.cusualt
  is 'Código Usuario Alta';
