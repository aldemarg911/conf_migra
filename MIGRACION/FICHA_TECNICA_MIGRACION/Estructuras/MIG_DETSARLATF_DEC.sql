-- Create table
create table MIG_DETSARLATF_DEC
(
  ncarga         NUMBER,
  cestmig        NUMBER,
  mig_pk         VARCHAR2(50) not null,
  mig_fk         VARCHAR2(50) not null,
  mig_fk2        VARCHAR2(50) not null,
  ctipoid        NUMBER,
  cnumeroid      VARCHAR2(150),
  tnombre        VARCHAR2(150),
  cmanejarec     NUMBER,
  cejercepod     NUMBER,
  cgozarec       NUMBER,
  cdeclaraci     NUMBER,
  cdeclaracicual VARCHAR2(150)
)
;
-- Add comments to the columns 
comment on column MIG_DETSARLATF_DEC.mig_pk
  is 'Clave única de MIG_DETSARLATF_DEC';
comment on column MIG_DETSARLATF_DEC.mig_fk
  is 'Clave externa para MIG_DATSARLAFT';
comment on column MIG_DETSARLATF_DEC.mig_fk2
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_DETSARLATF_DEC.ctipoid
  is 'Tipo de identificación persona (NIF, pasaporte, etc.)';
comment on column MIG_DETSARLATF_DEC.cnumeroid
  is 'Documento';
comment on column MIG_DETSARLATF_DEC.tnombre
  is 'Nombre';
comment on column MIG_DETSARLATF_DEC.cmanejarec
  is 'Maneja recursos públicos ? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DETSARLATF_DEC.cejercepod
  is 'Ejerce algún grado de poder público ? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DETSARLATF_DEC.cgozarec
  is 'Goza de reconocimiento público ? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DETSARLATF_DEC.cdeclaraci
  is 'Declaración (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DETSARLATF_DEC.cdeclaracicual
  is 'Cual';
