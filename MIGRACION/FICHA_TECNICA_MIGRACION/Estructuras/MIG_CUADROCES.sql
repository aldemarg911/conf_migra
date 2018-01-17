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
  is 'Clave �nica de MIG_CUADROCES';
comment on column MIG_CUADROCES.mig_fk
  is 'Clave externa de MIG_CODICONTRATOS';
comment on column MIG_CUADROCES.mig_fk2
  is 'Clave externa para MIG_COMPANIAS';
comment on column MIG_CUADROCES.nversio
  is 'N�mero versi�n contrato reas.';
comment on column MIG_CUADROCES.scontra
  is 'Secuencia de contrato (Nulo en este caso)';
comment on column MIG_CUADROCES.ctramo
  is 'C�digo del tramo';
comment on column MIG_CUADROCES.ccomrea
  is 'C�digo de comisi�n en contratos de reaseguro';
comment on column MIG_CUADROCES.pcesion
  is 'Porcentaje de cesi�n';
comment on column MIG_CUADROCES.nplenos
  is 'N� de plenos';
comment on column MIG_CUADROCES.icesfij
  is 'Importe de cesi�n fijo';
comment on column MIG_CUADROCES.icomfij
  is 'Importe de comisi�n fijo';
comment on column MIG_CUADROCES.isconta
  is 'Importe l�mite pago siniestros al contado';
comment on column MIG_CUADROCES.preserv
  is '% reserva sobre cesi�n - % dep�sito';
comment on column MIG_CUADROCES.pintres
  is '% inter�s sobre reserva - % dep�sito';
comment on column MIG_CUADROCES.iliacde
  is 'Importe l�mite acumulaci�n deducible(XLoss)';
comment on column MIG_CUADROCES.ppagosl
  is '% a pagar por el reasegurador sobre el % que ha asumido';
comment on column MIG_CUADROCES.ccorred
  is 'Indicador corredor (Cia que agrupamos)';
comment on column MIG_CUADROCES.cintres
  is 'Codi de Interes de reasseguran�a';
comment on column MIG_CUADROCES.cintref
  is 'C�digo de inter�s referenciado';
comment on column MIG_CUADROCES.cresref
  is 'C�digo de reserva referenciada';
comment on column MIG_CUADROCES.ireserv
  is 'Importe fijo de la reserva';
comment on column MIG_CUADROCES.ptasaj
  is 'Tasa de ajuste de la reserva';
comment on column MIG_CUADROCES.fultliq
  is '�ltima liquidaci�n reservas';
comment on column MIG_CUADROCES.iagrega
  is 'Importe Agregado XL';
comment on column MIG_CUADROCES.imaxagr
  is 'Importe Agregado M�ximo XL(L.A.A.)';
comment on column MIG_CUADROCES.ctipcomis
  is 'Tipo Comisi�n (cvalor=345)';
comment on column MIG_CUADROCES.pctcomis
  is '% Comisi�n fija / provisional';
comment on column MIG_CUADROCES.ctramocomision
  is 'Tramo comisi�n variable (Tabla CLAUSULAS_REAS)';
comment on column MIG_CUADROCES.cfreres
  is 'C�digo frecuencia liberaci�n/reembolso de Reservas VF:113';
comment on column MIG_CUADROCES.pctgastos
  is 'Porcentaje de gastos por Cia y Contrato';
--
create index MIG_CUADROCES_NCARGA on MIG_CUADROCES (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CUADROCES
  add constraint MIG_CUADROCES_PK primary key (MIG_PK);
