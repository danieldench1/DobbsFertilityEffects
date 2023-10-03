*! version 1.0  92023  Daniel Dench dench@gatech.edu

capture program drop sdid_eventstudy
capture mata: mata drop funct1() 
capture mata: mata drop funct2()
capture mata: mata drop  funct3()
capture mata: mata drop  funct4()
capture mata: mata drop  funct5()

mata: 
function funct1 () { 
lambda=st_matrix("e(lambda)")
st_matrix("lambdat",lambda)

st_numscalar("numrows", rows(lambda)-1)
st_numscalar("numcols", cols(lambda)-1)
lambda=editmissing(lambda,0)

st_matrix("lambda_0",lambda)
}
end


mata: 
function funct2 () {
aux=st_matrix("aux")
st_matrix("auxd",diagonal(aux))
}
end




mata:
function funct3 () {
lambda_1=st_matrix("lambda_1")
lambda_last=st_matrix("lambda_last")
st_numscalar("miss_1", nonmissing(lambda_1))
st_numscalar("last_miss", nonmissing(lambda_last))
}
end




mata: 
function funct4 () {
lambda=st_matrix("e(lambda)")
for (i=1; i<=cols(lambda)-1; i++) {
st_numscalar("miss_"+strofreal(i), nonmissing(lambda[.,i])-1)
}
}
end

mata: 
function funct5 () {
eventt=st_matrix("eventt")
st_matrix("event_study",diagonal(eventt))
}
end

mata: 
function funct6 () {
eventt=st_matrix("eventt_bb")
st_matrix("event_study_B",diagonal(eventt))
}
end



program define sdid_eventstudy, eclass sortpreserve
	version 13 
	
	
	#delimit ;
	syntax varlist(min=1 numeric) [if] [in], vce(string) 
	
	[
	covariates(string asis)
	reps(integer 10)
	method(string asis)
	]
	;
	#delimit cr  

	set more off
	set graphics off

	
* Mark sample (reflects the if/in conditions, and includes only nonmissing observations)
marksample touse
markout `touse' `by' `xq' `sdid', strok	


if !inlist("`vce'", "bootstrap", "placebo") {
    dis as error "vce() must be one of bootstrap or placebo ."
    exit 198
}

* Parse the dependent variable
local lhs: word 1 of `varlist'
local pvar: word 2 of `varlist'
local tvar2: word 3 of `varlist'
local treatvar: word 4 of `varlist'

qui tempfile beginning
qui save `beginning'
qui egen tvar=group(`tvar2')
local tvar tvar

qui sdid `varlist', vce(noinference) graph covariates(`covariates') method(`method')

mata: funct1()
matrix lambda=lambdat[1..scalar(numrows),1..scalar(numcols)]

capture mata: mata drop lambda


matrix lambda1 = lambda_0[1..scalar(numrows),1..scalar(numcols)]
mat define B=e(difference)
matrix dif1 = B[1...,2...]
matrix aux=lambda1'*dif1

mata: funct2()
capture mata: mata drop aux


matrix lambda_1 = lambda[1..scalar(numrows),1]
matrix lambda_last=lambda[1..scalar(numrows),scalar(numcols)]

mata: funct3()
capture mata: mata drop lambda_1 lambda_last

capture drop first_treat
capture drop never_treat 
capture drop ty
capture drop treat_time
capture drop gar*
	


 qui gen treat_time = `tvar' if `treatvar' == 1
 qui bysort `pvar': egen first_treat = min(treat_time)
 qui gen never_treat = (first_treat== .)
 drop treat_time
qui gen ty = `tvar' - first_treat
local forward=scalar(numrows)-scalar(miss_1)-1

        forvalues k = `=scalar(last_miss)'(-1)1 {
           qui gen gar_`k' = ty == -`k'
        }
        forvalues k = 0/`forward' {
             qui gen gar`k' = ty == `k'
        }



unab rel_time_list: gar*
unab pre_time_list: gar_*

global pre_length: word count `pre_time_list' 
local event_length: word count `rel_time_list' 

global post_length=`event_length'-$pre_length-1

mat define events=J(`event_length',scalar(numcols),0)

mata: funct4()
capture mata: mata drop length_*


forvalues x=1(1)`=scalar(numcols)' {
matrix length_`x' = lambda[1..scalar(numrows),`x']
scalar xm=`x'



local start=scalar(last_miss)-scalar(miss_`x')+1
local finish=`start'+scalar(numrows)-1
matrix dif=e(difference)
matrix dif1=dif[1..scalar(numrows),2..scalar(numcols)+1]

local i=1

forvalues y=`start'(1)`finish' {
mat events[`y',`x']=dif1[`i',`x']-auxd[`x',1]
local i=`i'+1
}
}




	* Convert the varlist of relative time indicators to nvarlist 
	local nvarlist "" // copies of relative time indicators with control cohort set to zero
	local dvarlist "" // for display
	foreach l of varlist `rel_time_list' {
		local dvarlist "`dvarlist' `l'"
		tempname n`l'
		qui gen `n`l'' = `l'
		qui replace `n`l'' = 0 if  never_treat == 1
		local nvarlist "`nvarlist' `n`l''"
	}	

	* Get cohort count  and count of relative time
	qui levelsof first_treat if  never_treat == 0, local(cohort_list) 
 	local nrel_times: word count `nvarlist' 
	local ncohort: word count `cohort_list'  
	
	* Initiate empty matrix for weights 
	* ff_w stores the cohort shares (rows) for relative time (cols)
	tempname bb ff_w
	
	* Loop over cohort and get cohort shares for relative times
	local nresidlist ""
	foreach yy of local cohort_list {
		tempvar cohort_ind resid`yy'
		qui gen `cohort_ind'  = (first_treat == `yy') 
		qui regress `cohort_ind' `nvarlist'  if `touse' & never_treat == 0, nocons
		mat `bb' = e(b)
		matrix `ff_w'  = nullmat(`ff_w') \ `bb'
		qui predict double `resid`yy'', resid
		local nresidlist "`nresidlist' `resid`yy''"
	
	
	
	}
	

 	mat define eventt=events*`ff_w'
	
	mata: funct5()

if "`vce'"=="bootstrap" {
 dis "Bootstrap replications (`reps'). This may take some time."
 dis "----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5"
	local b=1
	local B=`reps'
	while `b'<=`B' {
	preserve
	bsample, cluster(`pvar') idcluster(c2)
	qui count if `treatvar'==0
	local r1=r(N)
	qui count if `treatvar'~=0
	local r2=r(N)
	if (`r1'~=0 & `r2'~=0) {
	local varlist2 `lhs' c2 `tvar' `treatvar'
	local pvar2: word 2 of `varlist2'
	qui sdid `varlist2', vce(noinference) graph	 covariates(`covariates') method(`method')
	
mata: funct1()
matrix lambda=lambdat[1..scalar(numrows),1..scalar(numcols)]

capture mata: mata drop lambda


matrix lambda1 = lambda_0[1..scalar(numrows),1..scalar(numcols)]
mat define B=e(difference)
matrix dif1 = B[1...,2...]
matrix aux=lambda1'*dif1

mata: funct2()
capture mata: mata drop aux


matrix lambda_1 = lambda[1..scalar(numrows),1]
matrix lambda_last=lambda[1..scalar(numrows),scalar(numcols)]

mata: funct3()
capture mata: mata drop lambda_1 lambda_last

capture drop first_treat
capture drop never_treat 
capture drop ty
capture drop treat_time
capture drop gar*
	


 qui gen treat_time = `tvar' if `treatvar' == 1
 qui bysort `pvar2': egen first_treat = min(treat_time)
 qui gen never_treat = (first_treat== .)
 drop treat_time
qui gen ty = `tvar' - first_treat
local forward=scalar(numrows)-scalar(miss_1)-1

        forvalues k = `=scalar(last_miss)'(-1)1 {
           qui gen gar_`k' = ty == -`k'
        }
        forvalues k = 0/`forward' {
             qui gen gar`k' = ty == `k'
        }



unab rel_time_list: gar*
unab pre_time_list: gar_*

local pre_length_b: word count `pre_time_list' 
local event_length: word count `rel_time_list' 
local post_length_b=`event_length'-`pre_length_b'-1

mat define events=J(`event_length',scalar(numcols),0)

mata: funct4()
capture mata: mata drop length_*


forvalues x=1(1)`=scalar(numcols)' {
matrix length_`x' = lambda[1..scalar(numrows),`x']
scalar xm=`x'



local start=scalar(last_miss)-scalar(miss_`x')+1
local finish=`start'+scalar(numrows)-1
matrix dif=e(difference)
matrix dif1=dif[1..scalar(numrows),2..scalar(numcols)+1]

local i=1

forvalues y=`start'(1)`finish' {
mat events[`y',`x']=dif1[`i',`x']-auxd[`x',1]
local i=`i'+1



}
}




	* Convert the varlist of relative time indicators to nvarlist 
	local nvarlist "" // copies of relative time indicators with control cohort set to zero
	local dvarlist "" // for display
	foreach l of varlist `rel_time_list' {
		local dvarlist "`dvarlist' `l'"
		tempname n`l'
		qui gen `n`l'' = `l'
		qui replace `n`l'' = 0 if  never_treat == 1
		local nvarlist "`nvarlist' `n`l''"
	}	

	* Get cohort count  and count of relative time
	qui levelsof first_treat if  never_treat == 0, local(cohort_list) 
 	local nrel_times: word count `nvarlist' 
	local ncohort: word count `cohort_list'  
	
	* Initiate empty matrix for weights 
	* ff_w stores the cohort shares (rows) for relative time (cols)
	tempname bb ff_w
	
	* Loop over cohort and get cohort shares for relative times
	local nresidlist ""
	foreach yy of local cohort_list {
		tempvar cohort_ind resid`yy'
		qui gen `cohort_ind'  = (first_treat == `yy') 
		qui regress `cohort_ind' `nvarlist'  if `touse' & never_treat == 0, nocons
		mat `bb' = e(b)
		matrix `ff_w'  = nullmat(`ff_w') \ `bb'
		qui predict double `resid`yy'', resid
		local nresidlist "`nresidlist' `resid`yy''"
	
	
	
	}
	

	
 	mat define eventt_bb=events*`ff_w'
	
	mata: funct6()
	capture mata: mata drop eventt

	
	
local rr_pre=`pre_length_b'-$pre_length
local rr_post=`post_length_b'-$post_length

while `rr_pre'<0 {
matrix event_study_B=.\event_study_B
local ++rr_pre
}

while `rr_post'<0 {
matrix event_study_B=event_study_B\.
local ++rr_post
}

matrix event_study_bb=nullmat(event_study_bb),event_study_B
	local ++b

	}
	restore
display in smcl "." _continue
if mod(`b',50)==0 dis "     `b'"	
}
}



	
	
	if "`vce'"=="placebo" {
	
dis "Placebo replications (`reps'). This may take some time."
dis "----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5"

	qui tempfile plac
	local b=1
	local B=`reps'
	while `b'<=`B' {
	qui save `plac', replace
	
	preserve
	qui keep if first_treat!=.
	qui egen newgroup=group(`pvar')
	qui sort newgroup `tvar'
	qui keep newgroup `tvar' `treatvar'
	qui tempfile force
	qui save `force'
	restore
	
	
	qui gen rand=runiform()
	qui bysort `pvar': replace rand=rand[1]
	qui egen newgroup=group(rand)
	qui drop `treatvar'
	qui merge 1:1 newgroup `tvar' using `force'
	qui replace `treatvar'=0 if `treatvar'==.
	
	local varlist2 `lhs' newgroup `tvar' `treatvar'
	local pvar2: word 2 of `varlist2'
	qui sdid `varlist2', vce(noinference) graph	 covariates(`covariates') method(`method')
	
mata: funct1()
matrix lambda=lambdat[1..scalar(numrows),1..scalar(numcols)]

capture mata: mata drop lambda


matrix lambda1 = lambda_0[1..scalar(numrows),1..scalar(numcols)]
mat define B=e(difference)
matrix dif1 = B[1...,2...]
matrix aux=lambda1'*dif1

mata: funct2()
capture mata: mata drop aux


matrix lambda_1 = lambda[1..scalar(numrows),1]
matrix lambda_last=lambda[1..scalar(numrows),scalar(numcols)]

mata: funct3()
capture mata: mata drop lambda_1 lambda_last

capture drop first_treat
capture drop never_treat 
capture drop ty
capture drop treat_time
capture drop gar*
	


 qui gen treat_time = `tvar' if `treatvar' == 1
 qui bysort `pvar2': egen first_treat = min(treat_time)
 qui gen never_treat = (first_treat== .)
 drop treat_time
qui gen ty = `tvar' - first_treat
local forward=scalar(numrows)-scalar(miss_1)-1

        forvalues k = `=scalar(last_miss)'(-1)1 {
           qui gen gar_`k' = ty == -`k'
        }
        forvalues k = 0/`forward' {
             qui gen gar`k' = ty == `k'
        }



unab rel_time_list: gar*
unab pre_time_list: gar_*

local pre_length_b: word count `pre_time_list' 
local event_length: word count `rel_time_list' 
local post_length_b=`event_length'-`pre_length_b'-1

mat define events=J(`event_length',scalar(numcols),0)

mata: funct4()
capture mata: mata drop length_*


forvalues x=1(1)`=scalar(numcols)' {
matrix length_`x' = lambda[1..scalar(numrows),`x']
scalar xm=`x'



local start=scalar(last_miss)-scalar(miss_`x')+1
local finish=`start'+scalar(numrows)-1
matrix dif=e(difference)
matrix dif1=dif[1..scalar(numrows),2..scalar(numcols)+1]

local i=1

forvalues y=`start'(1)`finish' {
mat events[`y',`x']=dif1[`i',`x']-auxd[`x',1]
local i=`i'+1
}
}




	* Convert the varlist of relative time indicators to nvarlist 
	local nvarlist "" // copies of relative time indicators with control cohort set to zero
	local dvarlist "" // for display
	foreach l of varlist `rel_time_list' {
		local dvarlist "`dvarlist' `l'"
		tempname n`l'
		qui gen `n`l'' = `l'
		qui replace `n`l'' = 0 if  never_treat == 1
		local nvarlist "`nvarlist' `n`l''"
	}	

	* Get cohort count  and count of relative time
	qui levelsof first_treat if  never_treat == 0, local(cohort_list) 
 	local nrel_times: word count `nvarlist' 
	local ncohort: word count `cohort_list'  
	
	* Initiate empty matrix for weights 
	* ff_w stores the cohort shares (rows) for relative time (cols)
	tempname bb ff_w
	
	* Loop over cohort and get cohort shares for relative times
	local nresidlist ""
	foreach yy of local cohort_list {
		tempvar cohort_ind resid`yy'
		qui gen `cohort_ind'  = (first_treat == `yy') 
		qui regress `cohort_ind' `nvarlist'  if `touse' & never_treat == 0, nocons
		mat `bb' = e(b)
		matrix `ff_w'  = nullmat(`ff_w') \ `bb'
		qui predict double `resid`yy'', resid
		local nresidlist "`nresidlist' `resid`yy''"
	
	
	
	}
	

	
 	mat define eventt_bb=events*`ff_w'
	
	mata: funct6()
	capture mata: mata drop eventt

	
	
local rr_pre=`pre_length_b'-$pre_length
local rr_post=`post_length_b'-$post_length

while `rr_pre'<0 {
matrix event_study_B=.\event_study_B
local ++rr_pre
}

while `rr_post'<0 {
matrix event_study_B=event_study_B\.
local ++rr_post
}

matrix event_study_bb=nullmat(event_study_bb),event_study_B
	local ++b
	
	
	use `plac', clear
display in smcl "." _continue
if mod(`b',50)==0 dis "     `b'"	
	}
	
	
}



	
preserve

drop _all
qui svmat event_study
qui svmat event_study_bb
qui egen rsd=rowsd(event_study_bb*)
qui egen rowmissing=rowmiss(event_study_bb*)

qui gen LCI = event_study1 + invnormal(0.025)*rsd
qui gen UCI = event_study1 + invnormal(0.975)*rsd
mkmat LCI UCI, matrix(CI)
mkmat rowmissing, matrix(event_miss)

restore
	
	ereturn matrix event_miss event_miss
	ereturn scalar reps=`reps'
	ereturn matrix CI CI
	ereturn matrix event_study event_study


use `beginning', clear

capture matrix drop event_study_bb 
capture matrix drop event_study_B
capture matrix drop eventt_bb 
capture matrix drop dif1 
capture matrix drop dif 
capture matrix drop length_1 
capture matrix drop events
capture matrix drop lambda_last 
capture matrix drop lambda_1 
capture matrix drop auxd 
capture matrix drop aux 
capture matrix drop B 
capture matrix drop lambda1 
capture matrix drop lambda 
capture matrix drop lambda_0 
capture matrix drop lambdat 
capture matrix drop diff* 
capture matrix drop Ytr* 
capture matrix drop Yco* 
capture matrix drop tryears
capture matrix drop ttime 
capture matrix drop eventt
capture matrix drop diff*
capture matrix drop Ytr* 
capture matrix drop Yco* 
capture matrix drop beta
capture matrix drop se_tau
capture matrix drop tau_i





	end
	


