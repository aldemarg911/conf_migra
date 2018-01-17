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
  is 'Fichero con la informaci�n del detalle del cuadro facultativo.';
-- Add comments to the columns 
comment on column MIG_MOVRECIBO.ncarga  is 'N�mero de carga';
comment on column MIG_MOVRECIBO.cestmig  is 'Estado del registro';
comment on column MIG_CUACESFAC.MIG_PK   is 'Clave �nica de MIG_CUACESFAC';
comment on column MIG_CUACESFAC.MIG_FK   is 'Clave for�nea de MIG_CUAFACUL';
comment on column MIG_CUACESFAC.MIG_FK2   is 'Clave for�nea de MIG_COMPANIAS';
comment on column MIG_CUACESFAC.SFACULT   is 'Secuencia de cuadro facultativo (Nulo en este caso)';
comment on column MIG_CUACESFAC.CCOMPANI   is 'C�digo de compa��a (Nulo en este caso)';
comment on column MIG_CUACESFAC.CCOMREA   is 'C�digo de comisi�n en contratos de reaseguro (Nulo en este caso)';
comment on column MIG_CUACESFAC.PCESION   is 'Porcentaje de cesi�n por compa��a';
comment on column MIG_CUACESFAC.ICESFIJ   is 'Importe fijo de cesi�n';
comment on column MIG_CUACESFAC.ICOMFIJ   is 'Importe fijo de comisi�n';
comment on column MIG_CUACESFAC.ISCONTA   is 'Importe l�mite pago siniestro a al contado';
comment on column MIG_CUACESFAC.PRESERV   is 'Porcentaje reserva sobre cesi�n';
comment on column MIG_CUACESFAC.PINTRES   is 'Porcentaje inter�s sobre reserva';
comment on column MIG_CUACESFAC.PCOMISI   is 'Porcentaje de comisi�n';
comment on column MIG_CUACESFAC.CINTRES   is 'Codi de la taula inter�s variable (Nulo en este caso)';
comment on column MIG_CUACESFAC.CCORRED   is 'Porcentaje de impuestos sobre los intereses';
comment on column MIG_CUACESFAC.CFRERES   is 'C�digo frecuencia liberaci�n/reembolso de Reservas VF:113';
comment on column MIG_CUACESFAC.CRESREA   is 'Reserva/Dep�sito a cuenta de la reaseguradora (0-No, 1-Si)';
comment on column MIG_CUACESFAC.CCONREC   is 'Cl�usula control de reclamos';
comment on column MIG_CUACESFAC.FGARPRI   is 'Fecha garant�a de pago de primas';
comment on column MIG_CUACESFAC.FGARDEP   is 'Fecha garant�a de pago de dep�sitos';
comment on column MIG_CUACESFAC.PIMPINT   is '';
comment on column MIG_CUACESFAC.CTRAMOCOMISION   is 'Tramo comisi�n variable (Tabla CLAUSULAS_REAS) (Nulo en este caso)';
comment on column MIG_CUACESFAC.TIDFCOM   is 'ID del facultativo en la compa��a reaseguradora';
-- Create/Recreate indexes 
create index MIG_CUACESFAC_NCARGA on MIG_CUACESFAC (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CUACESFAC
  add constraint MIG_CUACESFAC_PK primary key (MIG_PK);
