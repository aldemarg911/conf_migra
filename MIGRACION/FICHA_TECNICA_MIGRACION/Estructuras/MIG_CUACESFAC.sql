-- Create table
create table MIG_CUACESFAC
(
  ncarga  NUMBER not null,
  cestmig NUMBER not null,
  --
  MIG_PK      VARCHAR2(50) NOT NULL,
  MIG_FK      VARCHAR2(50) NOT NULL,
  MIG_FK2      VARCHAR2(50) NOT NULL,
  SFACULT      NUMBER(6) NOT NULL,
  CCOMPANI      NUMBER(3) NOT NULL,
  CCOMREA      NUMBER(2),
  PCESION      NUMBER(8,5),
  ICESFIJ      NUMBER,
  ICOMFIJ      NUMBER,
  ISCONTA      NUMBER,
  PRESERV      NUMBER(5,2),
  PINTRES      NUMBER(7,5),
  PCOMISI      NUMBER(5,2),
  CINTRES      NUMBER(2),
  CCORRED      NUMBER(4),
  CFRERES      NUMBER(2),
  CRESREA      NUMBER(1),
  CCONREC      NUMBER(1),
  FGARPRI      DATE,
  FGARDEP      DATE,
  PIMPINT      NUMBER(5,2),
  CTRAMOCOMISION      NUMBER(5),
  TIDFCOM      VARCHAR2(50)
);
-- Add comments to the table 
comment on table MIG_CUACESFAC
  is 'Fichero con la información del detalle del cuadro facultativo.';
-- Add comments to the columns 
comment on column MIG_MOVRECIBO.ncarga  is 'Número de carga';
comment on column MIG_MOVRECIBO.cestmig  is 'Estado del registro';
comment on column MIG_CUACESFAC.MIG_PK   is 'Clave única de MIG_CUACESFAC';
comment on column MIG_CUACESFAC.MIG_FK   is 'Clave foránea de MIG_CUAFACUL';
comment on column MIG_CUACESFAC.MIG_FK2   is 'Clave foránea de MIG_COMPANIAS';
comment on column MIG_CUACESFAC.SFACULT   is 'Secuencia de cuadro facultativo (Nulo en este caso)';
comment on column MIG_CUACESFAC.CCOMPANI   is 'Código de compañía (Nulo en este caso)';
comment on column MIG_CUACESFAC.CCOMREA   is 'Código de comisión en contratos de reaseguro (Nulo en este caso)';
comment on column MIG_CUACESFAC.PCESION   is 'Porcentaje de cesión por compañía';
comment on column MIG_CUACESFAC.ICESFIJ   is 'Importe fijo de cesión';
comment on column MIG_CUACESFAC.ICOMFIJ   is 'Importe fijo de comisión';
comment on column MIG_CUACESFAC.ISCONTA   is 'Importe límite pago siniestro a al contado';
comment on column MIG_CUACESFAC.PRESERV   is 'Porcentaje reserva sobre cesión';
comment on column MIG_CUACESFAC.PINTRES   is 'Porcentaje interés sobre reserva';
comment on column MIG_CUACESFAC.PCOMISI   is 'Porcentaje de comisión';
comment on column MIG_CUACESFAC.CINTRES   is 'Codi de la taula interés variable (Nulo en este caso)';
comment on column MIG_CUACESFAC.CCORRED   is 'Porcentaje de impuestos sobre los intereses';
comment on column MIG_CUACESFAC.CFRERES   is 'Código frecuencia liberación/reembolso de Reservas VF:113';
comment on column MIG_CUACESFAC.CRESREA   is 'Reserva/Depósito a cuenta de la reaseguradora (0-No, 1-Si)';
comment on column MIG_CUACESFAC.CCONREC   is 'Cláusula control de reclamos';
comment on column MIG_CUACESFAC.FGARPRI   is 'Fecha garantía de pago de primas';
comment on column MIG_CUACESFAC.FGARDEP   is 'Fecha garantía de pago de depósitos';
comment on column MIG_CUACESFAC.PIMPINT   is '';
comment on column MIG_CUACESFAC.CTRAMOCOMISION   is 'Tramo comisión variable (Tabla CLAUSULAS_REAS) (Nulo en este caso)';
comment on column MIG_CUACESFAC.TIDFCOM   is 'ID del facultativo en la compañía reaseguradora';
-- Create/Recreate indexes 
create index MIG_CUACESFAC_NCARGA on MIG_CUACESFAC (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CUACESFAC
  add constraint MIG_CUACESFAC_PK primary key (MIG_PK);
