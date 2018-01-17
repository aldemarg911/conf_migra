-- Create table
create table MIG_SIN_TRAM_VPRETFIS
(
  ncarga     NUMBER not null,
  cestmig    NUMBER not null,
  nsinies    VARCHAR2(14) not null,
  ntramit    NUMBER(3) not null,
  MIG_PK      VARCHAR2(50) not null,
  MIG_FK      VARCHAR2(50) not null,
  MIG_FK2      VARCHAR2(50)not null,
  NORDEN      NUMBER(3) not null,
  CGARANT      NUMBER(4) not null,
  IPRETEN      NUMBER,
  FBAJA DATE,
  FMODIFI DATE,
  CUSUALT      VARCHAR2(20)
);
-- Add comments to the columns 
comment on TABLE MIG_SIN_TRAM_VPRETFIS   is 'Fichero con la información de los valores de pretensión de proceso fiscales.';
comment on column MIG_SIN_TRAM_VPRETFIS.nsinies  is 'Numero Siniestro';
comment on column MIG_SIN_TRAM_VPRETFIS.ntramit  is 'Numero Tramitacion Siniestro';
comment on column MIG_SIN_TRAM_VPRETFIS.MIG_PK   is 'Clave única de MIG_SIN_TRAMITA_VALPRETFISCAL';
comment on column MIG_SIN_TRAM_VPRETFIS.MIG_FK   is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAM_VPRETFIS.MIG_FK2   is 'Clave externa de MIG_SIN_TRAMITA_FISCAL';
comment on column MIG_SIN_TRAM_VPRETFIS.NORDEN   is 'Numero Orden Proceso';
comment on column MIG_SIN_TRAM_VPRETFIS.CGARANT   is 'Código de garantía';
comment on column MIG_SIN_TRAM_VPRETFIS.IPRETEN   is 'Importe de pretensión';
comment on column MIG_SIN_TRAM_VPRETFIS.FBAJA   is 'Fecha Baja Registro';
comment on column MIG_SIN_TRAM_VPRETFIS.FMODIFI   is 'Fecha Creación/Modificación';
comment on column MIG_SIN_TRAM_VPRETFIS.CUSUALT   is 'Código Usuario Alta';

