**********************************************************************************
*Programmers: Daniel Dench & Mayra Pineda-Torres								 *
*Date: 10/02/2023								                    			 *
*Purpose: Program to run the Dobbs analysis                     				 *
* 		 																		 *		 
*																				 *
*								 												 *
**********************************************************************************

sysdir set PERSONAL "c:\ado\plus"
cd C:\ddmpt_nchs\01data\


set seed 50237

************Main Paper final analysis plan. We show average effects with five year event studies controlling for lagged unemployment*******************
use birth_pop_dobbs_annual_2022_f.dta, clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

*Figure 2-Showing results overall
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


*This shows 

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(Figure2.gph, replace)  aspect(0.5)
graph export Figure2.png, replace		 
restore




*Figure 3-Showing results by age
use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(Figure3a.gph, replace)  aspect(0.5)
graph export Figure3a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)

twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))   saving(Figure3b.gph, replace)  aspect(0.5)
graph export Figure3b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(Figure3c.gph, replace)  aspect(0.5)
graph export Figure3c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-5(1)5, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(Figure3d.gph, replace)  aspect(0.5)
graph export Figure3d.png, replace		 
		 
restore


*Figure 4-Showing results by race

use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(Figure4a.gph, replace)  aspect(0.5)
graph export Figure4a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(Figure4b.gph, replace)  aspect(0.5)
graph export Figure4b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(Figure4c.gph, replace)  aspect(0.5)
graph export Figure4c.png, replace		 
		 
restore






*Table 1-Panel A
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

esttab using table1a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black" "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace


*Panel B
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

esttab using table1b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of observations" "Control for unemplyoment rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black"  "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace



************Appendix figures part 1- These event studies present the same thing as the main paper but without control for unemployment*******************
use birth_pop_dobbs_annual_2022_f.dta, clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

*Figure A1
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA1.gph, replace)  aspect(0.5)
graph export FigureA1.png, replace		 
		 
restore




*Figure A2
use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA2a.gph, replace)  aspect(0.5)
graph export FigureA2a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA2b.gph, replace)  aspect(0.5)
graph export FigureA2b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA2c.gph, replace)  aspect(0.5)
graph export FigureA2c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-5(1)5, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA2d.gph, replace)  aspect(0.5)
graph export FigureA2d.png, replace		 
		 
restore


*Figure A3

use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA3a.gph, replace)  aspect(0.5)
graph export FigureA3a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA3b.gph, replace)  aspect(0.5)
graph export FigureA3b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA3c.gph, replace)  aspect(0.5)
graph export FigureA3c.png, replace		 
		 
restore






************Appendix set 2 final analysis plan. This set presents the same thing as the main paper but with an extended pre-period, 2005-2022*******************
use birth_pop_dobbs_annual_2022_f.dta, clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
generate treatment=treat==1 & year==2023

*Figure A4
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA4.gph, replace)  aspect(0.5)
graph export FigureA4.png, replace		 
		 
restore




*Figure A5 
use `analysis1', clear
keep if population=="1519"
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-10, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(10, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(5)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA5a.gph, replace)  aspect(0.5)
graph export FigureA5a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA5b.gph, replace)  aspect(0.5)
graph export FigureA5b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA5c.gph, replace)  aspect(0.5)
graph export FigureA5c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-5(1)5, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA5d.gph, replace)  aspect(0.5)
graph export FigureA5d.png, replace		 
		 
restore


*Figure A6
*White
*This will be replace with the final dataset at the end. For now I am estimating by month cohort (first 3-months of )
use birth_pop_dobbs_annual_2022_f.dta, clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'



keep if population=="white"


keep if year>=2014
generate treatment=treat==1 & year==2023

sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming



preserve
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA6a.gph, replace)  aspect(0.5)
graph export FigureA6a.png, replace		 
		 
restore



*White
*This will be replace with the final dataset at the end. For now I am estimating by month cohort (first 3-months of )
use birth_pop_dobbs_annual_2022_f.dta, clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="black"


keep if year>=2014
generate treatment=treat==1 & year==2023

sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming



preserve
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA6b.gph, replace)  aspect(0.5)
graph export FigureA6b.png, replace		 
		 
restore


*Hispanic
use birth_pop_dobbs_annual_2022_f.dta, clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'



keep if population=="hispanic"


keep if year>=2014
generate treatment=treat==1 & year==2023

sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming



preserve
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel( 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA6c.gph, replace)  aspect(0.5)
graph export FigureA6c.png, replace		 
		 
restore



*Table A1
eststo clear
use `analysis1', clear
keep if population=="overall"
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


esttab using tableA1a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace

eststo clear
use `analysis1', clear
keep if population=="overall"
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


esttab using tableA1b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace




************Appendix set 3-variation of the main paper but including Texas in a staggered way which is automatically corrected for in SDID. The event studies are programmed based on advice from Clarke Stata journal paper on SDID section 4.4, final paragraph*******************
use "C:\ddmpt_nchs\01data\birth_pop_dobbs_annual_2022_f.dta", clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
keep if year>=2019
generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)

*Figure A7
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(1,2,3,4,5,6)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(4.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-4" 2 "T-3" 3 "T-2" 4 "T-1" 5 "T" 6 "T+1", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA7.gph, replace)  aspect(0.5)
graph export FigureA7.png, replace		 
		 
restore




*Figure A8 
use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(1,2,3,4,5,6)'
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(4.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-4" 2 "T-3" 3 "T-2" 4 "T-1" 5 "T" 6 "T+1", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA8a.gph, replace)  aspect(0.5)
graph export FigureA8a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(4.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-4" 2 "T-3" 3 "T-2" 4 "T-1" 5 "T" 6 "T+1", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA8b.gph, replace)  aspect(0.5)
graph export FigureA8b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-4" 2 "T-3" 3 "T-2" 4 "T-1" 5 "T" 6 "T+1", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA8c.gph, replace)  aspect(0.5)
graph export FigureA8c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-4" 2 "T-3" 3 "T-2" 4 "T-1" 5 "T" 6 "T+1", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA8d.gph, replace)  aspect(0.5)
graph export FigureA8d.png, replace		 
		 
restore


*Figure A9

use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-4" 2 "T-3" 3 "T-2" 4 "T-1" 5 "T" 6 "T+1", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA9a.gph, replace)  aspect(0.5)
graph export FigureA9a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-4" 2 "T-3" 3 "T-2" 4 "T-1" 5 "T" 6 "T+1", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA9b.gph, replace)  aspect(0.5)
graph export FigureA9b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-4" 2 "T-3" 3 "T-2" 4 "T-1" 5 "T" 6 "T+1", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA9c.gph, replace)  aspect(0.5)
graph export FigureA9c.png, replace		 
		 
restore


*Table A2
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019

generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019


generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019


generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019


generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
keep if year>=2019

generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


esttab using tableA2a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace

eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019


generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019


generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019


generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019


generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
keep if year>=2019


generate treatment=(treat==1 & year==2023) | (States=="Texas" & year==2022)

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


esttab using tableA2b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace


************Appendix set 4-This shows the effect on the monthly level. The estimates are deseasonalized by state with monthly dummies controlling for a linear trend term from 2019-2023, removing the effect of monthly seasonality without removing the effect of trend*******************
use "C:\ddmpt_nchs\01data\birth_pop_dobbs_monthly_2023Q1_f.dta", clear
drop if year==2023
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023_monthly.dta"
generate trend=12*(year-2019)+mob
replace birth_rate=12*birth_rate

egen statei=group(state_fips_res)
generate birth_rate_a=birth_rate

foreach y in "overall" "1519" "2024" "2529" "30" "white" "black" "hispanic" {
forvalues x=1(1)51 {
	regress birth_rate_a i.mob c.trend if statei==`x' & population=="`y'" & year<=2022
	replace birth_rate_a=birth_rate_a-e(b)[1,2] if mob==2 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,3] if mob==3 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,4] if mob==4 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,5] if mob==5 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,6] if mob==6 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,7] if mob==7 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,8] if mob==8 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,9] if mob==9 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,10] if mob==10 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,11] if mob==11 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,12] if mob==12 & statei==`x'  & population=="`y'"
	
}
}

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

*Figure A10
sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "2019" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "2020" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "2021" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "2022" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "2023" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA10.gph, replace)  aspect(0.5)
graph export FigureA10.png, replace		 
		 
restore




*Figure A11
use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60)'
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "2019" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "2020" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "2021" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "2022" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "2023" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA11a.gph, replace)  aspect(0.5)
graph export FigureA11a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "2019" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "2020" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "2021" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "2022" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "2023" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA11b.gph, replace)  aspect(0.5)
graph export FigureA11b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "2019" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "2020" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "2021" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "2022" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "2023" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA11c.gph, replace)  aspect(0.5)
graph export FigureA11c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "2019" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "2020" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "2021" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "2022" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "2023" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-5(1)5, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA11d.gph, replace)  aspect(0.5)
graph export FigureA11d.png, replace		 
		 
restore


*Figure A12

use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate_a state_fips_res  trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black))   yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "2019" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "2020" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "2021" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "2022" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "2023" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA12a.gph, replace)  aspect(0.5)
graph export FigureA12a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black))  yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-9, lcolor(black*0.8) lpattern(dot))   yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "2019" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "2020" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "2021" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "2022" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "2023" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA12b.gph, replace)  aspect(0.5)
graph export FigureA12b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "2019" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "2020" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "2021" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "2022" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "2023" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA12c.gph, replace)  aspect(0.5)
graph export FigureA12c.png, replace		 
		 
restore


*Table A3
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

esttab using table3a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black" "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace

*Panel B
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

esttab using table3b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of observations" "Control for unemplyoment rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black"  "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace



************Appendix set 5-Including hostile states which do not implement gestational age or late bans that could effect births in 2023
*******************
use birth_pop_dobbs_annual_2022_f.dta, clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2 | keep==3
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

*Figure A13
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA13.gph, replace)  aspect(0.5)
graph export FigureA13.png, replace		 
		 
restore




*Figure A14
use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA14a.gph, replace)  aspect(0.5)
graph export Figure14a.png, replace		 
	 
	 
restore

use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA14b.gph, replace)  aspect(0.5)
graph export FigureA14b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA14c.gph, replace)  aspect(0.5)
graph export Figure14c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-5(1)5, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA14d.gph, replace)  aspect(0.5)
graph export FigureA14d.png, replace		 
		 
restore


*Figure A15

use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA15a.gph, replace)  aspect(0.5)
graph export FigureA15a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA15b.gph, replace)  aspect(0.5)
graph export FigureA15b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA15c.gph, replace)  aspect(0.5)
graph export FigureA15c.png, replace		 
	 
restore







*Table A4
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

esttab using table4a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black" "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace

*Table A4-Panel B
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

esttab using table4b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of observations" "Control for unemplyoment rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black"  "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace


************Appendix set 6-TWFE analysis*******************
use "C:\ddmpt_nchs\01data\birth_pop_dobbs_annual_2022_f.dta", clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

*Figure A16
areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA16.gph, replace)  aspect(0.5)
graph export FigureA16.png, replace		 
		 
restore




*Figure A17
use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA17a.gph, replace)  aspect(0.5)
graph export FigureA17a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA17b.gph, replace)  aspect(0.5)
graph export FigureA17b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI, TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA17c.gph, replace)  aspect(0.5)
graph export FigureA17c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-5(1)5, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA17d.gph, replace)  aspect(0.5)
graph export FigureA17d.png, replace		 
		 
restore


*Figure A18

use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA18a.gph, replace)  aspect(0.5)
graph export FigureA18a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA18b.gph, replace)  aspect(0.5)
graph export FigureA18b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA18c.gph, replace)  aspect(0.5)
graph export FigureA18c.png, replace		 
		 
restore




areg birth_rate 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],0,e(b)[1,4])'
mat define CI=(e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]),e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]),e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]),e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ 0, 0 \ e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]),e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]))
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


*Table A5
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 

estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

esttab using table5a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black" "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace

*Panel B
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

esttab using table5b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of observations" "Control for unemplyoment rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black"  "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace


************Appendix set 7-TWFE extended*******************
use "C:\ddmpt_nchs\01data\birth_pop_dobbs_annual_2022_f.dta", clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
generate treatment=treat==1 & year==2023

*Figure A19
areg birth_rate 1.treat#2005.year 1.treat#2006.year 1.treat#2007.year 1.treat#2008.year 1.treat#2009.year 1.treat#2010.year 1.treat#2011.year 1.treat#2012.year 1.treat#2013.year 1.treat#2014.year 1.treat#2015.year 1.treat#2016.year 1.treat#2017.year 1.treat#2018.year 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],e(b)[1,4],e(b)[1,5],e(b)[1,6],e(b)[1,7],e(b)[1,8],e(b)[1,9],e(b)[1,10],e(b)[1,11],e(b)[1,12],e(b)[1,13],e(b)[1,14],e(b)[1,15],e(b)[1,16],e(b)[1,17],0,e(b)[1,18])'
mat define CI = (e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]), e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \ ///
e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]), e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \ ///
e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]), e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \ ///
e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]), e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]) \  ///
e(b)[1,5]-invttail(e(df_r),0.025)*sqrt(e(V)[5,5]), e(b)[1,5]+invttail(e(df_r),0.025)*sqrt(e(V)[5,5]) \  ///
e(b)[1,6]-invttail(e(df_r),0.025)*sqrt(e(V)[6,6]), e(b)[1,6]+invttail(e(df_r),0.025)*sqrt(e(V)[6,6]) \  ///
e(b)[1,7]-invttail(e(df_r),0.025)*sqrt(e(V)[7,7]), e(b)[1,7]+invttail(e(df_r),0.025)*sqrt(e(V)[7,7]) \  ///
e(b)[1,8]-invttail(e(df_r),0.025)*sqrt(e(V)[8,8]), e(b)[1,8]+invttail(e(df_r),0.025)*sqrt(e(V)[8,8]) \  ///
e(b)[1,9]-invttail(e(df_r),0.025)*sqrt(e(V)[9,9]), e(b)[1,9]+invttail(e(df_r),0.025)*sqrt(e(V)[9,9]) \  ///
e(b)[1,10]-invttail(e(df_r),0.025)*sqrt(e(V)[10,10]), e(b)[1,10]+invttail(e(df_r),0.025)*sqrt(e(V)[10,10]) \  ///
e(b)[1,11]-invttail(e(df_r),0.025)*sqrt(e(V)[11,11]), e(b)[1,11]+invttail(e(df_r),0.025)*sqrt(e(V)[11,11]) \  ///
e(b)[1,12]-invttail(e(df_r),0.025)*sqrt(e(V)[12,12]), e(b)[1,12]+invttail(e(df_r),0.025)*sqrt(e(V)[12,12]) \  ///
e(b)[1,13]-invttail(e(df_r),0.025)*sqrt(e(V)[13,13]), e(b)[1,13]+invttail(e(df_r),0.025)*sqrt(e(V)[13,13]) \  ///
e(b)[1,14]-invttail(e(df_r),0.025)*sqrt(e(V)[14,14]), e(b)[1,14]+invttail(e(df_r),0.025)*sqrt(e(V)[14,14]) \  ///
e(b)[1,15]-invttail(e(df_r),0.025)*sqrt(e(V)[15,15]), e(b)[1,15]+invttail(e(df_r),0.025)*sqrt(e(V)[15,15]) \  ///
e(b)[1,16]-invttail(e(df_r),0.025)*sqrt(e(V)[16,16]), e(b)[1,16]+invttail(e(df_r),0.025)*sqrt(e(V)[16,16]) \  ///
e(b)[1,17]-invttail(e(df_r),0.025)*sqrt(e(V)[17,17]), e(b)[1,17]+invttail(e(df_r),0.025)*sqrt(e(V)[17,17]) \  ///
0, 0 \  ///
e(b)[1,18]-invttail(e(df_r),0.025)*sqrt(e(V)[18,18]), e(b)[1,18]+invttail(e(df_r),0.025)*sqrt(e(V)[18,18]))

mat define TreatmentTiming=(2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA19.gph, replace)  aspect(0.5)
graph export FigureA19.png, replace		 
		 
restore




*Figure A20
use `analysis1', clear
keep if population=="1519"
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2005.year 1.treat#2006.year 1.treat#2007.year 1.treat#2008.year 1.treat#2009.year 1.treat#2010.year 1.treat#2011.year 1.treat#2012.year 1.treat#2013.year 1.treat#2014.year 1.treat#2015.year 1.treat#2016.year 1.treat#2017.year 1.treat#2018.year 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],e(b)[1,4],e(b)[1,5],e(b)[1,6],e(b)[1,7],e(b)[1,8],e(b)[1,9],e(b)[1,10],e(b)[1,11],e(b)[1,12],e(b)[1,13],e(b)[1,14],e(b)[1,15],e(b)[1,16],e(b)[1,17],0,e(b)[1,18])'
mat define CI = (e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]), e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \  ///
e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]), e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \  ///
e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]), e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \  ///
e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]), e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]) \  ///
e(b)[1,5]-invttail(e(df_r),0.025)*sqrt(e(V)[5,5]), e(b)[1,5]+invttail(e(df_r),0.025)*sqrt(e(V)[5,5]) \  ///
e(b)[1,6]-invttail(e(df_r),0.025)*sqrt(e(V)[6,6]), e(b)[1,6]+invttail(e(df_r),0.025)*sqrt(e(V)[6,6]) \  ///
e(b)[1,7]-invttail(e(df_r),0.025)*sqrt(e(V)[7,7]), e(b)[1,7]+invttail(e(df_r),0.025)*sqrt(e(V)[7,7]) \  ///
e(b)[1,8]-invttail(e(df_r),0.025)*sqrt(e(V)[8,8]), e(b)[1,8]+invttail(e(df_r),0.025)*sqrt(e(V)[8,8]) \  ///
e(b)[1,9]-invttail(e(df_r),0.025)*sqrt(e(V)[9,9]), e(b)[1,9]+invttail(e(df_r),0.025)*sqrt(e(V)[9,9]) \  ///
e(b)[1,10]-invttail(e(df_r),0.025)*sqrt(e(V)[10,10]), e(b)[1,10]+invttail(e(df_r),0.025)*sqrt(e(V)[10,10]) \  ///
e(b)[1,11]-invttail(e(df_r),0.025)*sqrt(e(V)[11,11]), e(b)[1,11]+invttail(e(df_r),0.025)*sqrt(e(V)[11,11]) \  ///
e(b)[1,12]-invttail(e(df_r),0.025)*sqrt(e(V)[12,12]), e(b)[1,12]+invttail(e(df_r),0.025)*sqrt(e(V)[12,12]) \  ///
e(b)[1,13]-invttail(e(df_r),0.025)*sqrt(e(V)[13,13]), e(b)[1,13]+invttail(e(df_r),0.025)*sqrt(e(V)[13,13]) \  ///
e(b)[1,14]-invttail(e(df_r),0.025)*sqrt(e(V)[14,14]), e(b)[1,14]+invttail(e(df_r),0.025)*sqrt(e(V)[14,14]) \  ///
e(b)[1,15]-invttail(e(df_r),0.025)*sqrt(e(V)[15,15]), e(b)[1,15]+invttail(e(df_r),0.025)*sqrt(e(V)[15,15]) \  ///
e(b)[1,16]-invttail(e(df_r),0.025)*sqrt(e(V)[16,16]), e(b)[1,16]+invttail(e(df_r),0.025)*sqrt(e(V)[16,16]) \  ///
e(b)[1,17]-invttail(e(df_r),0.025)*sqrt(e(V)[17,17]), e(b)[1,17]+invttail(e(df_r),0.025)*sqrt(e(V)[17,17]) \  ///
0, 0 \  ///
e(b)[1,18]-invttail(e(df_r),0.025)*sqrt(e(V)[18,18]), e(b)[1,18]+invttail(e(df_r),0.025)*sqrt(e(V)[18,18]))

mat define TreatmentTiming=(2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot))  yline(-10, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot))  yline(5, lcolor(black*0.8) lpattern(dot)) yline(10, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(5)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA20a.gph, replace)  aspect(0.5)
graph export FigureA20a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2005.year 1.treat#2006.year 1.treat#2007.year 1.treat#2008.year 1.treat#2009.year 1.treat#2010.year 1.treat#2011.year 1.treat#2012.year 1.treat#2013.year 1.treat#2014.year 1.treat#2015.year 1.treat#2016.year 1.treat#2017.year 1.treat#2018.year 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],e(b)[1,4],e(b)[1,5],e(b)[1,6],e(b)[1,7],e(b)[1,8],e(b)[1,9],e(b)[1,10],e(b)[1,11],e(b)[1,12],e(b)[1,13],e(b)[1,14],e(b)[1,15],e(b)[1,16],e(b)[1,17],0,e(b)[1,18])'
mat define CI = (e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]), e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \  ///
e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]), e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \  ///
e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]), e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \  ///
e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]), e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]) \  ///
e(b)[1,5]-invttail(e(df_r),0.025)*sqrt(e(V)[5,5]), e(b)[1,5]+invttail(e(df_r),0.025)*sqrt(e(V)[5,5]) \  ///
e(b)[1,6]-invttail(e(df_r),0.025)*sqrt(e(V)[6,6]), e(b)[1,6]+invttail(e(df_r),0.025)*sqrt(e(V)[6,6]) \  ///
e(b)[1,7]-invttail(e(df_r),0.025)*sqrt(e(V)[7,7]), e(b)[1,7]+invttail(e(df_r),0.025)*sqrt(e(V)[7,7]) \  ///
e(b)[1,8]-invttail(e(df_r),0.025)*sqrt(e(V)[8,8]), e(b)[1,8]+invttail(e(df_r),0.025)*sqrt(e(V)[8,8]) \  ///
e(b)[1,9]-invttail(e(df_r),0.025)*sqrt(e(V)[9,9]), e(b)[1,9]+invttail(e(df_r),0.025)*sqrt(e(V)[9,9]) \  ///
e(b)[1,10]-invttail(e(df_r),0.025)*sqrt(e(V)[10,10]), e(b)[1,10]+invttail(e(df_r),0.025)*sqrt(e(V)[10,10]) \  ///
e(b)[1,11]-invttail(e(df_r),0.025)*sqrt(e(V)[11,11]), e(b)[1,11]+invttail(e(df_r),0.025)*sqrt(e(V)[11,11]) \  ///
e(b)[1,12]-invttail(e(df_r),0.025)*sqrt(e(V)[12,12]), e(b)[1,12]+invttail(e(df_r),0.025)*sqrt(e(V)[12,12]) \  ///
e(b)[1,13]-invttail(e(df_r),0.025)*sqrt(e(V)[13,13]), e(b)[1,13]+invttail(e(df_r),0.025)*sqrt(e(V)[13,13]) \  ///
e(b)[1,14]-invttail(e(df_r),0.025)*sqrt(e(V)[14,14]), e(b)[1,14]+invttail(e(df_r),0.025)*sqrt(e(V)[14,14]) \  ///
e(b)[1,15]-invttail(e(df_r),0.025)*sqrt(e(V)[15,15]), e(b)[1,15]+invttail(e(df_r),0.025)*sqrt(e(V)[15,15]) \  ///
e(b)[1,16]-invttail(e(df_r),0.025)*sqrt(e(V)[16,16]), e(b)[1,16]+invttail(e(df_r),0.025)*sqrt(e(V)[16,16]) \  ///
e(b)[1,17]-invttail(e(df_r),0.025)*sqrt(e(V)[17,17]), e(b)[1,17]+invttail(e(df_r),0.025)*sqrt(e(V)[17,17]) \  ///
0, 0 \  ///
e(b)[1,18]-invttail(e(df_r),0.025)*sqrt(e(V)[18,18]), e(b)[1,18]+invttail(e(df_r),0.025)*sqrt(e(V)[18,18]))

mat define TreatmentTiming=(2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot))  yline(-10, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot))  yline(5, lcolor(black*0.8) lpattern(dot)) yline(10, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA20b.gph, replace)  aspect(0.5)
graph export FigureA20b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2005.year 1.treat#2006.year 1.treat#2007.year 1.treat#2008.year 1.treat#2009.year 1.treat#2010.year 1.treat#2011.year 1.treat#2012.year 1.treat#2013.year 1.treat#2014.year 1.treat#2015.year 1.treat#2016.year 1.treat#2017.year 1.treat#2018.year 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],e(b)[1,4],e(b)[1,5],e(b)[1,6],e(b)[1,7],e(b)[1,8],e(b)[1,9],e(b)[1,10],e(b)[1,11],e(b)[1,12],e(b)[1,13],e(b)[1,14],e(b)[1,15],e(b)[1,16],e(b)[1,17],0,e(b)[1,18])'
mat define CI = (e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]), e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \  ///
e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]), e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \  ///
e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]), e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \  ///
e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]), e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]) \  ///
e(b)[1,5]-invttail(e(df_r),0.025)*sqrt(e(V)[5,5]), e(b)[1,5]+invttail(e(df_r),0.025)*sqrt(e(V)[5,5]) \  ///
e(b)[1,6]-invttail(e(df_r),0.025)*sqrt(e(V)[6,6]), e(b)[1,6]+invttail(e(df_r),0.025)*sqrt(e(V)[6,6]) \  ///
e(b)[1,7]-invttail(e(df_r),0.025)*sqrt(e(V)[7,7]), e(b)[1,7]+invttail(e(df_r),0.025)*sqrt(e(V)[7,7]) \  ///
e(b)[1,8]-invttail(e(df_r),0.025)*sqrt(e(V)[8,8]), e(b)[1,8]+invttail(e(df_r),0.025)*sqrt(e(V)[8,8]) \  ///
e(b)[1,9]-invttail(e(df_r),0.025)*sqrt(e(V)[9,9]), e(b)[1,9]+invttail(e(df_r),0.025)*sqrt(e(V)[9,9]) \  ///
e(b)[1,10]-invttail(e(df_r),0.025)*sqrt(e(V)[10,10]), e(b)[1,10]+invttail(e(df_r),0.025)*sqrt(e(V)[10,10]) \  ///
e(b)[1,11]-invttail(e(df_r),0.025)*sqrt(e(V)[11,11]), e(b)[1,11]+invttail(e(df_r),0.025)*sqrt(e(V)[11,11]) \  ///
e(b)[1,12]-invttail(e(df_r),0.025)*sqrt(e(V)[12,12]), e(b)[1,12]+invttail(e(df_r),0.025)*sqrt(e(V)[12,12]) \  ///
e(b)[1,13]-invttail(e(df_r),0.025)*sqrt(e(V)[13,13]), e(b)[1,13]+invttail(e(df_r),0.025)*sqrt(e(V)[13,13]) \  ///
e(b)[1,14]-invttail(e(df_r),0.025)*sqrt(e(V)[14,14]), e(b)[1,14]+invttail(e(df_r),0.025)*sqrt(e(V)[14,14]) \  ///
e(b)[1,15]-invttail(e(df_r),0.025)*sqrt(e(V)[15,15]), e(b)[1,15]+invttail(e(df_r),0.025)*sqrt(e(V)[15,15]) \  ///
e(b)[1,16]-invttail(e(df_r),0.025)*sqrt(e(V)[16,16]), e(b)[1,16]+invttail(e(df_r),0.025)*sqrt(e(V)[16,16]) \  ///
e(b)[1,17]-invttail(e(df_r),0.025)*sqrt(e(V)[17,17]), e(b)[1,17]+invttail(e(df_r),0.025)*sqrt(e(V)[17,17]) \  ///
0, 0 \  ///
e(b)[1,18]-invttail(e(df_r),0.025)*sqrt(e(V)[18,18]), e(b)[1,18]+invttail(e(df_r),0.025)*sqrt(e(V)[18,18]))

mat define TreatmentTiming=(2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot))  yline(-10, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot))  yline(5, lcolor(black*0.8) lpattern(dot)) yline(10, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(5)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA20c.gph, replace)  aspect(0.5)
graph export FigureA20c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
generate treatment=treat==1 & year==2023
areg birth_rate 1.treat#2005.year 1.treat#2006.year 1.treat#2007.year 1.treat#2008.year 1.treat#2009.year 1.treat#2010.year 1.treat#2011.year 1.treat#2012.year 1.treat#2013.year 1.treat#2014.year 1.treat#2015.year 1.treat#2016.year 1.treat#2017.year 1.treat#2018.year 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],e(b)[1,4],e(b)[1,5],e(b)[1,6],e(b)[1,7],e(b)[1,8],e(b)[1,9],e(b)[1,10],e(b)[1,11],e(b)[1,12],e(b)[1,13],e(b)[1,14],e(b)[1,15],e(b)[1,16],e(b)[1,17],0,e(b)[1,18])'
mat define CI = (e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]), e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \  ///
e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]), e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \  ///
e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]), e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \  ///
e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]), e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]) \  ///
e(b)[1,5]-invttail(e(df_r),0.025)*sqrt(e(V)[5,5]), e(b)[1,5]+invttail(e(df_r),0.025)*sqrt(e(V)[5,5]) \  ///
e(b)[1,6]-invttail(e(df_r),0.025)*sqrt(e(V)[6,6]), e(b)[1,6]+invttail(e(df_r),0.025)*sqrt(e(V)[6,6]) \  ///
e(b)[1,7]-invttail(e(df_r),0.025)*sqrt(e(V)[7,7]), e(b)[1,7]+invttail(e(df_r),0.025)*sqrt(e(V)[7,7]) \  ///
e(b)[1,8]-invttail(e(df_r),0.025)*sqrt(e(V)[8,8]), e(b)[1,8]+invttail(e(df_r),0.025)*sqrt(e(V)[8,8]) \  ///
e(b)[1,9]-invttail(e(df_r),0.025)*sqrt(e(V)[9,9]), e(b)[1,9]+invttail(e(df_r),0.025)*sqrt(e(V)[9,9]) \  ///
e(b)[1,10]-invttail(e(df_r),0.025)*sqrt(e(V)[10,10]), e(b)[1,10]+invttail(e(df_r),0.025)*sqrt(e(V)[10,10]) \  ///
e(b)[1,11]-invttail(e(df_r),0.025)*sqrt(e(V)[11,11]), e(b)[1,11]+invttail(e(df_r),0.025)*sqrt(e(V)[11,11]) \  ///
e(b)[1,12]-invttail(e(df_r),0.025)*sqrt(e(V)[12,12]), e(b)[1,12]+invttail(e(df_r),0.025)*sqrt(e(V)[12,12]) \  ///
e(b)[1,13]-invttail(e(df_r),0.025)*sqrt(e(V)[13,13]), e(b)[1,13]+invttail(e(df_r),0.025)*sqrt(e(V)[13,13]) \  ///
e(b)[1,14]-invttail(e(df_r),0.025)*sqrt(e(V)[14,14]), e(b)[1,14]+invttail(e(df_r),0.025)*sqrt(e(V)[14,14]) \  ///
e(b)[1,15]-invttail(e(df_r),0.025)*sqrt(e(V)[15,15]), e(b)[1,15]+invttail(e(df_r),0.025)*sqrt(e(V)[15,15]) \  ///
e(b)[1,16]-invttail(e(df_r),0.025)*sqrt(e(V)[16,16]), e(b)[1,16]+invttail(e(df_r),0.025)*sqrt(e(V)[16,16]) \  ///
e(b)[1,17]-invttail(e(df_r),0.025)*sqrt(e(V)[17,17]), e(b)[1,17]+invttail(e(df_r),0.025)*sqrt(e(V)[17,17]) \  ///
0, 0 \  ///
e(b)[1,18]-invttail(e(df_r),0.025)*sqrt(e(V)[18,18]), e(b)[1,18]+invttail(e(df_r),0.025)*sqrt(e(V)[18,18]))

mat define TreatmentTiming=(2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot))  yline(-10, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot))  yline(5, lcolor(black*0.8) lpattern(dot)) yline(10, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2005 2006 " " 2007 2008 " " 2009 2010 " " 2011 2012 " " 2013 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(5)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA20d.gph, replace)  aspect(0.5)
graph export FigureA20d.png, replace		 
		 
restore


*Figure A21

use `analysis1', clear
keep if population=="white"
generate treatment=treat==1 & year==2023
areg birth_rate  1.treat#2014.year 1.treat#2015.year 1.treat#2016.year 1.treat#2017.year 1.treat#2018.year 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],e(b)[1,4],e(b)[1,5],e(b)[1,6],e(b)[1,7],e(b)[1,8],0,e(b)[1,9])'
mat define CI = (e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]), e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \  ///
e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]), e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \  ///
e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]), e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \  ///
e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]), e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]) \  ///
e(b)[1,5]-invttail(e(df_r),0.025)*sqrt(e(V)[5,5]), e(b)[1,5]+invttail(e(df_r),0.025)*sqrt(e(V)[5,5]) \  ///
e(b)[1,6]-invttail(e(df_r),0.025)*sqrt(e(V)[6,6]), e(b)[1,6]+invttail(e(df_r),0.025)*sqrt(e(V)[6,6]) \  ///
e(b)[1,7]-invttail(e(df_r),0.025)*sqrt(e(V)[7,7]), e(b)[1,7]+invttail(e(df_r),0.025)*sqrt(e(V)[7,7]) \  ///
e(b)[1,8]-invttail(e(df_r),0.025)*sqrt(e(V)[8,8]), e(b)[1,8]+invttail(e(df_r),0.025)*sqrt(e(V)[8,8]) \  ///
0, 0 \  ///
e(b)[1,9]-invttail(e(df_r),0.025)*sqrt(e(V)[9,9]), e(b)[1,9]+invttail(e(df_r),0.025)*sqrt(e(V)[9,9]))

mat define TreatmentTiming=(2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot))  yline(-10, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot))  yline(5, lcolor(black*0.8) lpattern(dot)) yline(10, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel( 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(5)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA21a.gph, replace)  aspect(0.5)
graph export FigureA21a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
generate treatment=treat==1 & year==2023
areg birth_rate  1.treat#2014.year 1.treat#2015.year 1.treat#2016.year 1.treat#2017.year 1.treat#2018.year 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],e(b)[1,4],e(b)[1,5],e(b)[1,6],e(b)[1,7],e(b)[1,8],0,e(b)[1,9])'
mat define CI = (e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]), e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \  ///
e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]), e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \  ///
e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]), e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \  ///
e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]), e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]) \  ///
e(b)[1,5]-invttail(e(df_r),0.025)*sqrt(e(V)[5,5]), e(b)[1,5]+invttail(e(df_r),0.025)*sqrt(e(V)[5,5]) \  ///
e(b)[1,6]-invttail(e(df_r),0.025)*sqrt(e(V)[6,6]), e(b)[1,6]+invttail(e(df_r),0.025)*sqrt(e(V)[6,6]) \  ///
e(b)[1,7]-invttail(e(df_r),0.025)*sqrt(e(V)[7,7]), e(b)[1,7]+invttail(e(df_r),0.025)*sqrt(e(V)[7,7]) \  ///
e(b)[1,8]-invttail(e(df_r),0.025)*sqrt(e(V)[8,8]), e(b)[1,8]+invttail(e(df_r),0.025)*sqrt(e(V)[8,8]) \  ///
0, 0 \  ///
e(b)[1,9]-invttail(e(df_r),0.025)*sqrt(e(V)[9,9]), e(b)[1,9]+invttail(e(df_r),0.025)*sqrt(e(V)[9,9]))
mat define TreatmentTiming=(2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot))  yline(-10, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot))  yline(5, lcolor(black*0.8) lpattern(dot)) yline(10, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel( 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(5)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA21b.gph, replace)  aspect(0.5)
graph export FigureA21b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
generate treatment=treat==1 & year==2023
areg birth_rate  1.treat#2014.year 1.treat#2015.year 1.treat#2016.year 1.treat#2017.year 1.treat#2018.year 1.treat#2019.year 1.treat#2020.year 1.treat#2021.year 1.treat#2023.year i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
mat define event_study=(e(b)[1,1],e(b)[1,2],e(b)[1,3],e(b)[1,4],e(b)[1,5],e(b)[1,6],e(b)[1,7],e(b)[1,8],0,e(b)[1,9])'
mat define CI = (e(b)[1,1]-invttail(e(df_r),0.025)*sqrt(e(V)[1,1]), e(b)[1,1]+invttail(e(df_r),0.025)*sqrt(e(V)[1,1]) \  ///
e(b)[1,2]-invttail(e(df_r),0.025)*sqrt(e(V)[2,2]), e(b)[1,2]+invttail(e(df_r),0.025)*sqrt(e(V)[2,2]) \  ///
e(b)[1,3]-invttail(e(df_r),0.025)*sqrt(e(V)[3,3]), e(b)[1,3]+invttail(e(df_r),0.025)*sqrt(e(V)[3,3]) \  ///
e(b)[1,4]-invttail(e(df_r),0.025)*sqrt(e(V)[4,4]), e(b)[1,4]+invttail(e(df_r),0.025)*sqrt(e(V)[4,4]) \  ///
e(b)[1,5]-invttail(e(df_r),0.025)*sqrt(e(V)[5,5]), e(b)[1,5]+invttail(e(df_r),0.025)*sqrt(e(V)[5,5]) \  ///
e(b)[1,6]-invttail(e(df_r),0.025)*sqrt(e(V)[6,6]), e(b)[1,6]+invttail(e(df_r),0.025)*sqrt(e(V)[6,6]) \  ///
e(b)[1,7]-invttail(e(df_r),0.025)*sqrt(e(V)[7,7]), e(b)[1,7]+invttail(e(df_r),0.025)*sqrt(e(V)[7,7]) \  ///
e(b)[1,8]-invttail(e(df_r),0.025)*sqrt(e(V)[8,8]), e(b)[1,8]+invttail(e(df_r),0.025)*sqrt(e(V)[8,8]) \  ///
0, 0 \  ///
e(b)[1,9]-invttail(e(df_r),0.025)*sqrt(e(V)[9,9]), e(b)[1,9]+invttail(e(df_r),0.025)*sqrt(e(V)[9,9]))
mat define TreatmentTiming=(2014,2015,2016,2017,2018,2019,2020,2021,2022,2023)'
mat define event_matrix=[event_study, CI,TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-10, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(10, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel( 2014 " " 2015 2016 " " 2017 2018 " " 2019 2020 " " 2021 2022 " " 2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(5)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA21c.gph, replace)  aspect(0.5)
graph export FigureA21c.png, replace		 
		 
restore





*Table A6
eststo clear
use `analysis1', clear
keep if population=="overall"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 

estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
generate treatment=treat==1 & year==2023


eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
generate treatment=treat==1 & year==2023


eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
generate treatment=treat==1 & year==2023
eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="white"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="black"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="hispanic"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year uer, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

esttab using table6a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black" "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace

*Panel B
eststo clear
use `analysis1', clear
keep if population=="overall"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

use `analysis1', clear
keep if population=="1519"
generate treatment=treat==1 & year==2023


eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2024"
generate treatment=treat==1 & year==2023


eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2529"
generate treatment=treat==1 & year==2023
eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="30"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="white"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="black"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="hispanic"
generate treatment=treat==1 & year==2023

eststo: areg birth_rate treatment i.year, cluster(state_fips_res) absorb(state_fips_res) 
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

esttab using table6b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of observations" "Control for unemplyoment rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black"  "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace






************Appendix set 8-Including controls for percent in each demographic category*******************
*This will be replace with the final dataset at the end. For now I am estimating by month cohort (first 3-months of )
use "C:\ddmpt_nchs\01data\birth_pop_dobbs_annual_2022_f.dta", clear
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023.dta"

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

*Figure A22
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA22.gph, replace)  aspect(0.5)
graph export FigureA22.png, replace		 
restore




*Figure A23 
use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
mat define TreatmentTiming=(2019,2020,2021,2022,2023)'
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA23a.gph, replace)  aspect(0.5)
graph export FigureA23a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)

twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))   saving(FigureA23b.gph, replace)  aspect(0.5)
graph export FigureA23b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA23c.gph, replace)  aspect(0.5)
graph export FigureA23c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-5(1)5, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA23d.gph, replace)  aspect(0.5)
graph export FigureA23d.png, replace		 
		 
restore


*Figure A24

use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA24a.gph, replace)  aspect(0.5)
graph export FigureA24a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA24b.gph, replace)  aspect(0.5)
graph export FigureA24b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
sdid_eventstudy birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(2022.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(2019(1)2023, format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA24c.gph, replace)  aspect(0.5)
graph export FigureA24c.png, replace		 
		 
restore







*Table A7
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(uer percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

esttab using table7a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black" "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace

*Panel B
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023


eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)


preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023

eststo: sdid birth_rate state_fips_res year treatment, vce(bootstrap) reps(1000) covariates(percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

esttab using table7b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of observations" "Control for unemplyoment rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black"  "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace




************Appendix set 9-by month of birth deseasonalized*******************
use "C:\ddmpt_nchs\01data\birth_pop_dobbs_monthly_2023Q1_f.dta", clear
drop if year==2023
append using "C:\ddmpt_nchs\01data\pseudo_NAT_2023_monthly.dta"
generate trend=12*(year-2019)+mob
replace birth_rate=12*birth_rate

egen statei=group(state_fips_res)
generate birth_rate_a=birth_rate

foreach y in "overall" "1519" "2024" "2529" "30" "white" "black" "hispanic" {
forvalues x=1(1)51 {
	regress birth_rate_a i.mob c.trend if statei==`x' & population=="`y'" & year<=2022
	replace birth_rate_a=birth_rate_a-e(b)[1,2] if mob==2 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,3] if mob==3 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,4] if mob==4 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,5] if mob==5 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,6] if mob==6 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,7] if mob==7 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,8] if mob==8 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,9] if mob==9 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,10] if mob==10 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,11] if mob==11 & statei==`x'  & population=="`y'"
	replace birth_rate_a=birth_rate_a-e(b)[1,12] if mob==12 & statei==`x'  & population=="`y'"
	
}
}

keep if keep==1 | keep==2
drop if States=="Texas"
generate treat=keep==1

tempfile analysis1
save `analysis1'




keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

*Figure A25
sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62)'
mat define event_matrix=[e(event_study), e(CI),TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming


preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-48" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "T-36" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "T-24" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "T-12" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "T" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 "T+11" 61 " " 62 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA25.gph, replace)  aspect(0.5)
graph export FigureA25.png, replace		 
		 
restore




*Figure A26
use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define TreatmentTiming=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62)'
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-48" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "T-36" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "T-24" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "T-12" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "T" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 "T+11" 61 " " 62 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-3(1)3, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA26a.gph, replace)  aspect(0.5)
graph export FigureA26a.png, replace		 
		 
	 
restore

use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-7, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-48" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "T-36" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "T-24" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "T-12" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "T" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 "T+11" 61 " " 62 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA26b.gph, replace)  aspect(0.5)
graph export FigureA26b.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

sdid_eventstudy birth_rate state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-15, lcolor(black*0.8) lpattern(dot)) yline(-12, lcolor(black*0.8) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) yline(12, lcolor(black*0.8) lpattern(dot)) yline(15, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-48" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "T-36" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "T-24" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "T-12" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "T" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 "T+11" 61 " " 62 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-15(3)15, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA26c.gph, replace)  aspect(0.5)
graph export FigureA26c.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-48" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "T-36" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "T-24" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "T-12" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "T" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 "T+11" 61 " " 62 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-5(1)5, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA26d.gph, replace)  aspect(0.5)
graph export FigureA26d.png, replace		 
		 
restore


*Figure A27

use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

sdid_eventstudy birth_rate_a state_fips_res  trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black))   yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-48" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "T-36" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "T-24" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "T-12" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "T" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 "T+11" 61 " " 62 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-6(2)6, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA27a.gph, replace)  aspect(0.5)
graph export FigureA27a.png, replace		 
		 
restore

use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot))  yline(0, lcolor(black))  yline(-8, lcolor(black*0.8) lpattern(dot)) yline(-9, lcolor(black*0.8) lpattern(dot))   yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-5, lcolor(black*0.8) lpattern(dot)) yline(-4, lcolor(black*0.8) lpattern(dot))  yline(-3, lcolor(black*0.8) lpattern(dot)) yline(-2, lcolor(black*0.8) lpattern(dot)) yline(-1, lcolor(black*0.8) lpattern(dot)) yline(1, lcolor(black*0.8) lpattern(dot)) yline(2, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(4, lcolor(black*0.8) lpattern(dot)) yline(5, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(7, lcolor(black*0.8) lpattern(dot)) yline(8, lcolor(black*0.8) lpattern(dot))|| /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-48" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "T-36" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "T-24" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "T-12" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "T" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 "T+11" 61 " " 62 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-8(2)8, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA27b.gph, replace)  aspect(0.5)
graph export FigureA27b.png, replace		 
		 
restore


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

sdid_eventstudy birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
mat define event_matrix=[e(event_study), e(CI), TreatmentTiming]
mat colnames event_matrix=Effect LowerBound UpperBound TreatmentTiming

preserve
clear
svmat event_matrix, names(col)


twoway rarea LowerBound UpperBound TreatmentTiming, lcolor(black%30*0.2) fcolor(black%30*0.2) xline(48.5, lcolor(red) lpattern(dot)) yline(0, lcolor(black)) yline(-9, lcolor(black*0.8) lpattern(dot)) yline(-6, lcolor(black*0.8) lpattern(dot)) yline(-3, lcolor(black*0.8) lpattern(dot)) yline(3, lcolor(black*0.8) lpattern(dot)) yline(6, lcolor(black*0.8) lpattern(dot)) yline(9, lcolor(black*0.8) lpattern(dot)) || /// 
         connected Effect TreatmentTiming, msymbol(o) lcolor(red*1.5) mcolor(black) legend(label(1 "95 Percent Confidence Interval") label(2 "Treatment Effect") size(small) rows(1))  xtitle("Year ", size(small) margin(medium)) xlabel(1 "T-48" 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " " 10 " " 11 " " 12 " "  13 "T-36" 14 " " 15 " " 16 " " 17 " " 18 " " 19 " " 20 " " 21 " " 22 " " 23 " "24 " "  25 "T-24" 26 " " 27 " " 28 " " 29 " " 30 " " 31 " " 32 " " 33 " " 34 " " 35 " " 36 " " 37 "T-12" 38 " " 39 " " 40 " " 41 " " 42 " " 43 " " 44 " " 45 " " 46 " " 47 " " 48 " " 49 "T" 50 " " 51 " " 52 " " 53 " " 54 " " 55 " " 56 " " 57 " " 58 " " 59 " " 60 "T+11" 61 " " 62 " ", format(%5.0f) labsize(small)) ytitle("Fertility rate relative to baseline", size(small) margin(medium)) ylabel(-9(3)9, format(%5.0f) labsize(small)) bgcolor(white) graphregion(color(white))  saving(FigureA27c.gph, replace)  aspect(0.5)
graph export FigureA27c.png, replace		 
		 
restore


*Table A7
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022



eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022



eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000) covariates(uer, projected)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "Yes"

esttab using table8a.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of Observations" "Control for Unemplyoment Rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black" "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace

*Panel B
eststo clear
use `analysis1', clear
keep if population=="overall"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

use `analysis1', clear
keep if population=="1519"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022



eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2024"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022



eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="2529"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022

eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="30"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="white"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="black"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"


use `analysis1', clear
keep if population=="hispanic"
keep if year>=2019
generate treatment=treat==1 & year==2023
replace treatment=1 if States=="Oklahoma" & mob>=11 & year==2022


eststo: sdid birth_rate_a state_fips_res trend treatment, vce(bootstrap) reps(1000)
estadd scalar numobs=e(N)

preserve
bysort state_fips_res: keep if _n==1
count if treat==1
estadd scalar Treated_N=r(N)
count if treat==0
estadd scalar Control_N=r(N)
restore

sum birth_rate if treat==1 & year==2022
estadd scalar premean=r(mean)
estadd scalar perceffect=100*e(b)[1,1]/r(mean)
estadd local uer_control "No"

esttab using table8b.tex, se stats( premean Control_N Treated_N numobs uer_control, label("2022 Ban State Mean Fertility Rate" "Number of control states" "Number of treatment states" "Number of observations" "Control for unemplyoment rate")) collabels("Overall" "15-19" "20-24" "25-29" "30" "Non-Hispanic White" "Non-Hispanic Black"  "Hispanic")  b(%5.1f) sfmt(%9.1fc %9.1fc %9.0f %9.0f)  noobs  rename(treatment "Effect of ban")  nomti nostar replace


