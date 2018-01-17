-- Create table
create table MIG_SIN_TRAMITA_VALPRETFISCAL
(
  ncarga   NUMBER,
  cestmig  NUMBER,
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
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.mig_pk
  is 'Clave �nica de MIG_SIN_TRAMITA_VALPRETFISCAL';
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.mig_fk
  is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.mig_fk2
  is 'Clave externa de MIG_SIN_TRAMITA_FISCAL';
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.norden
  is 'Numero Orden Proceso';
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.cgarant
  is 'C�digo de garant�a';
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.ipreten
  is 'Importe de pretensi�n';
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.fbaja
  is 'Fecha Baja Registro';
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.fmodifi
  is 'Fecha Creaci�n/Modificaci�n';
comment on column MIG_SIN_TRAMITA_VALPRETFISCAL.cusualt
  is 'C�digo Usuario Alta';
