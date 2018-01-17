-- Create table
create table MIG_AGR_CONTRATOS
(
  ncarga  NUMBER,
  cestmig NUMBER,
  mig_pk  VARCHAR2(50) not null,
  mig_fk  VARCHAR2(50) not null,
  scontra NUMBER(6),
  cramo   NUMBER(8) not null,
  cmodali NUMBER(2),
  ccolect NUMBER(2),
  ctipseg NUMBER(2),
  cactivi NUMBER(4),
  cgarant NUMBER(4),
  nversio NUMBER(2),
  ilimsub NUMBER
)
;
-- Add comments to the columns 
comment on column MIG_AGR_CONTRATOS.mig_pk
  is 'Clave única de MIG_AGR_CONTRATOS';
comment on column MIG_AGR_CONTRATOS.mig_fk
  is 'Clave externa de MIG_CODICONTRATOS';
comment on column MIG_AGR_CONTRATOS.scontra
  is 'Secuencia de contrato (Nulo en este caso)';
comment on column MIG_AGR_CONTRATOS.cramo
  is 'Código ramo';
comment on column MIG_AGR_CONTRATOS.cmodali
  is 'Código modalidad';
comment on column MIG_AGR_CONTRATOS.ccolect
  is 'Código de colectividad';
comment on column MIG_AGR_CONTRATOS.ctipseg
  is 'Código tipo de seguro';
comment on column MIG_AGR_CONTRATOS.cactivi
  is 'Código actividad del seguro. (Cero en este caso)';
comment on column MIG_AGR_CONTRATOS.cgarant
  is 'Código de garantía';
comment on column MIG_AGR_CONTRATOS.nversio
  is 'Número versión contrato reas.';
comment on column MIG_AGR_CONTRATOS.ilimsub
  is 'Límite de subscripción';
