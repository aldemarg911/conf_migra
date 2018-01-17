-- Create table
create table MIG_CTGAR_INMUEBLE
(
  ncarga       NUMBER,
  cestmig      NUMBER,
  mig_pk       VARCHAR2(50) not null,
  mig_fk       VARCHAR2(50) not null,
  nnumescr     NUMBER,
  fescritura   DATE,
  tdescripcion VARCHAR2(1000),
  tdireccion   VARCHAR2(1000),
  cpais        NUMBER(3) not null,
  cprovin      NUMBER not null,
  cpoblac      NUMBER not null,
  fcertlib     DATE
);

-- Add comments to the columns 
comment on column MIG_CTGAR_INMUEBLE.mig_pk
  is 'Clave única de MIG_CTGA_INMUEBLE';
comment on column MIG_CTGAR_INMUEBLE.mig_fk
  is 'Clave externa para MIG_CTGARDET';
comment on column MIG_CTGAR_INMUEBLE.nnumescr
  is 'Número de la escritura publica';
comment on column MIG_CTGAR_INMUEBLE.fescritura
  is 'Fecha de la escritura';
comment on column MIG_CTGAR_INMUEBLE.tdescripcion
  is 'Descripción general';
comment on column MIG_CTGAR_INMUEBLE.tdireccion
  is 'Dirección del inmueble';
comment on column MIG_CTGAR_INMUEBLE.cpais
  is 'País';
comment on column MIG_CTGAR_INMUEBLE.cprovin
  is 'Código de Provincia';
comment on column MIG_CTGAR_INMUEBLE.cpoblac
  is 'Municipio';
comment on column MIG_CTGAR_INMUEBLE.fcertlib
  is 'Certificado libertad';
