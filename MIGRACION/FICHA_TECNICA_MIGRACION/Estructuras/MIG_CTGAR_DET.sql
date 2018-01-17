-- Create table
create table MIG_CTGAR_DET
(
  ncarga    NUMBER,
  cestmig   NUMBER,
  mig_pk    VARCHAR2(50) not null,
  mig_fk    VARCHAR2(50) not null,
  mig_fk2   VARCHAR2(50) not null,
  cpais     NUMBER(3) not null,
  fexpedic  DATE,
  cbanco    NUMBER(4),
  sperfide  VARCHAR2(50),
  tsucursal VARCHAR2(100),
  iinteres  NUMBER,
  fvencimi  DATE,
  fvencimi1 DATE,
  fvencimi2 DATE,
  nplazo    NUMBER,
  iasegura  NUMBER,
  iintcap   NUMBER
);

-- Add comments to the columns 
comment on column MIG_CTGAR_DET.mig_pk
  is 'Clave única de MIG_CTGARDET';
comment on column MIG_CTGAR_DET.mig_fk
  is 'Clave externa para MIG_CTGARDET';
comment on column MIG_CTGAR_DET.mig_fk2
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_CTGAR_DET.cpais
  is 'País';
comment on column MIG_CTGAR_DET.fexpedic
  is 'Fecha constitución o expedición';
comment on column MIG_CTGAR_DET.cbanco
  is 'Entidad Fiduciaria - Bancaria';
comment on column MIG_CTGAR_DET.sperfide
  is 'Fideicomitente: Clave externa para MIG_PERSONAS';  
comment on column MIG_CTGAR_DET.tsucursal
  is 'Sucursal entidad bancaria emisora';
comment on column MIG_CTGAR_DET.iinteres
  is 'Importe Interés';
comment on column MIG_CTGAR_DET.fvencimi
  is 'Fecha de vencimiento';
comment on column MIG_CTGAR_DET.fvencimi1
  is 'Fecha de vencimiento 1';
comment on column MIG_CTGAR_DET.fvencimi2
  is 'Fecha de vencimiento 2';
comment on column MIG_CTGAR_DET.nplazo
  is 'Plazo';
comment on column MIG_CTGAR_DET.iasegura
  is 'Importe asegurado';
comment on column MIG_CTGAR_DET.iintcap
  is 'Importe interés capitalizables';
-- Create/Recreate indexes 
create index MIG_CTGAR_DET_NCARGA on MIG_CTGAR_DET (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CTGAR_DET
  add constraint MIG_CTGAR_DET_PK primary key (MIG_PK);
