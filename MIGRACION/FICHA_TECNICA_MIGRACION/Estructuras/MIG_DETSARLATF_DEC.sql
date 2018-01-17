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
  is 'Clave �nica de MIG_DETSARLATF_DEC';
comment on column MIG_DETSARLATF_DEC.mig_fk
  is 'Clave externa para MIG_DATSARLAFT';
comment on column MIG_DETSARLATF_DEC.mig_fk2
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_DETSARLATF_DEC.ctipoid
  is 'Tipo de identificaci�n persona (NIF, pasaporte, etc.)';
comment on column MIG_DETSARLATF_DEC.cnumeroid
  is 'Documento';
comment on column MIG_DETSARLATF_DEC.tnombre
  is 'Nombre';
comment on column MIG_DETSARLATF_DEC.cmanejarec
  is 'Maneja recursos p�blicos ? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DETSARLATF_DEC.cejercepod
  is 'Ejerce alg�n grado de poder p�blico ? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DETSARLATF_DEC.cgozarec
  is 'Goza de reconocimiento p�blico ? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DETSARLATF_DEC.cdeclaraci
  is 'Declaraci�n (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DETSARLATF_DEC.cdeclaracicual
  is 'Cual';
