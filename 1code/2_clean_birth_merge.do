**********************************************************************************
*Programmers: Daniel Dench & Mayra Pineda-Torres								 *
*Date: 10/02/2023								                    			 *
*Purpose: Program to append birth datasets imported from raw files				 *		 
*																				 *
*								 												 *
**********************************************************************************


cd C:\ddmpt_nchs\01data\


import excel using Dobbs_data.xlsx, firstrow clear




*1-primary treatment, the dobbs ban states, 2-primary control, expanded or left abortion regulation unchanged, 3-hostile to abortion but did not implement a gestational age ban in the time-period of analysing treatment effects in first year, 0-Changed gestational age limit in primary time-period of analysing treatment effects.
tab keep
destring State_fips, generate(state_fips_res)
keep keep state_fips_res States
tempfile dobbs_data
save `dobbs_data'


*Appending Natality Data
tempfile state_col
use "NAT_2005.dta", clear
generate birth=1
collapse (sum) birth, by( mbstate year mob state_fips_res county_fips_res mrace mhispanic mager) 
save `state_col', replace


forvalues i=2006(1)2022{
use "C:\ddmpt_nchs\01data\NAT_`i'.dta"
generate birth=1
collapse (sum) birth, by(mbstate  year mob state_fips_res county_fips_res mrace mhispanic mager) 
append using `state_col'
save `state_col', replace
}


*Code race/ethnicity
generate racehisp=1 if mrace==1 & mhispanic==2
replace racehisp=2 if mrace==2 & mhispanic==2
replace racehisp=3 if mhispanic==1
replace racehisp=4 if racehisp==.





*Code age group
generate age_group=1 if mager>=15 & mager<=19
replace age_group=2 if mager>=20 & mager<=24
replace age_group=3 if mager>=25 & mager<=29
replace age_group=4 if mager>=30

keep if mager<=44 & mager>=15



*We may want to do estimates for US born, during the covid period some immigrants were excluded coming to the US. 
generate usborn=1 if mbstate=="AK"
replace usborn=1 if mbstate=="AL"
replace usborn=1 if mbstate=="AR"
replace usborn=1 if mbstate=="AZ"
replace usborn=1 if mbstate=="CA"
replace usborn=1 if mbstate=="CO"
replace usborn=1 if mbstate=="CT"
replace usborn=1 if mbstate=="DC"
replace usborn=1 if mbstate=="DE"
replace usborn=1 if mbstate=="FL"
replace usborn=1 if mbstate=="GA"
replace usborn=1 if mbstate=="HI"
replace usborn=1 if mbstate=="IA"
replace usborn=1 if mbstate=="ID"
replace usborn=1 if mbstate=="IL"
replace usborn=1 if mbstate=="IN"
replace usborn=1 if mbstate=="KS"
replace usborn=1 if mbstate=="KY"
replace usborn=1 if mbstate=="LA"
replace usborn=1 if mbstate=="MA"
replace usborn=1 if mbstate=="MD"
replace usborn=1 if mbstate=="ME"
replace usborn=1 if mbstate=="MI"
replace usborn=1 if mbstate=="MN"
replace usborn=1 if mbstate=="MO"
replace usborn=1 if mbstate=="MS"
replace usborn=1 if mbstate=="MT"
replace usborn=1 if mbstate=="NC"
replace usborn=1 if mbstate=="ND"
replace usborn=1 if mbstate=="NE"
replace usborn=1 if mbstate=="NH"
replace usborn=1 if mbstate=="NJ"
replace usborn=1 if mbstate=="NM"
replace usborn=1 if mbstate=="NV"
replace usborn=1 if mbstate=="NY"
replace usborn=1 if mbstate=="OH"
replace usborn=1 if mbstate=="OK"
replace usborn=1 if mbstate=="OR"
replace usborn=1 if mbstate=="PA"
replace usborn=1 if mbstate=="RI"
replace usborn=1 if mbstate=="SC"
replace usborn=1 if mbstate=="SD"
replace usborn=1 if mbstate=="TN"
replace usborn=1 if mbstate=="TX"
replace usborn=1 if mbstate=="UT"
replace usborn=1 if mbstate=="VA"
replace usborn=1 if mbstate=="VT"
replace usborn=1 if mbstate=="WA"
replace usborn=1 if mbstate=="WI"
replace usborn=1 if mbstate=="WV"
replace usborn=1 if mbstate=="WY"

*keep if usborn==1

*Pairing down to state for now. We talked about using county level data. I am more sanguine that much can be squeezed out of this. It will require using Poisson, we won't be able to use SDID as an alternate which makes interpreting changes in groups with poor pre-trends more difficult. SDID is the only new method approved at the top levels, AER, so I think we can use it without much worry of pushback from reviewers.
collapse (sum) birth, by( year state_fips_res mob racehisp age_group ) 

fillin state_fips_res year mob racehisp age_group
replace birth=0 if _fillin==1


*Summing by each population of interest at the state-year level
preserve
collapse (sum) birth*, by(state_fips_res year)
generate population="overall"
tempfile overall
save `overall'
restore

preserve
keep if age_group==1
collapse (sum) birth*, by(state_fips_res year)
generate population="1519"
tempfile 1519
save `1519'
restore

preserve
keep if age_group==2
collapse (sum) birth*, by(state_fips_res year)
generate population="2024"
tempfile 2024
save `2024'
restore

preserve
keep if age_group==3
collapse (sum) birth*, by(state_fips_res year)
generate population="2529"
tempfile 2529
save `2529'
restore

preserve
keep if age_group==4
collapse (sum) birth*, by(state_fips_res year)
generate population="30"
tempfile 30
save `30'
restore

preserve
keep if racehisp==1
collapse (sum) birth*, by(state_fips_res year)
generate population="white"
tempfile white
save `white'
restore

preserve
keep if racehisp==2
collapse (sum) birth*, by(state_fips_res year)
generate population="black"
tempfile black
save `black'
restore

preserve
keep if racehisp==3
collapse (sum) birth*, by(state_fips_res year)
generate population="hispanic"
tempfile hispanic
save `hispanic'
restore


***Appending birth data together.
clear
use `overall'
append using `1519'
append using `2024'
append using `2529'
append using `30'
append using `white'
append using `black'
append using `hispanic'
destring state_fips_res, replace

***Merging in population data
merge 1:1 state_fips_res year population using pop_estimates_yearly.dta


*Dropping births with no assigned residence, and years with no birth records.
keep if _merge==3

generate birth_rate=birth/popestimate_adjusted*1000
drop _merge

merge m:1 state_fips_res using `dobbs_data'

drop _merge

***Merging in unemployment data
merge m:1 state_fips_res year using "C:\ddmpt_nchs\01data\ue.dta"
drop if _merge==2
drop _merge
drop if (population=="black" | population=="white" | population=="hispanic") &  year<=2013


save birth_pop_dobbs_annual_2022_f.dta, replace


/*
preserve
keep if keep==1 | keep==2
generate treatment=year==2022 & keep==1
replace treatment=1 if States=="Texas" & year==2021
keep if population=="overall"
sdid_eventstudy birth_rate state_fips_res year treatment, reps(200)
mat list e(event_study)
restore
*/



***Creating a monthly version of the data for provisional data releases and shorter frequency data
***Appending provisional data for monthly counts***
import delimited "C:\ddmpt_nchs\01data\rawdata\provisional_count_data\VSRR_-_State_and_National_Provisional_Counts_for_Live_Births__Deaths__and_Infant_Deaths.csv", delimiter(comma) varnames(1) clear




keep if indicator=="Number of Live Births"
keep if period=="Monthly"

generate mob=1 if month=="January"
replace mob=2 if month=="February"
replace mob=3 if month=="March"
replace mob=4 if month=="April"
replace mob=5 if month=="May"
replace mob=6 if month=="June"
replace mob=7 if month=="July"
replace mob=8 if month=="August"
replace mob=9 if month=="September"
replace mob=10 if month=="October"
replace mob=11 if month=="November"
replace mob=12 if month=="December"


generate state_fips_res=1 if state=="ALABAMA"
replace state_fips_res=2 if state=="ALASKA"
replace state_fips_res=4 if state=="ARIZONA"
replace state_fips_res=5 if state=="ARKANSAS"
replace state_fips_res=6 if state=="CALIFORNIA"
replace state_fips_res=8 if state=="COLORADO"
replace state_fips_res=9 if state=="CONNECTICUT"
replace state_fips_res=10 if state=="DELAWARE"
replace state_fips_res=11 if state=="DISTRICT OF COLUMBIA"
replace state_fips_res=12 if state=="FLORIDA"
replace state_fips_res=13 if state=="GEORGIA"
replace state_fips_res=15 if state=="HAWAII"
replace state_fips_res=16 if state=="IDAHO"
replace state_fips_res=17 if state=="ILLINOIS"
replace state_fips_res=18 if state=="INDIANA"
replace state_fips_res=19 if state=="IOWA"
replace state_fips_res=20 if state=="KANSAS"
replace state_fips_res=21 if state=="KENTUCKY"
replace state_fips_res=22 if state=="LOUISIANA"
replace state_fips_res=23 if state=="MAINE"
replace state_fips_res=24 if state=="MARYLAND"
replace state_fips_res=25 if state=="MASSACHUSETTS"
replace state_fips_res=26 if state=="MICHIGAN"
replace state_fips_res=27 if state=="MINNESOTA"
replace state_fips_res=28 if state=="MISSISSIPPI"
replace state_fips_res=29 if state=="MISSOURI"
replace state_fips_res=30 if state=="MONTANA"
replace state_fips_res=31 if state=="NEBRASKA"
replace state_fips_res=32 if state=="NEVADA"
replace state_fips_res=33 if state=="NEW HAMPSHIRE"
replace state_fips_res=34 if state=="NEW JERSEY"
replace state_fips_res=35 if state=="NEW MEXICO"
replace state_fips_res=36 if state=="NEW YORK"
replace state_fips_res=37 if state=="NORTH CAROLINA"
replace state_fips_res=38 if state=="NORTH DAKOTA"
replace state_fips_res=39 if state=="OHIO"
replace state_fips_res=40 if state=="OKLAHOMA"
replace state_fips_res=41 if state=="OREGON"
replace state_fips_res=42 if state=="PENNSYLVANIA"
replace state_fips_res=44 if state=="RHODE ISLAND"
replace state_fips_res=45 if state=="SOUTH CAROLINA"
replace state_fips_res=46 if state=="SOUTH DAKOTA"
replace state_fips_res=47 if state=="TENNESSEE"
replace state_fips_res=48 if state=="TEXAS"
replace state_fips_res=49 if state=="UTAH"
replace state_fips_res=50 if state=="VERMONT"
replace state_fips_res=51 if state=="VIRGINIA"
replace state_fips_res=53 if state=="WASHINGTON"
replace state_fips_res=54 if state=="WEST VIRGINIA"
replace state_fips_res=55 if state=="WISCONSIN"
replace state_fips_res=56 if state=="WYOMING"
drop if state_fips_res==.

tostring state_fips_res, replace
replace state_fips_res="0"+state_fips_res if length(state_fips_res)==1

*Keep relevant data
keep year mob state_fips_res datavalue
rename datavalue birth
collapse (sum) birth, by(state_fips_res year mob)
keep if year>=2023

tempfile state_2023
save `state_2023'

***Appending Natality Data***
tempfile state_col
use "NAT_2005.dta", clear
generate birth=1
collapse (sum) birth, by( mbstate year mob state_fips_res county_fips_res mrace mhispanic mager) 
save `state_col', replace


forvalues i=2006(1)2022{
use "C:\ddmpt_nchs\01data\NAT_`i'.dta"
generate birth=1
collapse (sum) birth, by(mbstate  year mob state_fips_res county_fips_res mrace mhispanic mager) 
append using `state_col'
save `state_col', replace
}


*Code race/ethnicity
generate racehisp=1 if mrace==1 & mhispanic==2
replace racehisp=2 if mrace==2 & mhispanic==2
replace racehisp=3 if mhispanic==1
replace racehisp=4 if racehisp==.





*Code age group
generate age_group=1 if mager>=15 & mager<=19
replace age_group=2 if mager>=20 & mager<=24
replace age_group=3 if mager>=25 & mager<=29
replace age_group=4 if mager>=30

keep if mager<=44 & mager>=15



*We may want to do estimates for US born, during the covid period some immigrants were excluded coming to the US. 
generate usborn=1 if mbstate=="AK"
replace usborn=1 if mbstate=="AL"
replace usborn=1 if mbstate=="AR"
replace usborn=1 if mbstate=="AZ"
replace usborn=1 if mbstate=="CA"
replace usborn=1 if mbstate=="CO"
replace usborn=1 if mbstate=="CT"
replace usborn=1 if mbstate=="DC"
replace usborn=1 if mbstate=="DE"
replace usborn=1 if mbstate=="FL"
replace usborn=1 if mbstate=="GA"
replace usborn=1 if mbstate=="HI"
replace usborn=1 if mbstate=="IA"
replace usborn=1 if mbstate=="ID"
replace usborn=1 if mbstate=="IL"
replace usborn=1 if mbstate=="IN"
replace usborn=1 if mbstate=="KS"
replace usborn=1 if mbstate=="KY"
replace usborn=1 if mbstate=="LA"
replace usborn=1 if mbstate=="MA"
replace usborn=1 if mbstate=="MD"
replace usborn=1 if mbstate=="ME"
replace usborn=1 if mbstate=="MI"
replace usborn=1 if mbstate=="MN"
replace usborn=1 if mbstate=="MO"
replace usborn=1 if mbstate=="MS"
replace usborn=1 if mbstate=="MT"
replace usborn=1 if mbstate=="NC"
replace usborn=1 if mbstate=="ND"
replace usborn=1 if mbstate=="NE"
replace usborn=1 if mbstate=="NH"
replace usborn=1 if mbstate=="NJ"
replace usborn=1 if mbstate=="NM"
replace usborn=1 if mbstate=="NV"
replace usborn=1 if mbstate=="NY"
replace usborn=1 if mbstate=="OH"
replace usborn=1 if mbstate=="OK"
replace usborn=1 if mbstate=="OR"
replace usborn=1 if mbstate=="PA"
replace usborn=1 if mbstate=="RI"
replace usborn=1 if mbstate=="SC"
replace usborn=1 if mbstate=="SD"
replace usborn=1 if mbstate=="TN"
replace usborn=1 if mbstate=="TX"
replace usborn=1 if mbstate=="UT"
replace usborn=1 if mbstate=="VA"
replace usborn=1 if mbstate=="VT"
replace usborn=1 if mbstate=="WA"
replace usborn=1 if mbstate=="WI"
replace usborn=1 if mbstate=="WV"
replace usborn=1 if mbstate=="WY"

*keep if usborn==1

*Pairing down to state for now. 
collapse (sum) birth, by( year state_fips_res mob racehisp age_group ) 

fillin state_fips_res year mob racehisp age_group
replace birth=0 if _fillin==1


*Overall event study specifications code
preserve
collapse (sum) birth*, by(state_fips_res year mob)
append using `state_2023'
generate population="overall"
tempfile overall
save `overall'
restore

preserve
keep if age_group==1
collapse (sum) birth*, by(state_fips_res year mob)
generate population="1519"
tempfile 1519
save `1519'
restore

preserve
keep if age_group==2
collapse (sum) birth*, by(state_fips_res year mob)
generate population="2024"
tempfile 2024
save `2024'
restore

preserve
keep if age_group==3
collapse (sum) birth*, by(state_fips_res year mob)
generate population="2529"
tempfile 2529
save `2529'
restore

preserve
keep if age_group==4
collapse (sum) birth*, by(state_fips_res year mob)
generate population="30"
tempfile 30
save `30'
restore

preserve
keep if racehisp==1
collapse (sum) birth*, by(state_fips_res year mob)
generate population="white"
tempfile white
save `white'
restore

preserve
keep if racehisp==2
collapse (sum) birth*, by(state_fips_res year mob)
generate population="black"
tempfile black
save `black'
restore

preserve
keep if racehisp==3
collapse (sum) birth*, by(state_fips_res year mob)
generate population="hispanic"
tempfile hispanic
save `hispanic'
restore

clear
use `overall'
append using `1519'
append using `2024'
append using `2529'
append using `30'
append using `white'
append using `black'
append using `hispanic'
destring state_fips_res, replace

merge 1:1 state_fips_res year mob population  using pop_estimates_monthly.dta


*Dropping births with no assigned residence, and years with no birth records and merging in unemployment data.
keep if _merge==3

generate birth_rate=birth/popestimate_adjusted*1000
drop _merge

merge m:1 state_fips_res using `dobbs_data'
drop if _merge==2
drop _merge

merge m:1 state_fips_res year using "C:\ddmpt_nchs\01data\ue.dta"
drop if _merge==2
drop _merge

merge m:1 state_fips_res year using "C:\ddmpt_nchs\01data\ue3.dta"
drop if _merge==2
drop _merge

merge m:1 state_fips_res year using "C:\ddmpt_nchs\01data\ue6.dta"
drop if _merge==2
drop _merge


merge m:1 state_fips_res year using "C:\ddmpt_nchs\01data\ue9.dta"
drop if _merge==2
drop _merge

drop if (population=="black" | population=="white" | population=="hispanic") &  year<=2013

*Saving monthly version of birth rates data
save birth_pop_dobbs_monthly_2023Q1_f.dta, replace


