-- Create table
create table MIG_CLAUSULAS_REAS
(
  ncarga       NUMBER,
  cestmig      NUMBER,
  mig_pk       VARCHAR2(50) not null,
  ccodigo      NUMBER(5) not null,
  tdescripcion VARCHAR2(200) not null
)
;
-- Add comments to the columns 
comment on column MIG_CLAUSULAS_REAS.mig_pk
  is 'Clave única de MIG_CLAUSULAS_REAS';
comment on column MIG_CLAUSULAS_REAS.ccodigo
  is 'Código de cláusula';
comment on column MIG_CLAUSULAS_REAS.tdescripcion
  is 'Descripción';
