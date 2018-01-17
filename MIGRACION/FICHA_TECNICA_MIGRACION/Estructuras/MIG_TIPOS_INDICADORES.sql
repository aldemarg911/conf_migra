-- Create table
create table MIG_TIPOS_INDICADORES
(
  ncarga  NUMBER,
  cestmig NUMBER,
  mig_pk  VARCHAR2(50) not null,
  tindica VARCHAR2(200) not null,
  carea   NUMBER not null,
  ctipreg NUMBER not null,
  cimpret NUMBER not null,
  ccindid VARCHAR2(10) not null,
  cindsap VARCHAR2(4),
  porcent NUMBER not null,
  cclaing VARCHAR2(1),
  ibasmin NUMBER,
  cprovin NUMBER,
  cpoblac NUMBER,
  fvigor  DATE
);

-- Add comments to the columns 
comment on column MIG_TIPOS_INDICADORES.mig_pk
  is 'Clave única de MIG_TIPOS_INDICADORES';
comment on column MIG_TIPOS_INDICADORES.tindica
  is 'Si   Descripción del indicador';
comment on column MIG_TIPOS_INDICADORES.carea
  is 'Área. 1-Reaseguro 2-Intermediarios 3-Siniestros 4-Producción';
comment on column MIG_TIPOS_INDICADORES.ctipreg
  is '1-Impuesto 2-Retención';
comment on column MIG_TIPOS_INDICADORES.cimpret
  is '1-IVA 2-Retefuente 3-ReteIVA 4-ReteICA';
comment on column MIG_TIPOS_INDICADORES.ccindid
  is 'Código del tipo de retención SAP';
comment on column MIG_TIPOS_INDICADORES.cindsap
  is 'Código del indicador de retención SAP';
comment on column MIG_TIPOS_INDICADORES.porcent
  is 'Porcentaje de retención';
comment on column MIG_TIPOS_INDICADORES.cclaing
  is 'Clase de ingreso. B-Bienes S-Servicios';
comment on column MIG_TIPOS_INDICADORES.ibasmin
  is 'Importe base mínima';
comment on column MIG_TIPOS_INDICADORES.cprovin
  is 'Código de provincia';
comment on column MIG_TIPOS_INDICADORES.cpoblac
  is 'Código de población';
comment on column MIG_TIPOS_INDICADORES.fvigor
  is 'Fecha entrada en vigor';
