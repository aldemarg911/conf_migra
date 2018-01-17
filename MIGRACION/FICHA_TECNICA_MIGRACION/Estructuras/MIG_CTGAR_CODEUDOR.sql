-- Create table
create table MIG_CTGAR_CODEUDOR
(
  ncarga  NUMBER,
  cestmig NUMBER,
  mig_pk  VARCHAR2(50) NOT NULL,
  mig_fk  VARCHAR2(50) NOT NULL,
  mig_fk2 VARCHAR2(2) NOT NULL
)
;
-- Add comments to the columns 
comment on column MIG_CTGAR_CODEUDOR.mig_pk
  is 'Clave única de MIG_CTGAR_CODEUDOR';
comment on column MIG_CTGAR_CODEUDOR.mig_fk
  is 'Clave externa para MIG_CTGAR_CONTRAGARANTIA';
comment on column MIG_CTGAR_CODEUDOR.mig_fk2
  is 'Clave externa para MIG_PERSONAS';
