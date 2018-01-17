-- Create table
create table MIG_SIN_TRAM_JUDI_DETPER
(
  ncarga     NUMBER not null,
  cestmig    NUMBER not null,
  nsinies    VARCHAR2(14) not null,
  ntramit    NUMBER(3) not null,
  MIG_PK     VARCHAR2(50) not null,
  MIG_FK     VARCHAR2(50) not null,
  MIG_FK2    VARCHAR2(50) not null,
  NORDEN     NUMBER(3) not null,
  NROL       NUMBER(3) not null,
  NPERSONA   NUMBER(3) not null,
  NTIPPER    NUMBER(8),
  NNUMIDE    VARCHAR2(50),
  TNOMBRE    VARCHAR2(200),
  IIMPORTE   NUMBER(19,2),
  FBAJA      DATE,
  FMODIFI    DATE,
  CUSUALT    VARCHAR2(20)
);
-- Add comments to the columns 
comment on column MIG_SIN_TRAM_JUDI_DETPER.nsinies  is 'Numero Siniestro';
comment on column MIG_SIN_TRAM_JUDI_DETPER.ntramit  is 'Numero Tramitacion Siniestro';
comment on column MIG_SIN_TRAM_JUDI_DETPER.MIG_PK   is 'Clave única de MIG_SIN_TRAM_JUDI_DETPER_DETPER';
comment on column MIG_SIN_TRAM_JUDI_DETPER.MIG_FK   is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAM_JUDI_DETPER.MIG_FK2   is 'Clave externa de MIG_SIN_TRAM_JUDI_DETPER';
comment on column MIG_SIN_TRAM_JUDI_DETPER.NORDEN   is 'Numero Orden Proceso';
comment on column MIG_SIN_TRAM_JUDI_DETPER.NROL   is 'Rol de persona (1 - Demandados/ 2 - Beneficiarios) ';
comment on column MIG_SIN_TRAM_JUDI_DETPER.NPERSONA   is 'Número de persona.';
comment on column MIG_SIN_TRAM_JUDI_DETPER.NTIPPER   is 'Tipo Persona (VF 8001099 Cuando rol sea Beneficiarios) - (VF 800067 cuando rol de persona demandados)';
comment on column MIG_SIN_TRAM_JUDI_DETPER.NNUMIDE   is 'Número de Censo/Pasaporte de la persona';
comment on column MIG_SIN_TRAM_JUDI_DETPER.TNOMBRE   is 'Nombre de la persona';
comment on column MIG_SIN_TRAM_JUDI_DETPER.IIMPORTE   is 'Importe a pagar';
comment on column MIG_SIN_TRAM_JUDI_DETPER.FBAJA   is 'Fecha Baja Registro';
comment on column MIG_SIN_TRAM_JUDI_DETPER.FMODIFI   is 'Fecha Creación/Modificación';
comment on column MIG_SIN_TRAM_JUDI_DETPER.CUSUALT   is 'Código Usuario Alta';
