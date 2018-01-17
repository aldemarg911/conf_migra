-- Create table
create table MIG_DETSARLAFT_REC
(
  ncarga     NUMBER,
  cestmig    NUMBER,
  mig_pk     VARCHAR2(50) not null,
  mig_fk     VARCHAR2(50) not null,
  mig_fk2    VARCHAR2(50) not null,
  canio      NUMBER,
  cramo      NUMBER,
  tcompania  VARCHAR2(150),
  cvalor     VARCHAR2(150),
  tresultado VARCHAR2(150)
)
;
-- Add comments to the columns 
comment on column MIG_DETSARLAFT_REC.mig_pk
  is 'Clave única de MIG_DETSARLAFT_REC';
comment on column MIG_DETSARLAFT_REC.mig_fk
  is 'Clave externa para MIG_DATSARLAFT';
comment on column MIG_DETSARLAFT_REC.mig_fk2
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_DETSARLAFT_REC.canio
  is 'Año';
comment on column MIG_DETSARLAFT_REC.cramo
  is 'Ramo';
comment on column MIG_DETSARLAFT_REC.tcompania
  is 'CompaC1ia';
comment on column MIG_DETSARLAFT_REC.cvalor
  is 'Valor';
comment on column MIG_DETSARLAFT_REC.tresultado
  is 'Resultado';
