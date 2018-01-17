-- Create table
create table MIG_HISTORICOSEGUROS
(
  ncarga     NUMBER,
  cestmig    NUMBER,
  mig_pk     VARCHAR2(50) not null,
  mig_fk     VARCHAR2(50) not null,
  mig_fk2    VARCHAR2(50) not null,
  MIG_FKDIR  VARCHAR2(50) not null,
  cagente    NUMBER not null,
  ncertif    NUMBER not null,
  fefecto    DATE not null,
  cactivi    NUMBER(4) not null,
  ccobban    NUMBER(3),
  ctiprea    NUMBER(1) not null,
  creafac    NUMBER(1) not null,
  ctipcom    NUMBER(2),
  csituac    NUMBER(2),
  fvencim    DATE,
  femisio    DATE,
  fanulac    DATE,
  iprianu    NUMBER(13,2),
  cidioma    NUMBER(1) not null,
  cforpag    NUMBER(2) not null,
  creteni    NUMBER(1),
  ctipcoa    NUMBER(1),
  sciacoa    NUMBER(6),
  pparcoa    NUMBER(5,2),
  npolcoa    VARCHAR2(10),
  nsupcoa    VARCHAR2(6),
  ncuacoa    NUMBER(2),
  pdtocom    NUMBER(5,2),
  cempres    NUMBER(2) not null,
  sproduc    NUMBER(6) not null,
  ccompani   NUMBER(3),
  ctipcob    NUMBER(3),
  crevali    NUMBER(2),
  prevali    NUMBER(5,2),
  irevali    NUMBER(13,2),
  ctipban    NUMBER(3),
  cbancar    VARCHAR2(50),
  casegur    NUMBER(2) not null,
  nsuplem    NUMBER(4) not null,
  cdomici    NUMBER(2),
  npolini    VARCHAR2(50),
  fcarant    DATE ,
  fcarpro    DATE ,
  crecfra    NUMBER(1),
  ndurcob    NUMBER(2),
  fcaranu    DATE ,
  nduraci    NUMBER(3),
  nedamar    NUMBER(2),
  fefeplazo  DATE,
  fvencplazo DATE,
  mig_fk3    VARCHAR2(50)
);
-- Add comments to the columns 
comment on column MIG_HISTORICOSEGUROS.mig_pk
  is 'Clave única de MIG_HISTORICOSEGUROS';
comment on column MIG_HISTORICOSEGUROS.mig_fk
  is 'Clave externa para el tomador (MIG_SEGUROS)';
comment on column MIG_HISTORICOSEGUROS.mig_fk2
  is 'Clave externa para el movimiento (MIG_MOVSEGURO)';
  comment on column MIG_HISTORICOSEGUROS.mig_fkdir
  is 'Clave externa para el tomador (MIG_PER_DIRECCIONES)';
comment on column MIG_HISTORICOSEGUROS.cagente
  is 'Código de Agente (MIG_AGENTES)';
comment on column MIG_HISTORICOSEGUROS.ncertif
  is 'Número de certificado para pólizas colectivas';
comment on column MIG_HISTORICOSEGUROS.fefecto
  is 'Fecha de efecto';
comment on column MIG_HISTORICOSEGUROS.cactivi
  is 'Código actividad del seguro. (Definición Producto) (Cero en este caso)';
comment on column MIG_HISTORICOSEGUROS.ccobban
  is 'Código de cobrador bancario (Definición Instalación)';
comment on column MIG_HISTORICOSEGUROS.ctiprea
  is 'Código tipo de reaseguro. (VALOR FIJO:60)';
comment on column MIG_HISTORICOSEGUROS.creafac
  is 'Indicador reaseguro facultativo. (VALOR FIJO:71)';
comment on column MIG_HISTORICOSEGUROS.ctipcom
  is 'Código tipo de comisión (VALOR FIJO:55)';
comment on column MIG_HISTORICOSEGUROS.csituac
  is 'Código de situación (VALOR FIJO:61)';
comment on column MIG_HISTORICOSEGUROS.FVENCIM
  is 'Fecha de Vencimiento';
comment on column MIG_HISTORICOSEGUROS.femisio
  is 'Fecha de Emisión';
comment on column MIG_HISTORICOSEGUROS.fanulac
  is 'Fecha de anulación';
comment on column MIG_HISTORICOSEGUROS.iprianu
  is 'Importe primera anualidad';
comment on column MIG_HISTORICOSEGUROS.cidioma
  is 'Código idioma  (9.1.1.2 Valor  IDIOMAS)';
comment on column MIG_HISTORICOSEGUROS.cforpag
  is 'Código forma de pago  (VALOR FIJO:17)';
comment on column MIG_HISTORICOSEGUROS.creteni
  is 'Código retención póliza (VALOR FIJO:66)';
comment on column MIG_HISTORICOSEGUROS.ctipcoa
  is 'Código tipo de coaseguro (VALOR FIJO:59)';
comment on column MIG_HISTORICOSEGUROS.sciacoa
  is 'Código de compañía coaseguro (MIG_PK) COMPANIAS';
comment on column MIG_HISTORICOSEGUROS.pparcoa
  is 'Porcentaje participación coaseguro';
comment on column MIG_HISTORICOSEGUROS.npolcoa
  is 'Número póliza compañía coaseguro';
comment on column MIG_HISTORICOSEGUROS.nsupcoa
  is 'Número de suplemento compañía coaseguro';
comment on column MIG_HISTORICOSEGUROS.ncuacoa
  is 'Número de cuadro coaseguro';
comment on column MIG_HISTORICOSEGUROS.pdtocom
  is 'Porcentaje descuento comercial';
comment on column MIG_HISTORICOSEGUROS.cempres
  is 'Código empresa (Definición Instalación) – 24 en este caso';
comment on column MIG_HISTORICOSEGUROS.sproduc
  is 'Identificador único producto (Definición Productos)';
comment on column MIG_HISTORICOSEGUROS.ccompani
  is 'Código Compañía (Definición Instalación)  – Nulo en este caso';
comment on column MIG_HISTORICOSEGUROS.ctipcob
  is 'Tipo cobro de la póliza (VALOR FIJO:552)';
comment on column MIG_HISTORICOSEGUROS.crevali
  is 'Código Revalorización (VALOR FIJO:62)';
comment on column MIG_HISTORICOSEGUROS.prevali
  is 'Porcentaje de revalorización';
comment on column MIG_HISTORICOSEGUROS.irevali
  is 'Importe de revalorización';
comment on column MIG_HISTORICOSEGUROS.ctipban
  is 'Tipo de cuenta (Ver Tabla TIPOS_CUENTA)';
comment on column MIG_HISTORICOSEGUROS.cbancar
  is 'CCC según Consejo Superior Bancario';
comment on column MIG_HISTORICOSEGUROS.casegur
  is 'Código de Asegurado (9.1.1.5 Valor  Código asegurado). Por defecto 0.';
comment on column MIG_HISTORICOSEGUROS.nsuplem
  is 'Contador del número de suplementos';
comment on column MIG_HISTORICOSEGUROS.cdomici
  is 'Indica el número de la dirección de MIG_PERSONAS (1 o 2)';
comment on column MIG_HISTORICOSEGUROS.npolini
  is 'Número de póliza inicial, antiguo del cliente';
comment on column MIG_HISTORICOSEGUROS.fcarant
  is 'Fecha cartera anterior. Si NULL la calcula el proceso de migración';
comment on column MIG_HISTORICOSEGUROS.fcarpro
  is 'Fecha cartera próxima. Si NULL la calcula el proceso de migración';
comment on column MIG_HISTORICOSEGUROS.crecfra
  is 'Se aplica o no el recargo de fraccionamiento (Si NULL, hereda valor de la definición del producto) 0-NO; 1-SI.';
comment on column MIG_HISTORICOSEGUROS.ndurcob
  is 'Duración del pago de primas';
comment on column MIG_HISTORICOSEGUROS.fcaranu
  is 'Fecha cartera anualidad. Si NULL la calcula el proceso de migración';
comment on column MIG_HISTORICOSEGUROS.NDURACI
  is 'Si la duración del producto está definida como Años o Meses, el número de Años o Meses de duración de la póliza.';
comment on column MIG_HISTORICOSEGUROS.nedamar
  is 'Edad Máx. de renovación';
comment on column MIG_HISTORICOSEGUROS.fefeplazo
  is 'Fecha efecto plazo ejecución';
comment on column MIG_HISTORICOSEGUROS.fvencplazo
  is 'Fecha vencimiento plazo ejecución';
comment on column MIG_HISTORICOSEGUROS.mig_fk3
  is 'Clave foránea de MIG_BUREAU (Número BUREAU)';
-- Create/Recreate indexes 
create index MIG_HISTORICOSEGUROS_NCARGA on MIG_HISTORICOSEGUROS (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_HISTORICOSEGUROS
  add constraint MIG_HISTORICOSEGUROS_PK primary key (MIG_PK);
