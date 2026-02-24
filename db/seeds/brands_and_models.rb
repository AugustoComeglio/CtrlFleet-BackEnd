# Vehiculos
renault_id = Brand.find_or_create_by(name: 'Renault').id
renault_attributes = [
  { brand_id: renault_id, name: 'Clio' },
  { brand_id: renault_id, name: 'Kwid' },
  { brand_id: renault_id, name: 'Fluence' },
  { brand_id: renault_id, name: 'Logan' },
  { brand_id: renault_id, name: 'Master' },
  { brand_id: renault_id, name: 'Duster' },
  { brand_id: renault_id, name: 'Duster Oroch' },
  { brand_id: renault_id, name: 'C' },
  { brand_id: renault_id, name: 'D WIDE' },
  { brand_id: renault_id, name: 'K' },
  { brand_id: renault_id, name: 'T' },
  { brand_id: renault_id, name: 'T Robust' },
  { brand_id: renault_id, name: 'T 01 Racing' },
  { brand_id: renault_id, name: 'T X-Road' },
  { brand_id: renault_id, name: 'T Selection' },
  { brand_id: renault_id, name: 'T High' }
]
renault_attributes.each { |attributes| Model.find_or_create_by(attributes) }

mercedes_id = Brand.find_or_create_by(name: 'Mercedes Benz').id
mercedes_attributes = [
  { brand_id: mercedes_id, name: 'Vito' },
  { brand_id: mercedes_id, name: 'Sprinter' },
  { brand_id: mercedes_id, name: 'Accelo' },
  { brand_id: mercedes_id, name: 'Atero' },
  { brand_id: mercedes_id, name: 'Actros' },
  { brand_id: mercedes_id, name: 'Axos' },
  { brand_id: mercedes_id, name: 'Arocs' }
]
mercedes_attributes.each { |attributes| Model.find_or_create_by(attributes) }

vw_id = Brand.find_or_create_by(name: 'Volkswagen').id
vw_attributes = [
  { brand_id: vw_id, name: 'Polo' },
  { brand_id: vw_id, name: 'Virtus' },
  { brand_id: vw_id, name: 'Voyage' },
  { brand_id: vw_id, name: 'Amarok' },
  { brand_id: vw_id, name: 'Amarok V6' },
  { brand_id: vw_id, name: 'Saveiro' },
  { brand_id: vw_id, name: 'Delivery 6.160' },
  { brand_id: vw_id, name: 'Delivery 9.170' },
  { brand_id: vw_id, name: 'Delivery 11.180' },
  { brand_id: vw_id, name: 'Constellation 14.190 Robust' },
  { brand_id: vw_id, name: 'Constellation 17.230 Robust' },
  { brand_id: vw_id, name: 'Constellation 17.280' },
  { brand_id: vw_id, name: 'Constellation 19.330' },
  { brand_id: vw_id, name: 'Constellation 24.280 6x2' },
  { brand_id: vw_id, name: 'Constellation 24.280 6x4' },
  { brand_id: vw_id, name: 'Constellation 31.280 6x4' },
  { brand_id: vw_id, name: 'Constellation 31.330 6x4' },
  { brand_id: vw_id, name: 'Constellation 32.360 VTronic' },
  { brand_id: vw_id, name: 'Constellation 17.280 Tractor' },
  { brand_id: vw_id, name: 'Constellation 19.360' },
  { brand_id: vw_id, name: 'Constellation 25.360' },
  { brand_id: vw_id, name: 'Meteor 28.460' },
  { brand_id: vw_id, name: 'Volksbus 9.160 OD' }
]
vw_attributes.each { |attributes| Model.find_or_create_by(attributes) }

ford_id = Brand.find_or_create_by(name: 'Ford').id
ford_attributes = [
  { brand_id: ford_id, name: 'Maverick' },
  { brand_id: ford_id, name: 'Ranger' },
  { brand_id: ford_id, name: 'Transit Chasis' },
  { brand_id: ford_id, name: 'Transit Van' },
  { brand_id: ford_id, name: 'Transit Minibus' },
  { brand_id: ford_id, name: 'Ka +' },
  { brand_id: ford_id, name: 'Cargo C916' },
  { brand_id: ford_id, name: 'Cargo C1119' },
  { brand_id: ford_id, name: 'Cargo C1519' },
  { brand_id: ford_id, name: 'Cargo C1723' },
  { brand_id: ford_id, name: 'Cargo C1729' },
  { brand_id: ford_id, name: 'Cargo C1933' },
  { brand_id: ford_id, name: 'Cargo C3129' }
]
ford_attributes.each { |attributes| Model.find_or_create_by(attributes) }

chevrolet_id = Brand.find_or_create_by(name: 'Chevrolet').id
chevrolet_attributes = [
  { brand_id: chevrolet_id, name: 'S10' },
  { brand_id: chevrolet_id, name: 'Classic' },
  { brand_id: chevrolet_id, name: 'Prisma' },
  { brand_id: chevrolet_id, name: 'Onix Plus' },
  { brand_id: chevrolet_id, name: 'Joy Plus' },
  { brand_id: chevrolet_id, name: 'Spin' },
  { brand_id: chevrolet_id, name: 'Montona' }
]
chevrolet_attributes.each { |attributes| Model.find_or_create_by(attributes) }

toyota_id = Brand.find_or_create_by(name: 'Toyota').id
toyota_attributes = [
  { brand_id: toyota_id, name: 'Hilux' },
  { brand_id: toyota_id, name: 'Corolla' },
  { brand_id: toyota_id, name: 'Yaris' },
  { brand_id: toyota_id, name: 'Etios' }
]
toyota_attributes.each { |attributes| Model.find_or_create_by(attributes) }

nissan_id = Brand.find_or_create_by(name: 'Nissan').id
iveco_id = Brand.find_or_create_by(name: 'Iveco').id
volvo_id = Brand.find_or_create_by(name: 'Volvo').id
scania_id = Brand.find_or_create_by(name: 'Scania').id
hyundai_id = Brand.find_or_create_by(name: 'Hyundai').id
baic_id = Brand.find_or_create_by(name: 'Baic').id
changan_id = Brand.find_or_create_by(name: 'Changan').id
foton_id = Brand.find_or_create_by(name: 'Foton').id
dfsk_id = Brand.find_or_create_by(name: 'DFSK').id
chery_id = Brand.find_or_create_by(name: 'Chery').id

# Repuestos
skf_id = Brand.find_or_create_by(name: 'SKF')
bosch_id = Brand.find_or_create_by(name: 'Bosch')
gm_id = Brand.find_or_create_by(name: 'GM')
acdelco_id = Brand.find_or_create_by(name: 'ACDelco')
valeo_id = Brand.find_or_create_by(name: 'Valeo')
vic_id = Brand.find_or_create_by(name: 'VIC')
taranto_id = Brand.find_or_create_by(name: 'Taranto')
mm_id = Brand.find_or_create_by(name: 'Magneti Marelli')
philips_id = Brand.find_or_create_by(name: 'Philips')
mahle_id = Brand.find_or_create_by(name: 'Mahle')