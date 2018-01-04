BEGIN
   pac_skip_ora.p_comprovadrop('MIG_DIRECCIONES_EXT', 'TABLE');
END;
/

CREATE TABLE MIG_DIRECCIONES_EXT
(
  mig_pk   VARCHAR2(200),
  mig_fk   VARCHAR2(200),
  sperson  VARCHAR2(200),  
  cagente  VARCHAR2(200),
  cdomici  VARCHAR2(200),
  cpostal  VARCHAR2(200),
  cpoblac  VARCHAR2(200),
  cprovin  VARCHAR2(200),
  tnomvia  VARCHAR2(200),
  ctipdir  VARCHAR2(200),
  cviavp   VARCHAR2(200),
  clitvp   VARCHAR2(200),
  cbisvp   VARCHAR2(200),
  corvp    VARCHAR2(200),
  nviaadco VARCHAR2(200),
  clitco   VARCHAR2(200),
  corco    VARCHAR2(200),
  nplacaco VARCHAR2(200),
  cor2co   VARCHAR2(200),
  cdet1ia  VARCHAR2(200),
  tnum1ia  VARCHAR2(200),
  cdet2ia  VARCHAR2(200),
  tnum2ia  VARCHAR2(200),
  cdet3ia  VARCHAR2(200),
  tnum3ia  VARCHAR2(200)
)
organization external
(
  type ORACLE_LOADER
  default directory TABEXT
  access parameters 
  (
    RECORDS DELIMITED BY 0x'0A'
                       LOGFILE 'MIG_DIRECCIONES_EXT.log'
                       BADFILE 'MIG_DIRECCIONES_EXT.bad'
                       DISCARDFILE 'MIG_DIRECCIONES_EXT.dis'
                       FIELDS TERMINATED BY ';' LRTRIM
                       MISSING FIELD VALUES ARE NULL
                       REJECT ROWS WITH ALL NULL FIELDS
                       (   
      mig_pk  ,
      mig_fk  ,
      sperson ,
      cagente ,
      cdomici ,
      cpostal ,
      cpoblac ,
      cprovin ,
      tnomvia ,
      ctipdir ,
      cviavp  ,
      clitvp  ,
      cbisvp  ,
      corvp   ,
      nviaadco,
      clitco  ,
      corco   ,
      nplacaco,
      cor2co  ,
      cdet1ia ,
      tnum1ia ,
      cdet2ia ,
      tnum2ia ,
      cdet3ia ,
      tnum3ia                   )
  )
  location (TABEXT:'MIG_DIRECCIONES_EXT.txt')
);
