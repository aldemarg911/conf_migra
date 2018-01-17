-- Create table
create table MIG_CODICONTRATOS
(
  ncarga       NUMBER,
  cestmig      NUMBER,
  mig_pk       VARCHAR2(50) not null,
  mig_fk       VARCHAR2(50) not null,
  nversion     NUMBER not null,
  scontra      NUMBER not null,
  spleno       NUMBER(6),
  cempres      NUMBER(2) not null,
  ctiprea      NUMBER(2) not null,
  finictr      DATE not null,
  ffinctr      DATE,
  nconrel      NUMBER(6),
  sconagr      NUMBER(6),
  cvidaga      NUMBER(1),
  cvidair      NUMBER(1),
  ctipcum      NUMBER(1),
  cvalid       NUMBER(1),
  cretira      NUMBER(1),
  cmoneda      VARCHAR2(3),
  tdescripcion VARCHAR2(100),
  cdevento     NUMBER(1)
)
;
-- Add comments to the columns 
comment on column MIG_CODICONTRATOS.mig_pk
  is 'Clave única de MIG_CODICONTRATOS';
comment on column MIG_CODICONTRATOS.mig_fk
  is 'Clave externa para MIG_COMPANIAS';
comment on column MIG_CODICONTRATOS.nversion
  is 'Número versión contrato reaseguro';
comment on column MIG_CODICONTRATOS.scontra
  is 'Código contrato (Nulo en este caso)';
comment on column MIG_CODICONTRATOS.spleno
  is 'Identificador del Pleno (Nulo en este caso)';
comment on column MIG_CODICONTRATOS.cempres
  is 'Código de Empresa';
comment on column MIG_CODICONTRATOS.ctiprea
  is 'Tipo de contrato de Reaseguro (1 - Cuota Parte, 2 - Pleno neto de retención, 3 - XL Excess Loss)';
comment on column MIG_CODICONTRATOS.finictr
  is 'Fecha inicio contrato';
comment on column MIG_CODICONTRATOS.ffinctr
  is 'Fecha fin contrato';
comment on column MIG_CODICONTRATOS.ctipcum
  is 'Tipos de cúmulo 0-Manual 1-Per ramo, 2- Per producto';
comment on column MIG_CODICONTRATOS.cvalid
  is 'Código de contratos con nueva versión validada para proceso de ajuste de cesiones';
comment on column MIG_CODICONTRATOS.cretira
  is 'Retirada de Cartera (0-No 1-Si)';
comment on column MIG_CODICONTRATOS.cmoneda
  is 'Código Moneda (Tabla ECO_CODMONEDAS)';
comment on column MIG_CODICONTRATOS.tdescripcion
  is 'Descripción del contrato';
comment on column MIG_CODICONTRATOS.cdevento
  is 'Indica si al contrato aplica reaseguro por eventos (0:No, 1:Si, 2:Ambos)';
