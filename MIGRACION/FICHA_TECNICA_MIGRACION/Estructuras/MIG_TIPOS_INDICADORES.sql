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
  is 'Clave �nica de MIG_TIPOS_INDICADORES';
comment on column MIG_TIPOS_INDICADORES.tindica
  is 'Si   Descripci�n del indicador';
comment on column MIG_TIPOS_INDICADORES.carea
  is '�rea. 1-Reaseguro 2-Intermediarios 3-Siniestros 4-Producci�n';
comment on column MIG_TIPOS_INDICADORES.ctipreg
  is '1-Impuesto 2-Retenci�n';
comment on column MIG_TIPOS_INDICADORES.cimpret
  is '1-IVA 2-Retefuente 3-ReteIVA 4-ReteICA';
comment on column MIG_TIPOS_INDICADORES.ccindid
  is 'C�digo del tipo de retenci�n SAP';
comment on column MIG_TIPOS_INDICADORES.cindsap
  is 'C�digo del indicador de retenci�n SAP';
comment on column MIG_TIPOS_INDICADORES.porcent
  is 'Porcentaje de retenci�n';
comment on column MIG_TIPOS_INDICADORES.cclaing
  is 'Clase de ingreso. B-Bienes S-Servicios';
comment on column MIG_TIPOS_INDICADORES.ibasmin
  is 'Importe base m�nima';
comment on column MIG_TIPOS_INDICADORES.cprovin
  is 'C�digo de provincia';
comment on column MIG_TIPOS_INDICADORES.cpoblac
  is 'C�digo de poblaci�n';
comment on column MIG_TIPOS_INDICADORES.fvigor
  is 'Fecha entrada en vigor';
