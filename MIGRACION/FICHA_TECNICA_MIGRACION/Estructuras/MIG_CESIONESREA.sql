--
-- Create table
create table MIG_CESIONESREA
(
  ncarga      NUMBER,
  cestmig     NUMBER,
  mig_pk      VARCHAR2(50) not null,
  scesrea     NUMBER(8) not null,
  ncesion     NUMBER(6) not null,
  icesion     NUMBER not null,
  icapces     NUMBER not null,
  mig_fkseg   NUMBER,
  nversio     NUMBER(2),
  scontra     NUMBER(6),
  ctramo      NUMBER(2),
  sfacult     NUMBER(6),
  nriesgo     NUMBER(6),
  cgarant     NUMBER(4),
  mif_fksini  NUMBER,
  fefecto     DATE,
  fvencim     DATE,
  fcontab     DATE,
  pcesion     NUMBER(8),
  cgenera     NUMBER(2),
  fgenera     DATE,
  fregula     DATE,
  fanulac     DATE,
  nmovimi     NUMBER(4),
  ipritarrea  NUMBER,
  idtosel     NUMBER,
  psobreprima NUMBER(8),
  cdetces     NUMBER(1),
  ipleno      NUMBER,
  icapaci     NUMBER,
  nmovigen    NUMBER(6) not NULL,
  CTRAMPA      NUMBER(2),	
  CTIPOMOV      VARCHAR2(1),	
  CCUTOFF      VARCHAR2(1)
);
-- Add comments to the table 
comment on table MIG_CESIONESREA
  is 'Fichero con la informaci�n de cesiones de reaseguro.';
-- Add comments to the columns 
comment on column MIG_CESIONESREA.mig_pk
  is 'Clave �nica de MIG_CESIONESREA';
comment on column MIG_CESIONESREA.scesrea
  is 'Secuencia de cesi�n de reaseguro. Si es nulo se calcula';
comment on column MIG_CESIONESREA.ncesion
  is 'N�mero de cesi�n de reaseguro';
comment on column MIG_CESIONESREA.icesion
  is 'Importe prima anual';
comment on column MIG_CESIONESREA.icapces
  is 'Capacidad de la sesi�n';
comment on column MIG_CESIONESREA.mig_fkseg
  is 'MIG_FK (SEGUROS) � Clave externa de seguros';
comment on column MIG_CESIONESREA.nversio
  is 'Versi�n del contrato';
comment on column MIG_CESIONESREA.scontra
  is 'C�digo del contrato';
comment on column MIG_CESIONESREA.ctramo
  is 'C�digo del tramo 0-Primer tramo (pleno inicial), 1...4-Sucesivos, 5-Facultativo';
comment on column MIG_CESIONESREA.sfacult
  is 'C�digo del cuadro facultativo (Nulo para la migraci�n)';
comment on column MIG_CESIONESREA.nriesgo
  is 'N�mero de riesgo';
comment on column MIG_CESIONESREA.cgarant
  is 'C�digo de garant�a';
comment on column MIG_CESIONESREA.mif_fksini
  is 'MIF_FK_SINI � Siniestro � Clave externa siniestros';
comment on column MIG_CESIONESREA.fefecto
  is 'Fecha efecto reaseguro';
comment on column MIG_CESIONESREA.fvencim
  is 'Fecha vencimiento reaseguro';
comment on column MIG_CESIONESREA.fcontab
  is 'Fecha contable';
comment on column MIG_CESIONESREA.pcesion
  is 'Porcentaje de cesi�n';
comment on column MIG_CESIONESREA.cgenera
  is 'Tipo movimiento 2-Siniestros, 3-Producci�n(normal), 4 y 7-Suplementos, 6 Anulaci�n, 5-Cartera';
comment on column MIG_CESIONESREA.fgenera
  is 'Fecha generaci�n reaseguro';
comment on column MIG_CESIONESREA.fregula
  is 'Fecha regularizaci�n reaseguro';
comment on column MIG_CESIONESREA.fanulac
  is 'Fecha de anulaci�n de la cesi�n';
comment on column MIG_CESIONESREA.nmovimi
  is 'N�mero de movimiento';
comment on column MIG_CESIONESREA.ipritarrea
  is 'Prima de tarifa';
comment on column MIG_CESIONESREA.idtosel
  is 'Importe descuento de selecci�n';
comment on column MIG_CESIONESREA.psobreprima
  is 'Porcentaje sobreprima';
comment on column MIG_CESIONESREA.cdetces
  is 'Indica si se graba o no a reasegemi. Por defecto 1';
comment on column MIG_CESIONESREA.ipleno
  is 'Pleno utilizado en el c�lculo de la cesi�n';
comment on column MIG_CESIONESREA.icapaci
  is 'Capacidad utilizada en el c�lculo de la cesi�n';
comment on column MIG_CESIONESREA.nmovigen
  is 'Conjunto de cesiones generadas.';
comment on column MIG_CESIONESREA.CTRAMPA   is 'Tramo padre amparado';
comment on column MIG_CESIONESREA.CTIPOMOV   is 'Null o M (Las distribuciones son a decisi�n del cliente)';
comment on column MIG_CESIONESREA.CCUTOFF   is 'S-S�/N-No. Indica si la retenci�n generada es debido a un movimiento de cutoff';

create index MIG_CESIONESREA_NCARGA on MIG_CESIONESREA (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CESIONESREA
  add constraint MIG_CESIONESREA_PK primary key (MIG_PK);
