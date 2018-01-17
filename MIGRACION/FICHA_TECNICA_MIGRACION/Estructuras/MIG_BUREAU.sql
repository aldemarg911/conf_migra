-- Create table
create table MIG_BUREAU
(
  ncarga     NUMBER,
  cestmig    NUMBER,
  mig_pk     VARCHAR2(50) not null,
  sbureau  NUMBER,
  nmovimi  NUMBER,
  canulada NUMBER,
  ctipo    NUMBER,
  nsuplem  NUMBER,
  cusualt  VARCHAR2(20),
  falta    DATE,
  cusumod  VARCHAR2(20),
  fmodif   DATE   
);
--
comment on column MIG_BUREAU.ncarga  is 'N�mero de carga';
comment on column MIG_BUREAU.cestmig  is 'Estado del registro';
-- Add comments to the columns 
comment on column MIG_BUREAU.mig_pk
  is 'Clave �nica de MIG_BUREAU (N�mero BUREAU)';
comment on column MIG_BUREAU.sbureau
  is 'N�mero de BUREAU (S� es cero se calcula en la migraci�n)';
comment on column MIG_BUREAU.nmovimi
  is 'N�mero de movimiento';
comment on column MIG_BUREAU.canulada
  is 'Estado Anulaci�n (0 � S�, 1 � No)';
comment on column MIG_BUREAU.ctipo
  is 'Tipo Ficha BURAU (1 - Acta Bureau, 2 � Vicepresidencia, 3 - Gerencia t�cnica)';
comment on column MIG_BUREAU.nsuplem
  is 'Numero suplemento';
comment on column MIG_BUREAU.cusualt
  is 'Usuario de alta';
comment on column MIG_BUREAU.falta
  is 'Fecha de alta';
comment on column MIG_BUREAU.cusumod
  is 'Usuario de modificaci�n';
comment on column MIG_BUREAU.fmodif
  is 'Fecha de modificaci�n';
--
alter table MIG_BUREAU add constraint MIG_BUREAU_PK primary key (MIG_PK);
--
