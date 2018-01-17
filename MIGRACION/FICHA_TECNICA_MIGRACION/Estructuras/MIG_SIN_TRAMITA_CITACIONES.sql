CREATE TABLE MIG_SIN_TRAMITA_CITACIONES(
  NCARGA      NUMBER NOT NULL,
  CESTMIG     NUMBER NOT NULL,
  MIG_PK      VARCHAR2(14) NOT NULL,
  MIG_FK      VARCHAR2(14) NOT NULL,
  NSINIES       NUMBER NOT NULL,
  NTRAMIT      NUMBER NOT NULL,
  NCITACION      NUMBER NOT NULL,
  FCITACION      DATE NOT NULL,
  HCITACION      VARCHAR2(5),
  SPERSON      NUMBER NOT NULL,
  CPAIS      NUMBER(3) NOT NULL,
  CPROVIN      NUMBER NOT NULL,
  CPOBLAC      NUMBER NOT NULL,
  TLUGAR      VARCHAR2(200),
  FALTA      DATE NOT NULL,
  TAUDIEN      VARCHAR2(2000),
  CORAL      NUMBER(1),
  CESTADO      NUMBER(1),
  CRESOLU      NUMBER(1),
  FNUEVA      DATE,
  TRESULT      VARCHAR2(2000),
  CMEDIO      NUMBER(1)
);
comment on column MIG_SIN_TRAMITA_CITACIONES.ncarga  is 'Número de carga';
comment on column MIG_SIN_TRAMITA_CITACIONES.cestmig  is 'Estado del registro';
comment on column MIG_SIN_TRAMITA_CITACIONES.MIG_PK   is 'Clave única de MIG_SIN_TRAMITACION.';
comment on column MIG_SIN_TRAMITA_CITACIONES.MIG_FK   is 'Clave externa para MIG_SIN_SINIESTRO.';
comment on column MIG_SIN_TRAMITA_CITACIONES.NSINIES  is 'Numero de siniestro';
comment on column MIG_SIN_TRAMITA_CITACIONES.NTRAMIT  is 'Numero de ntramit';
comment on column MIG_SIN_TRAMITA_CITACIONES.NCITACION   is 'Número citación de la tramitación';
comment on column MIG_SIN_TRAMITA_CITACIONES.FCITACION   is 'Fecha citación';
comment on column MIG_SIN_TRAMITA_CITACIONES.HCITACION   is 'Hora citación (HH:MM)';
comment on column MIG_SIN_TRAMITA_CITACIONES.SPERSON   is 'Código de la persona que asistirá a la cita';
comment on column MIG_SIN_TRAMITA_CITACIONES.CPAIS   is 'Código País';
comment on column MIG_SIN_TRAMITA_CITACIONES.CPROVIN   is 'Código Provincia';
comment on column MIG_SIN_TRAMITA_CITACIONES.CPOBLAC   is 'Código Población';
comment on column MIG_SIN_TRAMITA_CITACIONES.TLUGAR   is 'Lugar de la citación (texto libre)';
comment on column MIG_SIN_TRAMITA_CITACIONES.FALTA   is 'Fecha Alta';
comment on column MIG_SIN_TRAMITA_CITACIONES.TAUDIEN   is '';
comment on column MIG_SIN_TRAMITA_CITACIONES.CORAL   is '1-Si, 2-No (VF 8001094)';
comment on column MIG_SIN_TRAMITA_CITACIONES.CESTADO   is '1-Si, 2-No, 3-Aplazada (VF 8001095)';
comment on column MIG_SIN_TRAMITA_CITACIONES.CRESOLU   is '1-Favorable, 2-Desfavorable (VF 8001096)';
comment on column MIG_SIN_TRAMITA_CITACIONES.FNUEVA   is 'Nueva fecha';
comment on column MIG_SIN_TRAMITA_CITACIONES.TRESULT   is '';
comment on column MIG_SIN_TRAMITA_CITACIONES.CMEDIO   is '1-VideoConferencia, 2-Presencial, 3-Escrito (VF 8001171)';
--
create index MIG_SIN_TRAMITA_CITAC_NCARGA on MIG_SIN_TRAMITA_CITACIONES (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_SIN_TRAMITA_CITACIONES
  add constraint MIG_SIN_TRAMITA_CITACIONES_PK primary key (MIG_PK);
