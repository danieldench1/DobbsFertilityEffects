
*Programmers: Daniel Dench & Mayra Pineda-Torres								 
*Date: 10/02/2023								                    			 
*Purpose: The following cleans population data from the following    
*		                 
* 		  sources:
*			
*			2020-2022 estimates: 
*		   https://www2.census.gov/programs-surveys/popest/datasets/2020-2022/state/asrh/sc-est2022-alldata6.csv
*			2010-2020 estimates:
*         https://www2.census.gov/programs-surveys/popest/datasets/2010-2020/state/asrh/SC-EST2020-ALLDATA6.cs
*			2000-2010 estimates:
*		  https://www2.census.gov/programs-surveys/popest/datasets/2010/2010-eval-estimates/sc-est2010-alldata6.csv							 		 
																				 


clear 
set more off 
cd "C:\ddmpt_nchs\01data"


*Will need to modify for final 2023. This is the data for 2020-2022 population bases
import delimited using "rawdata\sc-est2022-alldata6.csv", delimiter(comma) varnames(1) clear

*Limit to female
keep if sex==2



*Limit to relevant age groups for fertility
keep if age>=15 & age<=44




preserve
*Limit to relevant race white nh and save as seperate dataset to be appended later
keep if race==1 & origin==1


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2020 popestimate2020 popestimate2021 popestimate2022, by(state)
rename popestimate2020 popestimate2020a

foreach x in estimatesbase2020 popestimate2020a popestimate2021 popestimate2022  {
	rename `x' `x'_white
	
}

tempfile popdatawhite
save `popdatawhite'
restore


preserve
*Limit to relevant race black nh and save as seperate dataset to be appended later
keep if race==2 & origin==1


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2020 popestimate2020 popestimate2021 popestimate2022, by(state)
rename popestimate2020 popestimate2020a

foreach x in estimatesbase2020 popestimate2020a popestimate2021 popestimate2022  {
	rename `x' `x'_black
	
}

tempfile popdatablack
save `popdatablack'
restore


preserve
*Limit to relevant ethnicity Hispanic and save as seperate dataset to be appended later
keep if  origin==2


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2020 popestimate2020 popestimate2021 popestimate2022, by(state)
rename popestimate2020 popestimate2020a

foreach x in estimatesbase2020 popestimate2020a popestimate2021 popestimate2022  {
	rename `x' `x'_hispanic
	
}

tempfile popdatahispanic
save `popdatahispanic'
restore


*Overall estimate (rather than splitting off by Hispanic/not Hispanic)
keep if origin==0

preserve
*Limit to relevant age group-15-19 and save as seperate dataset to be appended later
keep if age>=15 & age<=19


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2020 popestimate2020 popestimate2021 popestimate2022, by(state)
rename popestimate2020 popestimate2020a

foreach x in estimatesbase2020 popestimate2020a popestimate2021 popestimate2022  {
	rename `x' `x'_1519
	
}

tempfile popdata1519
save `popdata1519'
restore


*Limit to relevant age group-20-24 and save as seperate dataset to be appended later
preserve
keep if age>=20 & age<=24

collapse (sum) estimatesbase2020 popestimate2020 popestimate2021 popestimate2022, by(state)
rename popestimate2020 popestimate2020a


foreach x in estimatesbase2020 popestimate2020a popestimate2021 popestimate2022  {
	rename `x' `x'_2024
	
}

tempfile popdata2024
save `popdata2024'
restore


*Limit to relevant age group-25-29 and save as seperate dataset to be appended later
preserve
keep if age>=25 & age<=29

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2020 popestimate2020 popestimate2021 popestimate2022, by(state)
rename popestimate2020 popestimate2020a

foreach x in estimatesbase2020 popestimate2020a popestimate2021 popestimate2022  {
	rename `x' `x'_2529
	
}

tempfile popdata2529
save `popdata2529'
restore



*Limit to relevant age group-30 and save as seperate dataset to be appended later
preserve
keep if age>=30
collapse (sum) estimatesbase2020 popestimate2020 popestimate2021 popestimate2022, by(state)
rename popestimate2020 popestimate2020a

foreach x in estimatesbase2020 popestimate2020a popestimate2021 popestimate2022  {
	rename `x' `x'_30
	
}

tempfile popdata30
save `popdata30'
restore

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2020 popestimate2020 popestimate2021 popestimate2022, by(state)
rename popestimate2020 popestimate2020a


foreach x in estimatesbase2020 popestimate2020a popestimate2021 popestimate2022 {
	
	rename `x' `x'_overall
}


tempfile popdata
save `popdata'




**This datasets will not change and should remain stable. This is the data for 2010-2019 population bases.
import delimited using "rawdata\sc-est2020-alldata6.csv", delimiter(comma) varnames(1) clear


*Limit to female
keep if sex==2


*Limit to relevant age groups for fertility
keep if age>=15 & age<=44


preserve
*Limit to relevant race white nh and save as seperate dataset to be appended later
keep if race==1 & origin==1


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2010  popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020, by(state)
rename popestimate2010 popestimate2010a

foreach x in estimatesbase2010 popestimate2010a popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020  {
	rename `x' `x'_white
	
}


merge 1:1 state using `popdatawhite'
drop _merge

save `popdatawhite', replace
restore


preserve


*Limit to relevant race black nh and save as seperate dataset to be appended later
keep if race==2 & origin==1


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2010  popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020, by(state)
rename popestimate2010 popestimate2010a

foreach x in estimatesbase2010  popestimate2010a popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020  {
	rename `x' `x'_black
	
}

merge 1:1 state using `popdatablack'
drop _merge

save `popdatablack', replace
restore


preserve
*Limit to relevant ethnicity Hispanic and save as seperate dataset to be appended later
keep if  origin==2


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2010  popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020, by(state)
rename popestimate2010 popestimate2010a

foreach x in estimatesbase2010  popestimate2010a popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020 {
	rename `x' `x'_hispanic
	
}


merge 1:1 state using `popdatahispanic'
drop _merge

save `popdatahispanic', replace
restore

*Overall estimate (rather than splitting off by Hispanic/not Hispanic)
keep if origin==0




preserve
*Limit to relevant age group-15-19  and save as seperate dataset to be appended later
keep if age>=15 & age<=19

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2010  popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020, by(state)
rename popestimate2010 popestimate2010a



foreach x in estimatesbase2010  popestimate2010a popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020 {
	rename `x' `x'_1519
	
}

merge 1:1 state using `popdata1519'
drop _merge


save `popdata1519', replace 


restore


preserve
*Limit to relevant age group-20-24 and save as seperate dataset to be appended later
keep if age>=20 & age<=24

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2010  popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020, by(state)
rename popestimate2010 popestimate2010a

foreach x in estimatesbase2010  popestimate2010a popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020 {
	rename `x' `x'_2024
	
}


merge 1:1 state using `popdata2024'
drop _merge




save `popdata2024', replace

restore

preserve
*Limit to relevant age group-25-29 and save as seperate dataset to be appended later
keep if age>=25 & age<=29

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2010  popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020, by(state)
rename popestimate2010 popestimate2010a



foreach x in estimatesbase2010  popestimate2010a popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020 {
	rename `x' `x'_2529
	
}

merge 1:1 state using `popdata2529'
drop _merge




save `popdata2529', replace

restore



preserve
*Limit to relevant age group-30 and save as seperate dataset to be appended later
keep if age>=30

collapse (sum) estimatesbase2010  popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020, by(state)
rename popestimate2010 popestimate2010a



foreach x in estimatesbase2010  popestimate2010a popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020 {
	rename `x' `x'_30
	
}

merge 1:1 state using `popdata30'
drop _merge



save `popdata30', replace


restore



*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2010  popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020, by(state)
rename popestimate2010 popestimate2010a



foreach x in estimatesbase2010  popestimate2010a popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020 {
	
	rename `x' `x'_overall
}

merge 1:1 state using `popdata'
drop _merge
save `popdata', replace



**This datasets will not change and should remain stable. This dataset is for population bases for years 2000-2009.
import delimited using "rawdata\sc-est2010-alldata6.csv", delimiter(comma) varnames(1) clear


*Limit to female
keep if sex==2


*Limit to relevant age groups for fertility
keep if age>=15 & age<=44


preserve
*Limit to relevant race white nh and save as seperate dataset to be appended later
keep if race==1 & origin==1


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010, by(state)

foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010 {
	rename `x' `x'_white
	
}


merge 1:1 state using `popdatawhite'
drop _merge

save `popdatawhite', replace
restore


preserve
*Limit to relevant race black nh and save as seperate dataset to be appended later
keep if race==2 & origin==1


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010, by(state)

foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010 {
	rename `x' `x'_black
	
}

merge 1:1 state using `popdatablack'
drop _merge

save `popdatablack', replace
restore


preserve
*Limit to relevant ethnicity Hispanic and save as seperate dataset to be appended later
keep if  origin==2


*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010, by(state)

foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010 {
	rename `x' `x'_hispanic
	
}


merge 1:1 state using `popdatahispanic'
drop _merge

save `popdatahispanic', replace
restore

*Overall estimate (rather than splitting off by Hispanic/not Hispanic)
keep if origin==0




preserve
*Limit to relevant age group-15-19 and save as seperate dataset to be appended later
keep if age>=15 & age<=19

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010, by(state)



foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010 {
	rename `x' `x'_1519
	
}

merge 1:1 state using `popdata1519'
drop _merge


save `popdata1519', replace 


restore


preserve
*Limit to relevant age group-20-24 and save as seperate dataset to be appended later
keep if age>=20 & age<=24

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010, by(state)

foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010 {
	rename `x' `x'_2024
	
}


merge 1:1 state using `popdata2024'
drop _merge




save `popdata2024', replace

restore

preserve
*Limit to relevant age group-25-29 and save as seperate dataset to be appended later
keep if age>=25 & age<=29

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010, by(state)

foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010 {
	rename `x' `x'_2529
	
}

merge 1:1 state using `popdata2529'
drop _merge




save `popdata2529', replace

restore



preserve
*Limit to relevant age group-30 and save as seperate dataset to be appended later
keep if age>=30

*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010, by(state)

foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010 {
	rename `x' `x'_30
	
}

merge 1:1 state using `popdata30'
drop _merge



save `popdata30', replace


restore



*Collapse down to state population level in current wide format
collapse (sum) estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010, by(state)

foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 popestimate2010 {
	
	rename `x' `x'_overall
}


*Merging together to other pop estimates years and populations
merge 1:1 state using `popdata'
drop _merge

merge 1:1 state using `popdata1519'
drop _merge

merge 1:1 state using `popdata2024'
drop _merge

merge 1:1 state using `popdata2529'
drop _merge

merge 1:1 state using `popdata30'
drop _merge

merge 1:1 state using `popdatawhite'
drop _merge

merge 1:1 state using `popdatablack'
drop _merge

merge 1:1 state using `popdatahispanic'
drop _merge


*Reshaping to long format
reshape long estimatesbase2000_  popestimate2000_ popestimate2001_ popestimate2002_ popestimate2003_ popestimate2004_ popestimate2005_ popestimate2006_ popestimate2007_ popestimate2008_ popestimate2009_ popestimate2010_ estimatesbase2010_ popestimate2010a_ popestimate2011_ popestimate2012_ popestimate2013_ popestimate2014_ popestimate2015_ popestimate2016_ popestimate2017_ popestimate2018_ popestimate2019_ popestimate2020_ popestimate2020a_ estimatesbase2020_ popestimate2021_ popestimate2022_, i(state) j(population) string


generate adjust1=popestimate2010a_/popestimate2010_

generate adjust= popestimate2020a_/popestimate2020_

*Removing underscore
foreach x in estimatesbase2000  popestimate2000 popestimate2001 popestimate2002 popestimate2003 popestimate2004 popestimate2005 popestimate2006 popestimate2007 popestimate2008 popestimate2009 estimatesbase2010 popestimate2010 popestimate2011 popestimate2012 popestimate2013 popestimate2014 popestimate2015 popestimate2016 popestimate2017 popestimate2018 popestimate2019 popestimate2020 popestimate2020a estimatesbase2020 popestimate2021 popestimate2022 {
	rename `x'_ `x'
}

drop popestimate2020 popestimate2010
rename popestimate2020a popestimate2020
rename popestimate2010a popestimate2010

reshape long  estimatesbase popestimate, i(population state adjust) j(year)

drop estimatesbase

*Applying a closure of error formula: https://www2.census.gov/programs-surveys/popest/technical-documentation/methodology/intercensal/intercensal-nat-meth.pdf
generate t1=mdy(7,1,year)-mdy(7,1,2000) if mdy(7,1,year)<mdy(7,1,2010)

generate t=mdy(7,1,year)-mdy(7,1,2010)
replace t=0 if mdy(7,1,year)>=mdy(7,1,2020)

*Adjusted population estimates with error of closure adjustment applied
generate popestimate_adjusted=popestimate*(adjust1^(t1/3653)) if mdy(7,1,year)<mdy(7,1,2010)
replace popestimate_adjusted=popestimate*(adjust^(t/3653)) if year>=2010
rename state state_fips_res


*Getting percent of population in each population category
preserve
keep state_fips_res year popestimate_adjusted population
reshape wide popestimate_adjusted, i(state_fips_res year) j(population) string
foreach x in "1519" "2024" "2529" "30" "black" "white" "hispanic" {
generate percpop_`x'= popestimate_adjusted`x'/popestimate_adjustedoverall
}

keep state_fips_res year  percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic
tempfile percpop
save `percpop'
restore

*Merging in percent population in each group info
merge m:1 state_fips_res year using `percpop'
drop _merge

save "pop_estimates_yearly.dta", replace


drop t

*Expanding to create population bases for each month
expand 12, generate(dups)
bysort state population year: generate mob=_n

*Making adjustment from July since that's what the population bases are targeting. This code linearly interpolates between periods.
generate mob_f=mob-6 if mob>=7
replace mob_f=mob+6 if mob<7
generate year_f=year-1 if mob_f>=7
replace year_f=year if mob_f<7
generate popestimate_f=popestimate_adjusted if mob_f==1
bysort state population (year_f mob_f) : generate popestimate_f_m=popestimate_f[_n+12]-popestimate_f

*Modify for 2023 when released. Project forward from july 2022 based on the population growth rate from the previous year by state/population
bysort state population (year_f mob_f) : replace popestimate_f_m=popestimate_f_m[_n-12] if year_f==2022 & mob_f==1
bysort state population year_f : egen popestimate_f2=max(popestimate_f)
bysort state population year_f : egen popestimate_f_m2=max(popestimate_f_m)
bysort state population year_f : generate popestimate_adjusted2=popestimate_f2+((mob_f-1)/12)*popestimate_f_m2
expand 13 if year==2022 & mob==12, generate(dups2)
replace year=year+1 if dups2==1
bysort state population year: replace mob=_n if year==2023
sort state population year mob
by state population year: replace  popestimate_adjusted2=popestimate_adjusted2+((mob)/12)*popestimate_f_m2 if year==2023

keep state_fips_res population popestimate_adjusted2 mob year

*Get the percent population in each demographic category
preserve
keep state_fips_res year popestimate_adjusted population mob
reshape wide popestimate_adjusted2, i(state_fips_res year mob) j(population) string
foreach x in "1519" "2024" "2529" "30" "black" "white" "hispanic" {
generate percpop_`x'= popestimate_adjusted2`x'/popestimate_adjusted2overall
}

keep state_fips_res year mob percpop_1519 percpop_2024 percpop_2529 percpop_30 percpop_black percpop_white percpop_hispanic
tempfile percpop
save `percpop'
restore

merge m:1 state_fips_res year mob using `percpop'
drop _merge






save "pop_estimates_monthly.dta", replace





