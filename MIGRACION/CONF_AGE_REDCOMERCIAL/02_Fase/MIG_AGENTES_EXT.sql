DROP TABLE MIG_AGENTES_EXT;

-- Create table
create table MIG_AGENTES_EXT
(
  mig_pk    VARCHAR2(200),
  mig_fk    VARCHAR2(200),
  cagente   VARCHAR2(200),
  ctipage   VARCHAR2(200),
  cactivo   VARCHAR2(200),
  cretenc   VARCHAR2(200),
  ctipiva   VARCHAR2(200),
  ccomisi   VARCHAR2(200),
  cpadre    VARCHAR2(200),
  cpervisio VARCHAR2(200),
  cpernivel VARCHAR2(200),
  cpolvisio VARCHAR2(200),
  cpolnivel VARCHAR2(200),
  fmovini   VARCHAR2(200),
  fmovfin   VARCHAR2(200)
)
organization external
(
  type ORACLE_LOADER
  default directory TABEXT
  access parameters 
  (
    RECORDS DELIMITED BY 0x'0A'
    LOGFILE 'MIG_AGENTES_EXT.log'
    BADFILE 'MIG_AGENTES_EXT.bad'
    DISCARDFILE 'MIG_AGENTES_EXT.dis'
    FIELDS TERMINATED BY 0X'09' LRTRIM
    MISSING FIELD VALUES ARE NULL
    REJECT ROWS WITH ALL NULL FIELDS
    (
    MIG_PK   ,
    MIG_FK   ,
    CAGENTE  ,
    CTIPAGE  ,
    CACTIVO  ,
    CRETENC  ,
    CTIPIVA  ,
    CCOMISI  ,
    CPADRE   ,
    CPERVISIO,
    CPERNIVEL,
    CPOLVISIO,
    CPOLNIVEL,
    FMOVINI  ,
    FMOVFIN
    )
  )
  location (TABEXT:'MIG_AGENTES_EXT.txt')
);
 
