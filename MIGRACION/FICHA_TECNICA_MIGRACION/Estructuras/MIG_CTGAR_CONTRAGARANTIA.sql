-- Create table
create table MIG_CTGAR_CONTRAGARANTIA
(
  ncarga       NUMBER,
  cestmig      NUMBER,
  mig_pk       VARCHAR2(50) not null,
  mig_fk       VARCHAR2(50) not null,
  scontgar     NUMBER not null,
  nmovimi      NUMBER not null,
  tdescripcion VARCHAR2(100),
  ctipo        NUMBER,
  cclase       NUMBER,
  cmoneda      VARCHAR2(3) not null,
  ivalor       NUMBER,
  fvencimi     DATE,
  nempresa     NUMBER,
  nradica      VARCHAR2(100),
  fcrea        DATE,
  documento    VARCHAR2(100),
  ctenedor     NUMBER,
  tobsten      VARCHAR2(100),
  cestado      NUMBER,
  corigen      NUMBER,
  tcausa       VARCHAR2(1000),
  tauxilia     VARCHAR2(2000),
  cimpreso     NUMBER(1),
  cusualt      VARCHAR2(20),
  falta        DATE
);

-- Add comments to the columns 
comment on column MIG_CTGAR_CONTRAGARANTIA.mig_pk
  is 'Clave única de MIG_CONTRAGARAN';
comment on column MIG_CTGAR_CONTRAGARANTIA.mig_fk
  is 'Clave externa para MIG_PERSONAS (Si no tiene valor, se crea contragarantía sin pólizas asociada).';
comment on column MIG_CTGAR_CONTRAGARANTIA.scontgar
  is 'Identificador único / Secuencia de la contragarantía (Si valor = 0, lo calcula el proceso de migración)';
comment on column MIG_CTGAR_CONTRAGARANTIA.nmovimi
  is 'Número de movimiento. (Inicialmente 1)';
comment on column MIG_CTGAR_CONTRAGARANTIA.tdescripcion
  is 'Descripción general de la contragarantía';
comment on column MIG_CTGAR_CONTRAGARANTIA.ctipo
  is 'Tipo de contragarantía V.F. 8001035 ';
comment on column MIG_CTGAR_CONTRAGARANTIA.cclase
  is 'Clase de contragarantía V.F. 8001036';
comment on column MIG_CTGAR_CONTRAGARANTIA.cmoneda
  is 'Moneda';
comment on column MIG_CTGAR_CONTRAGARANTIA.ivalor
  is 'Valor contragarantía';
comment on column MIG_CTGAR_CONTRAGARANTIA.fvencimi
  is 'Fecha de vencimiento';
comment on column MIG_CTGAR_CONTRAGARANTIA.nempresa
  is 'id interno o NIT';
comment on column MIG_CTGAR_CONTRAGARANTIA.nradica
  is 'Número de radicación';
comment on column MIG_CTGAR_CONTRAGARANTIA.fcrea
  is 'Fecha de creación';
comment on column MIG_CTGAR_CONTRAGARANTIA.documento
  is 'Descripción documento - nombre';
comment on column MIG_CTGAR_CONTRAGARANTIA.ctenedor
  is 'Tenedor V.F. 8001037';
comment on column MIG_CTGAR_CONTRAGARANTIA.tobsten
  is 'Observación adicional tenedor';
comment on column MIG_CTGAR_CONTRAGARANTIA.cestado
  is 'Estado contragarantía V.F. 8001038';
comment on column MIG_CTGAR_CONTRAGARANTIA.corigen
  is 'Origen contragarantía V.F. 8001039';
comment on column MIG_CTGAR_CONTRAGARANTIA.tcausa
  is 'Causa contragarantía';
comment on column MIG_CTGAR_CONTRAGARANTIA.tauxilia
  is 'Observaciones auxiliares de la contragarantía';
comment on column MIG_CTGAR_CONTRAGARANTIA.cimpreso
  is 'Impreso pagare ->0=Si , 1=No';
comment on column MIG_CTGAR_CONTRAGARANTIA.cusualt
  is 'Usuario de alta';
comment on column MIG_CTGAR_CONTRAGARANTIA.falta
  is 'Fecha de alta';
