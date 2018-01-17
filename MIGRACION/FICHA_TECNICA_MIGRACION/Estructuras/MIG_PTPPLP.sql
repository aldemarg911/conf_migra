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
  is 'Fichero con los datos de PTPPLP (Provisiones de Prestaciones Pendientes de Liquidación o Pago)';
  --
comment on column MIG_PTPPLP.ncarga  is 'Número de carga';
comment on column MIG_PTPPLP.cestmig  is 'Estado del registro';
--comment on column MIG_PTPPLP.MIG_PK   is 'Clave única de MIG_PTPPLP';
comment on column MIG_PTPPLP.PRODUCTO   is 'Clave de producto iAxis ';
comment on column MIG_PTPPLP.POLIZA   is 'Id póliza en sistema origen (MIG_PK MIG_SEGUROS)';
comment on column MIG_PTPPLP.sseguro  is 'Número consecutivo de seguro asignado 0, lo calcula el proceso de migración';
comment on column MIG_PTPPLP.SINESTRO   is 'Id de siniestro en sistema origen (MIG_PK MIG_SIN_SINIESTRO)';
comment on column MIG_PTPPLP.nsinies  is 'Numero Siniestro';
comment on column MIG_PTPPLP.FCALCULO   is 'Fecha de cálculo de la provisión';
comment on column MIG_PTPPLP.IPPLPSD   is 'Importe prestación pendiente de liquidación  pendiente de pago';
comment on column MIG_PTPPLP.IPPLPRC   is 'Importe prestación pendiente de liquidación  pendiente de pago reaseguro cedido';
comment on column MIG_PTPPLP.IVALBRUTO   is 'Valor bruto';
comment on column MIG_PTPPLP.IVALPAGO   is 'Valor pago';
comment on column MIG_PTPPLP.IPPL   is 'Importe provisión pendiente de liquidar';
comment on column MIG_PTPPLP.IPPP   is 'Importe provisión pendiente de pagar';
--
create index MIG_PTPPLP_NCARGA on MIG_PTPPLP (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
--alter table MIG_PTPPLP  add constraint MIG_PTPPLP_CESIONESREA_PK primary key (MIG_PK);
--

