-- Create table
create table MIG_CUADROCES
(
  ncarga         NUMBER,
  cestmig        NUMBER,
  mig_pk         VARCHAR2(50) not null,
  mig_fk         VARCHAR2(50) not null,
  mig_fk2        VARCHAR2(50) not null,
  nversio        NUMBER(2) not null,
  scontra        NUMBER(6) not null,
  ctramo         NUMBER(2) not null,
  ccomrea        NUMBER(2),
  pcesion        NUMBER(8),
  nplenos        NUMBER(5),
  icesfij        NUMBER,
  icomfij        NUMBER,
  isconta        NUMBER,
  preserv        NUMBER(5,2),
  pintres        NUMBER(7,2),
  iliacde        NUMBER,
  ppagosl        NUMBER(5,2),
  ccorred        NUMBER(4),
  cintres        NUMBER(2),
  cintref        NUMBER(3),
  cresref        NUMBER(3),
  ireserv        NUMBER,
  ptasaj         NUMBER(5,2),
  fultliq        DATE,
  iagrega        NUMBER,
  imaxagr        NUMBER,
  ctipcomis      NUMBER(1),
  pctcomis       NUMBER(5,2),
  ctramocomision NUMBER(5),
  cfreres        NUMBER(2),
  pctgastos      NUMBER(5,2)
)
;
-- Add comments to the columns 
comment on column MIG_CUADROCES.mig_pk
  is 'Clave única de MIG_CUADROCES';
comment on column MIG_CUADROCES.mig_fk
  is 'Clave externa de MIG_CODICONTRATOS';
comment on column MIG_CUADROCES.mig_fk2
  is 'Clave externa para MIG_COMPANIAS';
comment on column MIG_CUADROCES.nversio
  is 'Número versión contrato reas.';
comment on column MIG_CUADROCES.scontra
  is 'Secuencia de contrato (Nulo en este caso)';
comment on column MIG_CUADROCES.ctramo
  is 'Código del tramo';
comment on column MIG_CUADROCES.ccomrea
  is 'Código de comisión en contratos de reaseguro';
comment on column MIG_CUADROCES.pcesion
  is 'Porcentaje de cesión';
comment on column MIG_CUADROCES.nplenos
  is 'Nº de plenos';
comment on column MIG_CUADROCES.icesfij
  is 'Importe de cesión fijo';
comment on column MIG_CUADROCES.icomfij
  is 'Importe de comisión fijo';
comment on column MIG_CUADROCES.isconta
  is 'Importe límite pago siniestros al contado';
comment on column MIG_CUADROCES.preserv
  is '% reserva sobre cesión - % depósito';
comment on column MIG_CUADROCES.pintres
  is '% interés sobre reserva - % depósito';
comment on column MIG_CUADROCES.iliacde
  is 'Importe límite acumulación deducible(XLoss)';
comment on column MIG_CUADROCES.ppagosl
  is '% a pagar por el reasegurador sobre el % que ha asumido';
comment on column MIG_CUADROCES.ccorred
  is 'Indicador corredor (Cia que agrupamos)';
comment on column MIG_CUADROCES.cintres
  is 'Codi de Interes de reassegurança';
comment on column MIG_CUADROCES.cintref
  is 'Código de interés referenciado';
comment on column MIG_CUADROCES.cresref
  is 'Código de reserva referenciada';
comment on column MIG_CUADROCES.ireserv
  is 'Importe fijo de la reserva';
comment on column MIG_CUADROCES.ptasaj
  is 'Tasa de ajuste de la reserva';
comment on column MIG_CUADROCES.fultliq
  is 'Última liquidación reservas';
comment on column MIG_CUADROCES.iagrega
  is 'Importe Agregado XL';
comment on column MIG_CUADROCES.imaxagr
  is 'Importe Agregado Máximo XL(L.A.A.)';
comment on column MIG_CUADROCES.ctipcomis
  is 'Tipo Comisión (cvalor=345)';
comment on column MIG_CUADROCES.pctcomis
  is '% Comisión fija / provisional';
comment on column MIG_CUADROCES.ctramocomision
  is 'Tramo comisión variable (Tabla CLAUSULAS_REAS)';
comment on column MIG_CUADROCES.cfreres
  is 'Código frecuencia liberación/reembolso de Reservas VF:113';
comment on column MIG_CUADROCES.pctgastos
  is 'Porcentaje de gastos por Cia y Contrato';
--
create index MIG_CUADROCES_NCARGA on MIG_CUADROCES (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CUADROCES
  add constraint MIG_CUADROCES_PK primary key (MIG_PK);
