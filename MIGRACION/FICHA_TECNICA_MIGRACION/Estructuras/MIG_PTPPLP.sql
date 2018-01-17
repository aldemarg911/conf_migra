-- Create table
CREATE TABLE MIG_PTPPLP
(
  ncarga      NUMBER NOT NULL,
  cestmig     NUMBER NOT NULL,
  --
 -- MIG_PK      VARCHAR2(50) not null,
  PRODUCTO    NUMBER NOT NULL,
  POLIZA      VARCHAR2(50) NOT NULL,
  sseguro     NUMBER not null, 
  SINESTRO    VARCHAR2(50) NOT NULL,
  nsinies     VARCHAR2(14) not null,
  FCALCULO    DATE NOT NULL,
  IPPLPSD     NUMBER(17,2) NOT NULL,
  IPPLPRC     NUMBER(17,2) NOT NULL,
  IVALBRUTO   NUMBER(13,2),
  IVALPAGO    NUMBER(13,2),
  IPPL        NUMBER(17,2) NOT NULL,
  IPPP        NUMBER(17,2) NOT NULL
);
-- Add comments to the table 
comment on table MIG_PTPPLP
  is 'Fichero con los datos de PTPPLP (Provisiones de Prestaciones Pendientes de Liquidaci�n o Pago)';
  --
comment on column MIG_PTPPLP.ncarga  is 'N�mero de carga';
comment on column MIG_PTPPLP.cestmig  is 'Estado del registro';
--comment on column MIG_PTPPLP.MIG_PK   is 'Clave �nica de MIG_PTPPLP';
comment on column MIG_PTPPLP.PRODUCTO   is 'Clave de producto iAxis ';
comment on column MIG_PTPPLP.POLIZA   is 'Id p�liza en sistema origen (MIG_PK MIG_SEGUROS)';
comment on column MIG_PTPPLP.sseguro  is 'N�mero consecutivo de seguro asignado 0, lo calcula el proceso de migraci�n';
comment on column MIG_PTPPLP.SINESTRO   is 'Id de siniestro en sistema origen (MIG_PK MIG_SIN_SINIESTRO)';
comment on column MIG_PTPPLP.nsinies  is 'Numero Siniestro';
comment on column MIG_PTPPLP.FCALCULO   is 'Fecha de c�lculo de la provisi�n';
comment on column MIG_PTPPLP.IPPLPSD   is 'Importe prestaci�n pendiente de liquidaci�n  pendiente de pago';
comment on column MIG_PTPPLP.IPPLPRC   is 'Importe prestaci�n pendiente de liquidaci�n  pendiente de pago reaseguro cedido';
comment on column MIG_PTPPLP.IVALBRUTO   is 'Valor bruto';
comment on column MIG_PTPPLP.IVALPAGO   is 'Valor pago';
comment on column MIG_PTPPLP.IPPL   is 'Importe provisi�n pendiente de liquidar';
comment on column MIG_PTPPLP.IPPP   is 'Importe provisi�n pendiente de pagar';
--
create index MIG_PTPPLP_NCARGA on MIG_PTPPLP (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
--alter table MIG_PTPPLP  add constraint MIG_PTPPLP_CESIONESREA_PK primary key (MIG_PK);
--

