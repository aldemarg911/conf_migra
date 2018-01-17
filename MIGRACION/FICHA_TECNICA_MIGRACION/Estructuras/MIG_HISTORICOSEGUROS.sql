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
  is 'Clave �nica de MIG_HISTORICOSEGUROS';
comment on column MIG_HISTORICOSEGUROS.mig_fk
  is 'Clave externa para el tomador (MIG_SEGUROS)';
comment on column MIG_HISTORICOSEGUROS.mig_fk2
  is 'Clave externa para el movimiento (MIG_MOVSEGURO)';
  comment on column MIG_HISTORICOSEGUROS.mig_fkdir
  is 'Clave externa para el tomador (MIG_PER_DIRECCIONES)';
comment on column MIG_HISTORICOSEGUROS.cagente
  is 'C�digo de Agente (MIG_AGENTES)';
comment on column MIG_HISTORICOSEGUROS.ncertif
  is 'N�mero de certificado para p�lizas colectivas';
comment on column MIG_HISTORICOSEGUROS.fefecto
  is 'Fecha de efecto';
comment on column MIG_HISTORICOSEGUROS.cactivi
  is 'C�digo actividad del seguro. (Definici�n Producto) (Cero en este caso)';
comment on column MIG_HISTORICOSEGUROS.ccobban
  is 'C�digo de cobrador bancario (Definici�n Instalaci�n)';
comment on column MIG_HISTORICOSEGUROS.ctiprea
  is 'C�digo tipo de reaseguro. (VALOR FIJO:60)';
comment on column MIG_HISTORICOSEGUROS.creafac
  is 'Indicador reaseguro facultativo. (VALOR FIJO:71)';
comment on column MIG_HISTORICOSEGUROS.ctipcom
  is 'C�digo tipo de comisi�n (VALOR FIJO:55)';
comment on column MIG_HISTORICOSEGUROS.csituac
  is 'C�digo de situaci�n (VALOR FIJO:61)';
comment on column MIG_HISTORICOSEGUROS.FVENCIM
  is 'Fecha de Vencimiento';
comment on column MIG_HISTORICOSEGUROS.femisio
  is 'Fecha de Emisi�n';
comment on column MIG_HISTORICOSEGUROS.fanulac
  is 'Fecha de anulaci�n';
comment on column MIG_HISTORICOSEGUROS.iprianu
  is 'Importe primera anualidad';
comment on column MIG_HISTORICOSEGUROS.cidioma
  is 'C�digo idioma  (9.1.1.2 Valor  IDIOMAS)';
comment on column MIG_HISTORICOSEGUROS.cforpag
  is 'C�digo forma de pago  (VALOR FIJO:17)';
comment on column MIG_HISTORICOSEGUROS.creteni
  is 'C�digo retenci�n p�liza (VALOR FIJO:66)';
comment on column MIG_HISTORICOSEGUROS.ctipcoa
  is 'C�digo tipo de coaseguro (VALOR FIJO:59)';
comment on column MIG_HISTORICOSEGUROS.sciacoa
  is 'C�digo de compa��a coaseguro (MIG_PK) COMPANIAS';
comment on column MIG_HISTORICOSEGUROS.pparcoa
  is 'Porcentaje participaci�n coaseguro';
comment on column MIG_HISTORICOSEGUROS.npolcoa
  is 'N�mero p�liza compa��a coaseguro';
comment on column MIG_HISTORICOSEGUROS.nsupcoa
  is 'N�mero de suplemento compa��a coaseguro';
comment on column MIG_HISTORICOSEGUROS.ncuacoa
  is 'N�mero de cuadro coaseguro';
comment on column MIG_HISTORICOSEGUROS.pdtocom
  is 'Porcentaje descuento comercial';
comment on column MIG_HISTORICOSEGUROS.cempres
  is 'C�digo empresa (Definici�n Instalaci�n) � 24 en este caso';
comment on column MIG_HISTORICOSEGUROS.sproduc
  is 'Identificador �nico producto (Definici�n Productos)';
comment on column MIG_HISTORICOSEGUROS.ccompani
  is 'C�digo Compa��a (Definici�n Instalaci�n)  � Nulo en este caso';
comment on column MIG_HISTORICOSEGUROS.ctipcob
  is 'Tipo cobro de la p�liza (VALOR FIJO:552)';
comment on column MIG_HISTORICOSEGUROS.crevali
  is 'C�digo Revalorizaci�n (VALOR FIJO:62)';
comment on column MIG_HISTORICOSEGUROS.prevali
  is 'Porcentaje de revalorizaci�n';
comment on column MIG_HISTORICOSEGUROS.irevali
  is 'Importe de revalorizaci�n';
comment on column MIG_HISTORICOSEGUROS.ctipban
  is 'Tipo de cuenta (Ver Tabla TIPOS_CUENTA)';
comment on column MIG_HISTORICOSEGUROS.cbancar
  is 'CCC seg�n Consejo Superior Bancario';
comment on column MIG_HISTORICOSEGUROS.casegur
  is 'C�digo de Asegurado (9.1.1.5 Valor  C�digo asegurado). Por defecto 0.';
comment on column MIG_HISTORICOSEGUROS.nsuplem
  is 'Contador del n�mero de suplementos';
comment on column MIG_HISTORICOSEGUROS.cdomici
  is 'Indica el n�mero de la direcci�n de MIG_PERSONAS (1 o 2)';
comment on column MIG_HISTORICOSEGUROS.npolini
  is 'N�mero de p�liza inicial, antiguo del cliente';
comment on column MIG_HISTORICOSEGUROS.fcarant
  is 'Fecha cartera anterior. Si NULL la calcula el proceso de migraci�n';
comment on column MIG_HISTORICOSEGUROS.fcarpro
  is 'Fecha cartera pr�xima. Si NULL la calcula el proceso de migraci�n';
comment on column MIG_HISTORICOSEGUROS.crecfra
  is 'Se aplica o no el recargo de fraccionamiento (Si NULL, hereda valor de la definici�n del producto) 0-NO; 1-SI.';
comment on column MIG_HISTORICOSEGUROS.ndurcob
  is 'Duraci�n del pago de primas';
comment on column MIG_HISTORICOSEGUROS.fcaranu
  is 'Fecha cartera anualidad. Si NULL la calcula el proceso de migraci�n';
comment on column MIG_HISTORICOSEGUROS.NDURACI
  is 'Si la duraci�n del producto est� definida como A�os o Meses, el n�mero de A�os o Meses de duraci�n de la p�liza.';
comment on column MIG_HISTORICOSEGUROS.nedamar
  is 'Edad M�x. de renovaci�n';
comment on column MIG_HISTORICOSEGUROS.fefeplazo
  is 'Fecha efecto plazo ejecuci�n';
comment on column MIG_HISTORICOSEGUROS.fvencplazo
  is 'Fecha vencimiento plazo ejecuci�n';
comment on column MIG_HISTORICOSEGUROS.mig_fk3
  is 'Clave for�nea de MIG_BUREAU (N�mero BUREAU)';
-- Create/Recreate indexes 
create index MIG_HISTORICOSEGUROS_NCARGA on MIG_HISTORICOSEGUROS (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_HISTORICOSEGUROS
  add constraint MIG_HISTORICOSEGUROS_PK primary key (MIG_PK);
