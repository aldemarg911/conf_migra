-- Create table
CREATE TABLE MIG_ECO_TIPOCAMBIO
(
  ncarga      NUMBER NOT NULL,
  cestmig     NUMBER NOT NULL,
  --
 -- MIG_PK      VARCHAR2(50) not null,
  CMONORI      VARCHAR2(3) NOT NULL,
  CMONDES      VARCHAR2(3) NOT NULL,
  FCAMBIO      DATE NOT NULL,
  ITASA      NUMBER NOT NULL
);
-- Add comments to the table 
comment on table MIG_ECO_TIPOCAMBIO
  is 'Fichero con la informaci�n de los movimientos de Tasas de Cambio necesarias para el c�lculo de los contratos de reaseguro con moneda extranjera.';
  --
comment on column MIG_ECO_TIPOCAMBIO.ncarga  is 'N�mero de carga';
comment on column MIG_ECO_TIPOCAMBIO.cestmig  is 'Estado del registro';
--comment on column MIG_PTPPLP.MIG_PK   is 'Clave �nica de MIG_PTPPLP';
comment on column MIG_ECO_TIPOCAMBIO.CMONORI   is 'C�digo de la moneda origen';
comment on column MIG_ECO_TIPOCAMBIO.CMONDES   is 'C�digo de la moneda destino';
comment on column MIG_ECO_TIPOCAMBIO.FCAMBIO   is 'Fecha del tipo de cambio, truncada ser� v�lida para todo ese d�a';
comment on column MIG_ECO_TIPOCAMBIO.ITASA   is 'Tasa de cambio al d�a';
--
create index MIG_ECO_TIPOCAMBIO_NCARGA on MIG_ECO_TIPOCAMBIO (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
--alter table MIG_PTPPLP  add constraint MIG_PTPPLP_CESIONESREA_PK primary key (MIG_PK);
--

