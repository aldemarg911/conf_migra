create table MIG_SIN_TRAM_VALPRET
(
ncarga       NUMBER not null,
cestmig      NUMBER not null,
nsinies      VARCHAR2(14)  not null,
ntramit      NUMBER(4)  not null,
--
MIG_PK      VARCHAR2(50),
MIG_FK      VARCHAR2(50),
MIG_FK2      VARCHAR2(50),
NORDEN      NUMBER(3),
CGARANT      NUMBER(4),
IPRETEN      NUMBER,
FBAJA       DATE,
FMODIFI     DATE,
CUSUALT     VARCHAR2(20)
);
--
comment on TABLE MIG_SIN_TRAM_VALPRET   is 'Fichero con la información de los valores de pretensión.';
comment on column MIG_SIN_TRAM_VALPRET.MIG_PK   is 'Clave única de MIG_SIN_TRAMITA_VALPRETENSION';
comment on column MIG_SIN_TRAM_VALPRET.MIG_FK   is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAM_VALPRET.MIG_FK2   is 'Clave externa de MIG_SIN_TRAMITA_JUDICIAL';
comment on column MIG_SIN_TRAM_VALPRET.NORDEN   is 'Numero Orden Proceso';
comment on column MIG_SIN_TRAM_VALPRET.CGARANT   is 'Código de garantía';
comment on column MIG_SIN_TRAM_VALPRET.IPRETEN   is 'Importe de pretensión';
comment on column MIG_SIN_TRAM_VALPRET.FBAJA   is 'Fecha Baja Registro';
comment on column MIG_SIN_TRAM_VALPRET.FMODIFI   is 'Fecha Creación/Modificación';
comment on column MIG_SIN_TRAM_VALPRET.CUSUALT   is 'Código Usuario Alta';
--

