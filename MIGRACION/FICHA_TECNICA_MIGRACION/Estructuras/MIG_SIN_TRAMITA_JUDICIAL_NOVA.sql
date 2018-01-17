-- Create table
create table MIG_SIN_TRAMITA_JUDICIAL
(
  ncarga    NUMBER,
  cestmig   NUMBER,
  mig_pk    VARCHAR2(50) not null,
  mig_fk    VARCHAR2(50) not null,
  mig_fk2   VARCHAR2(50) not null,
  norden    NUMBER(3) not null,
  cproceso  NUMBER(8),
  tproceso  NUMBER(8),
  cpostal   VARCHAR2(30),
  cpoblac   NUMBER(5),
  cprovin   NUMBER(5),
  tiexterno VARCHAR2(2000),
  sprofes   NUMBER,
  frecep    DATE,
  fnotifi   DATE,
  fvencimi  DATE,
  frespues  DATE,
  fconcil   DATE,
  fdesvin   DATE,
  tpreten   VARCHAR2(2000),
  texcep1   VARCHAR2(2000),
  texcep2   VARCHAR2(2000),
  faudien   DATE,
  haudien   DATE,
  taudien   VARCHAR2(200),
  cconti    NUMBER(8),
  cdespa    NUMBER(8),
  tlaudie   VARCHAR2(200),
  caudien   NUMBER(5),
  cdespao   NUMBER(8),
  tlaudieo  VARCHAR2(200),
  caudieno  NUMBER(5),
  sabogau   NUMBER(10),
  coral     NUMBER(1),
  cestado   NUMBER(1),
  cresolu   NUMBER(1),
  finsta1   DATE,
  finsta2   DATE,
  fnueva    DATE,
  tresult   VARCHAR2(2000),
  cposici   NUMBER(8),
  cdemand   NUMBER(8),
  sapodera  NUMBER(10),
  idemand   NUMBER,
  ftdeman   DATE,
  iconden   NUMBER,
  csenten   NUMBER(8),
  fsente1   DATE,
  fsente2   DATE,
  ctsente   NUMBER(8),
  tfallo    VARCHAR2(2000),
  fmodifi   DATE,
  cusualt   VARCHAR2(20)
)
;
-- Add comments to the columns 
comment on column MIG_SIN_TRAMITA_JUDICIAL.mig_pk
  is 'Clave �nica de MIG_SIN_TRAMITA_JUDICIAL';
comment on column MIG_SIN_TRAMITA_JUDICIAL.mig_fk
  is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAMITA_JUDICIAL.mig_fk2
  is 'Clave externa de MIG_SIN_TRAMITACION.';
comment on column MIG_SIN_TRAMITA_JUDICIAL.norden
  is 'Numero Orden Proceso';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cproceso
  is 'Clase de proceso (VF 8001090)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.tproceso
  is 'Tipo de proceso (VF 8001091)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cpostal
  is 'C�digo postal';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cpoblac
  is 'C�digo poblaci�n';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cprovin
  is 'C�digo provincia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.tiexterno
  is 'Identificador Externo';
comment on column MIG_SIN_TRAMITA_JUDICIAL.sprofes
  is 'Clave externa de MIG_SIN_PROF_PROFESIONALES (Profesional que asiste a la audiencia)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.frecep
  is 'Fecha Recepci�n Oficial';
comment on column MIG_SIN_TRAMITA_JUDICIAL.fnotifi
  is 'Fecha Notificaci�n';
comment on column MIG_SIN_TRAMITA_JUDICIAL.fvencimi
  is 'Fecha Vencimiento Termino';
comment on column MIG_SIN_TRAMITA_JUDICIAL.frespues
  is 'Fecha Respuesta';
comment on column MIG_SIN_TRAMITA_JUDICIAL.fconcil
  is 'Fecha Conciliaci�n';
comment on column MIG_SIN_TRAMITA_JUDICIAL.fdesvin
  is 'Desvinculados por notificaci�n extempor�nea';
comment on column MIG_SIN_TRAMITA_JUDICIAL.tpreten
  is 'Pretensiones de la demanda';
comment on column MIG_SIN_TRAMITA_JUDICIAL.texcep1
  is 'Excepciones del denunciado';
comment on column MIG_SIN_TRAMITA_JUDICIAL.texcep2
  is 'Excepciones de la compa��a';
comment on column MIG_SIN_TRAMITA_JUDICIAL.faudien
  is 'Fecha de audiencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.haudien
  is 'Hora de audiencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.taudien
  is 'Clase de audiencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cconti
  is 'Contingencia (VF 8001092)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cdespa
  is 'Despacho de la audiencia (VF 8001093)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.tlaudie
  is 'Lugar de la audiencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.caudien
  is 'C�digo postal - Ciudad audiencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cdespao
  is 'Despacho de audiencia origen (VF 8001093)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.tlaudieo
  is 'Lugar de la audiencia origen';
comment on column MIG_SIN_TRAMITA_JUDICIAL.caudieno
  is 'C�digo postal - Ciudad audiencia origen';
comment on column MIG_SIN_TRAMITA_JUDICIAL.sabogau
  is 'Clave externa de MIG_PERSONAS (Abogado que asiste a la audiencia)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.coral
  is '?La audiencia se llevar? a cabo de manera oral? (VF 8001094)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cestado
  is 'Estado audiencia (VF 8001095)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cresolu
  is 'Resoluci�n de audiencia (VF 8001096)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.finsta1
  is 'Fecha 1 instancia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.finsta2
  is 'Fecha 2 instancia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.fnueva
  is 'Nueva fecha';
comment on column MIG_SIN_TRAMITA_JUDICIAL.tresult
  is 'Resultado de la audiencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cposici
  is 'Posici�n de la compa��a (VF 8001097)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cdemand
  is 'Clase demanda (VF 8001098)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.sapodera
  is 'Clave externa de MIG_PERSONAS (Apoderado)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.idemand
  is 'Valor de la demanda';
comment on column MIG_SIN_TRAMITA_JUDICIAL.ftdeman
  is 'Terminaci�n anticipada';
comment on column MIG_SIN_TRAMITA_JUDICIAL.iconden
  is 'Valor de la condena';
comment on column MIG_SIN_TRAMITA_JUDICIAL.csenten
  is 'Resoluci�n de la sentencia (VF 8001100)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.fsente1
  is 'Fecha 1 sentencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.fsente2
  is 'Fecha 2 sentencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.ctsente
  is 'Termina el proceso por (VF 8001101)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.tfallo
  is 'Decisi�n del fallo';
comment on column MIG_SIN_TRAMITA_JUDICIAL.fmodifi
  is 'Fecha Creaci�n/Modificaci�n';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cusualt
  is 'C�digo Usuario Alta';
