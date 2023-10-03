/**************************************************************************
 |                                                                     
 |      CREATES ANNUAL NATALITY DETAIL FILES IN STATA FORMAT, 2014-2015
 |		Last updated: October 3, 2019 by Caitlin Myers
 |
 **************************************************************************/

/**************************************************************************
 |
 |	Source: 1980-1988 Downloaded from NCHS Vital Statistics online
 |          1989-2018 Confidential data obtained from the NCHS via NAPHSIS
 |			Citation:
 |  		"National Center for Health Statistics. Natality- All County files, 1980-2015, 
 |  		as compiled from data provided by the 57 vital statistics jurisdictions through the Vital Statistics Cooperative Program."
 |
 |  
 |			U.S. Standard Certificate of Live Birth revisions / versions and notes
 |			------------------------------------------------------------
 |			1978-1988  HRA-161 Rev 1/78
 |					   FIPS codes are not available in 1980-1981, only NCHS geo codes
 |					   From 1980-1984 a handful of states were based on a 50% sample
 |					   The variable "weight" is equal to 2 for observations from these states
 |					   From 1985 natality statistics are based on information from the total file of records
 |			1989-2002  1989 revision
 |					   This revision added Hispanic ethnicity as well as other measures of maternal and infant health
 |				       		Hispanic origin (ormoth) not reported by all states until 1992.  See imputation flag. 
 |						    (LA did not report in 1989, OK in 1989-1990, NH in 1989-1992) 
 |							Mother's education not reported by all states until 1992.  See imputation flag.
 |							Maternal and infant health not reported by all states.  See imputation flags.
 |			2003-2013       2003 revision
 |							Staggered implementation.  and multiple changes to file formats
 |							Alcohol info no longer available
 |							Adequacy no longer available
 |							WIC Added
 | 							Education revised; not able to perfectly reconcile with previous version of question
 |							Key items that the NCHS does not consider to be comparable between birth certificate revisions and 
 |							that were reported on the unrevised forms were removed from the data files beginning in 2011
 |			2014-2015		Changes to data locations.  Maintain some harmonized variables in positions 13*
 |			2016-2018		Adoption of 2003 Revision complete.  Harmonized variables in positions 13* dropped
 ****************************************************************************/

clear 
set more off 
cd "C:\ddmpt_nchs\01data"

********************
*Globals and labels*
********************

label drop _all

label define yesno 		1 "Yes" 2 "No" 9 "Unknown"

label define weekday 	1 "Sunday" 2 "Monday" 3 "Tuesday" 4 "Wednesday" 5 "Thursday" 6 "Friday" 7 "Saturday"

label define pldel 		1 "Hospital" 2 "Freestanding birthing center" 3 "Clinic or doctor's office" 4 "A residence" 5 "Other" 9 "Unknown"

label define birattnd   1 "M.D." 2 "D.O." 3 "C.N.M." 4 "Other midwife" 5 "Other" 9 "Unknown or not stated"

label define pay_rec	1 "Medicaid" 2 "Private insurance" 3 "Self-pay" 4 "Other" 9 "Unknown"

label define mrace3     1 "White" 2 "Black" 3 "Other" 9 "Unknown or not stated" /*Note re-code below*/

label define meduc6 	1 "0-8 years" 2 "9-11 years" 3 "12 years" 4 "13-15 years" 5 "16 years plus" 6 "Not stated"

label define meduc 		1 "<=8th grade" 2 "9-12th, nodiploma" 3 "high school diploma or GED" 4 "Some college" 5 "Associate degree" 6 "Bachelor's degree" 7 "Master's degree" 8 "Doctorate" 9 "Unknown"

label define marital 	1 "Married" 2 "Unmarried"

label define marital_imputed 1 "imputed"

label define num_births	8 "8 or more" 9 "Unknown"

label define ciglab		99 "Unknown"

label define bmi		999 "Unknown"

label define wtgain		99 "Unknown"

label define monpre 	0 "No prenatal care" 9 "9th month or later" 99 "Unknown"

label define nprevis 	0 "No prenatal care" 49 "49 or more visits" 99 "Unknown"

label define sex 		1 "Male" 2 "Female"

label define plurality  1 "Single" 2 "Twin" 3 "Triplet" 4 "Quadruplet" 5 "Quintuplet or more"

label define dmeth_rec 	1 "Vaginal" 2 "C-section" 9 "Unknown"

label define bwgt		9999 "Unkown"

***********
*2016-2018*
***********

forvalues i=2016(1)2021{

# delimit ;
infix 
/*When*/
year 						9-12
mob 						13-14
weekday  					23
/*Where*/
str postal_code_occurence 	24-25
str county_occ_fips 		28-30
str postal_code_residence 	89-90 
str county_fips 			91-93
pldel 						32
birattnd 					433
pay_rec 					436
/*Mother*/
mager 						75-76 
str mbstate					82-83
ormoth 						115
mrace 						110
meduc 						124
marital_imputed 			121
marital 					120
num_births 					182
str wic						251
cig_0 						253-254
cig_1 						255-256
cig_2 						257-258
cig_3 						259-260
bmi 						283-286
wtgain 						304-305
/*Father*/
fagecomb 					147-148
orfath 						160
frace3 						156
feduc 						163
/*Infant*/
str sex 					475
birthweight 				504-507
combgest					490-491
dgestat 					499-500
plurality 					454
apgar5 						444-445
str ilive 					568
str bfed 					569
/*Prenatal care*/
precare 					224-225
nprevis 					238-239
/*Revised Medical Risk Factors*/
str rrf_diab				313
str rrf_gest				314
str rrf_phyp				315
str rrf_ghyp				316
str rrf_eclam				317
str rrf_ppterm				318
str rrf_inftr				325
/*Obstetric procedure*/
um_route					402
dmeth_rec 					408
str op_induct				383
using "NATL`i'US.AllCnty.txt", clear;


# delimit cr

*label data "Natality Detail File, `i': [United States]"

/*When*/
drop if year==.
assert year==`i' /*Just checking*/
label variable year "Year child born"
label variable mob "Month child born"
label variable weekday "Day of week child born"
label values weekday weekday

/*Where*/
*****State of occurence name*****
rename postal_code_occurence postal_code
merge m:1 postal_code using "state identifiers.dta", keep(1 3) nogen keepusing(state_name fips_code)
rename state_name state_name_occ
drop postal_code
label variable state_name_occ "State of occurence name"

rename fips_code state_fips_occ

*****County of occurrence*****
gen zero="0"
tostring state_fips_occ, replace
tab state_fips_occ
codebook state_fips_occ
gen lenstate = length(state_fips_occ)
tab lenstate
egen state_occ = concat(zero state_fips_occ) if lenstate == 1
replace state_occ = state_fips_occ if lenstate == 2
codebook state_occ
drop lenstate zero


codebook county_occ_fips
gen lencounty = length(county_occ_fips)
tab lencounty
drop lencounty

*Fips code county of occurrence
egen fips_code = concat(state_occ county_occ_fips)

merge m:1 fips_code using "county identifiers.dta", keep(1 3)

tab fips_code if _merge == 1
drop _merge

*Filling in a few county names that were not present in 2010 census
replace county_name="Dade County (FL)" if fips_code=="12025" /*Dade County is renamed Miami-Dade County and renumbered 12086 in 1997*/
replace county_name="Shannon County (SD)" if fips_code=="46113"  /*Shannon County is renamed Oglala Lakota County (46102) in 2015*/
replace county_name="Bedford City (VA)" if fips_code=="51515" /*Bedford City merged with Bedford County in 2013*/
replace county_name="Clifton Forge City (VA)" if fips_code=="51560" /*Clifoton Force city merged with Alleghany county in 2001*/
replace county_name="South Boston City (VA)" if fips_code=="51780" /*South Boston City merged with Halifax County in 1995*/
replace county_name="Aleutian Islands Census Area (AK)" if fips_code=="02010" /*Split in 1987*/
replace county_name="Kobuk Census Area (AK)" if fips_code=="02140" /*Merged 1986*/
replace county_name="Skagway-Yakutat-Angood Census Area (AK)" if fips_code=="02231" /*Split 1992*/
replace county_name="Prince of Wales-Hyder Census Area (AK)" if fips_code=="02201" /*Created in 2008*/
replace county_name="Skagway-Hoonah-Angoon Census Area (AK)" if fips_code=="02232" /*Split in 2007*/
replace county_name="Wade Hampton Census Area (AK)" if fips_code=="02270" /*Renamed 2015*/
replace county_name="Wrangell-Petersburg Census Area (AK)" if fips_code=="02280" /*Split in 2008*/
*assert county_name!=""

rename county_name county_name_occ
rename fips_code county_fips_occ

*****County of residence fips_code*****
rename postal_code_residence postal_code
merge m:1 postal_code using "state identifiers.dta", assert(1 3) keep(3) nogen keepusing(fips_code state_name)
tostring fips_code, gen(state_fips) format(%02.0f)
drop fips_code
generate fips_code=state_fips+county_fips
drop county_fips postal_code
rename state_fips state_fips_res
label variable fips_code "County of residence FIPS code"
label variable state_name "State of residence name"
rename state_name state_name_res

*County of residence name
merge m:1 fips_code using "county identifiers.dta", keep(1 3) nogen keepusing(county_name)
/*Filling in a few county names that were not present in 2010 census*/
replace county_name="Dade County (FL)" if fips_code=="12025" /*Dade County is renamed Miami-Dade County and renumbered 12086 in 1997*/
replace county_name="Shannon County (SD)" if fips_code=="46113"  /*Shannon County is renamed Oglala Lakota County (46102) in 2015*/
replace county_name="Bedford City (VA)" if fips_code=="51515" /*Bedford City merged with Bedford County in 2013*/
replace county_name="Clifton Forge City (VA)" if fips_code=="51560" /*Clifoton Force city merged with Alleghany county in 2001*/
replace county_name="South Boston City (VA)" if fips_code=="51780" /*South Boston City merged with Halifax County in 1995*/
replace county_name="Aleutian Islands Census Area (AK)" if fips_code=="02010" /*Split in 1987*/
replace county_name="Kobuk Census Area (AK)" if fips_code=="02140" /*Merged 1986*/
replace county_name="Skagway-Yakutat-Angood Census Area (AK)" if fips_code=="02231" /*Split 1992*/
replace county_name="Prince of Wales-Hyder Census Area (AK)" if fips_code=="02201" /*Created in 2008*/
replace county_name="Skagway-Hoonah-Angoon Census Area (AK)" if fips_code=="02232" /*Split in 2007*/
replace county_name="Wade Hampton Census Area (AK)" if fips_code=="02270" /*Renamed 2015*/
replace county_name="Wrangell-Petersburg Census Area (AK)" if fips_code=="02280" /*Split in 2008*/
assert county_name!=""

rename county_name county_name_res
rename fips_code county_fips_res

label variable pldel "Place or facility of birth recode"
label values pldel pldel
label variable birattnd "Attendant at birth"
label values birattnd birattnd
label variable pay_rec "Payment source"
label values pay_rec pay_rec

/*Mother*/
label variable mage "Mother's age in single years"
generate mhispanic=1 if ormoth>=1 & ormoth<=5
replace mhispanic=2 if ormoth==0
replace mhispanic=9 if ormoth==9
label values mhispanic yesno
label variable mhispanic "Mother Hispanic"
drop ormoth
recode mrace (1=1) (2=2) (3=3) (4=3) /*To be consistent with earlier years*/
label values mrace mrace3
label variable mrace "Mother's race"
order mhispanic, after(mrace)
label variable meduc "Mother's education; 2003 revision"
label values meduc meduc
label variable marital "Marital status of mother"
label values marital marital
label variable marital_imputed "Imputation flag for marital status"
label values marital_imputed marital_imputed
label variable num_births "Total birth order recode"
label values num_births num_births
label variable wic "WIC"
replace wic="1" if wic=="Y"
replace wic="2" if wic=="N"
replace wic="9" if wic=="U"
destring wic, replace
label values wic yesno
label variable cig_0 "Average number of cigarettes per day before pregnant; 2003 revision"
forvalues k=1(1)3{
	label variable cig_`k' "Average number of cigarettes per day during trimester `i'; 2003 revision"
}
forvalues k=0(1)3{
	label values cig_`k' ciglab
}
label variable wtgain "Weight gain during pregnancy"
label values wtgain wtgain
label variable bmi "Pre-pregnancy BMI"
replace bmi=999 if bmi==99.9
label values bmi bmi


/*Father*/
label variable fage "Father's age in single years"
label values fage ciglab
generate fhispanic=1 if orfath>=1 & orfath<9
replace fhispanic=2 if orfath==0
replace fhispanic=9 if orfath==9
label variable fhispanic "Father Hispanic"
label values fhispanic yesno
drop orfath
recode frace (1=1) (2=2) (3=3) (4=3) (9=9)
label values frace mrace3
label variable frace "Father's race"
order fhispanic, after(frace)
label variable feduc "Father's education; 2003 revision"
label values feduc meduc

/*Infant*/ 
replace sex="1" if sex=="M"
replace sex="2" if sex=="F"
destring sex, replace
label variable sex "Sex of child"
label values sex sex
label variable birthweight "Birthweight in grams"
label values birthweight bwgt
label variable dgestat "Gestation detail in weeks"
label values dgestat 
label variable plurality "Plurality of birth"
label values plurality plurality
label variable apgar "Five minute Apgar score (not reported by all areas, see flag)"
label values apgar ciglab
label variable ilive "Infant living at time of report"
label variable bfed "Infant being breastfed"
foreach var in ilive bfed{
	replace `var'="1" if `var'=="Y"
	replace `var'="2" if `var'=="N"
	replace `var'="9" if `var'=="U"
	destring `var', replace
	label values `var' yesno
}

/*Obstetric procedures*/
label variable precare "Month of pregnancy prenatal care began"
label values precare prenatal
label variable nprevis "Total number of prenatal visits"
label values nprevis nprevis
label variable dmeth_rec "Method of delivery recode"
label values dmeth_rec delmeth
gen forceps=1 if um_route==2
replace forceps=2 if um_route!=2
replace forceps=9 if um_route==9
label variable forceps "Forceps used"
gen vacuum=1 if um_route==3
replace vacuum=2 if um_route<3|(um_route==4)
replace vacuum=9 if um_route==9
label variable vacuum "Vacuum used"
label values forceps yesno
label values vacuum yesno
drop um_route
order forceps vacuum, after(dmeth_rec)
label variable op_induct "Obstetric procedures: Induction of labor"
foreach var in op_induct{
	replace `var'="1" if `var'=="Y"
	replace `var'="2" if `var'=="N"
	replace `var'="9" if `var'=="U"
	destring `var', replace
	label values `var' yesno
}

/*Medical Risk Factors*/
label variable rrf_diab "Revised Medical Risk Factor: Pre-pregnancy diabetes"
label variable rrf_gest "Revised Medical Risk Factor: Gestational diabetes"
label variable rrf_phyp  "Revised Medical Risk Factor: Pre-pregnancy hypertension"
label variable rrf_ghyp "Revised Medical Risk Factor: Gestational hypertension"
label variable rrf_eclam "Revised Medical Risk Factor: Eclampsia"
label variable rrf_ppterm "Revised Medical Risk Factor: Previous pre-term birth"
label variable rrf_inftr "Revised Medical Risk Factor: Infertility treatment used"
foreach var in rrf_diab rrf_gest rrf_phyp rrf_ghyp rrf_eclam rrf_ppterm rrf_inftr{
	replace `var'="1" if `var'=="Y"
	replace `var'="2" if `var'=="N"
	replace `var'="9" if `var'=="U"
	destring `var', replace
	label values `var' yesno
}

gen revision=2003
order revision, after(year)

save "NAT_`i'.dta", replace 
}





