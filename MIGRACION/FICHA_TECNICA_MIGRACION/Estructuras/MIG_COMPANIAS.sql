-- Create table
create table MIG_COMPANIAS
(
  ncarga   NUMBER,
  cestmig  NUMBER,
  mig_pk   VARCHAR2(50) not null,
  mig_fk   VARCHAR2(50) not null,
  ccompani NUMBER,
  tcompani VARCHAR2(60),
  ctipcom  NUMBER(2) not null
)
;
-- Add comments to the columns 
comment on column MIG_COMPANIAS.mig_pk
  is 'Clave �nica de MIG_COMPANIAS';
comment on column MIG_COMPANIAS.mig_fk
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_COMPANIAS.ccompani
  is 'C�digo de compa��a  (Si es NULO se obtiene un c�digo)';
comment on column MIG_COMPANIAS.tcompani
  is 'Descripci�n de la compa��a';
comment on column MIG_COMPANIAS.ctipcom
  is 'Tipo de compa��a VF:800102';
