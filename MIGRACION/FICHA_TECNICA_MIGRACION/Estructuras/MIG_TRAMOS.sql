-- Create table
create table MIG_TRAMOS
(
  ncarga         NUMBER,
  cestmig        NUMBER,
  mig_pk         VARCHAR2(50) not null,
  mig_fk         VARCHAR2(50) not null,
  nversio        NUMBER(2) not null,
  scontra        NUMBER(6) not null,
  ctramo         NUMBER(2) not null,
  itottra        NUMBER,
  nplenos        NUMBER(6),
  cfrebor        NUMBER(2) not null,
  plocal         NUMBER(5),
  ixlprio        NUMBER,
  ixlexce        NUMBER,
  pslprio        NUMBER(5),
  pslexce        NUMBER(5),
  ncesion        NUMBER(6),
  fultbor        DATE,
  imaxplo        NUMBER,
  norden         NUMBER(2) not null,
  nsegcon        NUMBER(6),
  nsegver        NUMBER(2),
  iminxl         NUMBER,
  idepxl         NUMBER,
  nctrxl         NUMBER(6),
  nverxl         NUMBER(2),
  ptasaxl        NUMBER(6),
  ipmd           NUMBER,
  cfrepmd        NUMBER(2),
  caplixl        NUMBER(1),
  plimgas        NUMBER(5),
  pliminx        NUMBER(5),
  idaa           NUMBER,
  ilaa           NUMBER,
  ctprimaxl      NUMBER(1),
  iprimafijaxl   NUMBER,
  iprimaestimada NUMBER,
  caplictasaxl   NUMBER(1),
  ctiptasaxl     NUMBER(1),
  ctramotasaxl   NUMBER(5),
  pctpdxl        NUMBER(5),
  cforpagpdxl    NUMBER(1),
  pctminxl       NUMBER(5),
  pctpb          NUMBER(5),
  nanyosloss     NUMBER(2),
  closscorridor  NUMBER(5),
  ccappedratio   NUMBER(5),
  crepos         NUMBER(5),
  ibonorec       NUMBER,
  impaviso       NUMBER,
  impcontado     NUMBER,
  pctcontado     NUMBER(5),
  pctgastos      NUMBER(5),
  ptasaajuste    NUMBER(5),
  icapcoaseg     NUMBER,
  preest         NUMBER,
  icostofijo     NUMBER,
  pcomisinterm   NUMBER
)
;
-- Add comments to the columns 
comment on column MIG_TRAMOS.mig_pk
  is 'Clave �nica de MIG_TRAMOS';
comment on column MIG_TRAMOS.mig_fk
  is 'Clave externa de MIG_CODICONTRATOS';
comment on column MIG_TRAMOS.nversio
  is 'Versi�n del tramo';
comment on column MIG_TRAMOS.scontra
  is 'Secuencia de contrato (Nulo en este caso)';
comment on column MIG_TRAMOS.ctramo
  is 'C�digo de tramo';
comment on column MIG_TRAMOS.itottra
  is 'Importe tramo';
comment on column MIG_TRAMOS.nplenos
  is 'N�mero de plenos';
comment on column MIG_TRAMOS.cfrebor
  is 'C�digo de frecuencia borderour';
comment on column MIG_TRAMOS.plocal
  is 'Porcentaje local';
comment on column MIG_TRAMOS.ixlprio
  is 'Importe XL prioridad';
comment on column MIG_TRAMOS.ixlexce
  is 'Importe XL exceso';
comment on column MIG_TRAMOS.pslprio
  is 'Porcentaje l�mite prioridad';
comment on column MIG_TRAMOS.pslexce
  is 'Porcentaje l�mite exceso';
comment on column MIG_TRAMOS.ncesion
  is 'N�mero de cesi�n (Por defecto 0)';
comment on column MIG_TRAMOS.fultbor
  is 'Fecha �ltimo borderour ';
comment on column MIG_TRAMOS.imaxplo
  is '0';
comment on column MIG_TRAMOS.norden
  is 'Orden del tramo';
comment on column MIG_TRAMOS.nsegcon
  is '0';
comment on column MIG_TRAMOS.nsegver
  is '0';
comment on column MIG_TRAMOS.iminxl
  is 'Prima m�nima para contratos XL';
comment on column MIG_TRAMOS.idepxl
  is 'Prima de dep�sito para contratos XL';
comment on column MIG_TRAMOS.nctrxl
  is 'Contracte XL de protecci�.';
comment on column MIG_TRAMOS.nverxl
  is 'Versi� Ctr. XL de protecci�.';
comment on column MIG_TRAMOS.ptasaxl
  is 'Porcentaje de la tasa aplicable para contratos XL';
comment on column MIG_TRAMOS.ipmd
  is 'Importe Prima M�nima Dep�sito XL';
comment on column MIG_TRAMOS.cfrepmd
  is 'C�digo frecuencia pago PMD';
comment on column MIG_TRAMOS.caplixl
  is 'Aplica o no el l�mite por contrato del XL ( 0-S�, 1-No)';
comment on column MIG_TRAMOS.plimgas
  is 'Porcentaje de aumento del l�mite XL por gastos';
comment on column MIG_TRAMOS.pliminx
  is 'Porcentaje de l�mite de aplicaci�n de la indexaci�n';
comment on column MIG_TRAMOS.idaa
  is 'Deducible anual';
comment on column MIG_TRAMOS.ilaa
  is 'L�mite agregado anual';
comment on column MIG_TRAMOS.ctprimaxl
  is 'Tipo Prima XL  (cvalor=342)';
comment on column MIG_TRAMOS.iprimafijaxl
  is 'Prima fija XL';
comment on column MIG_TRAMOS.iprimaestimada
  is 'Prima Estimada para el tramo';
comment on column MIG_TRAMOS.caplictasaxl
  is 'Campo aplicaci�n tasa XL (cvalor=343)';
comment on column MIG_TRAMOS.ctiptasaxl
  is 'Tipo tasa XL (cvalor=344)';
comment on column MIG_TRAMOS.ctramotasaxl
  is 'Tramo de tasa variable XL (Tabla CLAUSULAS_REAS)';
comment on column MIG_TRAMOS.pctpdxl
  is '% Prima Dep�sito';
comment on column MIG_TRAMOS.cforpagpdxl
  is 'Forma pago prima de dep�sito XL';
comment on column MIG_TRAMOS.pctminxl
  is '% Prima M�nima XL';
comment on column MIG_TRAMOS.pctpb
  is '% PB';
comment on column MIG_TRAMOS.nanyosloss
  is 'A�os Loss Corridor';
comment on column MIG_TRAMOS.closscorridor
  is 'C�digo cl�usula Loss Corridor (Tabla CLAUSULAS_REAS)';
comment on column MIG_TRAMOS.ccappedratio
  is 'C�digo cl�usula Capped Ratio (Tabla CLAUSULAS_REAS)';
comment on column MIG_TRAMOS.crepos
  is 'C�digo Reposici�n Xl (Tabla REPOSICIONES)';
comment on column MIG_TRAMOS.ibonorec
  is 'Bono Reclamaci�n';
comment on column MIG_TRAMOS.impaviso
  is 'Importe Avisos Siniestro';
comment on column MIG_TRAMOS.impcontado
  is 'Importe pagos contado';
comment on column MIG_TRAMOS.pctcontado
  is '% Pagos Contado';
comment on column MIG_TRAMOS.pctgastos
  is 'Gastos';
comment on column MIG_TRAMOS.ptasaajuste
  is 'Tasa ajuste';
comment on column MIG_TRAMOS.icapcoaseg
  is 'Capacidad seg�n coaseguro';
comment on column MIG_TRAMOS.preest
  is 'Porcentaje de restablecimiento del tramo';
comment on column MIG_TRAMOS.icostofijo
  is 'Importe del costo fijo de la capa/tramo para el contrato-versi�n';
comment on column MIG_TRAMOS.pcomisinterm
  is 'Porcentaje de la comisi�n de intermediaci�n definida para la capa/tramo del contrato-versi�n';
