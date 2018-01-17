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
  is 'Clave �nica de MIG_AGR_CONTRATOS';
comment on column MIG_AGR_CONTRATOS.mig_fk
  is 'Clave externa de MIG_CODICONTRATOS';
comment on column MIG_AGR_CONTRATOS.scontra
  is 'Secuencia de contrato (Nulo en este caso)';
comment on column MIG_AGR_CONTRATOS.cramo
  is 'C�digo ramo';
comment on column MIG_AGR_CONTRATOS.cmodali
  is 'C�digo modalidad';
comment on column MIG_AGR_CONTRATOS.ccolect
  is 'C�digo de colectividad';
comment on column MIG_AGR_CONTRATOS.ctipseg
  is 'C�digo tipo de seguro';
comment on column MIG_AGR_CONTRATOS.cactivi
  is 'C�digo actividad del seguro. (Cero en este caso)';
comment on column MIG_AGR_CONTRATOS.cgarant
  is 'C�digo de garant�a';
comment on column MIG_AGR_CONTRATOS.nversio
  is 'N�mero versi�n contrato reas.';
comment on column MIG_AGR_CONTRATOS.ilimsub
  is 'L�mite de subscripci�n';
