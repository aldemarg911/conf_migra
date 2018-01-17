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
  is 'Clave única de MIG_TRAMOS';
comment on column MIG_TRAMOS.mig_fk
  is 'Clave externa de MIG_CODICONTRATOS';
comment on column MIG_TRAMOS.nversio
  is 'Versión del tramo';
comment on column MIG_TRAMOS.scontra
  is 'Secuencia de contrato (Nulo en este caso)';
comment on column MIG_TRAMOS.ctramo
  is 'Código de tramo';
comment on column MIG_TRAMOS.itottra
  is 'Importe tramo';
comment on column MIG_TRAMOS.nplenos
  is 'Número de plenos';
comment on column MIG_TRAMOS.cfrebor
  is 'Código de frecuencia borderour';
comment on column MIG_TRAMOS.plocal
  is 'Porcentaje local';
comment on column MIG_TRAMOS.ixlprio
  is 'Importe XL prioridad';
comment on column MIG_TRAMOS.ixlexce
  is 'Importe XL exceso';
comment on column MIG_TRAMOS.pslprio
  is 'Porcentaje límite prioridad';
comment on column MIG_TRAMOS.pslexce
  is 'Porcentaje límite exceso';
comment on column MIG_TRAMOS.ncesion
  is 'Número de cesión (Por defecto 0)';
comment on column MIG_TRAMOS.fultbor
  is 'Fecha último borderour ';
comment on column MIG_TRAMOS.imaxplo
  is '0';
comment on column MIG_TRAMOS.norden
  is 'Orden del tramo';
comment on column MIG_TRAMOS.nsegcon
  is '0';
comment on column MIG_TRAMOS.nsegver
  is '0';
comment on column MIG_TRAMOS.iminxl
  is 'Prima mínima para contratos XL';
comment on column MIG_TRAMOS.idepxl
  is 'Prima de depósito para contratos XL';
comment on column MIG_TRAMOS.nctrxl
  is 'Contracte XL de protecció.';
comment on column MIG_TRAMOS.nverxl
  is 'Versió Ctr. XL de protecció.';
comment on column MIG_TRAMOS.ptasaxl
  is 'Porcentaje de la tasa aplicable para contratos XL';
comment on column MIG_TRAMOS.ipmd
  is 'Importe Prima Mínima Depósito XL';
comment on column MIG_TRAMOS.cfrepmd
  is 'Código frecuencia pago PMD';
comment on column MIG_TRAMOS.caplixl
  is 'Aplica o no el límite por contrato del XL ( 0-Sí, 1-No)';
comment on column MIG_TRAMOS.plimgas
  is 'Porcentaje de aumento del límite XL por gastos';
comment on column MIG_TRAMOS.pliminx
  is 'Porcentaje de límite de aplicación de la indexación';
comment on column MIG_TRAMOS.idaa
  is 'Deducible anual';
comment on column MIG_TRAMOS.ilaa
  is 'Límite agregado anual';
comment on column MIG_TRAMOS.ctprimaxl
  is 'Tipo Prima XL  (cvalor=342)';
comment on column MIG_TRAMOS.iprimafijaxl
  is 'Prima fija XL';
comment on column MIG_TRAMOS.iprimaestimada
  is 'Prima Estimada para el tramo';
comment on column MIG_TRAMOS.caplictasaxl
  is 'Campo aplicación tasa XL (cvalor=343)';
comment on column MIG_TRAMOS.ctiptasaxl
  is 'Tipo tasa XL (cvalor=344)';
comment on column MIG_TRAMOS.ctramotasaxl
  is 'Tramo de tasa variable XL (Tabla CLAUSULAS_REAS)';
comment on column MIG_TRAMOS.pctpdxl
  is '% Prima Depósito';
comment on column MIG_TRAMOS.cforpagpdxl
  is 'Forma pago prima de depósito XL';
comment on column MIG_TRAMOS.pctminxl
  is '% Prima Mínima XL';
comment on column MIG_TRAMOS.pctpb
  is '% PB';
comment on column MIG_TRAMOS.nanyosloss
  is 'Años Loss Corridor';
comment on column MIG_TRAMOS.closscorridor
  is 'Código cláusula Loss Corridor (Tabla CLAUSULAS_REAS)';
comment on column MIG_TRAMOS.ccappedratio
  is 'Código cláusula Capped Ratio (Tabla CLAUSULAS_REAS)';
comment on column MIG_TRAMOS.crepos
  is 'Código Reposición Xl (Tabla REPOSICIONES)';
comment on column MIG_TRAMOS.ibonorec
  is 'Bono Reclamación';
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
  is 'Capacidad según coaseguro';
comment on column MIG_TRAMOS.preest
  is 'Porcentaje de restablecimiento del tramo';
comment on column MIG_TRAMOS.icostofijo
  is 'Importe del costo fijo de la capa/tramo para el contrato-versión';
comment on column MIG_TRAMOS.pcomisinterm
  is 'Porcentaje de la comisión de intermediación definida para la capa/tramo del contrato-versión';
