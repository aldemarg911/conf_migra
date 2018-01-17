-- Create table
create table MIG_PER_AGR_MARCAS
(
  ncarga      NUMBER,
  cestmig     NUMBER,
  mig_pk      VARCHAR2(50) not null,
  mig_fk      VARCHAR2(50) not null,
  cmarca      VARCHAR2(10) not null,
  ctipo       NUMBER,
  ctomador    NUMBER,
  cconsorcio  NUMBER,
  casegurado  NUMBER,
  ccodeudor   NUMBER,
  cbenef      NUMBER,
  caccionista NUMBER,
  cintermed   NUMBER,
  crepresen   NUMBER,
  capoderado  NUMBER,
  cpagador    NUMBER,
  tobseva     VARCHAR2(2000)
)
;
-- Add comments to the columns 
comment on column MIG_PER_AGR_MARCAS.mig_pk
  is 'Clave única de MIG_PER_AGR_MARCAS';
comment on column MIG_PER_AGR_MARCAS.mig_fk
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_PER_AGR_MARCAS.cmarca
  is 'Código de marca';
comment on column MIG_PER_AGR_MARCAS.ctipo
  is 'Tipo marca (0 Manual – 1 Automática)';
comment on column MIG_PER_AGR_MARCAS.ctomador
  is 'Marca Tomador (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.cconsorcio
  is 'Marca Consorcio (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.casegurado
  is 'Marca Asegurado (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.ccodeudor
  is 'Marca Codeudor (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.cbenef
  is 'Marca Beneficiario (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.caccionista
  is 'Marca Accionista (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.cintermed
  is 'Marca Intermediario (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.crepresen
  is 'Marca Representante legal (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.capoderado
  is 'Marca Apoderado (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.cpagador
  is 'Marca Pagador (0 Inactivo / 1 Activo)';
comment on column MIG_PER_AGR_MARCAS.tobseva
  is 'Observaciones';
