DROP TABLE IF EXISTS meter1;
CREATE TABLE meter1 (
    Date_Time				VARCHAR(25)
  , use_kW				REAL
  , gen_kW				REAL
  , FreshAirVentilation_kW		REAL
  , HousePanel_kW			REAL
  , LivingRoomReceptacles_kW		REAL
  , SecondFloorBathroom1_kW		REAL
  , WashingMachine_kW			REAL
  , Studies_amp_OutsideLighting_kW	REAL
  , DiningRoomReceptacles_kW		REAL
  , Basement_amp_HallLighting_kW	REAL
  , GuestHouseBathroom_kW		REAL
  , GuestHouseBedroom_kW		REAL
  , WorkshopReceptacleBathHeater_kW	REAL
  , GuestHouseKitchen1_kW		REAL
  , GuestHouseKitchen2_kW		REAL
  , GroundSourceHeatPump_kW		REAL
  , Photovoltaics_kW			REAL
  , WellPump_kW				REAL
  , Range_kW				REAL
  , SecondFloorBathroom2_kW		REAL
  , PanelReceptacles1_kW		REAL
  , KitchenReceptacles_kW		REAL
  , Microwave_kW			REAL
  , Refrigerator_kW			REAL
  , NetHousePowerUsage_kW		REAL
  , GarageReceptacles_amp_Lights_kW	REAL
  , GarageReceptacles_kW		REAL
  , ShedReceptacles_kW			REAL
  , ShedLights_kW			REAL
  , PanelReceptacles2_kW		REAL
  , GaragePV_kW				REAL
  , GuestHouseLivingRoom_kW		REAL
  , MasterBedroom_kW			REAL
  , HeatCirculatorPumps_kW		REAL
  , DomesticHotWaterReserve_kW		REAL
  , MasterBathroom_kW			REAL
  , KitchenIsland_kW			REAL
  , RadiantHeatReserveTank_kW		REAL
  , BasementReceptacles_kW		REAL
  , Dryer_kW				REAL
  , KitchenLighting_kW			REAL
  , GuestHouseDiningRoomRecept_kW	REAL
  , Porch_VerandaLighting_kW		REAL
) ENGINE=CONNECT table_type=CSV file_name='/mdb/Alldata/HomeD/2015/HomeD-meter1_2015.csv'
  header=1 sep_char=',' quoted=0; 
