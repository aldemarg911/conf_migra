-- Create table
create table MIG_FIN_D_RENTA
(
  ncarga   NUMBER NOT NULL,
  cestmig  NUMBER NOT NULL,
  mig_pk    VARCHAR2(50) not null,
  mig_fk    VARCHAR2(50) not null,
  sfinanci  NUMBER NOT NULL,
  fcorte    DATE not null,
  cesvalor  NUMBER,
  ipatriliq NUMBER,
  irenta    NUMBER
)
;
-- Add comments to the columns 
comment on column MIG_FIN_D_RENTA.mig_pk
  is 'Clave única de MIG_FIN_D_RENTA';
comment on column MIG_FIN_D_RENTA.mig_fk
  is 'Clave externa para MIG_FIN_GENERAL';
comment on column MIG_FIN_D_RENTA.sfinanci
  is 'Código ficha financiera (Si es nula se calcula de manera automática)';
comment on column MIG_FIN_D_RENTA.fcorte
  is 'Fecha de corte de declaración de renta';
comment on column MIG_FIN_D_RENTA.cesvalor
  is 'Valores en … V.F. 8001075';
comment on column MIG_FIN_D_RENTA.ipatriliq
  is 'Patrimonio liquido';
comment on column MIG_FIN_D_RENTA.irenta
  is 'Renta líquida Gravable';
--
create index MIG_FIN_D_RENTA_NCARGA on MIG_FIN_D_RENTA (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_FIN_D_RENTA
  add constraint MIG_FIN_D_RENTA_PK primary key (MIG_PK);
