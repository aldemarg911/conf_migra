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
comment on TABLE MIG_SIN_TRAMITA_FISCAL   is 'Fichero con la informaci�n del tr�mite fiscal.';
comment on column MIG_SIN_TRAMITA_FISCAL.nsinies  is 'Numero Siniestro';
comment on column MIG_SIN_TRAMITA_FISCAL.ntramit  is 'Numero Tramitacion Siniestro';
comment on column MIG_SIN_TRAMITA_FISCAL.MIG_PK   is 'Clave �nica de MIG_SIN_TRAMITA_FISCAL';
comment on column MIG_SIN_TRAMITA_FISCAL.MIG_FK   is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAMITA_FISCAL.MIG_FK2   is 'Clave externa de MIG_SIN_TRAMITACION.';
comment on column MIG_SIN_TRAMITA_FISCAL.NORDEN   is 'N�mero Orden Proceso';
comment on column MIG_SIN_TRAMITA_FISCAL.FAPERTU   is 'Fecha de auto de apertura';
comment on column MIG_SIN_TRAMITA_FISCAL.FIMPUTA   is 'Fecha del auto de imputaci�n';
comment on column MIG_SIN_TRAMITA_FISCAL.FNOTIFI   is 'Fecha de notificaci�n';
comment on column MIG_SIN_TRAMITA_FISCAL.FAUDIEN   is 'Fecha de audiencia de descargas';
comment on column MIG_SIN_TRAMITA_FISCAL.HAUDIEN   is 'Hora de audiencia de descargas (Null, en este caso)';
comment on column MIG_SIN_TRAMITA_FISCAL.CAUDIEN   is 'C�digo postal - Ciudad audiencia  (16.1.1.16 Valor C�digo Postal)';
comment on column MIG_SIN_TRAMITA_FISCAL.SPROFES   is 'Clave externa de MIG_SIN_PROF_PROFESIONALES (Profesional que asiste a la audiencia) ';
comment on column MIG_SIN_TRAMITA_FISCAL.COTERRI   is 'Orden territorial de la contralor�a (VF 8001116)';
comment on column MIG_SIN_TRAMITA_FISCAL.CCONTRA   is 'C�digo postal - Ciudad contralor�a (16.1.1.16 Valor C�digo Postal)';
comment on column MIG_SIN_TRAMITA_FISCAL.CUESPEC   is 'Unidades especiales (VF 8001117)';
comment on column MIG_SIN_TRAMITA_FISCAL.TCONTRA   is 'Otras contralor�as.';
comment on column MIG_SIN_TRAMITA_FISCAL.CTIPTRA   is 'Tipo de tr�mite (VF 8001118)';
comment on column MIG_SIN_TRAMITA_FISCAL.TESTADO   is 'Estado de la audiencia.';
comment on column MIG_SIN_TRAMITA_FISCAL.CMEDIO   is 'Medio realizaci�n de la audiencia (VF Tabla 8001171) (Null, en este caso)';
comment on column MIG_SIN_TRAMITA_FISCAL.FDESCAR   is 'Fecha presentaci�n descargos';
comment on column MIG_SIN_TRAMITA_FISCAL.FFALLO   is 'Fecha del fallo';
comment on column MIG_SIN_TRAMITA_FISCAL.CFALLO   is 'Decisi�n del Fallo (VF 8001119)';
comment on column MIG_SIN_TRAMITA_FISCAL.TFALLO   is 'Texto decisi�n o fallo';
comment on column MIG_SIN_TRAMITA_FISCAL.CRECURSO   is 'Recurso (VF 8001120)';
comment on column MIG_SIN_TRAMITA_FISCAL.FMODIFI   is 'Fecha Creaci�n/Modificaci�n';
comment on column MIG_SIN_TRAMITA_FISCAL.CUSUALT   is 'C�digo Usuario Alta';
--
