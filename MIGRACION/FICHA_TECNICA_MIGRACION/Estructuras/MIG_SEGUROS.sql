-- Create table
create table MIG_SEGUROS
(
  ncarga      NUMBER not null,
  cestmig     NUMBER not null,
  mig_pk      VARCHAR2(50) not null,
  mig_fk      VARCHAR2(50) not null,
  mig_fkdir   VARCHAR2(50) not null,
  cagente     NUMBER not null,
  npoliza     NUMBER not null,
  ncertif     NUMBER not null,
  fefecto     DATE not null,
  creafac     NUMBER(1) not null,
  cactivi     NUMBER(4) not null,
  ccobban     NUMBER(3),
  ctipcoa     NUMBER(1),
  ctiprea     NUMBER(1) not null,
  ctipcom     NUMBER(2),
  fvencim     DATE,
  femisio     DATE,
  fanulac     DATE,
  fcancel     DATE,
  csituac     NUMBER(2),
  iprianu     NUMBER,
  cidioma     NUMBER(2) not null,
  cforpag     NUMBER(2) not null,
  creteni     NUMBER(2),
  sciacoa     NUMBER(6),
  pparcoa     NUMBER(5,2),
  npolcoa     VARCHAR2(10),
  nsupcoa     VARCHAR2(6),
  pdtocom     NUMBER(5,2),
  ncuacoa     NUMBER(2),
  cempres     NUMBER(2) not null,
  sproduc     NUMBER(6) not null,
  ccompani    NUMBER(3),
  ctipcob     NUMBER(3),
  crevali     NUMBER(2),
  prevali     NUMBER(5,2),
  irevali     NUMBER,
  ctipban     NUMBER(3),
  cbancar     VARCHAR2(50),
  casegur     NUMBER(2) not null,
  nsuplem     NUMBER(4) not null,
  sseguro     NUMBER not null,
  sperson     NUMBER(10) not null,
  cdomici     NUMBER,
  npolini     VARCHAR2(15),
  ctipban2    NUMBER(1),
  cbancob     VARCHAR2(50),
  fcarant     DATE,
  fcarpro     DATE,
  crecfra     NUMBER(1),
  ndurcob     NUMBER(2),
  fcaranu     DATE,
  ctipretr    NUMBER(2),
  cindrevfran NUMBER(1),
  precarg     NUMBER(6,2),
  pdtotec     NUMBER(6,2),
  preccom     NUMBER(6,2),
  frenova     DATE,
  cpolcia     VARCHAR2(50),
  nedamar     NUMBER(2),
  proceso     NUMBER,
  nduraci     NUMBER(5,2),
  mig_fk2     VARCHAR2(50)
);
-- Add comments to the table 
comment on table MIG_SEGUROS
  is 'Tabla Intermedia migración Seguros';
-- Add comments to the columns 
comment on column MIG_SEGUROS.ncarga
  is 'Número de carga';
comment on column MIG_SEGUROS.cestmig
  is 'Estado del registro';
comment on column MIG_SEGUROS.mig_pk
  is 'Clave única de MIG_SEGUROS';
comment on column MIG_SEGUROS.mig_fk
  is 'Clave externa para el tomador (MIG_PERSONAS)';
comment on column MIG_SEGUROS.mig_fk
  is 'Clave externa para el tomador (MIG_DIRECCIONES) (Para manejo del NIT Duplicado)';
comment on column MIG_SEGUROS.cagente
  is 'Código de Agente';
comment on column MIG_SEGUROS.npoliza
  is 'Número de Póliza, si valor=0, lo calcula el proceso de migración';
comment on column MIG_SEGUROS.ncertif
  is 'Número de certificado para pólizas colectivas';
comment on column MIG_SEGUROS.fefecto
  is 'Fecha de efecto';
comment on column MIG_SEGUROS.creafac
  is 'Indicador reaseguro facultativo';
comment on column MIG_SEGUROS.cactivi
  is 'Código actividad del seguro';
comment on column MIG_SEGUROS.ccobban
  is 'Código de cobrador bancario';
comment on column MIG_SEGUROS.ctipcoa
  is 'Código tipo de coaseguro';
comment on column MIG_SEGUROS.ctiprea
  is 'Código tipo de reaseguro';
comment on column MIG_SEGUROS.ctipcom
  is 'Código tipo de comisión';
comment on column MIG_SEGUROS.fvencim
  is 'Fecha de Vencimiento';
comment on column MIG_SEGUROS.femisio
  is 'Fecha de Emisión';
comment on column MIG_SEGUROS.fanulac
  is 'Fecha de anulación';
comment on column MIG_SEGUROS.fcancel
  is 'Fecha de cancelación';
comment on column MIG_SEGUROS.csituac
  is 'Código de situación VF:61';
comment on column MIG_SEGUROS.iprianu
  is 'Importe primera anualidad';
comment on column MIG_SEGUROS.cidioma
  is 'Código idioma';
comment on column MIG_SEGUROS.cforpag
  is 'Código forma de pago';
comment on column MIG_SEGUROS.creteni
  is 'Propuesta retenida o no VF:66';
comment on column MIG_SEGUROS.sciacoa
  is 'Código de compañia coaseguro (SPERSON)';
comment on column MIG_SEGUROS.pparcoa
  is 'Porcentaje participación coaseguro';
comment on column MIG_SEGUROS.npolcoa
  is 'Número póliza compañia coaseguro';
comment on column MIG_SEGUROS.nsupcoa
  is 'Número de suplemento compañia coaseguro';
comment on column MIG_SEGUROS.pdtocom
  is 'Porcentaje descuento comercial';
comment on column MIG_SEGUROS.ncuacoa
  is 'Número de cuadro coaseguro';
comment on column MIG_SEGUROS.cempres
  is 'Código empresa';
comment on column MIG_SEGUROS.sproduc
  is 'Identificador único producto';
comment on column MIG_SEGUROS.ccompani
  is 'Código Compañia';
comment on column MIG_SEGUROS.ctipcob
  is 'Tipo cobro de la póliza VF 552';
comment on column MIG_SEGUROS.crevali
  is 'Código Revalorización VF 62';
comment on column MIG_SEGUROS.prevali
  is 'Porcentaje de revalorizacion';
comment on column MIG_SEGUROS.irevali
  is 'Importe de revalorizacion';
comment on column MIG_SEGUROS.ctipban
  is 'Tipo de cuenta';
comment on column MIG_SEGUROS.cbancar
  is 'CCC según Consejo Superior Bancario';
comment on column MIG_SEGUROS.casegur
  is 'Código de Asegurado';
comment on column MIG_SEGUROS.nsuplem
  is 'Contador del número de suplementos';
comment on column MIG_SEGUROS.sseguro
  is 'Número consecutivo de seguro asignado 0, lo calcula el proceso de migración';
comment on column MIG_SEGUROS.sperson
  is 'Identificador único de persona asignado 0, lo calcula el proceso de migración';
comment on column MIG_SEGUROS.cdomici
  is 'Indica el numero de la dirección de MIG_PERSONAS (1 o 2)';
comment on column MIG_SEGUROS.npolini
  is 'Número de póliza inicial, antiguo del cliente';
comment on column MIG_SEGUROS.ctipban2
  is 'Tipo cuenta cargo (APRA)';
comment on column MIG_SEGUROS.cbancob
  is 'Cuenta cargo (APRA)';
comment on column MIG_SEGUROS.fcarant
  is 'Fecha cartera anterior. Si NULL la calcula el proceso de migración';
comment on column MIG_SEGUROS.fcarpro
  is 'Fecha cartera próxima. Si NULL la calcula el proceso de migración';
comment on column MIG_SEGUROS.crecfra
  is 'Se aplica o no el recargo de fraccionamiento (Si NULL, hereda valor de la definición del producto)';
comment on column MIG_SEGUROS.ndurcob
  is 'Duración del pago de primas';
comment on column MIG_SEGUROS.fcaranu
  is 'Fecha cartera anualidad';
comment on column MIG_SEGUROS.ctipretr
  is 'Tipo de retribución';
comment on column MIG_SEGUROS.cindrevfran
  is 'Revalorización franquicia';
comment on column MIG_SEGUROS.precarg
  is 'Recargo técnico';
comment on column MIG_SEGUROS.pdtotec
  is 'Descuento técnico';
comment on column MIG_SEGUROS.preccom
  is 'Recargo comercial';
comment on column MIG_SEGUROS.frenova
  is 'Fecha renovación';
comment on column MIG_SEGUROS.cpolcia
  is 'Identificador de póliza en compañia/agente/partner';
comment on column MIG_SEGUROS.nedamar
  is 'Edad Máx. de renovación';
comment on column MIG_SEGUROS.proceso
  is 'Id.Proceso que ha cargado';
comment on column MIG_SEGUROS.nduraci
  is 'Valor duración para meses o años';
-- Create/Recreate indexes 
create index MIG_SEGUROS_NCARGA on MIG_SEGUROS (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_SEGUROS
  add constraint MIG_SEGUROS_PK primary key (MIG_PK);
