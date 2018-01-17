-- Create table
create table MIG_CTGAR_SEGURO
(
  ncarga   NUMBER,
  cestmig  NUMBER,
  mig_pk   VARCHAR2(50) not null,
  mig_fk   VARCHAR2(50) not null,
  scontgar NUMBER not null
)
;
-- Add comments to the columns 
comment on column MIG_CTGAR_SEGURO.mig_pk
  is 'Clave única de MIG_CTGAR_SEGURO';
comment on column MIG_CTGAR_SEGURO.mig_fk
  is 'Clave externa para MIG_SEGURO';
comment on column MIG_CTGAR_SEGURO.scontgar
  is 'Código contragarantía.';
