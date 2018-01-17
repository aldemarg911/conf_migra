-- Create table
create table MIG_LIQUIDALIN
(
  ncarga             NUMBER,
  cestmig            NUMBER,
  mig_pk             VARCHAR2(50) not null,
  mig_fk             VARCHAR2(50) not null,
  mig_fk2            VARCHAR2(50) not null,
  itotimp            NUMBER,
  itotalr            NUMBER,
  iprinet            NUMBER,
  icomisi            NUMBER,
  iretenccom         NUMBER,
  isobrecomision     NUMBER,
  iretencsobrecom    NUMBER,
  iconvoleducto      NUMBER,
  iretencoleoducto   NUMBER,
  ctipoliq           NUMBER(3),
  itotimp_moncia     NUMBER,
  itotalr_moncia     NUMBER,
  iprinet_moncia     NUMBER,
  icomisi_moncia     NUMBER,
  iretenccom_moncia  NUMBER,
  isobrecom_moncia   NUMBER,
  iretencscom_moncia NUMBER,
  iconvoleod_moncia  NUMBER,
  iretoleod_moncia   NUMBER,
  fcambio            DATE
)
;
-- Add comments to the columns 
comment on column MIG_LIQUIDALIN.mig_pk
  is 'Clave �nica de MIG_LIQUIDALIN';
comment on column MIG_LIQUIDALIN.mig_fk
  is 'Clave for�nea de MIG_LIQUIDACAB';
comment on column MIG_LIQUIDALIN.mig_fk2
  is 'Clave for�nea de MIG_MOVRECIBO';
comment on column MIG_LIQUIDALIN.itotimp
  is 'Total Impuestos y Arbitrios';
comment on column MIG_LIQUIDALIN.itotalr
  is 'Total del recibo';
comment on column MIG_LIQUIDALIN.iprinet
  is 'Prima Neta';
comment on column MIG_LIQUIDALIN.icomisi
  is 'Importe de comisi�n';
comment on column MIG_LIQUIDALIN.iretenccom
  is 'Importe retenci�n (Sumatorio impuestos a aplicar)';
comment on column MIG_LIQUIDALIN.isobrecomision
  is 'Importe sobre comisi�n';
comment on column MIG_LIQUIDALIN.iretencsobrecom
  is 'Importe retenci�n (Sumatorio impuestos a aplicar sobre la sobre comisi�n)';
comment on column MIG_LIQUIDALIN.iconvoleducto
  is 'Importe convenio oleoducto';
comment on column MIG_LIQUIDALIN.iretencoleoducto
  is 'Importe retenci�n (Sumatorio impuestos a aplicar sobre conv oleoducto)';
comment on column MIG_LIQUIDALIN.ctipoliq
  is 'Tipo de liquidaci�n o por el l�quido o por el total';
comment on column MIG_LIQUIDALIN.itotimp_moncia
  is 'Total Impuestos y Arbitrios en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.itotalr_moncia
  is 'Total del recibo en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.iprinet_moncia
  is 'Prima Neta en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.icomisi_moncia
  is 'Importe de comisi�n en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.iretenccom_moncia
  is 'Importe retenci�n (Sumatorio impuestos a aplicar) en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.isobrecom_moncia
  is 'Importe sobre comisi�n en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.iretencscom_moncia
  is 'Importe retenci�n (Sumatorio impuestos a aplicar sobre la sobre comisi�n) en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.iconvoleod_moncia
  is 'Importe convenio oleoducto en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.iretoleod_moncia
  is 'Importe retenci�n (Sumatorio impuestos a aplicar sobre conv oleoducto) en la moneda de la empresa';
comment on column MIG_LIQUIDALIN.fcambio
  is 'Fecha empleada para el c�lculo de los contravalores';
