create table MIG_SIN_TRAMITA_JUDICIAL
(
ncarga       NUMBER not null,
cestmig      NUMBER not null,
nsinies      VARCHAR2(14)  not null,
ntramit      NUMBER(4)  not null,
--
MIG_PK      VARCHAR2(50),
MIG_FK      VARCHAR2(50),
MIG_FK2      VARCHAR2(50),
NORDEN      NUMBER(3),
CPROCESO      NUMBER(8),
TPROCESO      NUMBER(8),
CPOSTAL      VARCHAR2(30),
CPOBLAC      NUMBER(5),
CPROVIN      NUMBER(5),
TIEXTERNO      VARCHAR2(2000),
SPROFES      NUMBER,
FRECEP DATE,
FNOTIFI DATE,
FVENCIMI DATE,
FRESPUES DATE,
FCONCIL DATE,
FDESVIN DATE,
TPRETEN      VARCHAR2(2000),
TEXCEP1      VARCHAR2(2000),
TEXCEP2      VARCHAR2(2000),
FAUDIEN DATE,
HAUDIEN DATE,
TAUDIEN      VARCHAR2(200),
CCONTI      NUMBER(8),
CDESPA      NUMBER(8),
TLAUDIE      VARCHAR2(200),
CAUDIEN      NUMBER(5),
CDESPAO      NUMBER(8),
TLAUDIEO      VARCHAR2(200),
CAUDIENO      NUMBER(5),
SABOGAU      NUMBER(10),
CORAL      NUMBER(1),
CESTADO      NUMBER(1),
CRESOLU      NUMBER(1),
FINSTA1 DATE,
FINSTA2 DATE,
FNUEVA DATE,
TRESULT      VARCHAR2(2000),
CPOSICI      NUMBER(8),
CDEMAND      NUMBER(8),
SAPODERA      NUMBER(10),
IDEMAND      NUMBER,
FTDEMAN DATE,
ICONDEN      NUMBER,
CSENTEN      NUMBER(8),
FSENTE1 DATE,
FSENTE2 DATE,
CTSENTE      NUMBER(8),
TFALLO      VARCHAR2(2000),
FMODIFI DATE,
CUSUALT      VARCHAR2(20),
CASACION      NUMBER(1),
FCASACI DATE,
CSENTEN2      NUMBER(8),
FTSENTE DATE
);
--
comment on table MIG_SIN_TRAMITA_JUDICIAL  is 'Fichero con la información de tramitación judicial.';
comment on column MIG_SIN_TRAMITA_JUDICIAL.ncarga  is 'Número de carga';
comment on column MIG_SIN_TRAMITA_JUDICIAL.cestmig  is 'Estado del registro';
comment on column MIG_SIN_TRAMITA_JUDICIAL.nsinies  is 'Número Siniestro';
comment on column MIG_SIN_TRAMITA_JUDICIAL.NTRAMIT  is 'Número Tramitación';
comment on column MIG_SIN_TRAMITA_JUDICIAL.MIG_PK   is 'Clave única de MIG_SIN_TRAMITA_JUDICIAL';
comment on column MIG_SIN_TRAMITA_JUDICIAL.MIG_FK   is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAMITA_JUDICIAL.MIG_FK2   is 'Clave externa de MIG_SIN_TRAMITACION.';
comment on column MIG_SIN_TRAMITA_JUDICIAL.NORDEN   is 'Numero Orden Proceso';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CPROCESO   is 'Clase de proceso (VF 8001090)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TPROCESO   is 'Tipo de proceso (VF 8001091)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CPOSTAL   is 'Código postal';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CPOBLAC   is 'Código población';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CPROVIN   is 'Código provincia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TIEXTERNO   is 'Identificador Externo';
comment on column MIG_SIN_TRAMITA_JUDICIAL.SPROFES   is 'Clave externa de MIG_SIN_PROF_PROFESIONALES (Profesional que asiste a la audiencia)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FRECEP   is 'Fecha Recepción Oficial';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FNOTIFI   is 'Fecha Notificación';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FVENCIMI   is 'Fecha Vencimiento Termino';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FRESPUES   is 'Fecha Respuesta';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FCONCIL   is 'Fecha Conciliación';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FDESVIN   is 'Desvinculados por notificación extemporánea';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TPRETEN   is 'Pretensiones de la demanda';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TEXCEP1   is 'Excepciones del denunciado';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TEXCEP2   is 'Excepciones de la compañía';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FAUDIEN   is 'Fecha de audiencia (Null en este caso, pasará la información a nueva tabla)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.HAUDIEN   is 'Hora de audiencia (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TAUDIEN   is 'Clase de audiencia (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CCONTI   is 'Contingencia (VF 8001092) (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CDESPA   is 'Despacho de la audiencia (VF 8001093)( Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TLAUDIE   is 'Lugar de la audiencia (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CAUDIEN   is 'Código postal - Ciudad audiencia (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CDESPAO   is 'Despacho de audiencia origen (VF 8001093) (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TLAUDIEO   is 'Lugar de la audiencia origen (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CAUDIENO   is 'Código postal - Ciudad audiencia origen (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.SABOGAU   is 'Clave externa de MIG_PERSONAS (Abogado que asiste a la audiencia) (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CORAL   is '?La audiencia se llevar? a cabo de manera oral? (VF 8001094) (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CESTADO   is 'Estado audiencia (VF 8001095) (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CRESOLU   is 'Resolución de audiencia (VF 8001096) (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FINSTA1   is 'Fecha 1 instancia (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FINSTA2   is 'Fecha 2 instancia (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FNUEVA   is 'Nueva fecha (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TRESULT   is 'Resultado de la audiencia (Null, ídem)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CPOSICI   is 'Posición de la compañía (VF 8001097)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CDEMAND   is 'Clase demanda (VF 8001098)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.SAPODERA   is 'Clave externa de MIG_PERSONAS (Apoderado)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.IDEMAND   is 'Valor de la demanda';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FTDEMAN   is 'Terminación anticipada';
comment on column MIG_SIN_TRAMITA_JUDICIAL.ICONDEN   is 'Valor de la condena';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CSENTEN   is 'Resolución de la sentencia (VF 8001100)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FSENTE1   is 'Fecha 1 sentencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FSENTE2   is 'Fecha 2 sentencia';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CTSENTE   is 'Termina el proceso por (VF 8001101)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.TFALLO   is 'Decisión del fallo';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FMODIFI   is 'Fecha Creación/Modificación';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CUSUALT   is 'Código Usuario Alta';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CASACION   is 'Casación de la sentencia 0-No/1-Si';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FCASACI   is 'Fecha de la casación';
comment on column MIG_SIN_TRAMITA_JUDICIAL.CSENTEN2   is 'Resolución de la segunda sentencia (VF 8001100)';
comment on column MIG_SIN_TRAMITA_JUDICIAL.FTSENTE   is 'Fecha de terminación de sentencia';
