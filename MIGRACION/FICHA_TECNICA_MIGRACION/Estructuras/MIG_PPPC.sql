--
-- Create table
--
create table MIG_PPPC
(
  ncarga  NUMBER not null,
  cestmig NUMBER not null,
  --
  PRODUCTO    NUMBER,
  POLIZA      VARCHAR2(50),
  SSEGURO     NUMBER NOT NULL,
  NMOVIMIENTO NUMBER(4),
  NRIESGO     NUMBER(6),
  RECIBO      VARCHAR2(50),
  GARANTIA    NUMBER(5),
  FCALCULO    DATE,
  IPPPC       NUMBER(17,2),
  IPRICOM     NUMBER(17,2),
  IPPNCPRIMA  NUMBER(17,2),
  IPPNCCOMIS  NUMBER(17,2),
  PREA        NUMBER(5,2),
  PCOM        NUMBER(5,2),
  ICOMIS      NUMBER(17,2),
  IPDEVRC     NUMBER(17,2),
  IPNCSRC     NUMBER(17,2),
  ICOMRC      NUMBER(17,2),
  ICNCSRC     NUMBER(17,2),
  CTRAMO      NUMBER(3)
);
-- Add comments to the table 
comment on table MIG_PPPC
  is 'Fichero con los datos de PPPC';
-- Add comments to the columns 
comment on column MIG_PPPC.PRODUCTO   is 'Clave de producto iAxis ';
comment on column MIG_PPPC.POLIZA   is 'Id p�liza en sistema origen';
comment on column MIG_PPPC.NMOVIMIENTO   is 'N�mero de movimiento';
comment on column MIG_PPPC.NRIESGO   is 'N�mero de riesgo';
comment on column MIG_PPPC.RECIBO   is 'Id recibo en sistema origen';
comment on column MIG_PPPC.GARANTIA   is 'C�digo de garant�a iAXIs';
comment on column MIG_PPPC.FCALCULO   is 'Fecha de c�lculo de la provisi�n';
comment on column MIG_PPPC.IPPPC   is 'Provisi�n de prima pendiente  de cobro';
comment on column MIG_PPPC.IPRICOM   is 'Importe Prima ';
comment on column MIG_PPPC.IPPNCPRIMA   is 'Prima pendiente de cobro no consumida';
comment on column MIG_PPPC.IPPNCCOMIS   is 'Comisi�n pendiente de cobro no consumida.';
comment on column MIG_PPPC.PREA   is 'Porcentaje reaseguro';
comment on column MIG_PPPC.PCOM   is 'Porcentaje comisi�n  anulaci�n (seg�n campo ctramo, 1- 3 meses = 25%, 2 � 3 a 6 meses=50%, 3- mayor que 6 meses = 100%). Se utiliza para calcular el campo IPPPC';
comment on column MIG_PPPC.ICOMIS   is 'Importe comisi�n';
comment on column MIG_PPPC.IPDEVRC   is 'Prima reaseguro cedido';
comment on column MIG_PPPC.IPNCSRC   is 'Prima no consumida reaseguro cedido';
comment on column MIG_PPPC.ICOMRC   is 'Comisi�n  reaseguro cedido';
comment on column MIG_PPPC.ICNCSRC   is 'Comisi�n  no consumida reaseguro cedido';
comment on column MIG_PPPC.CTRAMO   is 'Tramo antig�edad aplicable en meses (valor fijo: 1084)';
--
create index MIG_PPPC_NCARGA on MIG_PPPC (NCARGA);
