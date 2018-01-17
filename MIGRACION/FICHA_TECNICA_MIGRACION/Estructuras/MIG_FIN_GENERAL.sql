-- Create table
create table MIG_FIN_GENERAL
(
  ncarga   NUMBER,
  cestmig  NUMBER,
  mig_pk   VARCHAR2(50) not null,
  mig_fk   VARCHAR2(50) not null,
  sfinanci NUMBER,
  tdescrip VARCHAR2(2000),
  fccomer  DATE,
  cfotorut NUMBER,
  frut     DATE,
  ttitulo  VARCHAR2(2000),
  cfotoced NUMBER,
  fexpiced DATE,
  cpais    NUMBER,
  cprovin  NUMBER,
  cpoblac  NUMBER,
  tinfoad  VARCHAR2(2000),
  cciiu    NUMBER,
  ctipsoci NUMBER,
  cestsoc  NUMBER,
  tobjsoc  VARCHAR2(2000),
  texperi  VARCHAR2(3000),
  fconsti  DATE,
  tvigenc  VARCHAR2(2000)
)
;
-- Add comments to the columns 
comment on column MIG_FIN_GENERAL.mig_pk
  is 'Clave única de MIG_FIN_GENERAL';
comment on column MIG_FIN_GENERAL.mig_fk
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_FIN_GENERAL.sfinanci
  is 'Código ficha financiera (Si es nula se calcula de manera automática)';
comment on column MIG_FIN_GENERAL.tdescrip
  is 'Descripción de la ficha financiera';
comment on column MIG_FIN_GENERAL.fccomer
  is 'Fecha cámara de comercio';
comment on column MIG_FIN_GENERAL.cfotorut
  is 'Tiene fotocopia del RUT 0=No, 1=Si';
comment on column MIG_FIN_GENERAL.frut
  is 'Fecha RUT';
comment on column MIG_FIN_GENERAL.ttitulo
  is 'Título Obtenido';
comment on column MIG_FIN_GENERAL.cfotoced
  is 'Tiene fotocopia de la cedula 0=No, 1=Si';
comment on column MIG_FIN_GENERAL.fexpiced
  is 'Fecha de expedición de la cedula';
comment on column MIG_FIN_GENERAL.cpais
  is 'País';
comment on column MIG_FIN_GENERAL.cprovin
  is 'Departamento';
comment on column MIG_FIN_GENERAL.cpoblac
  is 'municipio';
comment on column MIG_FIN_GENERAL.tinfoad
  is 'Información variada';
comment on column MIG_FIN_GENERAL.cciiu
  is 'Código CIIU - Actividad económica V.F. 8001072';
comment on column MIG_FIN_GENERAL.ctipsoci
  is 'Tipo Sociedad V.F. 8001073';
comment on column MIG_FIN_GENERAL.cestsoc
  is 'Estado de la sociedad V.F. 8001074';
comment on column MIG_FIN_GENERAL.tobjsoc
  is 'Objeto social';
comment on column MIG_FIN_GENERAL.texperi
  is 'Experiencia';
comment on column MIG_FIN_GENERAL.fconsti
  is 'Fecha de constitución';
comment on column MIG_FIN_GENERAL.tvigenc
  is 'Vigencia de la sociedad';
