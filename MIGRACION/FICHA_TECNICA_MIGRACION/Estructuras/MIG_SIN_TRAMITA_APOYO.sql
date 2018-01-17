create table MIG_SIN_TRAMITA_APOYO
(
  NCARGA         NUMBER not null,
  CESTMIG        NUMBER not null,
    MIG_PK      VARCHAR2(50) NOT NULL,
    MIG_FK      VARCHAR2(50) NOT NULL,
    MIG_FK2      VARCHAR2(50) NOT NULL,
    SINTAPO      NUMBER NOT NULL,
    NSINIES      VARCHAR2(150) NOT NULL,
    NTRAMIT      NUMBER(4) NOT NULL,
    NAPOYO      NUMBER,
    CUNITRA      VARCHAR2(150) NOT NULL,
    CTRAMITAD      VARCHAR2(150) NOT NULL,
    FINGRESO      DATE,
    FTERMINO      DATE,
    FSALIDA      DATE,
    TOBSERVA      VARCHAR2(150),
    TLOCALI      VARCHAR2(150),
    CSIGLAS      NUMBER,
    TNOMVIA      VARCHAR2(150),
    NNUMVIA      NUMBER,
    TCOMPLE      VARCHAR2(150),
    CPAIS      NUMBER,
    CPROVIN      NUMBER,
    CPOBLAC      NUMBER,
    CPOSTAL      VARCHAR2(150),
    CVIAVP      NUMBER,
    CLITVP      NUMBER,
    CBISVP      NUMBER,
    CORVP      NUMBER,
    NVIAADCO      NUMBER,
    CLITCO      NUMBER,
    CORCO      NUMBER,
    NPLACACO      NUMBER,
    COR2CO      NUMBER,
    CDET1IA      NUMBER,
    TNUM1IA      VARCHAR2(150),
    CDET2IA      NUMBER,
    TNUM2IA      VARCHAR2(150),
    CDET3IA      NUMBER,
    TNUM3IA      VARCHAR2(150),
    LOCALIDAD      VARCHAR2(150),
    FALTA      DATE,
    CUSUALT      VARCHAR2(150),
    FMODIFI      DATE,
    CUSUMOD      VARCHAR2(150),
    TOBSERVA2      VARCHAR2(100),
    CAGENTE      NUMBER,
    SPERSON      NUMBER
);
--
comment on column MIG_SIN_TRAMITA_APOYO.MIG_PK   is 'Clave �nica de MIG_SIN_TRAMITA_APOYO';
comment on column MIG_SIN_TRAMITA_APOYO.MIG_FK   is 'Clave externa para MIG_SIN_SINIESTRO.';
comment on column MIG_SIN_TRAMITA_APOYO.MIG_FK2   is 'Clave externa para MIG_PERSONAS.';
comment on column MIG_SIN_TRAMITA_APOYO.SINTAPO   is 'Id Tramita Apoyo (Nulo en este caso)';
comment on column MIG_SIN_TRAMITA_APOYO.NSINIES   is 'N�mero Siniestro (Nulo en este caso)';
comment on column MIG_SIN_TRAMITA_APOYO.NTRAMIT   is 'N�mero Tramitaci�n Siniestro (Nulo en este caso)';
comment on column MIG_SIN_TRAMITA_APOYO.NAPOYO   is 'N�mero Solicitud Apoyo t�cnico (Nulo en este caso)';
comment on column MIG_SIN_TRAMITA_APOYO.CUNITRA   is 'C�digo Unidad Tramitaci�n (Ver 16.1.1.14)';
comment on column MIG_SIN_TRAMITA_APOYO.CTRAMITAD   is 'C�digo Tramitador. (Ver 16.1.1.15)';
comment on column MIG_SIN_TRAMITA_APOYO.FINGRESO   is 'Fecha ingreso, fecha en que se asigna la tarea';
comment on column MIG_SIN_TRAMITA_APOYO.FTERMINO   is 'Fecha termino, fecha en que se requiere que se ha finalizado la tarea';
comment on column MIG_SIN_TRAMITA_APOYO.FSALIDA   is 'Fecha salida, fecha real de finalizaci�n de la tarea';
comment on column MIG_SIN_TRAMITA_APOYO.TOBSERVA   is 'Observaciones de la ubicaci�n';
comment on column MIG_SIN_TRAMITA_APOYO.TLOCALI   is 'Descripci�n de la ubicaci�n (direcci�n no normalizada)';
comment on column MIG_SIN_TRAMITA_APOYO.CSIGLAS   is 'C�digo Tipo V�a';
comment on column MIG_SIN_TRAMITA_APOYO.TNOMVIA   is 'Nombre V�a';
comment on column MIG_SIN_TRAMITA_APOYO.NNUMVIA   is 'N�mero V�a';
comment on column MIG_SIN_TRAMITA_APOYO.TCOMPLE   is 'Descripci�n Complementaria';
comment on column MIG_SIN_TRAMITA_APOYO.CPAIS   is 'C�digo Pa�s';
comment on column MIG_SIN_TRAMITA_APOYO.CPROVIN   is 'C�digo Provincia';
comment on column MIG_SIN_TRAMITA_APOYO.CPOBLAC   is 'C�digo Poblaci�n';
comment on column MIG_SIN_TRAMITA_APOYO.CPOSTAL   is 'C�digo Postal';
comment on column MIG_SIN_TRAMITA_APOYO.CVIAVP   is 'C�digo de v�a predio - v�a principal';
comment on column MIG_SIN_TRAMITA_APOYO.CLITVP   is 'C�digo de literal predio - v�a principal';
comment on column MIG_SIN_TRAMITA_APOYO.CBISVP   is 'C�digo BIS predio - v�a principal';
comment on column MIG_SIN_TRAMITA_APOYO.CORVP   is 'C�digo orientaci�n predio - v�a principal';
comment on column MIG_SIN_TRAMITA_APOYO.NVIAADCO   is 'N�mero de v�a adyacente predio - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.CLITCO   is 'C�digo de literal predio - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.CORCO   is 'C�digo orientaci�n predio - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.NPLACACO   is 'N�mero consecutivo placa predio - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.COR2CO   is 'C�digo orientaci�n predio 2 - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.CDET1IA   is 'C�digo detalle 1 - informaci�n adicional';
comment on column MIG_SIN_TRAMITA_APOYO.TNUM1IA   is 'N�mero predio 1 - informaci�n adicional';
comment on column MIG_SIN_TRAMITA_APOYO.CDET2IA   is 'C�digo detalle 2 - informaci�n adicional';
comment on column MIG_SIN_TRAMITA_APOYO.TNUM2IA   is 'N�mero predio 2 - informaci�n adicional';
comment on column MIG_SIN_TRAMITA_APOYO.CDET3IA   is 'C�digo detalle 3 - informaci�n adicional';
comment on column MIG_SIN_TRAMITA_APOYO.TNUM3IA   is 'N�mero predio 3 - informaci�n adicional';
comment on column MIG_SIN_TRAMITA_APOYO.LOCALIDAD   is 'Localidad';
comment on column MIG_SIN_TRAMITA_APOYO.FALTA   is 'Fecha Alta';
comment on column MIG_SIN_TRAMITA_APOYO.CUSUALT   is 'C�digo Usuario Alta';
comment on column MIG_SIN_TRAMITA_APOYO.FMODIFI   is 'Fecha de modificaci�n';
comment on column MIG_SIN_TRAMITA_APOYO.CUSUMOD   is 'C�digo usuario de modificaci�n';
comment on column MIG_SIN_TRAMITA_APOYO.TOBSERVA2   is 'Observaciones';
comment on column MIG_SIN_TRAMITA_APOYO.CAGENTE   is 'C�digo del agente (Migraci�n = 19000)';
comment on column MIG_SIN_TRAMITA_APOYO.SPERSON   is 'C�digo de la persona � Clave externa de MIG_PERSONAS (Nulo en este caso)';
--
create index MIG_SIN_TRAMITA_APOYO_NCARGA on MIG_SIN_TRAMITA_APOYO (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_SIN_TRAMITA_APOYO
  add constraint MIG_SIN_TRAMITA_APOYO_PK primary key (MIG_PK);
