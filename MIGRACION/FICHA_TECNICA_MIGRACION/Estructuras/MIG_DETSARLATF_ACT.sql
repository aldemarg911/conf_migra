-- Create table
create table MIG_DETSARLATF_ACT
(
  ncarga     NUMBER,
  cestmig    NUMBER,
  mig_pk     VARCHAR2(50) not null,
  mig_fk     VARCHAR2(50) not null,
  mig_fk2    VARCHAR2(50) not null,
  ctipoprod  NUMBER,
  cidnumprod VARCHAR2(150),
  tentidad   VARCHAR2(150),
  cmonto     VARCHAR2(150),
  cciudad    NUMBER,
  cpais      NUMBER,
  cmoneda    VARCHAR2(150),
  scpais     VARCHAR2(150),
  stdepb     VARCHAR2(150),
  scciudad   VARCHAR2(150)
)
;
-- Add comments to the columns 
comment on column MIG_DETSARLATF_ACT.mig_pk
  is 'Clave única de MIG_DETSARLATF_ACT';
comment on column MIG_DETSARLATF_ACT.mig_fk
  is 'Clave externa para MIG_DATSARLAFT';
comment on column MIG_DETSARLATF_ACT.mig_fk2
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_DETSARLATF_ACT.ctipoprod
  is 'Tipo Producto';
comment on column MIG_DETSARLATF_ACT.cidnumprod
  is 'Número de producto';
comment on column MIG_DETSARLATF_ACT.tentidad
  is 'Entidad';
comment on column MIG_DETSARLATF_ACT.cmonto
  is 'Monto';
comment on column MIG_DETSARLATF_ACT.cciudad
  is 'Ciudad';
comment on column MIG_DETSARLATF_ACT.cpais
  is 'País';
comment on column MIG_DETSARLATF_ACT.cmoneda
  is 'Moneda';
comment on column MIG_DETSARLATF_ACT.scpais
  is 'Pais';
comment on column MIG_DETSARLATF_ACT.stdepb
  is 'Departamento';
comment on column MIG_DETSARLATF_ACT.scciudad
  is 'Ciudad';
