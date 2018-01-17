-- Create table
create table MIG_FIN_ENDEUDAMIENTO
(
  ncarga    NUMBER,
  cestmig   NUMBER,
  mig_pk    VARCHAR2(50) not null,
  mig_fk    VARCHAR2(50) not null,
  sfinanci  NUMBER NOT NULL,
  fconsulta DATE not null,
  cfuente   NUMBER not null,
  iminimo   NUMBER,
  icappag   NUMBER,
  icapend   NUMBER,
  iendtot   NUMBER,
  ncalifa   NUMBER,
  ncalifb   NUMBER,
  ncalifc   NUMBER,
  ncalifd   NUMBER,
  ncalife   NUMBER,
  nconsul   NUMBER,
  nscore    NUMBER,
  nmora     NUMBER,
  icupog    NUMBER,
  icupos    NUMBER,
  fcupo     DATE,
  tcupor    VARCHAR2(2000),
  crestric  NUMBER,
  tconcepc  VARCHAR2(2000),
  tconceps  VARCHAR2(2000),
  tcburea   VARCHAR2(2000),
  tcotros   VARCHAR2(2000)
)
;
-- Add comments to the columns 
comment on column MIG_FIN_ENDEUDAMIENTO.mig_pk
  is 'Clave única de MIG_FIN_ENDEUDAMIENTO';
comment on column MIG_FIN_ENDEUDAMIENTO.mig_fk
  is 'Clave externa para MIG_FIN_GENERAL';
comment on column MIG_FIN_ENDEUDAMIENTO.sfinanci
  is 'Código ficha financiera (Si es nula se calcula de manera automática)';
comment on column MIG_FIN_ENDEUDAMIENTO.fconsulta
  is 'Fecha consulta central';
comment on column MIG_FIN_ENDEUDAMIENTO.cfuente
  is 'Fuente de Información V.F 8001076';
comment on column MIG_FIN_ENDEUDAMIENTO.iminimo
  is 'Ingreso mínimo probable';
comment on column MIG_FIN_ENDEUDAMIENTO.icappag
  is 'Capacidad de pago';
comment on column MIG_FIN_ENDEUDAMIENTO.icapend
  is 'Capacidad de endeuda';
comment on column MIG_FIN_ENDEUDAMIENTO.iendtot
  is 'Endeudamiento total financiero';
comment on column MIG_FIN_ENDEUDAMIENTO.ncalifa
  is 'Sumatoria Calificación A';
comment on column MIG_FIN_ENDEUDAMIENTO.ncalifb
  is 'Sumatoria Calificación B';
comment on column MIG_FIN_ENDEUDAMIENTO.ncalifc
  is 'Sumatoria Calificación C';
comment on column MIG_FIN_ENDEUDAMIENTO.ncalifd
  is 'Sumatoria Calificación D';
comment on column MIG_FIN_ENDEUDAMIENTO.ncalife
  is 'Sumatoria Calificación E';
comment on column MIG_FIN_ENDEUDAMIENTO.nconsul
  is 'Número de consultas Últimos 6 meses';
comment on column MIG_FIN_ENDEUDAMIENTO.nscore
  is 'Puntaje score';
comment on column MIG_FIN_ENDEUDAMIENTO.nmora
  is 'Probabilidad Mora';
comment on column MIG_FIN_ENDEUDAMIENTO.icupog
  is 'Cupo del garantizado';
comment on column MIG_FIN_ENDEUDAMIENTO.icupos
  is 'Cupo sugerido';
comment on column MIG_FIN_ENDEUDAMIENTO.fcupo
  is 'Fecha cupo';
comment on column MIG_FIN_ENDEUDAMIENTO.tcupor
  is 'Responsable cupo';
comment on column MIG_FIN_ENDEUDAMIENTO.crestric
  is 'Cliente restringido por V.F. YYYY06';
comment on column MIG_FIN_ENDEUDAMIENTO.tconcepc
  is 'Concepto financiero del cliente';
comment on column MIG_FIN_ENDEUDAMIENTO.tconceps
  is 'Concepto del cliente sucursal';
comment on column MIG_FIN_ENDEUDAMIENTO.tcburea
  is 'Concepto Bureau y/o Gerencia técnica';
comment on column MIG_FIN_ENDEUDAMIENTO.tcotros
  is 'Concepto otras áreas';
--
create index MIG_FIN_ENDEUDAMIENTO_NCARGA on MIG_FIN_ENDEUDAMIENTO (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_FIN_ENDEUDAMIENTO
  add constraint MIG_FIN_ENDEUDAMIENTO_PK primary key (MIG_PK);
