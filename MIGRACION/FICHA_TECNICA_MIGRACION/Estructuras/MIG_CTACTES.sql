--
-- Create table
create table MIG_CTACTES
(
  ncarga  NUMBER not null,
  cestmig NUMBER not null,
  --
  MIG_PK       VARCHAR2(50) not null,
  CAGENTE      NUMBER not null,
  NNUMLIN      NUMBER(6) not null,
  CDEBHAB      NUMBER not null,
  CCONCTA      NUMBER(2) not null,
  CESTADO      NUMBER(1) not null,
  NDOCUME      VARCHAR2(10),
  FFECMOV      DATE not null,
  IIMPORT      NUMBER not null,
  TDESCRIP     VARCHAR2(100),
  CMANUAL      NUMBER(1),
  MIG_FK       VARCHAR2(50) ,    -- Mig_Recibos
  MIG_FK2      VARCHAR2(50) ,    -- Mig_Seguros
  MIG_FK3      VARCHAR2(50) ,    -- Mig_Siniestros
  FVALOR       DATE,
  CFISCAL      NUMBER(1),
  SPRODUC      NUMBER(8) not null,
  CCOMPANI     NUMBER(2),
  CTIPOLIQ     NUMBER
);
-- Add comments to the table 
comment on table MIG_CTACTES
  is 'Fichero con los apuntes manuales en la cuenta técnica del intermediario.';
-- Add comments to the columns 
comment on column MIG_CTACTES.ncarga   is 'Número de carga';
comment on column MIG_CTACTES.cestmig  is 'Estado del registro';
comment on column MIG_CTACTES.MIG_PK   is 'Clave única de MIG_CTCTES';
comment on column MIG_CTACTES.CAGENTE   is 'Código de agente';
comment on column MIG_CTACTES.NNUMLIN   is 'Número de línea';
comment on column MIG_CTACTES.CDEBHAB   is 'Código DEBE o HABER';
comment on column MIG_CTACTES.CCONCTA   is 'Código concepto cta. corriente.';
comment on column MIG_CTACTES.CESTADO   is 'Estado del apunte.  0 :Liquidado, 1:pendiente,';
comment on column MIG_CTACTES.NDOCUME   is 'Número de documento';
comment on column MIG_CTACTES.FFECMOV   is 'Fecha de movimiento';
comment on column MIG_CTACTES.IIMPORT   is 'Importe';
comment on column MIG_CTACTES.TDESCRIP   is 'Texto apunte';
comment on column MIG_CTACTES.CMANUAL   is '1 Manual';
comment on column MIG_CTACTES.MIG_FK   is 'Número de recibo (Clave foránea MIG_RECIBOS)';
comment on column MIG_CTACTES.MIG_FK2   is 'Número de siniestro (Clave foránea MIG_SINIESTROS)';
comment on column MIG_CTACTES.MIG_FK3   is 'Número de póliza (Clave foránea MIG_SEGUROS)';
comment on column MIG_CTACTES.FVALOR   is 'Fecha valor';
comment on column MIG_CTACTES.CFISCAL   is '0 Apunte Fiscal - 1 Apunte NO fiscal';
comment on column MIG_CTACTES.SPRODUC   is 'Producto de agrupamiento, default 0';
comment on column MIG_CTACTES.CCOMPANI   is 'Código de la compañía, default 0';
comment on column MIG_CTACTES.CTIPOLIQ   is 'Tipo de liquidación (0 Real - 1 Previo)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_CTACTES
  add constraint MIG_CTACTES_PK primary key (MIG_PK);

