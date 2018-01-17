create table MIG_SIN_TRAMITA_FISCAL
(
--
  ncarga     NUMBER not null,
  cestmig    NUMBER not null,
  nsinies    VARCHAR2(14) not null,
  ntramit    NUMBER(3) not null,
--
MIG_PK      VARCHAR2(50) not null,
MIG_FK      VARCHAR2(50) not null,
MIG_FK2      VARCHAR2(50) not null,
NORDEN      NUMBER not null,
FAPERTU DATE,
FIMPUTA DATE,
FNOTIFI DATE,
FAUDIEN DATE,
HAUDIEN DATE,
CAUDIEN      NUMBER ,
SPROFES      NUMBER ,
COTERRI      NUMBER ,
CCONTRA      NUMBER ,
CUESPEC      NUMBER ,
TCONTRA      VARCHAR2(2000),
CTIPTRA      NUMBER(8),
TESTADO      VARCHAR2(2000),
CMEDIO      NUMBER ,
FDESCAR DATE,
FFALLO DATE,
CFALLO      NUMBER ,
TFALLO      VARCHAR2(2000),
CRECURSO      NUMBER ,
FMODIFI DATE,
CUSUALT      VARCHAR2(20)
);
--
comment on TABLE MIG_SIN_TRAMITA_FISCAL   is 'Fichero con la información del trámite fiscal.';
comment on column MIG_SIN_TRAMITA_FISCAL.nsinies  is 'Numero Siniestro';
comment on column MIG_SIN_TRAMITA_FISCAL.ntramit  is 'Numero Tramitacion Siniestro';
comment on column MIG_SIN_TRAMITA_FISCAL.MIG_PK   is 'Clave única de MIG_SIN_TRAMITA_FISCAL';
comment on column MIG_SIN_TRAMITA_FISCAL.MIG_FK   is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAMITA_FISCAL.MIG_FK2   is 'Clave externa de MIG_SIN_TRAMITACION.';
comment on column MIG_SIN_TRAMITA_FISCAL.NORDEN   is 'Número Orden Proceso';
comment on column MIG_SIN_TRAMITA_FISCAL.FAPERTU   is 'Fecha de auto de apertura';
comment on column MIG_SIN_TRAMITA_FISCAL.FIMPUTA   is 'Fecha del auto de imputación';
comment on column MIG_SIN_TRAMITA_FISCAL.FNOTIFI   is 'Fecha de notificación';
comment on column MIG_SIN_TRAMITA_FISCAL.FAUDIEN   is 'Fecha de audiencia de descargas';
comment on column MIG_SIN_TRAMITA_FISCAL.HAUDIEN   is 'Hora de audiencia de descargas (Null, en este caso)';
comment on column MIG_SIN_TRAMITA_FISCAL.CAUDIEN   is 'Código postal - Ciudad audiencia  (16.1.1.16 Valor Código Postal)';
comment on column MIG_SIN_TRAMITA_FISCAL.SPROFES   is 'Clave externa de MIG_SIN_PROF_PROFESIONALES (Profesional que asiste a la audiencia) ';
comment on column MIG_SIN_TRAMITA_FISCAL.COTERRI   is 'Orden territorial de la contraloría (VF 8001116)';
comment on column MIG_SIN_TRAMITA_FISCAL.CCONTRA   is 'Código postal - Ciudad contraloría (16.1.1.16 Valor Código Postal)';
comment on column MIG_SIN_TRAMITA_FISCAL.CUESPEC   is 'Unidades especiales (VF 8001117)';
comment on column MIG_SIN_TRAMITA_FISCAL.TCONTRA   is 'Otras contralorías.';
comment on column MIG_SIN_TRAMITA_FISCAL.CTIPTRA   is 'Tipo de trámite (VF 8001118)';
comment on column MIG_SIN_TRAMITA_FISCAL.TESTADO   is 'Estado de la audiencia.';
comment on column MIG_SIN_TRAMITA_FISCAL.CMEDIO   is 'Medio realización de la audiencia (VF Tabla 8001171) (Null, en este caso)';
comment on column MIG_SIN_TRAMITA_FISCAL.FDESCAR   is 'Fecha presentación descargos';
comment on column MIG_SIN_TRAMITA_FISCAL.FFALLO   is 'Fecha del fallo';
comment on column MIG_SIN_TRAMITA_FISCAL.CFALLO   is 'Decisión del Fallo (VF 8001119)';
comment on column MIG_SIN_TRAMITA_FISCAL.TFALLO   is 'Texto decisión o fallo';
comment on column MIG_SIN_TRAMITA_FISCAL.CRECURSO   is 'Recurso (VF 8001120)';
comment on column MIG_SIN_TRAMITA_FISCAL.FMODIFI   is 'Fecha Creación/Modificación';
comment on column MIG_SIN_TRAMITA_FISCAL.CUSUALT   is 'Código Usuario Alta';
--
