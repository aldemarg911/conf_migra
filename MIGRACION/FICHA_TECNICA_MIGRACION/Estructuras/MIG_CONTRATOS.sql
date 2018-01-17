-- Create table
-- V.1.0 Se elimina columna mig_fk2 alineado con versi�n de la Ficha de Migraci�n v3.24
--
DROP TABLE MIG_CONTRATOS;
--
create table MIG_CONTRATOS
(
  ncarga          NUMBER,
  cestmig         NUMBER,
  mig_pk          VARCHAR2(50) not null,
  mig_fk          VARCHAR2(50) not null,
  --mig_fk2         VARCHAR2(50) not null,
  nversion        NUMBER not null,
  scontra         NUMBER not null,
  nversio         NUMBER(2) not null,
  npriori         NUMBER(2) not null,
  fconini         DATE not null,
  nconrel         NUMBER(6),
  fconfin         DATE,
  iautori         NUMBER,
  iretenc         NUMBER,
  iminces         NUMBER,
  icapaci         NUMBER,
  iprioxl         NUMBER,
  ppriosl         NUMBER,
  tcontra         VARCHAR2(50),
  tobserv         VARCHAR2(80),
  pcedido         NUMBER(5,2),
  priesgos        NUMBER(5,2),
  pdescuento      NUMBER(5,2),
  pgastos         NUMBER(5,2),
  ppartbene       NUMBER(5,2),
  creafac         NUMBER(1),
  pcesext         NUMBER(5,2),
  cgarrel         NUMBER(1),
  cfrecul         NUMBER(2),
  sconqp          NUMBER(6),
  nverqp          NUMBER(2),
  iagrega         NUMBER,
  imaxagr         NUMBER,
  pdeposito       NUMBER(17),
  cdetces         NUMBER(1),
  clavecbr        NUMBER(6),
  cercartera      NUMBER(2),
  nanyosloss      NUMBER(2),
  cbasexl         NUMBER(1),
  closscorridor   NUMBER(5),
  ccappedratio    NUMBER(5),
  scontraprot     NUMBER(6),
  cestado         NUMBER(2),
  nversioprot     NUMBER(2),
  iprimaesperadas NUMBER(17),
  ctpreest        NUMBER(1),
  pcomext         NUMBER
)
;
-- Add comments to the columns 
comment on column MIG_CONTRATOS.mig_pk
  is 'Clave �nica de MIG_CONTRATOS';
comment on column MIG_CONTRATOS.mig_fk
  is 'Clave externa de MIG_CODICONTRATOS';
--comment on column MIG_CONTRATOS.mig_fk2
--  is 'Clave externa para MIG_COMPANIAS';
comment on column MIG_CONTRATOS.nversion
  is 'N�mero versi�n contrato reaseguro';
comment on column MIG_CONTRATOS.scontra
  is 'C�digo contrato (Nulo en este caso)';
comment on column MIG_CONTRATOS.nversio
  is 'N�mero versi�n contrato reas.';
comment on column MIG_CONTRATOS.npriori
  is 'Porcentaje local asumible';
comment on column MIG_CONTRATOS.fconini
  is 'Fecha inicial de versi�n';
comment on column MIG_CONTRATOS.nconrel
  is 'Contrato relacionado';
comment on column MIG_CONTRATOS.fconfin
  is 'Fecha final de versi�n';
comment on column MIG_CONTRATOS.iautori
  is 'Importe con autorizaci�n';
comment on column MIG_CONTRATOS.iretenc
  is 'Importe pleno neto de retenci�n';
comment on column MIG_CONTRATOS.iminces
  is 'Imp. m�nimo cesi�n (Pleno Neto Retenci�n)';
comment on column MIG_CONTRATOS.icapaci
  is 'Importe capacidad m�xima';
comment on column MIG_CONTRATOS.iprioxl
  is 'Porcentaje intereses sobre reserva';
comment on column MIG_CONTRATOS.ppriosl
  is 'Prioridad SL';
comment on column MIG_CONTRATOS.tcontra
  is 'Descripci�n contrato';
comment on column MIG_CONTRATOS.tobserv
  is 'Observaciones varias';
comment on column MIG_CONTRATOS.priesgos
  is 'Porcentaje de riesgos agravados';
comment on column MIG_CONTRATOS.pdescuento
  is 'Porcentaje de descuentos de selecci�n';
comment on column MIG_CONTRATOS.pgastos
  is 'Porcentaje de gastos';
comment on column MIG_CONTRATOS.ppartbene
  is 'Porcentaje de participaci�n en beneficios';
comment on column MIG_CONTRATOS.creafac
  is 'C�digo de facultativo';
comment on column MIG_CONTRATOS.pcesext
  is 'Porcentaje de cesi�n sobre la extra prima';
comment on column MIG_CONTRATOS.cgarrel
  is 'Te garanties relacionades';
comment on column MIG_CONTRATOS.cfrecul
  is 'Frecuencia de liquidaci�n con la compa��a';
comment on column MIG_CONTRATOS.sconqp
  is 'Contrato CP relacionado';
comment on column MIG_CONTRATOS.nverqp
  is 'Versi�n CP relacionado';
comment on column MIG_CONTRATOS.iagrega
  is 'Importe Agregado XL';
comment on column MIG_CONTRATOS.imaxagr
  is 'Importe Agregado M�ximo XL (L.A.A.)';
comment on column MIG_CONTRATOS.pdeposito
  is 'Porcentaje deposito reaseguro';
comment on column MIG_CONTRATOS.cdetces
  is 'Indica si se graba o no a reasegemi';
comment on column MIG_CONTRATOS.clavecbr
  is 'F�rmula para el CBR';
comment on column MIG_CONTRATOS.cercartera
  is 'Tipo E/R cartera (cvalor=340)';
comment on column MIG_CONTRATOS.nanyosloss
  is 'A�os Loss-Corridos';
comment on column MIG_CONTRATOS.cbasexl
  is 'Base para el c�lculo XL (cvalor=341)';
comment on column MIG_CONTRATOS.closscorridor
  is 'C�digo cl�usula Loss Corridor (Tabla CLAUSULAS_REAS)';
comment on column MIG_CONTRATOS.ccappedratio
  is 'C�digo cl�usula Capped Ratio (Tabla CLAUSULAS_REAS)';
comment on column MIG_CONTRATOS.scontraprot
  is 'Contrato XL protecci�n';
comment on column MIG_CONTRATOS.cestado
  is 'Estado de la versi�n';
comment on column MIG_CONTRATOS.nversioprot
  is 'Versi�n del Contrato XL protecci�n';
comment on column MIG_CONTRATOS.ctpreest
  is 'Tipo de c�lculo de prima de restablecimiento {1- Pro-rata monto, 2- Pro-rata tiempo/monto}';
comment on column MIG_CONTRATOS.pcomext
  is 'Porcentaje comisi�n de la extra prima';
