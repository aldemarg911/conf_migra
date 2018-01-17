-- Create table
create table MIG_DET_CESIONESREA
(
  ncarga      NUMBER NOT NULL,
  cestmig     NUMBER NOT NULL,
MIG_PK      VARCHAR2(50)NOT NULL,
MIG_FK      VARCHAR2(50)NOT NULL,
SCESREA      NUMBER NOT NULL,
SDETCESREA  NUMBER NOT NULL,
SSEGURO      NUMBER NOT NULL,
NMOVIMI      NUMBER NOT NULL,
PTRAMO      NUMBER NOT NULL,
CGARANT      NUMBER NOT NULL,
ICESION      NUMBER NOT NULL,
ICAPCES      NUMBER NOT NULL,
PCESION      NUMBER,
PSOBREPRIMA  NUMBER,
IEXTRAP      NUMBER,
IEXTREA      NUMBER,
IPRITARREA      NUMBER,
ITARIFREA      NUMBER,
ICOMEXT      NUMBER,
CCOMPANI      NUMBER,
FALTA         DATE,
CUSUALT      VARCHAR2(32),
FMODIFI      DATE,
CUSUMOD      VARCHAR2(32),
CDEPURA      VARCHAR2(1),
FEFECDEMA    DATE,
NMOVDEP      NUMBER,
SPERSON      NUMBER
);
-- Add comments to the table 
comment on table MIG_DET_CESIONESREA
  is 'Fichero con la información de cesiones de reaseguro por garantía.';
  --
comment on column MIG_DET_CESIONESREA.MIG_PK   is 'Clave única de MIG_DET_CESIONESREA';
comment on column MIG_DET_CESIONESREA.MIG_FK   is 'Clave foránea de MIG_CESIONESREA';
comment on column MIG_DET_CESIONESREA.SCESREA   is 'Código de Cesión (Nulo en este caso)';
comment on column MIG_DET_CESIONESREA.SDETCESREA   is 'Código de Detalle de Cesión  (Nulo en este caso)';
comment on column MIG_DET_CESIONESREA.SSEGURO   is 'Código del Seguro  (Nulo en este caso)';
comment on column MIG_DET_CESIONESREA.NMOVIMI   is 'Número de Movimiento';
comment on column MIG_DET_CESIONESREA.PTRAMO   is 'Número del Tramo';
comment on column MIG_DET_CESIONESREA.CGARANT   is 'Garantía';
comment on column MIG_DET_CESIONESREA.ICESION   is 'Importe de Cesión';
comment on column MIG_DET_CESIONESREA.ICAPCES   is 'Capital de Cesión';
comment on column MIG_DET_CESIONESREA.PCESION   is 'Porcentaje de Cesión';
comment on column MIG_DET_CESIONESREA.PSOBREPRIMA   is 'Sobreprima';
comment on column MIG_DET_CESIONESREA.IEXTRAP   is 'Porcentaje Extra Prima';
comment on column MIG_DET_CESIONESREA.IEXTREA   is 'Importe Extra Prima';
comment on column MIG_DET_CESIONESREA.IPRITARREA   is 'Prima Tarifa';
comment on column MIG_DET_CESIONESREA.ITARIFREA   is 'Importe Tarifa';
comment on column MIG_DET_CESIONESREA.ICOMEXT   is 'Comisión';
comment on column MIG_DET_CESIONESREA.CCOMPANI   is 'Compañía';
comment on column MIG_DET_CESIONESREA.FALTA   is 'Fecha Alta';
comment on column MIG_DET_CESIONESREA.CUSUALT   is 'Usuario Alta';
comment on column MIG_DET_CESIONESREA.FMODIFI   is 'Fecha Modifica';
comment on column MIG_DET_CESIONESREA.CUSUMOD   is 'Usuario Modifica';
comment on column MIG_DET_CESIONESREA.CDEPURA   is 'N/S si la garantía aporta';
comment on column MIG_DET_CESIONESREA.FEFECDEMA   is 'Fecha efecto manual';
comment on column MIG_DET_CESIONESREA.NMOVDEP   is 'Número de depuraciones';
comment on column MIG_DET_CESIONESREA.SPERSON   is 'Para consorcios, 1 reg por garantías x persona';
--
create index MIG_DET_CESIONESREA_NCARGA on MIG_DET_CESIONESREA (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_DET_CESIONESREA
  add constraint MIG_DET_CESIONESREA_PK primary key (MIG_PK);

