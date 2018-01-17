create table MIG_CTACOASEGURO
(
  ncarga         NUMBER not null,
  cestmig        NUMBER not null,
  mig_pk         VARCHAR2(50),
  smovcoa        NUMBER(8),
  mig_fk2        VARCHAR2(50),
  cimport        NUMBER(2),
  ctipcoa        NUMBER(2),
  cmovimi        NUMBER(2),
  imovimi        NUMBER,
  fmovimi        DATE,
  fcontab        DATE,
  cdebhab        NUMBER(1),
  fliqcia        DATE,
  pcescoa        NUMBER(5,2),
  sidepag        NUMBER(8),
  nrecibo        NUMBER,
  smovrec        NUMBER,
  cempres        NUMBER(2),
  sseguro        NUMBER,
  sproduc        NUMBER(6),
  cestado        NUMBER(2),
  ctipmov        NUMBER(1),
  tdescri        VARCHAR2(2000),
  tdocume        VARCHAR2(2000),
  imovimi_moncon NUMBER,
  fcambio        DATE,
  nsinies        VARCHAR2(14),
  ccompapr       NUMBER(3),
  cmoneda        NUMBER(3),
  spagcoa        NUMBER(10),
  ctipgas        NUMBER(3),
  fcierre        DATE,
  ntramit        NUMBER(3),
  nmovres        NUMBER(4),
  cgarant        NUMBER(4),
  mig_fk3        VARCHAR2(50),
  mig_fk4        VARCHAR2(50),
  mig_fk5        VARCHAR2(50)
);
--
comment on column MIG_CTACOASEGURO.MIG_PK   is 'Clave �nica de MIG_COACEDIDO';
comment on column MIG_CTACOASEGURO.SMOVCOA   is 'Identificador del movimiento (Nulo en este caso)';
comment on column MIG_CTACOASEGURO.MIG_FK2   is 'C�digo compa��a (MIG_PK � MIG_COMPANIAS)';
comment on column MIG_CTACOASEGURO.CIMPORT   is 'C�digo de importe (4 - Comisi�n gastos, 2 � Gastos, 1 � Prima)';
comment on column MIG_CTACOASEGURO.CTIPCOA   is 'Tipo de coaseguro (VF 59)';
comment on column MIG_CTACOASEGURO.CMOVIMI   is 'C�digo de movimiento -Tipo de recibo (VALOR FIJO:8)';
comment on column MIG_CTACOASEGURO.IMOVIMI   is 'Importe del movimiento';
comment on column MIG_CTACOASEGURO.FMOVIMI   is 'Fecha movimiento';
comment on column MIG_CTACOASEGURO.FCONTAB   is 'Fecha contabilizaci�n';
comment on column MIG_CTACOASEGURO.CDEBHAB   is '1 Debe/ 2 Haber';
comment on column MIG_CTACOASEGURO.FLIQCIA   is 'Liquidaci�n mov. a/de la Compa��a';
comment on column MIG_CTACOASEGURO.PCESCOA   is 'Porcentaje cedido/aceptado';
comment on column MIG_CTACOASEGURO.SIDEPAG   is 'N�mero secuencial del pago';
comment on column MIG_CTACOASEGURO.NRECIBO   is 'N�mero de recibo.';
comment on column MIG_CTACOASEGURO.SMOVREC   is '';
comment on column MIG_CTACOASEGURO.CEMPRES   is 'C�digo de Empresa';
comment on column MIG_CTACOASEGURO.SSEGURO   is 'N�mero consecutivo de seguro asignado autom�ticamente. (NULO)';
comment on column MIG_CTACOASEGURO.SPRODUC   is 'Secuencia del producto';
comment on column MIG_CTACOASEGURO.CESTADO   is 'Estado del movimiento';
comment on column MIG_CTACOASEGURO.CTIPMOV   is 'Tipo de movimiento manual-1 o autom�tica-0';
comment on column MIG_CTACOASEGURO.TDESCRI   is 'Descripci�n';
comment on column MIG_CTACOASEGURO.TDOCUME   is 'Documento';
comment on column MIG_CTACOASEGURO.IMOVIMI_MONCON   is 'Importe del movimiento en la moneda de la contabilidad';
comment on column MIG_CTACOASEGURO.FCAMBIO   is 'Fecha empleada para el c�lculo de los contravalores';
comment on column MIG_CTACOASEGURO.NSINIES   is 'Numero Siniestro';
comment on column MIG_CTACOASEGURO.CCOMPAPR   is 'C�digo compa��a propia (CCOMPANI de SEGUROS) � Nulo en este caso';
comment on column MIG_CTACOASEGURO.CMONEDA   is 'Moneda Pago (por ser diferente a la de la p�liza)';
comment on column MIG_CTACOASEGURO.SPAGCOA   is 'Campo secuencial del pago coaseguro';
comment on column MIG_CTACOASEGURO.CTIPGAS   is 'Tipo de reserva de gastos (VF 1047)';
comment on column MIG_CTACOASEGURO.FCIERRE   is 'Fecha cierre';
comment on column MIG_CTACOASEGURO.NTRAMIT   is 'N�mero Tramitaci�n Siniestro';
comment on column MIG_CTACOASEGURO.NMOVRES   is 'N�mero Movimiento Reserva';
comment on column MIG_CTACOASEGURO.CGARANT   is 'C�digo Garant�a';
comment on column MIG_CTACOASEGURO.MIG_FK3   is 'C�digo seguro (MIG_PK � MIG_SEGUROS)';
comment on column MIG_CTACOASEGURO.MIG_FK4   is 'N�mero de recibo (MIG_PK � MIG_RECIBOS)';
comment on column MIG_CTACOASEGURO.MIG_FK5   is 'N�mero de siniestro (MIG_PK � MIG_SINIESTROS)';
--
create index MIG_CTACOASEGURO_NCARGA on MIG_CTACOASEGURO (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CTACOASEGURO
  add constraint MIG_CTACOASEGURO_PK primary key (MIG_PK);
