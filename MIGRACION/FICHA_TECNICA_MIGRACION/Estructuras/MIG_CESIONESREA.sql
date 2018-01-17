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
  is 'Fichero con la información de cesiones de reaseguro.';
-- Add comments to the columns 
comment on column MIG_CESIONESREA.mig_pk
  is 'Clave única de MIG_CESIONESREA';
comment on column MIG_CESIONESREA.scesrea
  is 'Secuencia de cesión de reaseguro. Si es nulo se calcula';
comment on column MIG_CESIONESREA.ncesion
  is 'Número de cesión de reaseguro';
comment on column MIG_CESIONESREA.icesion
  is 'Importe prima anual';
comment on column MIG_CESIONESREA.icapces
  is 'Capacidad de la sesión';
comment on column MIG_CESIONESREA.mig_fkseg
  is 'MIG_FK (SEGUROS) – Clave externa de seguros';
comment on column MIG_CESIONESREA.nversio
  is 'Versión del contrato';
comment on column MIG_CESIONESREA.scontra
  is 'Código del contrato';
comment on column MIG_CESIONESREA.ctramo
  is 'Código del tramo 0-Primer tramo (pleno inicial), 1...4-Sucesivos, 5-Facultativo';
comment on column MIG_CESIONESREA.sfacult
  is 'Código del cuadro facultativo (Nulo para la migración)';
comment on column MIG_CESIONESREA.nriesgo
  is 'Número de riesgo';
comment on column MIG_CESIONESREA.cgarant
  is 'Código de garantía';
comment on column MIG_CESIONESREA.mif_fksini
  is 'MIF_FK_SINI – Siniestro – Clave externa siniestros';
comment on column MIG_CESIONESREA.fefecto
  is 'Fecha efecto reaseguro';
comment on column MIG_CESIONESREA.fvencim
  is 'Fecha vencimiento reaseguro';
comment on column MIG_CESIONESREA.fcontab
  is 'Fecha contable';
comment on column MIG_CESIONESREA.pcesion
  is 'Porcentaje de cesión';
comment on column MIG_CESIONESREA.cgenera
  is 'Tipo movimiento 2-Siniestros, 3-Producción(normal), 4 y 7-Suplementos, 6 Anulación, 5-Cartera';
comment on column MIG_CESIONESREA.fgenera
  is 'Fecha generación reaseguro';
comment on column MIG_CESIONESREA.fregula
  is 'Fecha regularización reaseguro';
comment on column MIG_CESIONESREA.fanulac
  is 'Fecha de anulación de la cesión';
comment on column MIG_CESIONESREA.nmovimi
  is 'Número de movimiento';
comment on column MIG_CESIONESREA.ipritarrea
  is 'Prima de tarifa';
comment on column MIG_CESIONESREA.idtosel
  is 'Importe descuento de selección';
comment on column MIG_CESIONESREA.psobreprima
  is 'Porcentaje sobreprima';
comment on column MIG_CESIONESREA.cdetces
  is 'Indica si se graba o no a reasegemi. Por defecto 1';
comment on column MIG_CESIONESREA.ipleno
  is 'Pleno utilizado en el cálculo de la cesión';
comment on column MIG_CESIONESREA.icapaci
  is 'Capacidad utilizada en el cálculo de la cesión';
comment on column MIG_CESIONESREA.nmovigen
  is 'Conjunto de cesiones generadas.';
comment on column MIG_CESIONESREA.CTRAMPA   is 'Tramo padre amparado';
comment on column MIG_CESIONESREA.CTIPOMOV   is 'Null o M (Las distribuciones son a decisión del cliente)';
comment on column MIG_CESIONESREA.CCUTOFF   is 'S-Sí/N-No. Indica si la retención generada es debido a un movimiento de cutoff';

create index MIG_CESIONESREA_NCARGA on MIG_CESIONESREA (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CESIONESREA
  add constraint MIG_CESIONESREA_PK primary key (MIG_PK);
