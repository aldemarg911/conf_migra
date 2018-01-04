BEGIN
   pac_skip_ora.p_comprovadrop('MIG_PERSONAS_EXT', 'TABLE');
END;
/
-- Create table
create table MIG_PERSONAS_EXT
(
  mig_pk    VARCHAR2(200),
  ctipide   VARCHAR2(200),
  nnumide   VARCHAR2(200),
  cestper   VARCHAR2(200),
  ctipper   VARCHAR2(200),
  fultmov   VARCHAR2(200),
  swpubli   VARCHAR2(200),
  csexper   VARCHAR2(200),
  fnacimi   VARCHAR2(200),
  cagente   VARCHAR2(200),
  tapell1   VARCHAR2(200),
  tapell2   VARCHAR2(200),
  tnom      VARCHAR2(200),
  tnom2     VARCHAR2(200),
  cestciv   VARCHAR2(200),
  cpais     VARCHAR2(200),
  cprofes   VARCHAR2(200),
  cnacio    VARCHAR2(200),
  nnumtel   VARCHAR2(200),
  nnumfax   VARCHAR2(200),
  nnummov   VARCHAR2(200),
  tmail     VARCHAR2(200)
)
organization external
(
  type ORACLE_LOADER
  default directory TABEXT
  access parameters 
  (
    RECORDS DELIMITED BY 0x'0A'
                   LOGFILE 'mig_intermediarios.log'
                   BADFILE 'mig_intermediarios.bad'
                   DISCARDFILE 'mig_intermediarios.dis'
                   FIELDS TERMINATED BY 0X'09' LRTRIM
                   MISSING FIELD VALUES ARE NULL
                   REJECT ROWS WITH ALL NULL FIELDS
                   (
    mig_pk   ,
    ctipide  ,
    nnumide  ,
    cestper  ,
    ctipper  ,
    fultmov  ,
    swpubli  ,
    csexper  ,
    fnacimi  ,
    cagente  ,
    tapell1  ,
    tapell2  ,
    tnom     ,
    tnom2    ,
    cestciv  ,
    cpais    ,
    cprofes  ,
    cnacio   ,
    nnumtel  ,
    nnumfax  ,
    nnummov  ,
    tmail    
	)
  )
  location (TABEXT:'MIG_PERSONAS_EXT.txt')
);
