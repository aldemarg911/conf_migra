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
comment on column MIG_SIN_TRAMITA_APOYO.MIG_PK   is 'Clave única de MIG_SIN_TRAMITA_APOYO';
comment on column MIG_SIN_TRAMITA_APOYO.MIG_FK   is 'Clave externa para MIG_SIN_SINIESTRO.';
comment on column MIG_SIN_TRAMITA_APOYO.MIG_FK2   is 'Clave externa para MIG_PERSONAS.';
comment on column MIG_SIN_TRAMITA_APOYO.SINTAPO   is 'Id Tramita Apoyo (Nulo en este caso)';
comment on column MIG_SIN_TRAMITA_APOYO.NSINIES   is 'Número Siniestro (Nulo en este caso)';
comment on column MIG_SIN_TRAMITA_APOYO.NTRAMIT   is 'Número Tramitación Siniestro (Nulo en este caso)';
comment on column MIG_SIN_TRAMITA_APOYO.NAPOYO   is 'Número Solicitud Apoyo técnico (Nulo en este caso)';
comment on column MIG_SIN_TRAMITA_APOYO.CUNITRA   is 'Código Unidad Tramitación (Ver 16.1.1.14)';
comment on column MIG_SIN_TRAMITA_APOYO.CTRAMITAD   is 'Código Tramitador. (Ver 16.1.1.15)';
comment on column MIG_SIN_TRAMITA_APOYO.FINGRESO   is 'Fecha ingreso, fecha en que se asigna la tarea';
comment on column MIG_SIN_TRAMITA_APOYO.FTERMINO   is 'Fecha termino, fecha en que se requiere que se ha finalizado la tarea';
comment on column MIG_SIN_TRAMITA_APOYO.FSALIDA   is 'Fecha salida, fecha real de finalización de la tarea';
comment on column MIG_SIN_TRAMITA_APOYO.TOBSERVA   is 'Observaciones de la ubicación';
comment on column MIG_SIN_TRAMITA_APOYO.TLOCALI   is 'Descripción de la ubicación (dirección no normalizada)';
comment on column MIG_SIN_TRAMITA_APOYO.CSIGLAS   is 'Código Tipo Vía';
comment on column MIG_SIN_TRAMITA_APOYO.TNOMVIA   is 'Nombre Vía';
comment on column MIG_SIN_TRAMITA_APOYO.NNUMVIA   is 'Número Vía';
comment on column MIG_SIN_TRAMITA_APOYO.TCOMPLE   is 'Descripción Complementaria';
comment on column MIG_SIN_TRAMITA_APOYO.CPAIS   is 'Código País';
comment on column MIG_SIN_TRAMITA_APOYO.CPROVIN   is 'Código Provincia';
comment on column MIG_SIN_TRAMITA_APOYO.CPOBLAC   is 'Código Población';
comment on column MIG_SIN_TRAMITA_APOYO.CPOSTAL   is 'Código Postal';
comment on column MIG_SIN_TRAMITA_APOYO.CVIAVP   is 'Código de vía predio - vía principal';
comment on column MIG_SIN_TRAMITA_APOYO.CLITVP   is 'Código de literal predio - vía principal';
comment on column MIG_SIN_TRAMITA_APOYO.CBISVP   is 'Código BIS predio - vía principal';
comment on column MIG_SIN_TRAMITA_APOYO.CORVP   is 'Código orientación predio - vía principal';
comment on column MIG_SIN_TRAMITA_APOYO.NVIAADCO   is 'Número de vía adyacente predio - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.CLITCO   is 'Código de literal predio - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.CORCO   is 'Código orientación predio - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.NPLACACO   is 'Número consecutivo placa predio - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.COR2CO   is 'Código orientación predio 2 - coordenada';
comment on column MIG_SIN_TRAMITA_APOYO.CDET1IA   is 'Código detalle 1 - información adicional';
comment on column MIG_SIN_TRAMITA_APOYO.TNUM1IA   is 'Número predio 1 - información adicional';
comment on column MIG_SIN_TRAMITA_APOYO.CDET2IA   is 'Código detalle 2 - información adicional';
comment on column MIG_SIN_TRAMITA_APOYO.TNUM2IA   is 'Número predio 2 - información adicional';
comment on column MIG_SIN_TRAMITA_APOYO.CDET3IA   is 'Código detalle 3 - información adicional';
comment on column MIG_SIN_TRAMITA_APOYO.TNUM3IA   is 'Número predio 3 - información adicional';
comment on column MIG_SIN_TRAMITA_APOYO.LOCALIDAD   is 'Localidad';
comment on column MIG_SIN_TRAMITA_APOYO.FALTA   is 'Fecha Alta';
comment on column MIG_SIN_TRAMITA_APOYO.CUSUALT   is 'Código Usuario Alta';
comment on column MIG_SIN_TRAMITA_APOYO.FMODIFI   is 'Fecha de modificación';
comment on column MIG_SIN_TRAMITA_APOYO.CUSUMOD   is 'Código usuario de modificación';
comment on column MIG_SIN_TRAMITA_APOYO.TOBSERVA2   is 'Observaciones';
comment on column MIG_SIN_TRAMITA_APOYO.CAGENTE   is 'Código del agente (Migración = 19000)';
comment on column MIG_SIN_TRAMITA_APOYO.SPERSON   is 'Código de la persona – Clave externa de MIG_PERSONAS (Nulo en este caso)';
--
create index MIG_SIN_TRAMITA_APOYO_NCARGA on MIG_SIN_TRAMITA_APOYO (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_SIN_TRAMITA_APOYO
  add constraint MIG_SIN_TRAMITA_APOYO_PK primary key (MIG_PK);
