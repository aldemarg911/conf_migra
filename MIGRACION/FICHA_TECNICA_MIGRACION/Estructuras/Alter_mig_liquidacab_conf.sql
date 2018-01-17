--
create index MIG_LIQUIDACAB_NCARGA on MIG_LIQUIDACAB (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_LIQUIDACAB
  add constraint MIG_LIQUIDACAB_PK primary key (MIG_PK);
--
ALTER TABLE mig_ctactes
  MODIFY MIG_FK varchar2(50);
ALTER TABLE mig_ctactes
  MODIFY MIG_FK2 varchar2(50);
ALTER TABLE mig_ctactes
  MODIFY MIG_FK3 varchar2(50);
  --
create index MIG_CUADROCES_NCARGA on MIG_CUADROCES (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CUADROCES
  add constraint MIG_CUADROCES_PK primary key (MIG_PK);
--
create index MIG_LIQUIDALIN_NCARGA on MIG_LIQUIDALIN (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_LIQUIDALIN
  add constraint MIG_LIQUIDALIN_PK primary key (MIG_PK);
