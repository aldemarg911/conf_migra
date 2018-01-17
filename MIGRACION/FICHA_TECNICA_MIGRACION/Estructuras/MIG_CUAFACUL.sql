-- Create table
create table MIG_CUAFACUL
(
  ncarga  NUMBER not null,
  cestmig NUMBER not null,
  --
  MIG_PK      VARCHAR2(50) NOT NULL,
  MIG_FK      VARCHAR2(50) NOT NULL,
  MIG_FK2      VARCHAR2(50) NOT NULL,
  SFACULT      NUMBER(6) NOT NULL,
  CESTADO      NUMBER(2) NOT NULL,
  FINICUF      DATE NOT NULL,
  CFREBOR      NUMBER(2) NOT NULL,
  SCONTRA      NUMBER(6) NOT NULL,
  NVERSIO      NUMBER(2) NOT NULL,
  SSEGURO      NUMBER NOT NULL,
  CGARANT      NUMBER(4) NOT NULL,
  CCALIF1      VARCHAR2(1),
  CCALIF2      NUMBER(2),
  SPLENO      NUMBER(6),
  NMOVIMI      NUMBER(4),
  SCUMULO      NUMBER(6),
  NRIESGO      NUMBER(6),
  FFINCUF      DATE,
  PLOCAL      NUMBER(5,2),
  FULTBOR      DATE,
  PFACCED      NUMBER(15,6),
  IFACCED      NUMBER,
  NCESION      NUMBER(6),
  CTIPFAC      NUMBER(1) NOT NULL,
  PTASAXL      NUMBER(7,5) NOT NULL,
  CNOTACES      VARCHAR2(100)
);
-- Add comments to the table 
comment on table MIG_CUAFACUL
  is 'Fichero con la informaci�n de los cuadros facultativos.';
-- Add comments to the columns 
comment on column MIG_MOVRECIBO.ncarga  is 'N�mero de carga';
comment on column MIG_MOVRECIBO.cestmig  is 'Estado del registro';
comment on column MIG_CUAFACUL.MIG_PK   is 'Clave �nica de MIG_CUAFACUL';
comment on column MIG_CUAFACUL.MIG_FK   is 'Clave for�nea de MIG_CODICONTRATOS';
comment on column MIG_CUAFACUL.MIG_FK2   is 'Clave for�nea de MIG_SEGUROS';
comment on column MIG_CUAFACUL.SFACULT   is 'Secuencia de cuadro facultativo (Nulo en este caso)';
comment on column MIG_CUAFACUL.CESTADO   is 'Estado del cuadro';
comment on column MIG_CUAFACUL.FINICUF   is 'Fecha inicio validez';
comment on column MIG_CUAFACUL.CFREBOR   is 'Frecuencia del border�';
comment on column MIG_CUAFACUL.SCONTRA   is 'Secuencia de contrato (Nulo en este caso)';
comment on column MIG_CUAFACUL.NVERSIO   is 'N�mero versi�n contrato reas. (Siempre 1)';
comment on column MIG_CUAFACUL.SSEGURO   is 'N�mero consecutivo de seguro asignado autom�ticamente. (Nulo en este caso)';
comment on column MIG_CUAFACUL.CGARANT   is 'C�digo de garant�a (Nulo en este caso)';
comment on column MIG_CUAFACUL.CCALIF1   is 'Calificaci�n del riesgo (Nulo en este caso)';
comment on column MIG_CUAFACUL.CCALIF2   is 'Subcalificaci�n del riesgo (Nulo en este caso)';
comment on column MIG_CUAFACUL.SPLENO   is 'Identificador del Pleno (Nulo en este caso)';
comment on column MIG_CUAFACUL.NMOVIMI   is 'N�mero de movimiento';
comment on column MIG_CUAFACUL.SCUMULO   is 'Identificador de un c�mulo (Nulo en este caso)';
comment on column MIG_CUAFACUL.NRIESGO   is 'N�mero de riesgo (Siempre 1)';
comment on column MIG_CUAFACUL.FFINCUF   is 'Fecha fin valide';
comment on column MIG_CUAFACUL.PLOCAL   is 'Parte que retenemos del facultativo';
comment on column MIG_CUAFACUL.FULTBOR   is 'Fecha impresi�n �ltimo border�';
comment on column MIG_CUAFACUL.PFACCED   is 'Porcentaje cedido de facultativo';
comment on column MIG_CUAFACUL.IFACCED   is 'Importe cedido facultativo';
comment on column MIG_CUAFACUL.NCESION   is 'N�mero de cesi�n';
comment on column MIG_CUAFACUL.CTIPFAC   is 'C�digo tipo facultativo (0-Normal, 1-Fac.XL)';
comment on column MIG_CUAFACUL.PTASAXL   is 'Tasa Facultativo XL';
comment on column MIG_CUAFACUL.CNOTACES   is 'Nota cesiones del facultativo para impresi�n';
-- Create/Recreate indexes 
create index MIG_CUAFACUL_NCARGA on MIG_CUAFACUL (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CUAFACUL
  add constraint MIG_CUAFACUL_PK primary key (MIG_PK);
