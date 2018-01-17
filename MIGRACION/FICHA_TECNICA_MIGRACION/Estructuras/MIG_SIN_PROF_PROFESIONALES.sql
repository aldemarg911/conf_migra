-- Create table
create table MIG_SIN_PROF_PROFESIONALES
(
  ncarga     NUMBER not null,
  cestmig    NUMBER not null,
  mig_pk     VARCHAR2(50) not null,
  sprofes    NUMBER(8),
  idperson   NUMBER(10),
  ctipide    NUMBER(3) not null,
  nnumide    VARCHAR2(50) not null,
  tdigitoide VARCHAR2(1),
  nregmer    VARCHAR2(20),
  fregmer    DATE,
  cdomici    NUMBER,
  cmodcon    NUMBER,
  nlimite    NUMBER,
  cnoasis    NUMBER(1),
  proceso    NUMBER
);
-- Add comments to the columns 
comment on column MIG_SIN_PROF_PROFESIONALES.sprofes
  is 'Codigo de profesional';
comment on column MIG_SIN_PROF_PROFESIONALES.idperson
  is 'Identificador unico personas';
comment on column MIG_SIN_PROF_PROFESIONALES.ctipide
  is 'Codigo tipo identificador (VF:672)';
comment on column MIG_SIN_PROF_PROFESIONALES.nnumide
  is 'Numero de identificacion';
comment on column MIG_SIN_PROF_PROFESIONALES.tdigitoide
  is 'Digito verificacion';
comment on column MIG_SIN_PROF_PROFESIONALES.nregmer
  is 'Numero registro mercantil';
comment on column MIG_SIN_PROF_PROFESIONALES.fregmer
  is 'Vigencia registro mercantil';
comment on column MIG_SIN_PROF_PROFESIONALES.cdomici
  is 'Direccion fiscal';
comment on column MIG_SIN_PROF_PROFESIONALES.cmodcon
  is 'Contacto preferente. Clave PER_CONTACTOS';
comment on column MIG_SIN_PROF_PROFESIONALES.nlimite
  is 'Limite cuanto peritable';
comment on column MIG_SIN_PROF_PROFESIONALES.cnoasis
  is 'Exclusion siniestros de asistencia';
comment on column MIG_SIN_PROF_PROFESIONALES.proceso
  is 'Proceso que ha cargado';