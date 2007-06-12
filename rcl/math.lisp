;; Copyright (c) 2006-2007 Carlos Ungil

;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(in-package :rcl)

;; Rmath.h  should contain ALL headers from R's C code in `src/nmath'
;; -------  such that ``the Math library'' can be used by simply
;; #include <Rmath.h>
;; and nothing else.

;; R_VERSION_STRING "2.2.1"

;; See http://cran.r-project.org/doc/manuals/R-exts.html#Distribution-functions

(cffi:defcfun "Rf_d1mach" :double (a :int))
(cffi:defcfun "Rf_i1mach" :double (a :int))
#-linux
(cffi:defcfun "Rf_gamma_cody" :double (a :double))

;; search also for "undefined" aliens

;; 6.3 Random number generation

;; Random Number Generators 
(cffi:defcfun "norm_rand" :double)
(cffi:defcfun "unif_rand" :double)
(cffi:defcfun "exp_rand" :double)

;;(cffi:defcfun "set_seed" :void (a :int) (b :int))
;;(cffi:defcfun "get_seed" :void (a :pointer) (b :pointer))

;; 6.7.2 Mathematical functions

;; Gamma and Related Functions
(cffi:defcfun "Rf_gammafn" :double (x :double))
(cffi:defcfun "Rf_lgammafn" :double (x :double))
(cffi:defcfun "Rf_digamma" :double (x :double))
(cffi:defcfun "Rf_trigamma" :double (x :double))
(cffi:defcfun "Rf_tetragamma" :double (x :double))
(cffi:defcfun "Rf_pentagamma" :double (x :double))
(cffi:defcfun "Rf_psigamma" :double (x :double) (deriv :double))
;; The Gamma function, its natural logarithm and first four
;; derivatives and the n-th derivative of Psi, the digamma function.

;;; void    dpsifn(double, int, int, int, double*, int*, int*);

(cffi:defcfun "Rf_beta" :double (a :double) (b :double)) 
(cffi:defcfun "Rf_lbeta" :double (a :double) (b :double))
;; The (complete) Beta function and its natural logarithm.

(cffi:defcfun "Rf_choose" :double (a :double) (b :double))
(cffi:defcfun "Rf_lchoose" :double (a :double) (b :double))
;; The number of combinations of k items chosen from from n and its
;; natural logarithm.  n and k are rounded to the nearest integer.

;; Bessel Functions
(cffi:defcfun "Rf_bessel_i" :double (x :double) (nu :double) (expo :double))
(cffi:defcfun "Rf_bessel_j" :double (x :double) (nu :double))
(cffi:defcfun "Rf_bessel_k" :double (x :double) (nu :double) (expo :double))
(cffi:defcfun "Rf_bessel_y" :double (x :double) (nu :double))
;;  Bessel functions of types I, J, K and Y with index nu. For
;;  bessel_i and bessel_k there is the option to return
;;  exp(-x) I(x; nu) or exp(x) K(x; nu) if expo is 2. 
;;  (Use expo == 1 for unscaled values.)


;; 6.7.3 Numerical Utilities

;;undefined in newer versions (post 2.1.1)
;;(cffi:defcfun "R_log" :double (x :double))

(cffi:defcfun "R_pow" :double (x :double) (y :double))
(cffi:defcfun "R_pow_di" :double (x :double) (i :int))
;; R_pow(x, y) and R_pow_di(x, i) compute x^y and x^i, respectively
;; using R_FINITE checks and returning the proper result (the same as
;; R) for the cases where x, y or i are 0 or missing or infinite or
;; NaN.

(cffi:defcfun "Rf_pythag" :double (a :double) (b :double))
;; pythag(a, b) computes sqrt(a^2 + b^2) without overflow or
;; destructive underflow: for example it still works when both a and b
;; are between 1e200 and 1e300 (in IEEE double precision).

;;undefined
;;(cffi:defcfun "Rlog1p" :double (x :double))
;; = log(1+x) {care for small x} 
;; Computes log(1 + x) (log 1 plus x), accurately even for small x,
;; i.e., |x| << 1.
;; This may be provided by your platform, in which case it is not
;; included in Rmath.h, but is (probably) in math.h which Rmath.h
;; includes. For backwards compatibility with R versions prior to
;; 1.5.0, the entry point Rf_log1p is still provided.

(cffi:defcfun "Rf_log1pmx" :double (x :double))
;; Accurate log(1+x) - x, {care for small x} */
;; Computes log(1 + x) - x (log 1 plus x minus x), accurately even for
;; small x, i.e., |x| << 1.

(cffi:defcfun "expm1" :double (x :double))
;; = exp(x)-1 {care for small x}
;; Computes exp(x) - 1 (exp x minus 1), accurately even for small x,
;; i.e., |x| << 1.
;; This may be provided by your platform, in which case it is not
;; included in Rmath.h, but is (probably) in math.h which Rmath.h
;; includes.

(cffi:defcfun "Rf_lgamma1p" :double (x :double))
;; accurate log(gamma(x+1)), small x (0 < x < 0.5)
;; Computes log(gamma(x + 1)) (log(gamma(1 plus x))), accurately even
;; for small x, i.e., 0 < x < 0.5.

(cffi:defcfun "Rf_logspace_add" :double (logx :double) (logy :double))
(cffi:defcfun "Rf_logspace_sub" :double (logx :double) (logy :double))
;; Compute the log of a sum or difference from logs of terms, i.e., 
;; “x + y” as log (exp(logx) + exp(logy)) and “x - y” as log
;; (exp(logx) - exp(logy)), without causing overflows or throwing away
;; too much accuracy.

(cffi:defcfun "Rf_imax2" :int (x :int) (y :int))
(cffi:defcfun "Rf_imin2" :int (x :int) (y :int))
(cffi:defcfun "Rf_fmax2" :double (x :double) (y :double))
(cffi:defcfun "Rf_fmin2" :double (x :double) (y :double))
;;  Return the larger (max) or smaller (min) of two integer or double
;;  numbers, respectively.

(cffi:defcfun "Rf_sign" :double (x :double))
;;  Compute the signum function, where sign(x) is 1, 0, or -1, when x
;;  is positive, 0, or negative, respectively.

(cffi:defcfun "Rf_fsign" :double (x :double) (y :double))
;;  Performs "transfer of sign" and is defined as |x| * sign(y).

(cffi:defcfun "Rf_fprec" :double (x :double) (digits :double))
;;  Returns the value of x rounded to digits decimal digits (after the
;;  decimal point).

(cffi:defcfun "Rf_fround" :double (x :double) (digits :double))
;;  Returns the value of x rounded to digits significant decimal
;;  digits.

(cffi:defcfun "Rf_ftrunc" :double (x :double))
;;  Returns the value of x truncated (to an integer value) towards zero.


;; 6.7.1 Distribution functions

#|The routines used to calculate densities, cumulative distribution
functions and quantile functions for the standard statistical
distributions are available as entry points.

The arguments for the entry points follow the pattern of those for the
normal distribution:
     double dnorm(double x, double mu, double sigma, int give_log);
     double pnorm(double x, double mu, double sigma, int lower_tail, int give_log);
     double qnorm(double p, double mu, double sigma, int lower_tail, int log_p);
     double rnorm(double mu, double sigma);

That is, the first argument gives the position for the density and CDF
and probability for the quantile function, followed by the
distribution's parameters. Argument lower_tail should be TRUE (or 1)
for normal use, but can be FALSE (or 0) if the probability of the
upper tail is desired or specified.

Finally, give_log should be non-zero if the result is required on log
scale, and log_p should be non-zero if p has been specified on log
scale.

Note that you directly get the cumulative (or “integrated”) hazard
function, H(t) = - log(1 - F(t)), by using
 - pdist(t, ..., /*lower_tail = */ FALSE, /* give_log = */ TRUE)
or shorter (and more cryptic) 
 - pdist(t, ..., 0, 1). 

The random-variate generation routine rnorm returns one normal
variate. See Random numbers, for the protocol in using the
random-variate routines. Note that these argument sequences are (apart
from the names and that rnorm has no n) exactly the same as the
corresponding R functions of the same name, so the documentation of
the R functions can be used.

For reference, the following table gives the basic name (to be
prefixed by `d', `p', `q' or `r' apart from the exceptions noted) and 
distribution-specific arguments for the complete set of distributions.

...

Entries marked with an asterisk only have `p' and `q' functions
available, and none of the non-central distributions have `r'
functions. After a call to dwilcox, pwilcox or qwilcox the function
wilcox_free() should be called, and similarly for the signed rank
functions.

The argument names are not all quite the same as the R ones.
|#

;; Normal Distribution
;; normal	norm	mu, sigma 
(cffi:defcfun "Rf_dnorm4" :double (x :double) (mu :double) (sigma :double) (give-log :int))
(cffi:defcfun "Rf_pnorm5" :double (x :double) (mu :double) (sigma :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qnorm5" :double (p :double) (mu :double) (sigma :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rnorm" :double (mu :double) (sigma :double))
(cffi:defcfun "Rf_pnorm_both" :void (x :double) (cum :pointer) (ccum :pointer) (lower-tail :int) (log-p :int))

;; Uniform Distribution
;; unif	a, b 
(cffi:defcfun "Rf_dunif" :double (x :double) (a :double) (b :double) (give-log :int))
(cffi:defcfun "Rf_punif" :double (x :double) (a :double) (b :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qunif" :double (p :double) (a :double) (b :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_runif" :double (a :double) (b :double))

;; Gamma Distribution 
;; gamma	shape, scale 
(cffi:defcfun "Rf_dgamma" :double (x :double) (shape :double) (scale :double) (give-log :int))
(cffi:defcfun "Rf_pgamma" :double (x :double) (shape :double) (scale :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qgamma" :double (p :double) (shape :double) (scale :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rgamma" :double (shape :double) (scale :double))

;; Beta Distribution
;; beta	a, b 
(cffi:defcfun "Rf_dbeta" :double (x :double) (a :double) (b :double) (give-log :int))
(cffi:defcfun "Rf_pbeta" :double (x :double) (a :double) (b :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qbeta" :double (p :double) (a :double) (b :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rbeta" :double (a :double) (b :double))
#-linux
(cffi:defcfun "Rf_pbeta_raw" :double (x :double) (a :double) (b :double) (lower-tail :int))

;; Lognormal Distribution
;; lnorm	logmean, logsd 
(cffi:defcfun "Rf_dlnorm" :double (x :double) (logmean :double) (logsd :double) (give-log :int))
(cffi:defcfun "Rf_plnorm" :double (x :double) (logmean :double) (logsd :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qlnorm" :double (p :double) (logmean :double) (logsd :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rlnorm" :double (logmean :double) (logsd :double))

;; Chi-squared Distribution
;; chisq	df 
(cffi:defcfun "Rf_dchisq" :double (x :double) (df :double) (give-log :int))
(cffi:defcfun "Rf_pchisq" :double (x :double) (df :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qchisq" :double (p :double) (df :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rchisq" :double (df :double))
#-linux
(cffi:defcfun "Rf_qchisq_appr" :double (p :double) (df :double) (lgamma :double) (lower-tail :int) (log-p :int) (tol :double))

;; Non-central Chi-squared Distribution
;; nchisq	df, lambda 
(cffi:defcfun "Rf_dnchisq" :double (x :double) (df :double) (lambda :double) (give-log :int))
(cffi:defcfun "Rf_pnchisq" :double (x :double) (df :double) (lambda :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qnchisq" :double (p :double) (df :double) (lambda :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rnchisq" :double (df :double) (lambda :double))

;; F Distibution
;; f	n1, n2 
(cffi:defcfun "Rf_df" :double (x :double) (n1 :double) (n2 :double) (give-log :int))
(cffi:defcfun "Rf_pf" :double (x :double) (n1 :double) (n2 :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qf" :double (p :double) (n1 :double) (n2 :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rf" :double (n1 :double) (n2 :double))

;; Student t Distibution 
;; t	n 
(cffi:defcfun "Rf_dt" :double (x :double) (n :double) (give-log :int))
(cffi:defcfun "Rf_pt" :double (x :double) (n :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qt" :double (p :double) (n :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rt" :double (n :double))

;; Binomial Distribution
;; binom	n, p 
(cffi:defcfun "Rf_dbinom" :double (x :double) (n :double) (p :double) (give-log :int))
(cffi:defcfun "Rf_pbinom" :double (x :double) (n :double) (p :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qbinom" :double (p :double) (n :double) (pp :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rbinom" :double (n :double) (p :double))

;; Multinomial Distribution 

;; void	rmultinom(int, double*, int, int*);

;; Cauchy Distribution
;;cauchy	location, scale 
(cffi:defcfun "Rf_dcauchy" :double (x :double) (location :double) (scale :double) (give-log :int))
(cffi:defcfun "Rf_pcauchy" :double (x :double) (location :double) (scale :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qcauchy" :double (p :double) (location :double) (scale :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rcauchy" :double (location :double) (scale :double))

;; Exponential Distribution 
;; exp	scale 
(cffi:defcfun "Rf_dexp" :double (x :double) (scale :double) (give-log :int))
(cffi:defcfun "Rf_pexp" :double (x :double) (scale :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qexp" :double (p :double) (scale :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rexp" :double (scale :double))

;; Geometric Distribution
;; geom	p 
(cffi:defcfun "Rf_dgeom" :double (x :double) (p :double) (give-log :int))
(cffi:defcfun "Rf_pgeom" :double (x :double) (p :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qgeom" :double (p :double) (pp :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rgeom" :double (p :double))

;; Hypergeometric Distibution 
;; hyper	NR, NB, n 
(cffi:defcfun "Rf_dhyper" :double (x :double) (nr :double) (nb :double) (n :double) (give-log :int))
(cffi:defcfun "Rf_phyper" :double (x :double) (nr :double) (nb :double) (n :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qhyper" :double (p :double) (nr :double) (nb :double) (n :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rhyper" :double (nr :double) (nb :double) (n :double))

;; Negative Binomial Distribution
;; nbinom	n, p 
(cffi:defcfun "Rf_dnbinom" :double (x :double) (n :double) (p :double) (give-log :int))
(cffi:defcfun "Rf_pnbinom" :double (x :double) (n :double) (p :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qnbinom" :double (p :double) (n :double) (pp :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rnbinom" :double (n :double) (p :double))

;; Poisson Distribution
;; pois	lambda
(cffi:defcfun "Rf_dpois" :double (x :double) (lambda :double) (give-log :int))
(cffi:defcfun "Rf_ppois" :double (x :double) (lambda :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qpois" :double (p :double) (lambda :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rpois" :double (lambdax :double))

;; Weibull Distribution
;; weibull	shape, scale 
(cffi:defcfun "Rf_dweibull" :double (x :double) (shape :double) (scale :double) (give-log :int))
(cffi:defcfun "Rf_pweibull" :double (x :double) (shape :double) (scale :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qweibull" :double (p :double) (shape :double) (scale :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rweibull" :double (shape :double) (scale :double))

;; Logistic Distribution
;; logis	location, scale
(cffi:defcfun "Rf_dlogis" :double (x :double) (location :double) (scale :double) (give-log :int))
(cffi:defcfun "Rf_plogis" :double (x :double) (location :double) (scale :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qlogis" :double (p :double) (location :double) (scale :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rlogis" :double (location :double) (scale :double))

;; Non-central Beta Distribution
;; nbeta	a, b, lambda 
(cffi:defcfun "Rf_dnbeta" :double (x :double) (a :double) (b :double) (lambda :double) (give-log :int))
(cffi:defcfun "Rf_pnbeta" :double (x :double) (a :double) (b :double) (lambda :double) (lower-tail :int) (give-log :int))
;;undefined
;;(cffi:defcfun "Rf_qnbeta" :double (p :double) (a :double) (b :double) (lambda :double) (lower-tail :int) (log-p :int))
;;(cffi:defcfun "Rf_rnbeta" :double (a :double) (b :double) (lambda :double))

;; Non-central F Distribution
;; nf (*)	n1, n2, ncp 
(cffi:defcfun "Rf_dnf" :double (x :double) (n1 :double) (n2 :double) (ncp :double) (give-log :int))
(cffi:defcfun "Rf_pnf" :double (x :double) (n1 :double) (n2 :double) (ncp :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qnf" :double (p :double) (n1 :double) (n2 :double) (ncp :double) (lower-tail :int) (log-p :int))

;; Non-central Student t Distribution
;; nt	df, delta 
(cffi:defcfun "Rf_dnt" :double (x :double) (df :double) (delta :double) (give-log :int))
(cffi:defcfun "Rf_pnt" :double (x :double) (df :double) (delta :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qnt" :double (p :double) (df :double) (delta :double) (lower-tail :int) (log-p :int))

;; Studentized Range Distribution 
;; tukey (*)	rr, cc, df 
(cffi:defcfun "Rf_ptukey" :double (x :double) (rr :double) (cc :double) (df :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qtukey" :double (p :double) (rr :double) (cc :double) (df :double) (lower-tail :int) (log-p :int))

;; Wilcoxon Rank Sum Distribution 
;; wilcox	m, n 
(cffi:defcfun "Rf_dwilcox" :double (x :double) (m :double) (n :double) (give-log :int))
(cffi:defcfun "Rf_pwilcox" :double (x :double) (m :double) (n :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qwilcox" :double (p :double) (m :double) (n :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rwilcox" :double (m :double) (n :double))

;; Wilcoxon Signed Rank Distribution
;; signrank	n 
(cffi:defcfun "Rf_dsignrank" :double (x :double) (n :double) (give-log :int))
(cffi:defcfun "Rf_psignrank" :double (x :double) (n :double) (lower-tail :int) (give-log :int))
(cffi:defcfun "Rf_qsignrank" :double (p :double) (n :double) (lower-tail :int) (log-p :int))
(cffi:defcfun "Rf_rsignrank" :double (n :double))
