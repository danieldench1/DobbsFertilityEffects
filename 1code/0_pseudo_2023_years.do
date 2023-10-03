**********************************************************************************
*Programmers: Daniel Dench & Mayra Pineda-Torres								 *
*Date: 01/16/2023								                    			 *
*Purpose: Creates pseudo years to be able to program for 2023 analysis when 	 *	 
*		data comes in															 *
*								 												 *
**********************************************************************************

cd C:\ddmpt_nchs\01data\

*This will be replace with the final dataset at the end. For now I am estimating by month cohort (first 3-months of )
use birth_pop_dobbs_annual_2022_f.dta, clear

set seed 4289
keep if year==2022
replace year=2023
mean birth_rate
replace birth=rnormal(0,1)*0.01*birth+birth
replace birth_rate=1000*birth/popestimate_adjusted

mean birth_rate

save pseudo_NAT_2023.dta, replace



cd C:\ddmpt_nchs\01data\

*This will be replace with the final dataset at the end. For now I am estimating by month cohort (first 3-months of )
use birth_pop_dobbs_monthly_2023Q1_f.dta, clear
keep if year==2022

set seed 0328

replace year=2023
mean birth_rate
replace birth=rnormal(0,1)*0.01*birth+birth
replace birth_rate=1000*birth/popestimate_adjusted

mean birth_rate

save pseudo_NAT_2023_monthly.dta, replace


