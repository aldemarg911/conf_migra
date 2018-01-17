-- Create table
create table MIG_CTATECNICA
(
  ncarga         NUMBER,
  cestmig        NUMBER,
  mig_pk         VARCHAR2(50) not null,
  mig_fk         VARCHAR2(50) not null,
  nversion       NUMBER not null,
  scontra        NUMBER not null,
  tramo          NUMBER not null,
  nnumlin        NUMBER not null,
  fmovimi        DATE not null,
  fefecto        DATE not null,
  cconcep        NUMBER(2) not null,
  cdedhab        NUMBER(1) not null,
  iimport        NUMBER(13,2) not null,
  cestado        NUMBER(2) not null,
  iimport_moncon NUMBER(13,2),
  fcambio        DATE,
  ctipmov        NUMBER(1),
  sproduc        NUMBER(6),
  npoliza        VARCHAR2(50),
  nsiniestro     VARCHAR2(50),
  tdescri        VARCHAR2(2000),
  tdocume        VARCHAR2(2000),
  fliquid        DATE,
  cevento        VARCHAR2(2),
  fcontab        DATE not null,
  sidepag        NUMBER(8),
  cusucre        VARCHAR2(20),
  fcreac         DATE,
  cramo          NUMBER(8),
  ccorred        NUMBER(4)
)
;
-- Add comments to the columns 
comment on column MIG_CTATECNICA.mig_pk
  is 'Clave única de MIG_CTATECNICA';
comment on column MIG_CTATECNICA.mig_fk
  is 'Clave externa para MIG_COMPANIAS';
comment on column MIG_CTATECNICA.nversion
  is 'Número versión contrato reaseguro';
comment on column MIG_CTATECNICA.scontra
  is 'Código contrato';
comment on column MIG_CTATECNICA.tramo
  is 'Código de tramo';
comment on column MIG_CTATECNICA.nnumlin
  is 'Número de línea';
comment on column MIG_CTATECNICA.fmovimi
  is 'Fecha de cierre  de movimiento';
comment on column MIG_CTATECNICA.fefecto
  is 'Fecha de efecto del movimiento';
comment on column MIG_CTATECNICA.cconcep
  is 'Concepto del movimiento VF:124';
comment on column MIG_CTATECNICA.cdedhab
  is 'Debe y haber (1 – debe 2 – haber)';
comment on column MIG_CTATECNICA.iimport
  is 'Importe del movimiento';
comment on column MIG_CTATECNICA.cestado
  is 'Estado del movimiento VF:800106. Por defecto debería estar liquidado.';
comment on column MIG_CTATECNICA.iimport_moncon
  is 'Importe del movimiento en la moneda de la contabilidad';
comment on column MIG_CTATECNICA.fcambio
  is 'Fecha empleada para el cálculo de los contravalores';
comment on column MIG_CTATECNICA.ctipmov
  is 'Tipo de movimiento manual-1 o automática-0';
comment on column MIG_CTATECNICA.sproduc
  is 'Código del producto iAxis';
comment on column MIG_CTATECNICA.npoliza
  is 'Identificador de póliza en sistema externo';
comment on column MIG_CTATECNICA.nsiniestro
  is 'Identificador de siniestro en sistema externo';
comment on column MIG_CTATECNICA.tdescri
  is 'Descripción (apuntes manuales)';
comment on column MIG_CTATECNICA.tdocume
  is 'Documento (apuntes manuales)';
comment on column MIG_CTATECNICA.fliquid
  is 'Fecha de liquidación';
comment on column MIG_CTATECNICA.cevento
  is 'Código de evento (si corresponde a un evento de un siniestro)';
comment on column MIG_CTATECNICA.fcontab
  is 'Fecha contable';
comment on column MIG_CTATECNICA.sidepag
  is 'Identificador del pago asociado al siniestro';
comment on column MIG_CTATECNICA.cusucre
  is 'Usuario Alta';
comment on column MIG_CTATECNICA.fcreac
  is 'Fecha alta';
comment on column MIG_CTATECNICA.cramo
  is 'Identificador del ramo';
comment on column MIG_CTATECNICA.ccorred
  is 'Indicador de corredor (bróker)';
