PROC IMPORT DATAFILE ='/home/u39210004/Marvin/Data Analytics and Interpretation/foo.csv' OUT = new REPLACE;
PROC Sort; by ground_floor_type_v; 


ods graphics on;
proc surveyselect data=new out=traintest seed=123 samprate=0.8 method=srs outall;
run;  

proc glmselect data=traintest plots=all seed=123;
partition ROLE=selected(train='1' test='0'); 
class damage_grade foundation_type_r ground_floor_type_v HSSMMS roof_type_x HSSCMB;
model damage_grade=foundation_type_r ground_floor_type_v HSSMMS roof_type_x HSSCMB  / selection=lar(choose=cv stop=none) cvmethod=random(10);
run; 

proc freq;tables foundation_type_r ground_floor_type_v HSSMMS roof_type_x HSSCMB; run;
proc print; var foundation_type_r; run;

proc gchart; vbar foundation_type_r/discrete TYPE=mean SUMVAR=damage_grade;
proc gchart; vbar ground_floor_type_v/discrete TYPE= mean SUMVAR=damage_grade;
proc gchart; vbar HSSMMS/discrete TYPE=mean SUMVAR= damage_grade;
proc gchart; vbar roof_type_x/discrete TYPE=mean SUMVAR= damage_grade;
proc gchart; vbar HSSCMB/discrete TYPE=mean SUMVAR=damage_grade;


proc freq; tables damage_grade*foundation_type_r/chisq; by ground_floor_type_v;
proc freq; tables damage_grade*ground_floor_type_v/chisq;
proc freq; tables damage_grade*HSSMMS/chisq;
proc freq; tables damage_grade*roof_type_x/chisq;
proc freq; tables damage_grade*HSSCMB/chisq;



proc glmselect data=traintest plots=all seed=123;
partition ROLE=selected(train='1' test='0'); 
class damage_grade has_superstructure_adobe_mud HSSMMS 
 has_superstructure_stone_flag HSSCMS  HSSMMB HSSCMB has_superstructure_timber 
 has_superstructure_bamboo HSSRCNE has_superstructure_rc_engineered has_superstructure_other 
 count_families has_secondary_use has_secondary_use_agriculture has_secondary_use_hotel 
 has_secondary_use_rental has_secondary_use_institution has_secondary_use_school has_secondary_use_industry 
 has_secondary_use_health_post has_secondary_use_gov_office has_secondary_use_use_police has_secondary_use_other 
 land_surface_condition_n land_surface_condition_o land_surface_condition_t foundation_type_h foundation_type_i 
 foundation_type_r foundation_type_u foundation_type_w roof_type_n roof_type_q roof_type_x ground_floor_type_f 
 ground_floor_type_m ground_floor_type_v ground_floor_type_x ground_floor_type_z other_floor_type_j other_floor_type_q 
 other_floor_type_s other_floor_type_x position_j position_o position_s position_t plan_configuration_a plan_configuration_c 
 plan_configuration_d plan_configuration_f plan_configuration_m plan_configuration_n 
 plan_configuration_o plan_configuration_q plan_configuration_s plan_configuration_u 
 legal_ownership_status_a legal_ownership_status_r legal_ownership_status_v 
 legal_ownership_status_w;
model damage_grade=building_id geo_level_1_id geo_level_2_id geo_level_3_id count_floors_pre_eq
 age area_percentage height_percentage has_superstructure_adobe_mud HSSMMS 
 has_superstructure_stone_flag HSSCMS  HSSMMB HSSCMB has_superstructure_timber 
 has_superstructure_bamboo HSSRCNE has_superstructure_rc_engineered has_superstructure_other 
 count_families has_secondary_use has_secondary_use_agriculture has_secondary_use_hotel 
 has_secondary_use_rental has_secondary_use_institution has_secondary_use_school has_secondary_use_industry 
 has_secondary_use_health_post has_secondary_use_gov_office has_secondary_use_use_police has_secondary_use_other 
 land_surface_condition_n land_surface_condition_o land_surface_condition_t foundation_type_h foundation_type_i 
 foundation_type_r foundation_type_u foundation_type_w roof_type_n roof_type_q roof_type_x ground_floor_type_f 
 ground_floor_type_m ground_floor_type_v ground_floor_type_x ground_floor_type_z other_floor_type_j other_floor_type_q 
 other_floor_type_s other_floor_type_x position_j position_o position_s position_t plan_configuration_a plan_configuration_c 
 plan_configuration_d plan_configuration_f plan_configuration_m plan_configuration_n 
 plan_configuration_o plan_configuration_q plan_configuration_s plan_configuration_u 
 legal_ownership_status_a legal_ownership_status_r legal_ownership_status_v 
 legal_ownership_status_w / selection=lar(choose=cv stop=none) cvmethod=random(10);
run; 



 


