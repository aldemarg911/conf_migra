-- Create table
CREATE TABLE MIG_PPNA
(
  ncarga      NUMBER NOT NULL,
  cestmig     NUMBER NOT NULL,
  --
 -- MIG_PK      VARCHAR2(50) not null,
  PRODUCTO      NUMBER NOT NULL,
  Poliza      VARCHAR2(50) NOT NULL,
  SSEGURO      NUMBER NOT NULL,
  NMOVIMIENTO      NUMBER(4) NOT NULL,
  RIESGO      NUMBER(6) NOT NULL,
  GARANTIA      NUMBER(5) NOT NULL,
  FCALCULO      DATE NOT NULL,
  IPRIDEV      NUMBER(13,2) NOT NULL,
  IPRINCS      NUMBER(13,2) NOT NULL,
  IPDEVRC      NUMBER(13,2),
  IPNCSRC      NUMBER(13,2),
  FEFEINI      DATE,
  FFINEFE      DATE,
  ICOMAGE      NUMBER(13,2),
  ICOMNCS      NUMBER(13,2),
  ICOMRC      NUMBER(13,2),
  ICNCSRC      NUMBER(13,2),
  IRECFRA      NUMBER(13,2),
  PRECARG      NUMBER(13,2),
  IRECFRANC      NUMBER(13,2)
);
-- Add comments to the table 
comment on table MIG_PTPPLP
  is 'Fichero con los datos de PTPPLP (Provisiones de Prestaciones Pendientes de Liquidación o Pago)';
  --
comment on column MIG_PPNA.ncarga  is 'Número de carga';
comment on column MIG_PPNA.cestmig  is 'Estado del registro';
--comment on column MIG_PTPPLP.MIG_PK   is 'Clave única de MIG_PTPPLP';
comment on column MIG_PPNA.PRODUCTO   is 'Clave de producto iAxis ';
comment on column MIG_PPNA.POliza   is 'Id Póliza en sistema origen (MIG_PK MIG_SEGUROS)';
comment on column MIG_PPNA.NMOVIMIENTO   is 'Número de movimiento';
comment on column MIG_PPNA.RIESGO   is 'Número de riesgo';
comment on column MIG_PPNA.GARANTIA   is 'Código de garantía iAxis';
comment on column MIG_PPNA.FCALCULO   is 'Fecha de cálculo de la provisión';
comment on column MIG_PPNA.IPRIDEV   is 'Prima devengada';
comment on column MIG_PPNA.IPRINCS   is 'Prima no consumida';
comment on column MIG_PPNA.IPDEVRC   is 'Prima devengada reaseguro cedido';
comment on column MIG_PPNA.IPNCSRC   is 'Prima reaseguro cedido no consumida';
comment on column MIG_PPNA.FEFEINI   is 'Inicio periodo de vigencia de la garantía (inicio)';
comment on column MIG_PPNA.FFINEFE   is 'Fecha fin de vigencia de la garantía, fecha vencimiento de la póliza o próxima renovación.';
comment on column MIG_PPNA.ICOMAGE   is 'Comisión  del agente';
comment on column MIG_PPNA.ICOMNCS   is 'Comisión  del agente no consumida';
comment on column MIG_PPNA.ICOMRC   is 'Comisión del reaseguro cedido';
comment on column MIG_PPNA.ICNCSRC   is 'Comisión del reaseguro cedido no consumida';
comment on column MIG_PPNA.IRECFRA   is 'Recargo por fraccionamiento';
comment on column MIG_PPNA.PRECARG   is 'Porcentaje de recargo por fraccionamiento';
comment on column MIG_PPNA.IRECFRANC   is 'Recargo por fraccionamiento no consumida';
--
create index MIG_PPNA_NCARGA on MIG_PPNA (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
--alter table MIG_PTPPLP  add constraint MIG_PTPPLP_CESIONESREA_PK primary key (MIG_PK);
--

